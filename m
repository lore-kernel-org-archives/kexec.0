Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XK3pK-00075C-3G
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:13:15 +0000
Received: from 157.15.12.109.rev.sfr.net ([109.12.15.157]
 helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <louis.bouchard@ubuntu.com>)
 id 1XK3ov-0001qN-LU
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:12:49 +0000
From: Louis Bouchard <louis.bouchard@ubuntu.com>
Subject: [PATCH 3/9] Add comments to default/kdump-tools to outline
 functionality
Date: Wed, 20 Aug 2014 13:11:14 +0200
Message-Id: <1408533080-17838-4-git-send-email-louis.bouchard@ubuntu.com>
In-Reply-To: <1408533080-17838-1-git-send-email-louis.bouchard@ubuntu.com>
References: <1408533080-17838-1-git-send-email-louis.bouchard@ubuntu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Signed-off-by: Louis Bouchard <louis.bouchard@ubuntu.com>
---
 debian/kdump-config        | 1 -
 debian/kdump-tools.default | 7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/debian/kdump-config b/debian/kdump-config
index b0164dd..1184d6d 100755
--- a/debian/kdump-config
+++ b/debian/kdump-config
@@ -434,7 +434,6 @@ function kdump_save_core_to_ssh()
 
 function kdump_propagate()
 {
-KDUMP_COREDIR=${KDUMP_COREDIR:=/var/crash}
 	KDUMP_SSH_KEY="${SSH_KEY:=/root/.ssh/kdump_id_rsa}"
 	KDUMP_REMOTE_HOST="$SSH"
 
diff --git a/debian/kdump-tools.default b/debian/kdump-tools.default
index d870523..8ef95b8 100644
--- a/debian/kdump-tools.default
+++ b/debian/kdump-tools.default
@@ -65,7 +65,12 @@ KDUMP_COREDIR="/var/crash"
 # Architecture specific Overrides:
 
 # ---------------------------------------------------------------------------
-# Remote dump facilities
+# Remote dump facilities:
+# SSH - username and hostname of the remote server that will receive the dump
+# 	and dmesg files.
+# SSH_KEY - Full path of the ssh private key to be used to login to the remote
+# 	    server. use kdump-config propagate to send the public key to the
+# 	    remote server
 #
 # SSH="<user@server>"
 #
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
