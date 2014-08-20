Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XK3pK-00075D-3M
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:13:15 +0000
Received: from 157.15.12.109.rev.sfr.net ([109.12.15.157]
 helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <louis.bouchard@ubuntu.com>)
 id 1XK3ov-0001qN-VW
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:12:50 +0000
From: Louis Bouchard <louis.bouchard@ubuntu.com>
Subject: [PATCH 4/9] Add a prefix to the timestamped directory
Date: Wed, 20 Aug 2014 13:11:15 +0200
Message-Id: <1408533080-17838-5-git-send-email-louis.bouchard@ubuntu.com>
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

When sending the dump to a remote server, add IP address
or hostname as a prefix to the timestamped directory.
IP address is the default.

Signed-off-by: Louis Bouchard <louis.bouchard@ubuntu.com>
---
 debian/kdump-config        | 14 ++++++++++++--
 debian/kdump-tools.default |  5 +++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/debian/kdump-config b/debian/kdump-config
index 1184d6d..d97de02 100755
--- a/debian/kdump-config
+++ b/debian/kdump-config
@@ -362,9 +362,19 @@ function kdump_save_core()
 function kdump_save_core_to_ssh()
 {
 	KDUMP_SSH_KEY="${SSH_KEY:=/root/.ssh/kdump_id_rsa}"
-	KDUMP_STAMP=`date +"%Y%m%d%H%M"`
 	KDUMP_REMOTE_HOST="$SSH"
-	KDUMP_STAMPDIR="$KDUMP_COREDIR/$KDUMP_STAMP"
+	KDUMP_STAMP=`date +"%Y%m%d%H%M"`
+	HOSTTAG="${HOSTTAG:=ip}"
+
+	if [ $HOSTTAG = "hostname" ];then
+		THIS_HOST="$(hostname)"
+	else
+		THIS_HOST="$(hostname -I)"
+		set -a $THIS_HOST
+		THIS_HOST=$1
+	fi
+
+	KDUMP_STAMPDIR="$KDUMP_COREDIR/$THIS_HOST-$KDUMP_STAMP"
 	KDUMP_CORETEMP="$KDUMP_STAMPDIR/dump-incomplete"
 	KDUMP_COREFILE="$KDUMP_STAMPDIR/dump.$KDUMP_STAMP"
 	KDUMP_TMPDMESG="/tmp/dmesg.$KDUMP_STAMP"
diff --git a/debian/kdump-tools.default b/debian/kdump-tools.default
index 8ef95b8..c391f3c 100644
--- a/debian/kdump-tools.default
+++ b/debian/kdump-tools.default
@@ -71,9 +71,14 @@ KDUMP_COREDIR="/var/crash"
 # SSH_KEY - Full path of the ssh private key to be used to login to the remote
 # 	    server. use kdump-config propagate to send the public key to the
 # 	    remote server
+# HOSTTAG - Select if hostname of IP address will be used as a prefix to the
+#           timestamped directory when sending files to the remote server.
+#           'ip' is the default.
 #
 # SSH="<user@server>"
 #
+# HOSTTAG="hostname|[ip]"
+# 
 # NFS="<nfs mount>"
 #
 # NFS4="<nfs mount>"
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
