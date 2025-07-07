<?php
/**
 * LegumLex Client Authentication Controller
 * This goes on your backend server (e.g., https://legumlex.com/api/)
 */

class ClientAuthController {
    
    private $perfexApiUrl = 'https://www.legumlex.com/accs/api/';
    private $perfexAdminToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9...'; // Keep this secure on server
    
    /**
     * Client Authentication Endpoint
     * POST /api/auth/login
     */
    public function login() {
        $email = $_POST['email'] ?? '';
        $password = $_POST['password'] ?? '';
        
        // Validate client credentials against your client database
        $client = $this->validateClientCredentials($email, $password);
        
        if (!$client) {
            return $this->jsonResponse(['success' => false, 'message' => 'Invalid credentials'], 401);
        }
        
        // Generate client session token
        $sessionToken = $this->generateSessionToken($client['id']);
        
        // Store session in database/cache
        $this->storeClientSession($sessionToken, $client);
        
        return $this->jsonResponse([
            'success' => true,
            'token' => $sessionToken,
            'client' => [
                'id' => $client['id'],
                'name' => $client['company'],
                'email' => $client['email']
            ]
        ]);
    }
    
    /**
     * Get Client Projects
     * GET /api/client/projects
     */
    public function getClientProjects() {
        $clientId = $this->getAuthenticatedClientId();
        if (!$clientId) {
            return $this->jsonResponse(['success' => false, 'message' => 'Unauthorized'], 401);
        }
        
        // Call Perfex API with admin token
        $projects = $this->callPerfexApi('projects');
        
        // Filter projects for this specific client
        $clientProjects = array_filter($projects, function($project) use ($clientId) {
            return $project['clientid'] == $clientId;
        });
        
        return $this->jsonResponse([
            'success' => true,
            'data' => array_values($clientProjects)
        ]);
    }
    
    /**
     * Get Client Invoices
     * GET /api/client/invoices
     */
    public function getClientInvoices() {
        $clientId = $this->getAuthenticatedClientId();
        if (!$clientId) {
            return $this->jsonResponse(['success' => false, 'message' => 'Unauthorized'], 401);
        }
        
        // Call Perfex API with admin token
        $invoices = $this->callPerfexApi('invoices');
        
        // Filter invoices for this specific client
        $clientInvoices = array_filter($invoices, function($invoice) use ($clientId) {
            return $invoice['clientid'] == $clientId;
        });
        
        return $this->jsonResponse([
            'success' => true,
            'data' => array_values($clientInvoices)
        ]);
    }
    
    /**
     * Get Dashboard Stats
     * GET /api/client/dashboard
     */
    public function getDashboardStats() {
        $clientId = $this->getAuthenticatedClientId();
        if (!$clientId) {
            return $this->jsonResponse(['success' => false, 'message' => 'Unauthorized'], 401);
        }
        
        // Get client-specific data
        $projects = $this->getFilteredData('projects', $clientId);
        $invoices = $this->getFilteredData('invoices', $clientId);
        $tickets = $this->getFilteredData('tickets', $clientId); // Optional
        
        $stats = [
            'activeCases' => count($projects),
            'unpaidInvoices' => count(array_filter($invoices, function($inv) {
                return $inv['status'] == '1' || $inv['status'] == 'unpaid';
            })),
            'totalDocuments' => 0, // To be implemented
            'openTickets' => count(array_filter($tickets, function($ticket) {
                return $ticket['status'] == '1' || $ticket['status'] == 'open';
            }))
        ];
        
        return $this->jsonResponse([
            'success' => true,
            'data' => $stats
        ]);
    }
    
    // Private helper methods
    private function validateClientCredentials($email, $password) {
        // Query your client database
        $sql = "SELECT * FROM clients WHERE email = ? AND password = ?";
        // Hash password properly in production
        $hashedPassword = hash('sha256', $password); // Use proper bcrypt in production
        
        // Return client data if valid, null if invalid
        // This is where you validate against your client database
        return [
            'id' => '11', // Perfex client ID
            'email' => $email,
            'company' => 'Punjabi Food and Spices Private Limited'
        ];
    }
    
    private function callPerfexApi($endpoint) {
        $url = $this->perfexApiUrl . $endpoint;
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
            'Accept: application/json',
            'authtoken: ' . $this->perfexAdminToken
        ]);
        
        $response = curl_exec($ch);
        curl_close($ch);
        
        return json_decode($response, true);
    }
    
    private function getFilteredData($endpoint, $clientId) {
        $data = $this->callPerfexApi($endpoint);
        return array_filter($data, function($item) use ($clientId) {
            return $item['clientid'] == $clientId;
        });
    }
    
    private function getAuthenticatedClientId() {
        $token = $_SERVER['HTTP_AUTHORIZATION'] ?? '';
        $token = str_replace('Bearer ', '', $token);
        
        // Get client ID from session/database using token
        // Return client ID or null if invalid
        return '11'; // Example - get from session
    }
    
    private function generateSessionToken($clientId) {
        return bin2hex(random_bytes(32));
    }
    
    private function storeClientSession($token, $client) {
        // Store in database/cache with expiration
    }
    
    private function jsonResponse($data, $status = 200) {
        http_response_code($status);
        header('Content-Type: application/json');
        echo json_encode($data);
        exit;
    }
}
?>