Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ScTi3-0005ln-Ik
 for kexec@lists.infradead.org; Thu, 07 Jun 2012 03:48:34 +0000
Date: Thu, 7 Jun 2012 12:46:35 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC PATCH 4/4] makedumpfile: Add main routine of cyclic
 processing.
Message-Id: <20120607124635.e3b6fd7f.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120604.134212.319008231.d.hatayama@jp.fujitsu.com>
References: <20120531135654.a26dd3fe.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120604.134212.319008231.d.hatayama@jp.fujitsu.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

Hello HATAYAMA-san,

On Mon, 04 Jun 2012 13:42:12 +0900 (JST)
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Subject: [RFC PATCH 4/4] makedumpfile: Add main routine of cyclic processing.
> Date: Thu, 31 May 2012 13:56:54 +0900
> 
> > +	/*
> > +	 * Write pages and bitmap cyclically.
> > +	 */
> > +	for (info->split_start_pfn = 0, info->split_end_pfn = PFN_CYCLIC;
> > +	     info->split_end_pfn <= info->max_mapnr;
> > +	     info->split_start_pfn += PFN_CYCLIC, info->split_end_pfn += PFN_CYCLIC) {
> 
> The cyclic processing is orthogonal to the splitting feature. The
> feature of splitting a single vmcore into multiple dumpfiles is an
> important feature on large system to reduce dump generation time. They
> should exist together.

As you pointed out, prototype can't be specified --split and -K at the same time.
I will improve the issue in next prototype version if possible.

At least, it is needed to change the variable names to clarify their purpose
as follows.


Thanks
Atsushi Kumagai

diff --git a/makedumpfile.c b/makedumpfile.c
index a211a89..0154851 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2797,14 +2797,14 @@ set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val)
 {
 	int byte, bit;
 
-	if (pfn < info->split_start_pfn || info->split_end_pfn < pfn)
+	if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn < pfn)
 		return FALSE;
 
 	/*
 	 * If val is 0, clear bit on the bitmap.
 	 */
-	byte = (pfn - info->split_start_pfn)>>3;
-	bit  = (pfn - info->split_start_pfn) & 7;
+	byte = (pfn - info->cyclic_start_pfn)>>3;
+	bit  = (pfn - info->cyclic_start_pfn) & 7;
 	if (val)
 		bitmap[byte] |= 1<<bit;
 	else
@@ -3659,7 +3659,7 @@ create_1st_bitmap_cyclic()
 	 */
 	pfn_bitmap1 = 0;
 
-	for (pfn = info->split_start_pfn; pfn <	info->split_end_pfn; pfn++) {
+	for (pfn = info->cyclic_start_pfn; pfn < info->cyclic_end_pfn; pfn++) {
 		if (is_in_segs(pfn_to_paddr(pfn))) {
 			set_bit_on_1st_bitmap(pfn);
 			pfn_bitmap1++;
@@ -3871,7 +3871,7 @@ exclude_unnecessary_pages_cyclic(void)
 		if (mmd->mem_map == NOT_MEMMAP_ADDR)
 			continue;
 
-		if (mmd->pfn_end >= info->split_start_pfn || mmd->pfn_start <= info->split_end_pfn) {
+		if (mmd->pfn_end >= info->cyclic_start_pfn || mmd->pfn_start <= info->cyclic_end_pfn) {
 			if (!__exclude_unnecessary_pages(mmd->mem_map,
 							 mmd->pfn_start, mmd->pfn_end))
 				return FALSE;
@@ -4554,7 +4554,7 @@ get_num_dumpable_cyclic(void)
 	if (!exclude_unnecessary_pages_cyclic())
 		return FALSE;
 
-	for (pfn = info->split_start_pfn, num_dumpable = 0; pfn < info->split_end_pfn; pfn++) {
+	for (pfn = info->cyclic_start_pfn, num_dumpable = 0; pfn < info->cyclic_end_pfn; pfn++) {
 		if (is_dumpable_cyclic(info->partial_bitmap2, pfn)) {
 			num_dumpable++;
 		} 
@@ -5105,8 +5105,8 @@ write_kdump_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_pag
 
 	gettimeofday(&tv_start, NULL);
 
-	start_pfn = info->split_start_pfn;
-	end_pfn   = info->split_end_pfn;
+	start_pfn = info->cyclic_start_pfn;
+	end_pfn   = info->cyclic_end_pfn;
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 
@@ -5507,9 +5507,9 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 	 * Get number of dumpable pages.
 	 */
 	d_exclude_start = getdtime();
-	for (info->split_start_pfn = 0, info->split_end_pfn = PFN_CYCLIC;
-	     info->split_end_pfn <= info->max_mapnr;
-	     info->split_start_pfn += PFN_CYCLIC, info->split_end_pfn += PFN_CYCLIC) {
+	for (info->cyclic_start_pfn = 0, info->cyclic_end_pfn = PFN_CYCLIC;
+	     info->cyclic_end_pfn <= info->max_mapnr;
+	     info->cyclic_start_pfn += PFN_CYCLIC, info->cyclic_end_pfn += PFN_CYCLIC) {
 
 		info->num_dumpable += get_num_dumpable_cyclic();
 	}
@@ -5545,9 +5545,9 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
 	/*
 	 * Write pages and bitmap cyclically.
 	 */
-	for (info->split_start_pfn = 0, info->split_end_pfn = PFN_CYCLIC;
-	     info->split_end_pfn <= info->max_mapnr;
-	     info->split_start_pfn += PFN_CYCLIC, info->split_end_pfn += PFN_CYCLIC) {
+	for (info->cyclic_start_pfn = 0, info->cyclic_end_pfn = PFN_CYCLIC;
+	     info->cyclic_end_pfn <= info->max_mapnr;
+	     info->cyclic_start_pfn += PFN_CYCLIC, info->cyclic_end_pfn += PFN_CYCLIC) {
 
 		d_exclude_start = getdtime();
 		if (!create_1st_bitmap_cyclic())
diff --git a/makedumpfile.h b/makedumpfile.h
index ca9b100..79a8e41 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -936,6 +936,8 @@ struct DumpInfo {
 	/*
 	 * for cyclic
 	 */
+	unsigned long long cyclic_start_pfn;
+	unsigned long long cyclic_end_pfn;
 	char            *partial_bitmap1;
 	char            *partial_bitmap2;
 	unsigned long long num_dumpable;
@@ -1412,10 +1414,10 @@ is_dumpable(struct dump_bitmap *bitmap, unsigned long long pfn)
 static inline int
 is_dumpable_cyclic(char *bitmap, unsigned long long pfn)
 {
-       if (pfn < info->split_start_pfn || info->split_end_pfn < pfn)
+       if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn < pfn)
                return FALSE;
        else
-               return is_on(bitmap, pfn - info->split_start_pfn);
+               return is_on(bitmap, pfn - info->cyclic_start_pfn);
 }

 static inline int

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
