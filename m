Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YOcFE-0002Wz-BN
 for kexec@lists.infradead.org; Fri, 20 Feb 2015 01:19:05 +0000
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7F24BAC01A2
 for <kexec@lists.infradead.org>; Fri, 20 Feb 2015 10:18:37 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 1F6A81DB8038
 for <kexec@lists.infradead.org>; Fri, 20 Feb 2015 10:18:37 +0900 (JST)
Date: Fri, 20 Feb 2015 10:18:18 +0900 (JST)
Message-Id: <20150220.101818.129830441.d.hatayama@jp.fujitsu.com>
Subject: [PATCH] sadump: Support more than 16TB physical memory space
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

This patch makes sadump format support more than 16TB physical memory
space.

The limitation is caused by several members of dump_header structure:
max_mapnr and the others. They have 4 byte length only. In particular,
max_mapnr member gets overflow if more than 16TB physical memory space
is given.

To support more than 16TB physical memory space, this patch adds new 4
64-bit length members in dump_header structure:

- max_mapnr_64
- total_ram_blocks_64
- device_blocks_64
- written_blocks_64

Next table shows correspondence between the 32-bit version and the
64-bit version members:

    | 32-bit version         | 64-bit version            |
    |------------------------+---------------------------|
    | max_mapnr              | max_mapnr_64              |
    | total_ram_blocks       | total_ram_blocks_64       |
    | device_blocks          | device_blocks_64          |
    | written_blocks         | written_blocks_64         |

In addition, header_version member of dump_header structure is
increased to 1 in this extended new format.

Old makedumpfile can access the new sadump format under 16TB
correctly.

Current implementation treats vmcore with kernel version 2 or later as
kernel version 1, assuming backward compatibility.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---
 sadump_info.c | 20 +++++++++++++++++---
 sadump_mod.h  |  8 ++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/sadump_info.c b/sadump_info.c
index 9434ff7..e2c4f03 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -84,6 +84,7 @@ struct sadump_info {
 	unsigned long backup_src_size;
 	unsigned long long backup_offset;
 	int kdump_backed_up;
+	mdf_pfn_t max_mapnr;
 };
 
 static char *guid_to_str(efi_guid_t *guid, char *buf, size_t buflen);
@@ -625,6 +626,19 @@ restart:
 		offset += sh->sub_hdr_size * block_size;
 	}
 
+	switch (sh->header_version) {
+	case 0:
+		si->max_mapnr = (mdf_pfn_t)(uint64_t)sh->max_mapnr;
+		break;
+	default:
+		ERRMSG("sadump: unsupported header version: %u\n"
+		       "sadump: assuming header version: 1\n",
+		       sh->header_version);
+	case 1:
+		si->max_mapnr = (mdf_pfn_t)sh->max_mapnr_64;
+		break;
+	}
+
 	if (!sh->bitmap_blocks) {
 		DEBUG_MSG("sadump: bitmap_blocks is zero\n");
 		return FALSE;
@@ -775,7 +789,7 @@ sadump_initialize_bitmap_memory(void)
 	memset(bmp->buf, 0, BUFSIZE_BITMAP);
 	bmp->offset = dumpable_bitmap_offset;
 
-	max_section = divideup(sh->max_mapnr, SADUMP_PF_SECTION_NUM);
+	max_section = divideup(si->max_mapnr, SADUMP_PF_SECTION_NUM);
 
 	block_table = calloc(sizeof(unsigned long long), max_section);
 	if (block_table == NULL) {
@@ -906,7 +920,7 @@ sadump_set_timestamp(struct timeval *ts)
 mdf_pfn_t
 sadump_get_max_mapnr(void)
 {
-	return si->sh_memory->max_mapnr;
+	return si->max_mapnr;
 }
 
 #ifdef __x86_64__
@@ -964,7 +978,7 @@ readpage_sadump(unsigned long long paddr, void *bufptr)
 
 	pfn = paddr_to_pfn(paddr);
 
-	if (pfn >= si->sh_memory->max_mapnr)
+	if (pfn >= si->max_mapnr)
 		return FALSE;
 
 	if (!is_dumpable(info->bitmap_memory, pfn)) {
diff --git a/sadump_mod.h b/sadump_mod.h
index afeead8..0dd5bb5 100644
--- a/sadump_mod.h
+++ b/sadump_mod.h
@@ -106,6 +106,14 @@ struct sadump_header {
 	uint32_t written_blocks;	/* Number of written blocks */
 	uint32_t current_cpu;	/* CPU# which handles dump */
 	uint32_t nr_cpus;	/* Number of CPUs */
+	/*
+	 * The members from below are supported in header version 1
+	 * and later.
+	 */
+	uint64_t max_mapnr_64;
+	uint64_t total_ram_blocks_64;
+	uint64_t device_blocks_64;
+	uint64_t written_blocks_64;
 };
 
 struct sadump_apic_state {
-- 
1.9.3



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
