Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XK3pK-00075A-3U
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:13:16 +0000
Received: from 157.15.12.109.rev.sfr.net ([109.12.15.157]
 helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <louis.bouchard@ubuntu.com>)
 id 1XK3ou-0001qN-Um
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:12:49 +0000
From: Louis Bouchard <louis.bouchard@ubuntu.com>
Subject: [PATCH 1/9] Add SSH remote dump collection mechanism
Date: Wed, 20 Aug 2014 13:11:12 +0200
Message-Id: <1408533080-17838-2-git-send-email-louis.bouchard@ubuntu.com>
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

Make Error testing coherent to all sections
Add initial SSH connectivity verification to remote host
use ssh -i with explicit key location

On Ubuntu kdump-config runs as root with / as $HOME so it cannot
locate the .ssh directory. Tell the ssh commands where to find
it explicitely

Signed-off-by: Louis Bouchard <louis.bouchard@ubuntu.com>
---
 debian/kdump-config        | 79 +++++++++++++++++++++++++++++++++++++++++++++-
 debian/kdump-tools.default |  9 ++++++
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/debian/kdump-config b/debian/kdump-config
index 2e6cad9..4e283ab 100755
--- a/debian/kdump-config
+++ b/debian/kdump-config
@@ -357,6 +357,79 @@ function kdump_save_core()
 	fi
 }
 
+function kdump_save_core_to_ssh()
+{
+	KDUMP_SSH_KEY="${SSH_KEY:=/root/.ssh/kdump_id_rsa}"
+	KDUMP_STAMP=`date +"%Y%m%d%H%M"`
+	KDUMP_REMOTE_HOST="$SSH"
+	KDUMP_STAMPDIR="$KDUMP_COREDIR/$KDUMP_STAMP"
+	KDUMP_CORETEMP="$KDUMP_STAMPDIR/dump-incomplete"
+	KDUMP_COREFILE="$KDUMP_STAMPDIR/dump.$KDUMP_STAMP"
+	KDUMP_TMPDMESG="/tmp/dmesg.$KDUMP_STAMP"
+	KDUMP_DMESGFILE="$KDUMP_STAMPDIR/dmesg.$KDUMP_STAMP"
+	ERROR=0
+
+	ssh -i $KDUMP_SSH_KEY $KDUMP_REMOTE_HOST mkdir -p $KDUMP_STAMPDIR
+	ERROR=$?
+	# If remote connections fails, no need to continue
+	if [ $ERROR -ne 0 ] ; then
+		log_failure_msg "$NAME: Unable to reach remote server $KDUMP_REMOTE_HOST. No reason to continue"
+		logger -t $NAME "Unable to reach remote server $KDUMP_REMOTE_HOST. No reason to continue"
+		return 1
+	fi
+
+	log_action_msg "sending makedumpfile $MAKEDUMP_ARGS $vmcore_file to $KDUMP_REMOTE_HOST : $KDUMP_CORETEMP"
+	makedumpfile $MAKEDUMP_ARGS $vmcore_file | ssh -i $KDUMP_SSH_KEY $KDUMP_REMOTE_HOST dd of=$KDUMP_CORETEMP
+	ERROR=$?
+	if [ $ERROR -ne 0 ] ; then
+		log_failure_msg "$NAME: makedumpfile failed, falling back to 'scp'"
+		logger -t $NAME "makedumpfile failed, falling back to 'scp'"
+		KDUMP_CORETEMP="$KDUMP_STAMPDIR/vmcore-incomplete"
+		KDUMP_COREFILE="$KDUMP_STAMPDIR/vmcore.$KDUMP_STAMP"
+		scp -i $KDUMP_SSH_KEY $vmcore_file $KDUMP_REMOTE_HOST:$KDUMP_CORETEMP
+		if [ $? -ne 0 ];then
+			log_failure_msg "$NAME: makedumpfile scp failed. The vmcore file will  not be available"
+			logger -t $NAME "makedumpfile scp failed. The vmcore file will  not be available"
+		else
+			ERROR=0
+		fi
+	else
+		ERROR=0
+	fi
+
+	# did we succeed?
+	if [ $ERROR -ne 0 ]; then
+		log_failure_msg "$NAME: failed to save vmcore in $KDUMP_REMOTE_HOST:$KDUMP_STAMPDIR"
+		logger -t $NAME "failed to save vmcore in $KDUMP_REMOTE_HOST:$KDUMP_STAMPDIR"
+	else
+		ssh -i $KDUMP_SSH_KEY $KDUMP_REMOTE_HOST mv $KDUMP_CORETEMP $KDUMP_COREFILE
+		log_success_msg "$NAME: saved vmcore in $KDUMP_REMOTE_HOST:$KDUMP_STAMPDIR"
+		logger -t $NAME "saved vmcore in $KDUMP_REMOTE_HOST:$KDUMP_STAMPDIR"
+	fi
+
+	log_action_msg "running makedumpfile --dump-dmesg $vmcore_file $KDUMP_TMPDMESG"
+	makedumpfile --dump-dmesg $vmcore_file $KDUMP_TMPDMESG
+	ERROR=$?
+	if [ $ERROR -ne 0 ] ; then
+		log_failure_msg "$NAME: makedumpfile --dump-dmesg failed. dmesg content will be unavailable"
+		logger -t $NAME "makedumpfile --dump-dmesg failed. dmesg content will be unavailable"
+	else
+		scp -i $KDUMP_SSH_KEY $KDUMP_TMPDMESG $KDUMP_REMOTE_HOST:$KDUMP_DMESGFILE
+		ERROR=$?
+	fi
+
+	# did we succeed?
+	if [ $ERROR == 0 ]; then
+		log_success_msg "$NAME: saved dmesg content in $KDUMP_REMOTE_HOST:$KDUMP_STAMPDIR"
+		logger -t $NAME "saved dmesg content in $KDUMP_REMOTE_HOST:$KDUMP_STAMPDIR"
+		return 0;
+	else
+		log_failure_msg "$NAME: failed to save dmesg content in $KDUMP_REMOTE_HOST:$KDUMP_STAMPDIR"
+		logger -t $NAME "failed to save dmesg content in $KDUMP_REMOTE_HOST:$KDUMP_STAMPDIR"
+		return 1;
+	fi
+}
+
 
 
 case "$1" in
@@ -390,7 +463,11 @@ case "$1" in
 	exit 0;
 	;;
   savecore)
-	kdump_save_core
+	if ! [ -z $SSH ] || ! [ -z $NFS ] || [ -z NFS4 ]];then
+		kdump_save_core_to_ssh
+	else
+		kdump_save_core
+	fi
 	exit $?
 	;;
   help|-h*|--h*)
diff --git a/debian/kdump-tools.default b/debian/kdump-tools.default
index 8d02da0..e5e3bec 100644
--- a/debian/kdump-tools.default
+++ b/debian/kdump-tools.default
@@ -63,3 +63,12 @@ KDUMP_COREDIR="/var/crash"
 
 # ---------------------------------------------------------------------------
 # Architecture specific Overrides:
+
+# ---------------------------------------------------------------------------
+# Remote dump facilities
+#
+# SSH="<user@server>"
+#
+# NFS="<nfs mount>"
+#
+# NFS4="<nfs mount>"
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
