From: Simon Horman <horms@verge.net.au>
Date: Wed, 23 Mar 2022 15:02:20 +0100
Subject: [PATCH kexec-tools] github: run apt-get update before installing
 packages
Message-ID: <20220323140220.358948-1-horms@verge.net.au>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Refresh package database before installing dependencies to avoid failures
due to trying to install older, no longer available, versions of packages.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 .github/workflows/build.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

 Workflow run
 - https://github.com/horms/kexec-tools/actions/runs/2028827809

diff --git a/.github/workflows/build.yml b/.github/workflows/build.yml
index df35703a27e0..e554751e0017 100644
--- a/.github/workflows/build.yml
+++ b/.github/workflows/build.yml
@@ -61,7 +61,9 @@ jobs:
 
     - name: Install Dependencies
       if: env.EXTRA_PKGS != ''
-      run: sudo apt-get -q=2 install ${{ env.EXTRA_PKGS }}
+      run: |
+        sudo apt-get update
+        sudo apt-get -q=2 install ${{ env.EXTRA_PKGS }}
 
     - name: Build
       run: |
-- 
2.30.2


