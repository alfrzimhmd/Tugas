<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>MutiBlog</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
        }
        .navbar {
            backdrop-filter: blur(10px);
        }
        .card {
            transition: 0.3s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="/">MutiBlog</a>

            <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navMenu">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navMenu">
                <ul class="navbar-nav ms-auto gap-3">
                    <li><a class="nav-link" href="/">Home</a></li>
                    <li><a class="nav-link" href="/profile">Profile</a></li>
                    <li><a class="nav-link" href="/articles">Articles</a></li>
                    <li><a class="nav-link" href="/admin/artikel">Admin</a></li>
                </ul>
            </div>
        </div>
    </nav>
</header>

<main class="flex-grow-1">
    @yield('content')
</main>

<footer class="bg-dark text-light text-center py-4 mt-auto">
    <small>&copy; 2026 MutiBlog. Built with Laravel ❤️</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>