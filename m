Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bEsE3-0003ls-7y
 for kexec@lists.infradead.org; Mon, 20 Jun 2016 05:58:24 +0000
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 65DCDAC015E
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 14:57:57 +0900 (JST)
Date: Mon, 20 Jun 2016 14:57:44 +0900 (JST)
Message-Id: <20160620.145744.403680288.d.hatayama@jp.fujitsu.com>
Subject: [PATCH 1/2] sadump: fix segmentation fault on sadump-related formats
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
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
To: ats-kumagai@wm.jp.nec.com
Cc: kexec@lists.infradead.org

Currently, makedumpfile results in segmentation fault on
sadump-related formats:

    # ~/makedumpfile --message-level 31 -l -d 31 -x ./vmlinux vmcore
    sadump: read dump device as single partition
    sadump: single partition configuration
    page_size    : 4096
    Segmentation fault

This is because although commit
5fc24bf754fa6d2c0bd0f1c6f5655de371efb9d5 started dynamically
allocating the buffer of struct dump_bitmap, the sadump source code
doesn't follow the change.

This commit fixes this by following the change.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 makedumpfile.c |  5 ++++-
 sadump_info.c  | 28 ++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 853b999..90cfc3e 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -11229,8 +11229,11 @@ out:
 			free(info->kh_memory);
 		if (info->valid_pages)
 			free(info->valid_pages);
-		if (info->bitmap_memory)
+		if (info->bitmap_memory) {
+			if (info->bitmap_memory->buf)
+				free(info->bitmap_memory->buf);
 			free(info->bitmap_memory);
+		}
 		if (info->fd_memory)
 			close(info->fd_memory);
 		if (info->fd_dumpfile)
diff --git a/sadump_info.c b/sadump_info.c
index 20376f0..8716167 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -832,18 +832,28 @@ sadump_initialize_bitmap_memory(void)
 		       strerror(errno));
 		return FALSE;
 	}
+
 	bmp->fd = info->fd_memory;
 	bmp->file_name = info->name_memory;
 	bmp->no_block = -1;
-	memset(bmp->buf, 0, BUFSIZE_BITMAP);
 	bmp->offset = dumpable_bitmap_offset;
 
+	bmp->buf = malloc(BUFSIZE_BITMAP);
+	if (!bmp->buf) {
+		ERRMSG("Can't allocate memory for the memory-bitmap's buffer. %s\n",
+		       strerror(errno));
+		free(bmp);
+		return FALSE;
+	}
+	memset(bmp->buf, 0, BUFSIZE_BITMAP);
+
 	max_section = divideup(si->max_mapnr, SADUMP_PF_SECTION_NUM);
 
 	block_table = calloc(sizeof(unsigned long long), max_section);
 	if (block_table == NULL) {
 		ERRMSG("Can't allocate memory for the block_table. %s\n",
 		       strerror(errno));
+		free(bmp->buf);
 		free(bmp);
 		return FALSE;
 	}
@@ -870,8 +880,17 @@ sadump_initialize_bitmap_memory(void)
 	bmp->fd = info->fd_memory;
 	bmp->file_name = info->name_memory;
 	bmp->no_block = -1;
-	memset(bmp->buf, 0, BUFSIZE_BITMAP);
 	bmp->offset = si->sub_hdr_offset + sh->block_size * sh->sub_hdr_size;
+
+	bmp->buf = malloc(BUFSIZE_BITMAP);
+	if (!bmp->buf) {
+		ERRMSG("Can't allocate memory for the memory-bitmap's buffer. %s\n",
+		       strerror(errno));
+		free(bmp);
+		return FALSE;
+	}
+	memset(bmp->buf, 0, BUFSIZE_BITMAP);
+
 	si->ram_bitmap = bmp;
 
 	/*
@@ -1904,6 +1923,11 @@ free_sadump_info(void)
 		fclose(si->file_elf_note);
 	if (si->cpu_online_mask_buf)
 		free(si->cpu_online_mask_buf);
+	if (si->ram_bitmap) {
+		if (si->ram_bitmap->buf)
+			free(si->ram_bitmap->buf);
+		free(si->ram_bitmap);
+	}
 }
 
 void
-- 
1.9.3

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
