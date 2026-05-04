@extends('layouts.main')

@section('content')
<section class="container py-5 text-center">
    <h2 class="fw-bold">Profil Penulis</h2>

    <img src="https://ui-avatars.com/api/?name={{ $data['name'] }}&size=150"
         class="rounded-circle my-3 shadow">

    <div class="card mx-auto p-4 shadow-sm" style="max-width:400px;">
        <p><strong>Nama:</strong> {{ $data['name'] }}</p>
        <p><strong>Alamat:</strong> {{ $data['address'] }}</p>
        <p><strong>Email:</strong> {{ $data['email'] }}</p>
        <p><strong>Universitas:</strong> {{ $data['univ'] }}</p>
    </div>
</section>
@endsection