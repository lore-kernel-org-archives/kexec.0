Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MxaQ0-0005Jf-C2
	for kexec@lists.infradead.org; Tue, 13 Oct 2009 05:59:37 +0000
Message-ID: <4AD40DFC.5020708@mxs.nes.nec.co.jp>
Date: Tue, 13 Oct 2009 14:19:56 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH 2/5] Cleanup: Fix some indents in write_kdump_header().
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

[PATCH 2/5] Cleanup: Fix some indents in write_kdump_header().

Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
diff -rpuN a/makedumpfile.c b/makedumpfile.c
--- a/makedumpfile.c	2009-10-13 11:07:33.000000000 +0900
+++ b/makedumpfile.c	2009-10-13 11:08:56.000000000 +0900
@@ -5449,12 +5449,11 @@ write_kdump_header(void)
 	 */
 	strcpy(dh->signature, KDUMP_SIGNATURE);
 	dh->header_version = 2;
-	dh->block_size   = info->page_size;
-	dh->sub_hdr_size = divideup(sizeof(sub_dump_header), dh->block_size);
-	dh->max_mapnr    = info->max_mapnr;
-	dh->nr_cpus      = 1;
-	dh->bitmap_blocks
-	    = divideup(info->len_bitmap, dh->block_size);
+	dh->block_size     = info->page_size;
+	dh->sub_hdr_size   = divideup(sizeof(sub_dump_header), dh->block_size);
+	dh->max_mapnr      = info->max_mapnr;
+	dh->nr_cpus        = 1;
+	dh->bitmap_blocks  = divideup(info->len_bitmap, dh->block_size);
 	memcpy(&dh->timestamp, &info->timestamp, sizeof(dh->timestamp));
 	memcpy(&dh->utsname, &info->system_utsname, sizeof(dh->utsname));
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
