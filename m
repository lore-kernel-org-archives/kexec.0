Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XK3pK-00075H-3U
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:13:16 +0000
Received: from 157.15.12.109.rev.sfr.net ([109.12.15.157]
 helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <louis.bouchard@ubuntu.com>)
 id 1XK3ow-0001qN-KZ
 for kexec@lists.infradead.org; Wed, 20 Aug 2014 11:12:50 +0000
From: Louis Bouchard <louis.bouchard@ubuntu.com>
Subject: [PATCH 6/9] Add NFS remote dump collection
Date: Wed, 20 Aug 2014 13:11:17 +0200
Message-Id: <1408533080-17838-7-git-send-email-louis.bouchard@ubuntu.com>
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

Refactor subdirectory definition into a function

Create define_stampdir() that will create the subdirectoy
where the dump is sent to according to the values of the
SSH, NFS and HOSTTAG variables. Nothing is added if the
dump is local
Signed-off-by: Louis Bouchard <louis.bouchard@ubuntu.com>
---
 debian/kdump-config | 97 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 77 insertions(+), 20 deletions(-)

diff --git a/debian/kdump-config b/debian/kdump-config
index 5913478..2818b56 100755
--- a/debian/kdump-config
+++ b/debian/kdump-config
@@ -306,6 +306,29 @@ function kdump_unload()
 	fi
 }
 
+#
+# Return the name of the subdirectory to store core file.
+#	Will add hostname/IP according to the value of
+#	HOSTTAG if networked dump is selected
+
+function define_stampdir()
+{
+	STAMP=$1
+	HOSTTAG="${HOSTTAG:=ip}"
+
+	if [ -z "$SSH" ] && [ -z "$NFS" ]; then
+		echo "$KDUMP_COREDIR/$STAMP"
+	elif [ $HOSTTAG = "hostname" ];then
+		echo "$KDUMP_COREDIR/$(hostname)-$STAMP"
+	else
+		THIS_HOST="$(hostname -I)"
+		set -a $THIS_HOST
+		THIS_HOST=$1
+		echo "$KDUMP_COREDIR/$THIS_HOST-$STAMP"
+	fi
+}
+
+
 # Saving the vmcore:
 #	Our priorities are:
 #	  1. If the makedumpfile config link is valid, use that
@@ -313,33 +336,64 @@ function kdump_unload()
 #	  3. else fallback to using:  makedumpfile -d 1 -c
 #	  4. else use cp
 #
-# TODO: implement different transport options other than
-# store to local disk
-#
 # Returns: 0/1 (success/fail)
 # Sets: KDUMP_STAMPDIR, KDUMP_COREFILE
 function kdump_save_core()
 {
 	KDUMP_STAMP=`date +"%Y%m%d%H%M"`
-	KDUMP_STAMPDIR="$KDUMP_COREDIR/$KDUMP_STAMP"
+	KDUMP_STAMPDIR=$(define_stampdir $KDUMP_STAMP)
 	KDUMP_CORETEMP="$KDUMP_STAMPDIR/dump-incomplete"
 	KDUMP_COREFILE="$KDUMP_STAMPDIR/dump.$KDUMP_STAMP"
 	KDUMP_DMESGFILE="$KDUMP_STAMPDIR/dmesg.$KDUMP_STAMP"
 
-	mkdir -p $KDUMP_STAMPDIR
+	# If we use NFS, verify that we can mount the FS
+	#
+	if [ -n "$NFS" ];then
+		log_action_msg "Mounting NFS mountpoint $NFS ..."
+		mount -t nfs -o nolock -o tcp -o soft -o timeo=5 -o retrans=5 $NFS $KDUMP_COREDIR
+		ERROR=$?
+		if [ $ERROR -ne 0 ];then
+			log_failure_msg "$NAME: Unable to mount remote NFS directory $NFS. Cannot save core"
+			logger -t $NAME "Unable to mount remote NFS directory $NFS. Cannot save core"
+			return 1;
+		fi
+
+		# FS is mounted, see if we can write to it
+		#
+		mkdir -p $KDUMP_STAMPDIR
+		ERROR=$?
+
+		if [ $ERROR -ne 0 ];then
+			log_failure_msg "$NAME: Unable to write to the remote NFS directory $NFS. Cannot save core"
+			logger -t $NAME "Unable to write to the remote NFS directory $NFS. Cannot save core"
+			umount $KDUMP_COREDIR
+			UMNT_ERROR=$?
+			if [ $UMNT_ERROR -ne 0 ];then
+				log_failure_msg "$NAME: Unable to cleanly unmount the NFS file system"
+				logger -t $NAME "Unable to cleanly unmount the NFS file system"
+			fi
+		else
+			log_action_msg "Dumping to NFS mountpoint $NFS/$KDUMP_STAMP"
+			logger -t $NAME "Dumping to NFS mountpoint $NFS/$KDUMP_STAMP"
+		fi
+	else
+		mkdir -p $KDUMP_STAMPDIR
+	fi
 
 	log_action_msg "running makedumpfile $MAKEDUMP_ARGS $vmcore_file $KDUMP_CORETEMP"
 	makedumpfile $MAKEDUMP_ARGS $vmcore_file $KDUMP_CORETEMP
-	if [ $? -ne 0 ] ; then
+	ERROR=$?
+	if [ $ERROR -ne 0 ] ; then
 		log_failure_msg "$NAME: makedumpfile failed, falling back to 'cp'"
 		logger -t $NAME "makedumpfile failed, falling back to 'cp'"
 		KDUMP_CORETEMP="$KDUMP_STAMPDIR/vmcore-incomplete"
 		KDUMP_COREFILE="$KDUMP_STAMPDIR/vmcore.$KDUMP_STAMP"
 		cp $vmcore_file $KDUMP_CORETEMP
+		ERROR=$?
 	fi
 
 	# did we succeed?
-	if [ $? == 0 ]; then
+	if [ $ERROR == 0 ]; then
 		mv $KDUMP_CORETEMP $KDUMP_COREFILE
 		log_success_msg "$NAME: saved vmcore in $KDUMP_STAMPDIR"
 		logger -t $NAME "saved vmcore in $KDUMP_STAMPDIR"
@@ -360,30 +414,33 @@ function kdump_save_core()
 	if [ $ERROR == 0 ]; then
 		log_success_msg "$NAME: saved dmesg content in $KDUMP_STAMPDIR"
 		logger -t $NAME "saved dmesg content in $KDUMP_STAMPDIR"
-		return 0;
 	else
 		log_failure_msg "$NAME: failed to save dmesg content in $KDUMP_STAMPDIR"
 		logger -t $NAME "failed to save dmesg content in $KDUMP_STAMPDIR"
-		return 1;
 	fi
+
+	# If we use NFS, umount the remote FS
+	#
+	if [ -n "$NFS" ];then
+		umount $KDUMP_COREDIR
+		UMNT_ERROR=$?
+		if [ $UMNT_ERROR -ne 0 ] ; then
+			log_failure_msg "$NAME: Unable to cleanly unmount the NFS file system"
+			logger -t $NAME "Unable to cleanly unmount the NFS file system"
+		fi
+	fi
+
+	return $ERROR
 }
 
 function kdump_save_core_to_ssh()
 {
 	KDUMP_SSH_KEY="${SSH_KEY:=/root/.ssh/kdump_id_rsa}"
 	KDUMP_REMOTE_HOST="$SSH"
-	KDUMP_STAMP=`date +"%Y%m%d%H%M"`
-	HOSTTAG="${HOSTTAG:=ip}"
 
-	if [ $HOSTTAG = "hostname" ];then
-		THIS_HOST="$(hostname)"
-	else
-		THIS_HOST="$(hostname -I)"
-		set -a $THIS_HOST
-		THIS_HOST=$1
-	fi
+	KDUMP_STAMP=`date +"%Y%m%d%H%M"`
+	KDUMP_STAMPDIR=$(define_stampdir $KDUMP_STAMP)
 
-	KDUMP_STAMPDIR="$KDUMP_COREDIR/$THIS_HOST-$KDUMP_STAMP"
 	KDUMP_CORETEMP="$KDUMP_STAMPDIR/dump-incomplete"
 	KDUMP_COREFILE="$KDUMP_STAMPDIR/dump.$KDUMP_STAMP"
 	KDUMP_TMPDMESG="/tmp/dmesg.$KDUMP_STAMP"
@@ -523,7 +580,7 @@ case "$1" in
 	exit 0;
 	;;
   savecore)
-	if ! [ -z $SSH ] || ! [ -z $NFS ] || [ -z NFS4 ]];then
+	if ! [ -z $SSH ];then
 		kdump_save_core_to_ssh
 	else
 		kdump_save_core
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
