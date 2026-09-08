<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Aetheria LMS | Light Ivory & Copper Cloud Sanctuary</title>

  <!-- Google Fonts & Lucide Icons -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&family=Playfair+Display:ital,wght@0,500;0,700;1,400&display=swap" rel="stylesheet">
  <script src="https://unpkg.com/lucide@latest"></script>

  <!-- Three.js, GSAP & ScrollTrigger Engine -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>

  <style>
    :root {
      /* Palette: Light Ivory Base & Warm Copper Accents */
      --bg-light: #f7f4ee;                 /* Light Warm Ivory Base */
      --glass-panel: rgba(255, 253, 249, 0.75);/* High-clarity frosted light ivory glass */
      --glass-card: rgba(255, 255, 255, 0.65);
      --glass-border: rgba(184, 115, 51, 0.22);/* Delicate metallic copper border */
      
      --accent-copper: #b87333;            /* Rich Copper */
      --accent-copper-dark: #8c4e1a;       /* Deep Warm Bronze Copper */
      --accent-copper-light: #d48c46;      /* Bright Polished Copper */
      --accent-ivory: #ffffff;             /* Pure White Ivory Highlight */
      
      --text-main: #2b221b;                /* High-contrast deep dark warm brown text */
      --text-muted: #6e5f53;               /* Muted warm earth text */
      --sidebar-width: 280px;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
      font-family: 'Plus Jakarta Sans', sans-serif;
      user-select: none;
    }

    body {
      background-color: var(--bg-light);
      color: var(--text-main);
      overflow-x: hidden;
      width: 100vw;
    }

    /* Fixed WebGL Background Canvas */
    #webgl-canvas {
      position: fixed;
      top: 0;
      left: 0;
      width: 100vw;
      height: 100vh;
      z-index: 0;
      pointer-events: none;
    }

    /* Glassmorphism Light Panels */
    .glass-box {
      background: var(--glass-panel);
      backdrop-filter: blur(20px) saturate(160%);
      -webkit-backdrop-filter: blur(20px) saturate(160%);
      border: 1px solid var(--glass-border);
      border-radius: 24px;
      box-shadow: 0 12px 30px rgba(138, 90, 48, 0.08), inset 0 1px 0 rgba(255, 255, 255, 0.8);
    }

    .glass-card {
      background: var(--glass-card);
      backdrop-filter: blur(12px);
      border: 1px solid var(--glass-border);
      border-radius: 18px;
      padding: 24px;
      transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
    }

    .glass-card:hover {
      transform: translateY(-5px);
      border-color: var(--accent-copper-light);
      box-shadow: 0 12px 30px rgba(184, 115, 51, 0.15);
    }

    /* Strict Invite-Only Login Guard Overlay */
    #auth-guard {
      position: fixed;
      inset: 0;
      z-index: 2000;
      display: flex;
      align-items: center;
      justify-content: center;
      background: rgba(247, 244, 238, 0.88);
      backdrop-filter: blur(25px);
    }

    .login-modal {
      width: 400px;
      padding: 40px;
      text-align: center;
    }

    .brand-title {
      font-family: 'Playfair Display', serif;
      font-size: 2.2rem;
      font-weight: 700;
      background: linear-gradient(135deg, var(--accent-copper-dark) 0%, var(--accent-copper-light) 100%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      letter-spacing: 0.5px;
    }

    .input-field {
      width: 100%;
      padding: 14px 18px;
      margin-top: 15px;
      background: rgba(255, 255, 255, 0.7);
      border: 1px solid var(--glass-border);
      border-radius: 12px;
      color: var(--text-main);
      outline: none;
      transition: 0.3s;
    }

    .input-field:focus {
      border-color: var(--accent-copper);
      background: #ffffff;
      box-shadow: 0 0 15px rgba(184, 115, 51, 0.2);
    }

    .btn-action {
      width: 100%;
      padding: 14px;
      margin-top: 20px;
      border: none;
      border-radius: 12px;
      background: linear-gradient(135deg, var(--accent-copper) 0%, var(--accent-copper-dark) 100%);
      color: var(--accent-ivory);
      font-weight: 700;
      cursor: pointer;
      box-shadow: 0 4px 20px rgba(184, 115, 51, 0.25);
      transition: transform 0.2s, box-shadow 0.2s;
    }

    .btn-action:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 25px rgba(184, 115, 51, 0.35);
    }

    /* Main Viewport & Scroll Container */
    #app-container {
      position: relative;
      z-index: 10;
      width: 100vw;
      opacity: 0;
      transition: opacity 0.8s ease;
    }

    /* Fixed Navigation Sidebar */
    .sidebar {
      position: fixed;
      top: 20px;
      left: 20px;
      width: var(--sidebar-width);
      height: calc(100vh - 40px);
      padding: 30px 20px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      z-index: 100;
    }

    .nav-list { list-style: none; margin-top: 30px; }

    .nav-item {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 12px 16px;
      margin-bottom: 8px;
      border-radius: 12px;
      color: var(--text-muted);
      cursor: pointer;
      transition: 0.3s;
    }

    .nav-item:hover, .nav-item.active {
      color: var(--accent-copper-dark);
      background: rgba(184, 115, 51, 0.1);
      border: 1px solid var(--glass-border);
    }

    .nav-item.active { border-left: 3px solid var(--accent-copper); }

    /* Scrollable Section Storyboard Layout */
    .sections-wrapper {
      margin-left: calc(var(--sidebar-width) + 40px);
      padding: 20px 40px 100px 0;
      width: calc(100vw - var(--sidebar-width) - 60px);
    }

    .lms-section {
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      justify-content: center;
      padding: 60px 0;
    }

    .section-title {
      font-family: 'Playfair Display', serif;
      font-size: 2.5rem;
      margin-bottom: 10px;
      color: var(--accent-copper-dark);
    }

    /* Grid Layouts */
    .grid-container {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
      gap: 24px;
      margin-top: 20px;
    }

    /* Dynamic Links & Custom Elements */
    .auto-link {
      color: var(--accent-copper);
      text-decoration: underline;
      word-break: break-all;
    }

    .pill-badge {
      font-size: 0.7rem;
      padding: 4px 10px;
      border-radius: 20px;
      font-weight: 700;
      text-transform: uppercase;
    }
    .badge-admin { background: rgba(184, 115, 51, 0.15); color: var(--accent-copper-dark); border: 1px solid var(--accent-copper); }
    .badge-editor { background: rgba(212, 140, 70, 0.15); color: var(--accent-copper); border: 1px solid var(--accent-copper-light); }
    .badge-student { background: rgba(110, 95, 83, 0.12); color: var(--text-muted); border: 1px solid rgba(110, 95, 83, 0.3); }

    .video-frame {
      position: relative;
      padding-bottom: 56.25%;
      border-radius: 16px;
      overflow: hidden;
      margin-bottom: 20px;
      background: #000;
    }
    .video-frame iframe { position: absolute; width: 100%; height: 100%; border: 0; }

    .btn-sm {
      padding: 8px 14px;
      font-size: 0.8rem;
      border-radius: 8px;
      border: 1px solid var(--glass-border);
      background: rgba(255, 255, 255, 0.6);
      color: var(--accent-copper-dark);
      cursor: pointer;
    }
    .btn-sm:hover { background: rgba(184, 115, 51, 0.15); }
    .btn-danger { background: rgba(184, 115, 51, 0.12); color: var(--accent-copper-dark); }
  </style>
</head>
<body>

  <!-- WebGL Background Scene Canvas -->
  <div id="webgl-canvas"></div>

  <!-- Invite-Only Login Guard Overlay -->
  <div id="auth-guard">
    <div class="glass-box login-modal">
      <div class="brand-title">Aetheria</div>
      <p style="color: var(--text-muted); font-size: 0.85rem; margin-top: 6px;">Copper & Light Ivory Cloud Sanctuary</p>
      
      <form onsubmit="event.preventDefault(); login();">
        <input type="text" id="user" class="input-field" placeholder="Username" required autocomplete="off">
        <input type="password" id="pass" class="input-field" placeholder="Password" required>
        <button type="submit" class="btn-action">Enter Sanctuary</button>
      </form>
      <div id="login-err" style="color: var(--accent-copper-dark); font-size: 0.8rem; margin-top: 15px; display: none;"></div>
    </div>
  </div>

  <!-- Main Scrollable App Container -->
  <div id="app-container">
    
    <!-- Sidebar Navigation Controls -->
    <aside class="glass-box sidebar">
      <div>
        <div style="padding: 0 10px 20px 10px;">
          <div class="brand-title" style="font-size: 1.6rem;">Aetheria</div>
          <span style="font-size: 0.7rem; color: var(--text-muted); letter-spacing: 2px;">CLOUD SANCTUARY</span>
        </div>
        <ul class="nav-list">
          <li class="nav-item active" onclick="scrollToSec('sec-announcements')"><i data-lucide="bell"></i> Announcements</li>
          <li class="nav-item" onclick="scrollToSec('sec-courses')"><i data-lucide="book-open"></i> Courses</li>
          <li class="nav-item" onclick="scrollToSec('sec-library')"><i data-lucide="folder"></i> Library</li>
          <li class="nav-item" onclick="scrollToSec('sec-jobs')"><i data-lucide="briefcase"></i> Opportunities</li>
          <li class="nav-item" onclick="scrollToSec('sec-profile')"><i data-lucide="user"></i> Profile</li>
          <li class="nav-item" onclick="scrollToSec('sec-help')"><i data-lucide="help-circle"></i> Help</li>
        </ul>
      </div>
      <div>
        <div style="margin-bottom: 15px; padding: 0 10px;">
          <div id="u-name" style="font-weight: 600;">Guest</div>
          <span id="u-role" class="pill-badge badge-student">Student</span>
        </div>
        <button onclick="logout()" class="btn-sm btn-danger" style="width: 100%;"><i data-lucide="log-out"></i> End Session</button>
      </div>
    </aside>

    <!-- Scrollable Content Storyboard Sections -->
    <main class="sections-wrapper">

      <!-- 1. ANNOUNCEMENTS -->
      <section id="sec-announcements" class="lms-section">
        <h2 class="section-title">Sanctuary Announcements</h2>
        <p style="color: var(--text-muted);">Latest updates from around the academy sanctuary.</p>
        <div id="btn-add-announcement" style="margin-top: 15px; display: none;">
          <button onclick="createItem('announcement')" class="btn-action" style="width: auto; padding: 10px 20px;">+ Post Announcement</button>
        </div>
        <div id="announcement-grid" class="grid-container"></div>
      </section>

      <!-- 2. COURSES -->
      <section id="sec-courses" class="lms-section">
        <div id="courses-catalog">
          <h2 class="section-title">Courses & Topics</h2>
          <p style="color: var(--text-muted);">Explore video modules and guided study paths.</p>
          <div id="btn-add-course" style="margin-top: 15px; display: none;">
            <button onclick="createItem('course')" class="btn-action" style="width: auto; padding: 10px 20px;">+ Add Topic / Video</button>
          </div>
          <div id="course-grid" class="grid-container"></div>
        </div>

        <!-- Topic Detailed View Container -->
        <div id="topic-detail" class="glass-box" style="padding: 30px; display: none;">
          <button onclick="closeTopic()" class="btn-sm" style="margin-bottom: 20px;"><i data-lucide="arrow-left"></i> Back to Courses</button>
          <h2 id="topic-title" style="margin-bottom: 15px;"></h2>
          <div id="video-wrapper" class="video-frame"></div>
          <h4>Notes & Reference Material</h4>
          <div id="topic-notes" style="background: rgba(255,255,255,0.5); padding: 20px; border-radius: 12px; margin: 15px 0; white-space: pre-wrap;"></div>
          
          <h4 style="margin-top: 30px;">Sanctuary Discussion</h4>
          <div id="comment-list" style="margin: 15px 0;"></div>
          <div style="display: flex; gap: 10px;">
            <input type="text" id="comm-input" class="input-field" placeholder="Ask a question or share a link..." style="margin:0; flex:1;">
            <button onclick="postComment()" class="btn-action" style="margin:0; width:auto;">Post</button>
          </div>
        </div>
      </section>

      <!-- 3. LIBRARY -->
      <section id="sec-library" class="lms-section">
        <h2 class="section-title">Resource Library</h2>
        <p style="color: var(--text-muted);">Curated reading materials and external reference links.</p>
        <div id="btn-add-lib" style="margin-top: 15px; display: none;">
          <button onclick="createItem('library')" class="btn-action" style="width: auto; padding: 10px 20px;">+ Add Resource</button>
        </div>
        <div id="library-grid" class="grid-container"></div>
      </section>

      <!-- 4. JOB OPPORTUNITIES -->
      <section id="sec-jobs" class="lms-section">
        <h2 class="section-title">Job Opportunities</h2>
        <p style="color: var(--text-muted);">Career listings managed by academy administrators.</p>
        <div id="btn-add-job" style="margin-top: 15px; display: none;">
          <button onclick="createItem('job')" class="btn-action" style="width: auto; padding: 10px 20px;">+ Post Opening</button>
        </div>
        <div id="job-grid" class="grid-container"></div>
      </section>

      <!-- 5. PROFILE -->
      <section id="sec-profile" class="lms-section">
        <h2 class="section-title">User Profile</h2>
        <div class="glass-box" style="padding: 30px; max-width: 500px; margin-top: 20px;">
          <h3>Account Credentials</h3>
          <div style="margin-top: 20px; display: flex; flex-direction: column; gap: 12px;">
            <div><strong>User ID:</strong> <span id="p-user"></span></div>
            <div><strong>Role:</strong> <span id="p-role"></span></div>
            <div><strong>Access Override:</strong> <span id="p-override"></span></div>
            <div><strong>Assigned Subjects:</strong> <div id="p-subjects" style="margin-top:8px; display:flex; gap:8px;"></div></div>
          </div>
        </div>
      </section>

      <!-- 6. HELP HUB -->
      <section id="sec-help" class="lms-section">
        <h2 class="section-title">Sanctuary Guide</h2>
        <div class="glass-box" style="padding: 30px; margin-top: 20px;">
          <h3>Aetheria Platform Access & Structure</h3>
          <p style="margin-top: 10px; color: var(--text-muted); line-height: 1.6;">
            Access to Aetheria is strictly invite-only. Role hierarchies control system interactions:
          </p>
          <ul style="margin: 15px 0 0 20px; color: var(--text-muted); line-height: 1.8;">
            <li><strong>Admin:</strong> Global access to add, edit, or delete any content.</li>
            <li><strong>Editor:</strong> Authoring rights; can modify or delete only their self-created assets.</li>
            <li><strong>Student:</strong> Read-only learner access filtered strictly by assigned subjects.</li>
          </ul>
        </div>
      </section>

    </main>
  </div>

  <script>
    /* 1. MOCK DATABASE ENGINE */
    const DB = {
      users: [
        { username: 'admin', pass: 'admin123', role: 'admin', subject_all: true, allowed_subjects: [] },
        { username: 'editor', pass: 'edit123', role: 'editor', subject_all: true, allowed_subjects: [] },
        { username: 'devops_student', pass: 'stud123', role: 'student', subject_all: false, allowed_subjects: ['DevOps'] }
      ],
      announcements: [
        { id: 1, title: 'Cloud Sanctuary Opening', body: 'Welcome to Aetheria Cloud Academy! Access docs at https://aetheria.edu/docs', author: 'admin' }
      ],
      courses: [
        { id: 1, subject: 'DevOps', title: 'Kubernetes Architecture', ytUrl: 'https://www.youtube.com/watch?v=PH-2FfFD2PU', notes: 'Official Kubernetes Guide: https://kubernetes.io', author: 'admin', comments: [] },
        { id: 2, subject: 'Data Science', title: 'Neural Networks & AI', ytUrl: 'https://www.youtube.com/watch?v=aircAruvnKk', notes: 'Deep Learning fundamentals: https://colab.research.google.com', author: 'editor', comments: [] }
      ],
      library: [
        { id: 1, subject: 'DevOps', title: 'Docker Reference Manual', url: 'https://docs.docker.com', author: 'admin' }
      ],
      jobs: [
        { id: 1, title: 'DevOps Cloud Engineer', company: 'Zenith Labs', link: 'https://careers.google.com', author: 'admin' }
      ]
    };

    let currentUser = null;
    let activeTopicId = null;

    /* 2. THREE.JS LIGHT IVORY & COPPER VOLUMETRIC CLOUD 3D ENGINE */
    let scene, camera, renderer, cloudGroup, particles;

    function init3D() {
      const container = document.getElementById('webgl-canvas');
      scene = new THREE.Scene();
      // Soft Light Ivory Volumetric Fog
      scene.fog = new THREE.FogExp2(0xf7f4ee, 0.022);

      camera = new THREE.PerspectiveCamera(50, window.innerWidth / window.innerHeight, 0.1, 1000);
      camera.position.set(0, 0, 30);

      renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
      renderer.setSize(window.innerWidth, window.innerHeight);
      renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
      container.appendChild(renderer.domElement);

      // Light Sky Lighting Setup
      const ambientLight = new THREE.AmbientLight(0xfffdfa, 2.2);
      scene.add(ambientLight);

      const copperSun = new THREE.DirectionalLight(0xd48c46, 2.0);
      copperSun.position.set(10, 30, 20);
      scene.add(copperSun);

      const ivoryGlow = new THREE.PointLight(0xffffff, 2.5, 40);
      ivoryGlow.position.set(-10, -10, 10);
      scene.add(ivoryGlow);

      // Master Cloud Group
      cloudGroup = new THREE.Group();
      scene.add(cloudGroup);

      // Create Volumetric Soft Cloud Clusters (Replacing the Tree)
      const cloudMatIvory = new THREE.MeshStandardMaterial({
        color: 0xffffff,
        roughness: 0.9,
        transparent: true,
        opacity: 0.82,
        flatShading: true
      });

      const cloudMatCopper = new THREE.MeshStandardMaterial({
        color: 0xeddcc4,
        roughness: 0.8,
        transparent: true,
        opacity: 0.75,
        flatShading: true
      });

      // Generate cloud banks along the scroll journey path
      for (let i = 0; i < 28; i++) {
        const cluster = new THREE.Group();
        const numPuffs = 5 + Math.floor(Math.random() * 6);
        const mat = (i % 3 === 0) ? cloudMatCopper : cloudMatIvory;

        for (let j = 0; j < numPuffs; j++) {
          const radius = 2 + Math.random() * 3.5;
          const puffGeo = new THREE.DodecahedronGeometry(radius, 1);
          const puff = new THREE.Mesh(puffGeo, mat);
          puff.position.set(
            (Math.random() - 0.5) * 5,
            (Math.random() - 0.5) * 3,
            (Math.random() - 0.5) * 5
          );
          cluster.add(puff);
        }

        // Distribute cloud layers vertically and in depth along scroll path
        cluster.position.set(
          (Math.random() - 0.5) * 35,
          (i * -4) + 10,
          (Math.random() - 0.5) * 25
        );
        cloudGroup.add(cluster);
      }

      // Add Floating Ambient Copper Dust / Mist Particles
      const pCount = 120;
      const pGeo = new THREE.BufferGeometry();
      const pPos = new Float32Array(pCount * 3);
      for(let i = 0; i < pCount * 3; i += 3) {
        pPos[i] = (Math.random() - 0.5) * 40;
        pPos[i+1] = (Math.random() - 0.5) * 100;
        pPos[i+2] = (Math.random() - 0.5) * 40;
      }
      pGeo.setAttribute('position', new THREE.BufferAttribute(pPos, 3));
      const pMat = new THREE.PointsMaterial({
        color: 0xb87333,
        size: 0.35,
        transparent: true,
        opacity: 0.6
      });
      particles = new THREE.Points(pGeo, pMat);
      scene.add(particles);

      // Init GSAP ScrollTrigger Cloud Flying Transition
      initScrollAnimations();

      window.addEventListener('resize', onResize);
      document.addEventListener('mousemove', onPointerMove);
      animate();
    }

    let mouseX = 0, mouseY = 0;
    function onPointerMove(e) {
      mouseX = (e.clientX / window.innerWidth) - 0.5;
      mouseY = (e.clientY / window.innerHeight) - 0.5;
    }

    function animate() {
      requestAnimationFrame(animate);

      const time = Date.now() * 0.0005;

      // Slow drift for cloud group to simulate living cloud/smoke sky
      cloudGroup.children.forEach((cloud, index) => {
        cloud.rotation.y = time * 0.1 * ((index % 2 === 0) ? 1 : -1);
        cloud.position.x += Math.sin(time + index) * 0.005;
      });

      // Animate floating copper particles
      const positions = particles.geometry.attributes.position.array;
      for(let i = 1; i < positions.length; i += 3) {
        positions[i] += Math.sin(time + i) * 0.01;
      }
      particles.geometry.attributes.position.needsUpdate = true;

      // Mouse Parallax Offset
      camera.position.x += (mouseX * 4 - camera.position.x) * 0.04;
      camera.lookAt(0, camera.position.y - 2, 0);

      renderer.render(scene, camera);
    }

    function onResize() {
      camera.aspect = window.innerWidth / window.innerHeight;
      camera.updateProjectionMatrix();
      renderer.setSize(window.innerWidth, window.innerHeight);
    }

    /* 3. GSAP SCROLLTRIGGER CLOUD FLYING ENGINE */
    function initScrollAnimations() {
      gsap.registerPlugin(ScrollTrigger);

      // Smooth scroll timeline gliding camera down through clouds
      const tl = gsap.timeline({
        scrollTrigger: {
          trigger: ".sections-wrapper",
          start: "top top",
          end: "bottom bottom",
          scrub: 1.5
        }
      });

      tl.to(camera.position, { y: -15, z: 22, x: 3 })
        .to(camera.position, { y: -35, z: 18, x: -4 })
        .to(camera.position, { y: -55, z: 25, x: 2 })
        .to(camera.position, { y: -75, z: 20, x: -2 });
    }

    function scrollToSec(secId) {
      const el = document.getElementById(secId);
      if(el) {
        el.scrollIntoView({ behavior: 'smooth' });
      }
    }

    /* 4. SYSTEM UTILITIES */
    function linkify(text) {
      if(!text) return '';
      const regex = /(https?:\/\/[^\s]+)/g;
      return text.replace(regex, url => `<a href="${url}" target="_blank" class="auto-link">${url}</a>`);
    }

    function getYtEmbed(url) {
      const match = url.match(/^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/);
      return (match && match[2].length === 11) ? `https://www.youtube.com/embed/${match[2]}` : null;
    }

    /* 5. AUTHENTICATION & ACCESS CONTROL */
    function login() {
      const u = document.getElementById('user').value.trim();
      const p = document.getElementById('pass').value.trim();
      const err = document.getElementById('login-err');

      const user = DB.users.find(x => x.username === u && x.pass === p);
      if(user) {
        currentUser = user;
        err.style.display = 'none';

        gsap.to('#auth-guard', { opacity: 0, duration: 0.6, onComplete: () => {
          document.getElementById('auth-guard').style.display = 'none';
          document.getElementById('app-container').style.opacity = '1';
        }});

        setupUI();
        renderAll();
      } else {
        err.innerText = 'Invalid credentials. Access is restricted to invited accounts.';
        err.style.display = 'block';
      }
    }

    function logout() {
      currentUser = null;
      document.getElementById('app-container').style.opacity = '0';
      document.getElementById('auth-guard').style.display = 'flex';
      gsap.to('#auth-guard', { opacity: 1, duration: 0.5 });
    }

    function setupUI() {
      document.getElementById('u-name').innerText = currentUser.username;
      const b = document.getElementById('u-role');
      b.innerText = currentUser.role;
      b.className = `pill-badge badge-${currentUser.role}`;

      const isPower = currentUser.role === 'admin' || currentUser.role === 'editor';
      document.getElementById('btn-add-announcement').style.display = isPower ? 'block' : 'none';
      document.getElementById('btn-add-course').style.display = isPower ? 'block' : 'none';
      document.getElementById('btn-add-lib').style.display = isPower ? 'block' : 'none';
      document.getElementById('btn-add-job').style.display = isPower ? 'block' : 'none';
    }

    function hasAccess(sub) {
      if(currentUser.subject_all) return true;
      return currentUser.allowed_subjects.includes(sub);
    }

    function canDelete(item) {
      if(currentUser.role === 'admin') return true;
      if(currentUser.role === 'editor' && item.author === currentUser.username) return true;
      return false;
    }

    /* 6. CONTENT RENDERERS */
    function renderAll() {
      renderAnnouncements();
      renderCourses();
      renderLibrary();
      renderJobs();
      renderProfile();
    }

    function renderAnnouncements() {
      const container = document.getElementById('announcement-grid');
      container.innerHTML = DB.announcements.map(item => `
        <div class="glass-card">
          <h3 style="margin-bottom: 10px;">${item.title}</h3>
          <p style="color: var(--text-muted); font-size: 0.9rem;">${linkify(item.body)}</p>
          <div style="margin-top: 15px; font-size: 0.75rem; color: var(--text-muted);">Author: ${item.author}</div>
          ${canDelete(item) ? `<button onclick="deleteItem('announcements', ${item.id})" class="btn-sm btn-danger" style="margin-top:10px;">Delete</button>` : ''}
        </div>
      `).join('');
    }

    function renderCourses() {
      const container = document.getElementById('course-grid');
      const filtered = DB.courses.filter(c => hasAccess(c.subject));

      container.innerHTML = filtered.map(c => `
        <div class="glass-card">
          <span style="font-size:0.7rem; color: var(--accent-copper); font-weight:700;">${c.subject}</span>
          <h3 style="margin: 8px 0 15px 0;">${c.title}</h3>
          <div style="display:flex; gap:10px;">
            <button onclick="openTopic(${c.id})" class="btn-sm"><i data-lucide="play-circle"></i> View Topic</button>
            ${canDelete(c) ? `<button onclick="deleteItem('courses', ${c.id})" class="btn-sm btn-danger"><i data-lucide="trash"></i></button>` : ''}
          </div>
        </div>
      `).join('');
      lucide.createIcons();
    }

    function renderLibrary() {
      const container = document.getElementById('library-grid');
      const filtered = DB.library.filter(l => hasAccess(l.subject));

      container.innerHTML = filtered.map(item => `
        <div class="glass-card">
          <span style="font-size:0.7rem; color: var(--accent-copper-dark); font-weight:700;">${item.subject}</span>
          <h3 style="margin: 8px 0 10px 0;">${item.title}</h3>
          <div>${linkify(item.url)}</div>
          ${canDelete(item) ? `<button onclick="deleteItem('library', ${item.id})" class="btn-sm btn-danger" style="margin-top:15px;">Delete</button>` : ''}
        </div>
      `).join('');
    }

    function renderJobs() {
      const container = document.getElementById('job-grid');
      container.innerHTML = DB.jobs.map(item => `
        <div class="glass-card">
          <h3>${item.title}</h3>
          <div style="color:var(--text-muted); font-size:0.85rem; margin: 6px 0 10px 0;">Company: ${item.company}</div>
          <div>Apply Link: ${linkify(item.link)}</div>
          ${canDelete(item) ? `<button onclick="deleteItem('jobs', ${item.id})" class="btn-sm btn-danger" style="margin-top:15px;">Delete</button>` : ''}
        </div>
      `).join('');
    }

    function renderProfile() {
      document.getElementById('p-user').innerText = currentUser.username;
      document.getElementById('p-role').innerText = currentUser.role.toUpperCase();
      document.getElementById('p-override').innerText = currentUser.subject_all ? 'Active (Full Platform Access)' : 'Inactive';
      
      const el = document.getElementById('p-subjects');
      if(currentUser.subject_all) {
        el.innerHTML = `<span class="pill-badge badge-editor">All Subjects Included</span>`;
      } else {
        el.innerHTML = currentUser.allowed_subjects.map(s => `<span class="pill-badge badge-student">${s}</span>`).join('');
      }
    }

    /* 7. INTERACTION CONTROLLERS */
    function openTopic(id) {
      activeTopicId = id;
      const c = DB.courses.find(x => x.id === id);
      document.getElementById('courses-catalog').style.display = 'none';
      document.getElementById('topic-detail').style.display = 'block';

      document.getElementById('topic-title').innerText = c.title;
      document.getElementById('topic-notes').innerHTML = linkify(c.notes);

      const embed = getYtEmbed(c.ytUrl);
      document.getElementById('video-wrapper').innerHTML = embed 
        ? `<iframe src="${embed}" allowfullscreen></iframe>`
        : `<div style="padding:30px; text-align:center;">Link: ${linkify(c.ytUrl)}</div>`;

      renderComments();
    }

    function closeTopic() {
      document.getElementById('topic-detail').style.display = 'none';
      document.getElementById('courses-catalog').style.display = 'block';
      document.getElementById('video-wrapper').innerHTML = '';
      activeTopicId = null;
    }

    function renderComments() {
      const c = DB.courses.find(x => x.id === activeTopicId);
      document.getElementById('comment-list').innerHTML = c.comments.map(cm => `
        <div style="background: rgba(255,255,255,0.6); padding: 10px 14px; border-radius: 8px; margin-bottom: 8px;">
          <div style="font-size:0.75rem; color:var(--accent-copper);">${cm.author}</div>
          <div>${linkify(cm.text)}</div>
        </div>
      `).join('') || '<p style="color:var(--text-muted); font-size:0.85rem;">No comments posted yet.</p>';
    }

    function postComment() {
      const inp = document.getElementById('comm-input');
      if(!inp.value.trim()) return;

      const c = DB.courses.find(x => x.id === activeTopicId);
      c.comments.push({ author: currentUser.username, text: inp.value });
      inp.value = '';
      renderComments();
    }

    function deleteItem(type, id) {
      DB[type] = DB[type].filter(x => x.id !== id);
      renderAll();
    }

    function createItem(type) {
      const title = prompt(`Enter ${type} title:`);
      if(!title) return;

      if(type === 'announcement') {
        const body = prompt('Enter announcement content/links:');
        DB.announcements.push({ id: Date.now(), title, body, author: currentUser.username });
      } else if(type === 'course') {
        const subject = prompt('Enter Subject Name:');
        const ytUrl = prompt('Enter YouTube Link:');
        const notes = prompt('Enter Notes/Documentation:');
        DB.courses.push({ id: Date.now(), subject, title, ytUrl, notes, author: currentUser.username, comments: [] });
      } else if(type === 'library') {
        const subject = prompt('Enter Subject Name:');
        const url = prompt('Enter Resource URL:');
        DB.library.push({ id: Date.now(), subject, title, url, author: currentUser.username });
      } else if(type === 'job') {
        const company = prompt('Enter Company Name:');
        const link = prompt('Enter Job Link:');
        DB.jobs.push({ id: Date.now(), title, company, link, author: currentUser.username });
      }

      renderAll();
    }

    window.onload = () => {
      init3D();
      lucide.createIcons();
    };
  </script>
</body>
</html>
