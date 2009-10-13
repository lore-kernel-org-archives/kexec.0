Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MxaPp-0005J0-41
	for kexec@lists.infradead.org; Tue, 13 Oct 2009 05:59:26 +0000
Message-ID: <4AD40E0F.4030207@mxs.nes.nec.co.jp>
Date: Tue, 13 Oct 2009 14:20:15 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: {PATCH 3/5] Cleanup: Shorten the declaration name of kdump_sub_header.
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

{PATCH 3/5] Cleanup: Shorten the declaration name of kdump_sub_header.

Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
diff -rpuN a/makedumpfile.c b/makedumpfile.c
--- a/makedumpfile.c	2009-10-13 12:18:10.000000000 +0900
+++ b/makedumpfile.c	2009-10-13 12:19:21.000000000 +0900
@@ -5439,7 +5439,7 @@ write_kdump_header(void)
 {
 	size_t size;
 	struct disk_dump_header *dh = info->dump_header;
-	struct kdump_sub_header sub_dump_header;
+	struct kdump_sub_header kh;
 
 	if (info->flag_elf_dumpfile)
 		return FALSE;
@@ -5450,7 +5450,7 @@ write_kdump_header(void)
 	strcpy(dh->signature, KDUMP_SIGNATURE);
 	dh->header_version = 2;
 	dh->block_size     = info->page_size;
-	dh->sub_hdr_size   = divideup(sizeof(sub_dump_header), dh->block_size);
+	dh->sub_hdr_size   = divideup(sizeof(kh), dh->block_size);
 	dh->max_mapnr      = info->max_mapnr;
 	dh->nr_cpus        = 1;
 	dh->bitmap_blocks  = divideup(info->len_bitmap, dh->block_size);
@@ -5465,15 +5465,15 @@ write_kdump_header(void)
 	 * Write sub header
 	 */
 	size = sizeof(struct kdump_sub_header);
-	memset(&sub_dump_header, 0, size);
-	sub_dump_header.phys_base  = info->phys_base;
-	sub_dump_header.dump_level = info->dump_level;
+	memset(&kh, 0, size);
+	kh.phys_base  = info->phys_base;
+	kh.dump_level = info->dump_level;
 	if (info->flag_split) {
-		sub_dump_header.split = 1;
-		sub_dump_header.start_pfn = info->split_start_pfn;
-		sub_dump_header.end_pfn   = info->split_end_pfn;
+		kh.split = 1;
+		kh.start_pfn = info->split_start_pfn;
+		kh.end_pfn   = info->split_end_pfn;
 	}
-	if (!write_buffer(info->fd_dumpfile, dh->block_size, &sub_dump_header,
+	if (!write_buffer(info->fd_dumpfile, dh->block_size, &kh,
 	    size, info->name_dumpfile))
 		return FALSE;
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
