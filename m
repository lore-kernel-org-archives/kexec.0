Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XOI7n-0001HK-VZ
 for kexec@lists.infradead.org; Mon, 01 Sep 2014 03:17:48 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 6/8] introduce a function exclude_zero_pages_cyclic()
Date: Mon,  1 Sep 2014 11:15:38 +0800
Message-Id: <1409541340-2719-7-git-send-email-bhe@redhat.com>
In-Reply-To: <1409541340-2719-1-git-send-email-bhe@redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
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
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, Baoquan He <bhe@redhat.com>, vgoyal@redhat.com

Introduced a new function exclude_zero_pages_cyclic(), this will
exclude and counting zero pages. Calling it in get_num_dumpable_cyclic
can get the number of zero pages.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index d43d02d..a511179 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -4582,6 +4582,45 @@ exclude_zero_pages(void)
 	return TRUE;
 }
 
+int
+exclude_zero_pages_cyclic(struct cycle *cycle)
+{
+	mdf_pfn_t pfn;
+	unsigned long long paddr;
+	unsigned char buf[info->page_size];
+
+	for (pfn = cycle->start_pfn, paddr = pfn_to_paddr(pfn); pfn < cycle->end_pfn;
+	    pfn++, paddr += info->page_size) {
+
+		if (!is_in_segs(paddr))
+			continue;
+
+		if (!is_dumpable_cyclic(info->partial_bitmap2, pfn, cycle))
+			continue;
+
+		if (is_xen_memory()) {
+			if (!readmem(MADDR_XEN, paddr, buf, info->page_size)) {
+				ERRMSG("Can't get the page data(pfn:%llx, max_mapnr:%llx).\n",
+				    pfn, info->max_mapnr);
+				return FALSE;
+			}
+		} else {
+			if (!readmem(PADDR, paddr, buf, info->page_size)) {
+				ERRMSG("Can't get the page data(pfn:%llx, max_mapnr:%llx).\n",
+				    pfn, info->max_mapnr);
+				return FALSE;
+			}
+		}
+		if (is_zero_page(buf, info->page_size)) {
+			if (clear_bit_on_2nd_bitmap(pfn, cycle))
+				pfn_zero++;
+		}
+	}
+
+	return TRUE;
+}
+
+
 static int
 initialize_2nd_bitmap_cyclic(struct cycle *cycle)
 {
@@ -5662,6 +5701,9 @@ get_num_dumpable_cyclic(void)
 		if (!exclude_unnecessary_pages_cyclic(&cycle))
 			return FALSE;
 
+		if (info->flag_mem_usage)
+			exclude_zero_pages_cyclic(&cycle);
+
 		for(pfn=cycle.start_pfn; pfn<cycle.end_pfn; pfn++)
 			if (is_dumpable_cyclic(info->partial_bitmap2, pfn, &cycle))
 				num_dumpable++;
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
