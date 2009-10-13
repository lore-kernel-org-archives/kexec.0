Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MxaQ6-0005KL-Qu
	for kexec@lists.infradead.org; Tue, 13 Oct 2009 05:59:43 +0000
Message-ID: <4AD40E22.2080609@mxs.nes.nec.co.jp>
Date: Tue, 13 Oct 2009 14:20:34 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH 4/5] Store vmcoreinfo data into a kdump-compressed dumpfile.
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

[PATCH 4/5] Store vmcoreinfo data into a kdump-compressed dumpfile.

By applying this patch, makedumpfile takes vmcoreinfo data from
/proc/vmcore and stores the data into a dumpfile in the kdump-
compressed fomat. By the next patch, makedumpfile takes the data
from a dumpfile in the kdump-compressed format and uses the data
for re-filtering.


Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
diff -rpuN a/diskdump_mod.h b/diskdump_mod.h
--- a/diskdump_mod.h	2009-10-13 12:19:53.000000000 +0900
+++ b/diskdump_mod.h	2009-10-13 12:20:03.000000000 +0900
@@ -71,6 +71,8 @@ struct kdump_sub_header {
 	int		split;		/* header_version 2 and later */
 	unsigned long	start_pfn;	/* header_version 2 and later */
 	unsigned long	end_pfn;	/* header_version 2 and later */
+	off_t		offset_vmcoreinfo;/* header_version 3 and later */
+	unsigned long	size_vmcoreinfo;  /* header_version 3 and later */
 };
 
 /* page flags */
diff -rpuN a/makedumpfile.c b/makedumpfile.c
--- a/makedumpfile.c	2009-10-13 12:19:53.000000000 +0900
+++ b/makedumpfile.c	2009-10-13 12:23:49.000000000 +0900
@@ -5437,9 +5437,11 @@ out:
 int
 write_kdump_header(void)
 {
+	int ret = FALSE;
 	size_t size;
 	struct disk_dump_header *dh = info->dump_header;
 	struct kdump_sub_header kh;
+	char *buf = NULL;
 
 	if (info->flag_elf_dumpfile)
 		return FALSE;
@@ -5448,9 +5450,10 @@ write_kdump_header(void)
 	 * Write common header
 	 */
 	strcpy(dh->signature, KDUMP_SIGNATURE);
-	dh->header_version = 2;
-	dh->block_size     = info->page_size;
-	dh->sub_hdr_size   = divideup(sizeof(kh), dh->block_size);
+	dh->header_version = 3;
+  	dh->block_size     = info->page_size;
+	dh->sub_hdr_size   = sizeof(kh) + info->size_vmcoreinfo;
+	dh->sub_hdr_size   = divideup(dh->sub_hdr_size, dh->block_size);
 	dh->max_mapnr      = info->max_mapnr;
 	dh->nr_cpus        = 1;
 	dh->bitmap_blocks  = divideup(info->len_bitmap, dh->block_size);
@@ -5473,14 +5476,47 @@ write_kdump_header(void)
 		kh.start_pfn = info->split_start_pfn;
 		kh.end_pfn   = info->split_end_pfn;
 	}
+	if (info->offset_vmcoreinfo && info->size_vmcoreinfo) {
+		kh.offset_vmcoreinfo  = DISKDUMP_HDADER_BLOCKS * dh->block_size;
+		kh.offset_vmcoreinfo += sizeof(kh);
+		kh.size_vmcoreinfo    = info->size_vmcoreinfo;
+
+		buf = malloc(info->size_vmcoreinfo);
+		if (buf == NULL) {
+			ERRMSG("Can't allocate memory for vmcoreinfo. %s\n",
+			    strerror(errno));
+			return FALSE;
+		}
+		if (lseek(info->fd_memory, info->offset_vmcoreinfo, SEEK_SET)
+		    < 0) {
+			ERRMSG("Can't seek the dump memory(%s). %s\n",
+			    info->name_memory, strerror(errno));
+			goto out;
+		}
+		if (read(info->fd_memory, buf, info->size_vmcoreinfo)
+		    != info->size_vmcoreinfo) {
+			ERRMSG("Can't read the dump memory(%s). %s\n",
+			    info->name_memory, strerror(errno));
+			goto out;
+		}
+	}
 	if (!write_buffer(info->fd_dumpfile, dh->block_size, &kh,
 	    size, info->name_dumpfile))
-		return FALSE;
+		goto out;
+
+	if (!write_buffer(info->fd_dumpfile, kh.offset_vmcoreinfo, buf,
+	    kh.size_vmcoreinfo, info->name_dumpfile))
+		goto out;
 
 	info->offset_bitmap1
 	    = (DISKDUMP_HDADER_BLOCKS + dh->sub_hdr_size) * dh->block_size;
 
-	return TRUE;
+	ret = TRUE;
+out:
+	if (buf)
+		free(buf);
+
+	return ret;
 }
 
 void

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
