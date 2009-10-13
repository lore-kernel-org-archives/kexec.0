Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MxaPD-0005C3-EL
	for kexec@lists.infradead.org; Tue, 13 Oct 2009 05:58:48 +0000
Message-ID: <4AD40DE0.60809@mxs.nes.nec.co.jp>
Date: Tue, 13 Oct 2009 14:19:28 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH 1/5] Cleanup: Set a meaning value for KDUMP_SUB_HEADER_BLOCKS.
References: <4ACEA2A3.5090706@mxs.nes.nec.co.jp>	<20091010.165135.12569232.caiqian@redhat.com>
	<4AD3D19F.7000508@mxs.nes.nec.co.jp>
	<4AD40DB4.6030808@mxs.nes.nec.co.jp>
In-Reply-To: <4AD40DB4.6030808@mxs.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org, tindoh@redhat.com, usui@mxm.nes.nec.co.jp, CAI Qian <caiqian@redhat.com>, anderson@redhat.com

[PATCH 1/5] Cleanup: Set a meaning value for KDUMP_SUB_HEADER_BLOCKS.

Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
diff -rpuN a/diskdump_mod.h b/diskdump_mod.h
--- a/diskdump_mod.h	2009-10-09 10:51:18.000000000 +0900
+++ b/diskdump_mod.h	2009-10-13 11:02:05.000000000 +0900
@@ -25,7 +25,6 @@
 #define KDUMP_SIGNATURE			"KDUMP   "
 #define SIG_LEN (sizeof(DUMP_PARTITION_SIGNATURE) - 1)
 #define DISKDUMP_HDADER_BLOCKS		(1)
-#define KDUMP_SUB_HEADER_BLOCKS		(1)
 
 #define DUMP_HEADER_COMPLETED	0
 #define DUMP_HEADER_INCOMPLETED 1
diff -rpuN a/makedumpfile.c b/makedumpfile.c
--- a/makedumpfile.c	2009-10-09 10:51:18.000000000 +0900
+++ b/makedumpfile.c	2009-10-13 11:06:25.000000000 +0900
@@ -5450,7 +5450,7 @@ write_kdump_header(void)
 	strcpy(dh->signature, KDUMP_SIGNATURE);
 	dh->header_version = 2;
 	dh->block_size   = info->page_size;
-	dh->sub_hdr_size = KDUMP_SUB_HEADER_BLOCKS;
+	dh->sub_hdr_size = divideup(sizeof(sub_dump_header), dh->block_size);
 	dh->max_mapnr    = info->max_mapnr;
 	dh->nr_cpus      = 1;
 	dh->bitmap_blocks

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
