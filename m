Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cH9Ta-000056-9G
 for kexec@lists.infradead.org; Wed, 14 Dec 2016 13:20:07 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBEDEiAs136435
 for <kexec@lists.infradead.org>; Wed, 14 Dec 2016 08:19:45 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27b2y1xbya-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 14 Dec 2016 08:19:45 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <kamalesh@linux.vnet.ibm.com>;
 Wed, 14 Dec 2016 23:19:43 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id DE16D2CE8056
 for <kexec@lists.infradead.org>; Thu, 15 Dec 2016 00:19:41 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBEDJfOX1311048
 for <kexec@lists.infradead.org>; Thu, 15 Dec 2016 00:19:41 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBEDJfK5016667
 for <kexec@lists.infradead.org>; Thu, 15 Dec 2016 00:19:41 +1100
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: [PATCH 1/2] eppic: vhost_net_buffers - Adopt to struct sk_buff changes
Date: Wed, 14 Dec 2016 18:49:24 +0530
Message-Id: <a2161c027dba53f21476f3bc283fae8700778a74.1481721378.git.kamalesh@linux.vnet.ibm.com>
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
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Linux kernel commit 56b174256b69 ("net: add rbnode to struct sk_buff"),
moves sk_buff->next into an union of sk_buff->{next/prev/tstamp/rb_node}.
Introduce this structure member change, while traversing the socket
buffer list.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 eppic_scripts/vhost_net_buffers.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/eppic_scripts/vhost_net_buffers.c b/eppic_scripts/vhost_net_buffers.c
index 39ae595..1260acb 100644
--- a/eppic_scripts/vhost_net_buffers.c
+++ b/eppic_scripts/vhost_net_buffers.c
@@ -45,7 +45,10 @@ vhost_net(struct vhost_net *net)
 				memset((char *)&(buff->data_len), 'L', 0x4);
 			}
 
-			next = buff->next;
+			/*
+			 * .next is the first entry.
+			 */
+			next = (struct sk_buff *)(unsigned long)*buff;
 		}
 
 		head = (struct sk_buff_head *)&(sk->sk_write_queue);
@@ -60,8 +63,10 @@ vhost_net(struct vhost_net *net)
 				memset((char *)&(buff->data_len), 'L', 0x4);
 			}
 
-			next = buff->next;
-
+			/*
+			 * .next is the first entry.
+			 */
+			next = (struct sk_buff *)(unsigned long)*buff;
 		}
 	}
 }
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
