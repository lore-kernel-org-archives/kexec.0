Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XK3pK-000758-3J
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:13:16 +0000
Received: from 157.15.12.109.rev.sfr.net ([109.12.15.157]
 helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <louis.bouchard@ubuntu.com>)
 id 1XK3ov-0001qN-9o
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:12:49 +0000
From: Louis Bouchard <louis.bouchard@ubuntu.com>
Subject: [PATCH 2/9] Implement propagate to send ssh key file to remote server
Date: Wed, 20 Aug 2014 13:11:13 +0200
Message-Id: <1408533080-17838-3-git-send-email-louis.bouchard@ubuntu.com>
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
 debian/kdump-config        | 69 ++++++++++++++++++++++++++++++++++++++--------
 debian/kdump-tools.default |  2 ++
 2 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/debian/kdump-config b/debian/kdump-config
index 4e283ab..b0164dd 100755
--- a/debian/kdump-config
+++ b/debian/kdump-config
@@ -24,6 +24,7 @@
 #	* unloading a kdump kernel
 #	* saving a vmcore kdump kernel
 #	* determining the status of kdump
+#	* propagate ssh key to remote host
 
 PATH=/bin:/usr/bin:/sbin:/usr/sbin
 NAME=${NAME:="kdump-config"}
@@ -61,17 +62,18 @@ function kdump_help()
 {
 cat <<EOHELP
 Usage:
-kdump-config {help|test|show|status|load|unload|savecore}"
-  help     - print this page
-  test     - Do a dry-run of the load command.  Show the kernels and
-             parameters that will be used and echo the kexec command.
-             The kexec command will not be executed.
-  show     - Show kdump status, kexec command, and any current parameters.
-  status   - evaluate /sys/kernel/kexec_crash_loaded and print a message
-  load     - Locate the kdump kernel, debug kernel, and establish links for
-             makedumpfile.  Then load the kdump kernel using kexec
-  unload   - unload the kdump kernel using kexec
-  savecore - use previously made links to save /proc/vmcore
+kdump-config {help|test|show|status|load|unload|savecore|propagate}"
+  help      - print this page
+  test      - Do a dry-run of the load command.  Show the kernels and
+              parameters that will be used and echo the kexec command.
+              The kexec command will not be executed.
+  show      - Show kdump status, kexec command, and any current parameters.
+  status    - evaluate /sys/kernel/kexec_crash_loaded and print a message
+  load      - Locate the kdump kernel, debug kernel, and establish links for
+              makedumpfile.  Then load the kdump kernel using kexec
+  unload    - unload the kdump kernel using kexec
+  savecore  - use previously made links to save /proc/vmcore
+  propagate - Send public ssh key to remote host for passwordless connection
 
 EOHELP
 }
@@ -430,6 +432,46 @@ function kdump_save_core_to_ssh()
 	fi
 }
 
+function kdump_propagate()
+{
+KDUMP_COREDIR=${KDUMP_COREDIR:=/var/crash}
+	KDUMP_SSH_KEY="${SSH_KEY:=/root/.ssh/kdump_id_rsa}"
+	KDUMP_REMOTE_HOST="$SSH"
+
+	# ssh key propagation is only needed
+	# if remote ssh dump is configured
+	if [ -z $KDUMP_REMOTE_HOST ];then
+		log_failure_msg "$NAME: Remote ssh dump is not configured. No reason to propagate"
+		logger -t $NAME "Remote ssh dump is not configured. No reason to propagate"
+		return 1;
+	fi
+
+	# Verify if the provided key exists and create it if needed
+	if [ -f $KDUMP_SSH_KEY ];then
+		echo "Using existing key $KDUMP_SSH_KEY"
+	else
+		echo "Need to generate a new ssh key..."
+		/usr/bin/ssh-keygen -t rsa -f $KDUMP_SSH_KEY -N "" 2>&1 > /dev/null
+	fi
+
+	KDUMP_SSH_USER=${KDUMP_REMOTE_HOST%@*}
+	KDUMP_SSH_TARGET=${KDUMP_REMOTE_HOST#*@}
+
+	ssh-copy-id -i $KDUMP_SSH_KEY $KDUMP_SSH_USER@$KDUMP_SSH_TARGET &>/dev/null
+	ERROR=$?
+
+	if [ $ERROR -ne 0 ];then
+		log_failure_msg "$NAME: $KDUMP_SSH_KEY failed to be sent to $KDUMP_REMOTE_HOST"
+		logger -t $NAME "$KDUMP_SSH_KEY failed to be sent to $KDUMP_REMOTE_HOST"
+		return 1;
+	else
+		logger -t $NAME "propagated ssh key $KDUMP_SSH_KEY to server $KDUMP_REMOTE_HOST"
+		echo "propagated ssh key $KDUMP_SSH_KEY to server $KDUMP_REMOTE_HOST"
+		return 0;
+	fi
+
+}
+
 
 
 case "$1" in
@@ -470,11 +512,14 @@ case "$1" in
 	fi
 	exit $?
 	;;
+  propagate)
+	kdump_propagate;
+	;;
   help|-h*|--h*)
 	kdump_help
 	;;
   *)
-	echo "Usage: $0 {help|test|show|status|load|unload|savecore}"
+	echo "Usage: $0 {help|test|show|status|load|unload|savecore|propagate}"
 	exit 1
 	;;
 esac
diff --git a/debian/kdump-tools.default b/debian/kdump-tools.default
index e5e3bec..d870523 100644
--- a/debian/kdump-tools.default
+++ b/debian/kdump-tools.default
@@ -72,3 +72,5 @@ KDUMP_COREDIR="/var/crash"
 # NFS="<nfs mount>"
 #
 # NFS4="<nfs mount>"
+#
+# SSH_KEY="<path>"
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
