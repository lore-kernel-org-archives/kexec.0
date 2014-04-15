Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZvU0-0007aT-B7
 for kexec@lists.infradead.org; Tue, 15 Apr 2014 05:00:33 +0000
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aruna@linux.vnet.ibm.com>;
 Tue, 15 Apr 2014 10:30:04 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 28443125804D
 for <kexec@lists.infradead.org>; Tue, 15 Apr 2014 10:32:42 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3F5082v5570818
 for <kexec@lists.infradead.org>; Tue, 15 Apr 2014 10:30:08 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3F502Mi011738
 for <kexec@lists.infradead.org>; Tue, 15 Apr 2014 10:30:02 +0530
Subject: [PATCH] makedumpfile/eppic: Do not scrub buffer length if length is
 zero
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Tue, 15 Apr 2014 10:30:02 +0530
Message-ID: <20140415045938.15285.65667.stgit@aruna-ThinkPad-T420>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp

The patch takes care of scrubbing buffer length only when it is
non-zero.

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 eppic_scripts/ap_messages.c        |   12 ++++++++----
 eppic_scripts/tcp_sk_buf.c         |   12 ++++++++----
 eppic_scripts/udp_sk_buf.c         |   12 ++++++++----
 eppic_scripts/unix_sk_buff.c       |   12 ++++++++----
 eppic_scripts/vhost_net_buffers.c  |   12 ++++++++----
 eppic_scripts/vhost_scsi_buffers.c |   10 +++++++---
 6 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/eppic_scripts/ap_messages.c b/eppic_scripts/ap_messages.c
index f0e9f6f..849e9bc 100644
--- a/eppic_scripts/ap_messages.c
+++ b/eppic_scripts/ap_messages.c
@@ -51,8 +51,10 @@ ap_device()
 			struct ap_message *apmsg;
 			apmsg = (struct ap_message *)next1;
 
-			memset((char *)apmsg->message, 'L', apmsg->length);
-			memset((char *)&(apmsg->length), 'L', 0x8);
+			if (apmsg->length) {
+				memset((char *)apmsg->message, 'L', apmsg->length);
+				memset((char *)&(apmsg->length), 'L', 0x8);
+			}
 
 			next1 = (struct list_head *)apmsg->list.next;
 		}
@@ -65,8 +67,10 @@ ap_device()
 			struct ap_message *apmsg;
 			apmsg = (struct ap_message *)next1;
 
-			memset((char *)apmsg->message, 'L', apmsg->length);
-			memset((char *)&(apmsg->length), 'L', 0x8);
+			if (apmsg->length) {
+				memset((char *)apmsg->message, 'L', apmsg->length);
+				memset((char *)&(apmsg->length), 'L', 0x8);
+			}
 
 			next1 = (struct list_head *)apmsg->list.next;
 		}
diff --git a/eppic_scripts/tcp_sk_buf.c b/eppic_scripts/tcp_sk_buf.c
index 4c3efc3..922f507 100644
--- a/eppic_scripts/tcp_sk_buf.c
+++ b/eppic_scripts/tcp_sk_buf.c
@@ -51,8 +51,10 @@ tcp()
 			{
 				struct sk_buff *buff = (struct sk_buff *) next;
 
-				memset((char *)buff->data, 'L', buff->data_len);
-				memset((char *)&(buff->data_len), 'L', 0x4);
+				if (buff->data_len) {
+					memset((char *)buff->data, 'L', buff->data_len);
+					memset((char *)&(buff->data_len), 'L', 0x4);
+				}
 
 				next = buff->next;
 			}
@@ -64,8 +66,10 @@ tcp()
 			{
 				struct sk_buff *buff = (struct sk_buff *) next;
 
-				memset((char *)buff->data, 'L', buff->data_len);
-				memset((char *)&(buff->data_len), 'L', 0x4);
+				if (buff->data_len) {
+					memset((char *)buff->data, 'L', buff->data_len);
+					memset((char *)&(buff->data_len), 'L', 0x4);
+				}
 
 				next = buff->next;
 			}
diff --git a/eppic_scripts/udp_sk_buf.c b/eppic_scripts/udp_sk_buf.c
index 7e64300..0fa1325 100644
--- a/eppic_scripts/udp_sk_buf.c
+++ b/eppic_scripts/udp_sk_buf.c
@@ -52,8 +52,10 @@ udp()
 			{
 				struct sk_buff *buff = (struct sk_buff *)next;
 
-				memset((char *)buff->data, 'L', buff->data_len);
-				memset((char *)&(buff->data_len), 'L', 0x4);
+				if (buff->data_len) {
+					memset((char *)buff->data, 'L', buff->data_len);
+					memset((char *)&(buff->data_len), 'L', 0x4);
+				}
 
 				next = buff->next;
 			}
@@ -65,8 +67,10 @@ udp()
 			{
 				struct sk_buff *buff = (struct sk_buff *)next;
 
-				memset((char *)buff->data, 'L', buff->data_len);
-				memset((char *)&(buff->data_len), 'L', 0x4);
+				if (buff->data_len) {
+					memset((char *)buff->data, 'L', buff->data_len);
+					memset((char *)&(buff->data_len), 'L', 0x4);
+				}
 
 				next = buff->next;
                         }
diff --git a/eppic_scripts/unix_sk_buff.c b/eppic_scripts/unix_sk_buff.c
index 6ab1e6c..12e1e6c 100644
--- a/eppic_scripts/unix_sk_buff.c
+++ b/eppic_scripts/unix_sk_buff.c
@@ -54,8 +54,10 @@ sunix()
 			{
 				struct sk_buff *buff = (struct sk_buff *)next;
 
-				memset((char *)buff->data, 'L', buff->data_len);
-				memset((char *)&(buff->data_len), 'L', 0x4);
+				if (buff->data_len) {
+					memset((char *)buff->data, 'L', buff->data_len);
+					memset((char *)&(buff->data_len), 'L', 0x4);
+				}
 
 				next = buff->next;
 			}
@@ -67,8 +69,10 @@ sunix()
 			{
 				struct sk_buff *buff = (struct sk_buff *)next;
 
-				memset((char *)buff->data, 'L', buff->data_len);
-				memset((char *)&(buff->data_len), 'L', 0x4);
+				if (buff->data_len) {
+					memset((char *)buff->data, 'L', buff->data_len);
+					memset((char *)&(buff->data_len), 'L', 0x4);
+				}
 
 			        next = buff->next;
 			}
diff --git a/eppic_scripts/vhost_net_buffers.c b/eppic_scripts/vhost_net_buffers.c
index 6c2b8df..39ae595 100644
--- a/eppic_scripts/vhost_net_buffers.c
+++ b/eppic_scripts/vhost_net_buffers.c
@@ -40,8 +40,10 @@ vhost_net(struct vhost_net *net)
 		{
 			struct sk_buff *buff = (struct sk_buff *) next;
 
-			memset((unsigned char *)buff->data, 'L', buff->data_len);
-			memset((char *)&(buff->data_len), 'L', 0x4);
+			if (buff->data_len) {
+				memset((char *)buff->data, 'L', buff->data_len);
+				memset((char *)&(buff->data_len), 'L', 0x4);
+			}
 
 			next = buff->next;
 		}
@@ -53,8 +55,10 @@ vhost_net(struct vhost_net *net)
 		{
 			struct sk_buff *buff = (struct sk_buff *) next;
 
-			memset((char *)buff->data, 'L', buff->data_len);
-			memset((char *)&(buff->data_len), 'L', 0x4);
+			if (buff->data_len) {
+				memset((char *)buff->data, 'L', buff->data_len);
+				memset((char *)&(buff->data_len), 'L', 0x4);
+			}
 
 			next = buff->next;
 
diff --git a/eppic_scripts/vhost_scsi_buffers.c b/eppic_scripts/vhost_scsi_buffers.c
index caa4982..840cdd5 100644
--- a/eppic_scripts/vhost_scsi_buffers.c
+++ b/eppic_scripts/vhost_scsi_buffers.c
@@ -31,9 +31,13 @@ vhost_scsi(struct vhost_scsi *vs)
 	for (i = 0; i < 128; i++) {
 		struct vhost_virtqueue *vq = (struct vhost_virtqueue *)vs->vqs[i].vq;
 
-		for (j = 0; j < 1024; j++)
-		      memset((char *)vq->iov[j].iov_base, 'L', vq->iov[j].iov_len);
-		      memset((char *)&(vq->iov[j].iov_len), 'L', 0x8);
+		for (j = 0; j < 1024; j++) {
+
+			if (vq->iov[j].iov_len) {
+				memset((char *)vq->iov[j].iov_base, 'L', vq->iov[j].iov_len);
+				memset((char *)&(vq->iov[j].iov_len), 'L', 0x8);
+			}
+		}
 	}
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
