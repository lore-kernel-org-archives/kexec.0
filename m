Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XKPgD-00030D-0V
 for kexec@lists.infradead.org; Thu, 21 Aug 2014 10:33:17 +0000
Date: Thu, 21 Aug 2014 18:31:26 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [Patch v3 7/7] add a new interface to show the memory usage of
 1st kernel
Message-ID: <20140821103126.GA6517@dhcp-16-105.nay.redhat.com>
References: <1406535606-16303-1-git-send-email-bhe@redhat.com>
 <1406535606-16303-8-git-send-email-bhe@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97246623@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE97246623@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 08/01/14 at 07:12am, Atsushi Kumagai wrote:
> >Page number of memory in different use
> >--------------------------------------------------
> >TYPE		PAGES			EXCLUDABLE	DESCRIPTION
> >ZERO		0               	yes		Pages filled with zero
> 
> The number of zero pages is always 0 since it isn't counted during
> get_num_dumpable_cyclic(). To count it up, we have to read all of the
> pages like exclude_zero_pages(), so we need "exclude_zero_pages_cyclic()".
> My idea is to call it in get_num_dumpable_cyclic() like:
> 
> 		for_each_cycle(0, info->max_mapnr, &cycle)
> 		{
> 				if (!exclude_unnecessary_pages_cyclic(&cycle))
> 					return FALSE;
> 
> +				if (info->flag_mem_usage)
> +					exclude_zero_pages_cyclic(&cycle);
> +
> 				for(pfn=cycle.start_pfn; pfn<cycle.end_pfn; pfn++)


Hi Atsushi,

I just introduced a new function exclude_zero_pages_cyclic as you
suggested. But it always exited with below message. I don't know what's
wrong with this function. Could you help have a look at it?

"Program terminated with signal SIGKILL"


From: Baoquan He <bhe@redhat.com>
Date: Thu, 21 Aug 2014 13:29:31 +0800
Subject: [PATCH] introduce a function exclude_zero_pages_cyclic()

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
