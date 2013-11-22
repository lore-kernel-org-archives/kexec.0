Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjpXL-0004iV-O9
 for kexec@lists.infradead.org; Fri, 22 Nov 2013 12:08:40 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
 (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rAMC8GYm024358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Fri, 22 Nov 2013 07:08:16 -0500
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH] makedumpfile: add a new function
 update_cyclic_region_without_exclude for partial_bitmap1 setting
Date: Fri, 22 Nov 2013 20:07:22 +0800
Message-Id: <1385122042-22959-1-git-send-email-bhe@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Baoquan He <bhe@redhat.com>, chaowang@redhat.com

When use "--message-level 31" to do a kdump compressed dump, printing
message is not correct any more. Free pages number is doubled as below.

Original pages  : 0x000000000007539c
  Excluded pages   : 0x00000000000d986a
    Pages filled with zero  : 0x0000000000001196
    Cache pages             : 0x0000000000025008
    Cache pages + private   : 0x0000000000004baa
    User process data pages : 0x00000000000127d0
    Free pages              : 0x000000000009c352
    Hwpoison pages          : 0x0000000000000000
  Remaining pages  : 0xfffffffffff9bb32
  (The number of pages is reduced to 38418230895101%.)
Memory Hole     : 0x000000000000ac62
--------------------------------------------------
Total pages     : 0x000000000007fffe

After review code, it's caused by update_cyclic_region. This function calls
exclude_unnecessary_pages_cyclic to set partial_bitmap2, then free pages are
counted. But when write the 1st bitmap, it's also called though it is
useless, and pfn_free add free pages number. Here add a new function
update_cyclic_region_without_exclude which is used to set partial_bitmap1
specifically.
---
 makedumpfile.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 3746cf6..367e8cf 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4745,6 +4745,26 @@ update_cyclic_region(unsigned long long pfn)
 	return TRUE;
 }
 
+
+int
+update_cyclic_region_without_exclude(unsigned long long pfn)
+{
+	if (is_cyclic_region(pfn))
+		return TRUE;
+
+	info->cyclic_start_pfn = round(pfn, info->pfn_cyclic);
+	info->cyclic_end_pfn = info->cyclic_start_pfn + info->pfn_cyclic;
+
+	if (info->cyclic_end_pfn > info->max_mapnr)
+		info->cyclic_end_pfn = info->max_mapnr;
+
+	if (info->flag_elf_dumpfile && !create_1st_bitmap_cyclic())
+		return FALSE;
+
+	return TRUE;
+}
+
+
 int
 copy_bitmap(void)
 {
@@ -6805,7 +6825,7 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 	for (pfn = 0; pfn < info->max_mapnr; pfn++) {
 		if (is_cyclic_region(pfn))
 			continue;
-		if (!update_cyclic_region(pfn))
+		if (!update_cyclic_region_without_exclude(pfn))
 			return FALSE;
 		if (!create_1st_bitmap_cyclic())
 			return FALSE;
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
