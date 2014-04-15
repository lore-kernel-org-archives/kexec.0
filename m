Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZvVB-0007gB-0D
 for kexec@lists.infradead.org; Tue, 15 Apr 2014 05:01:46 +0000
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aruna@linux.vnet.ibm.com>;
 Tue, 15 Apr 2014 10:31:19 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id EF2ED125803E
 for <kexec@lists.infradead.org>; Tue, 15 Apr 2014 10:33:54 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3F51C7O12255590
 for <kexec@lists.infradead.org>; Tue, 15 Apr 2014 10:31:12 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3F510Ac018251
 for <kexec@lists.infradead.org>; Tue, 15 Apr 2014 10:31:00 +0530
Subject: [PATCH] eppic: makedumpfile fails to recognise between global
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Tue, 15 Apr 2014 10:31:00 +0530
Message-ID: <20140415050055.15599.6255.stgit@aruna-ThinkPad-T420>
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

    symbol and structure of the same name

    Fix the eppic script to reflect the type

    Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 eppic_scripts/udp_sk_buf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/eppic_scripts/udp_sk_buf.c b/eppic_scripts/udp_sk_buf.c
index 0fa1325..ca8c77b 100644
--- a/eppic_scripts/udp_sk_buf.c
+++ b/eppic_scripts/udp_sk_buf.c
@@ -30,7 +30,7 @@ udp()
 	struct udp_table *table;
 	struct sock_common *off = 0;
 
-	table = &udp_table;
+	table = (struct udp_table *)&udp_table;
 
 	for (i = 0; i < table->mask; i++) {
 		struct hlist_nulls_node *pos;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
