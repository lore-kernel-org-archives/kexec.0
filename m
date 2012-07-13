Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SpYVs-0001uL-1z
 for kexec@lists.infradead.org; Fri, 13 Jul 2012 05:34:04 +0000
Date: Fri, 13 Jul 2012 14:23:03 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC PATCH 00/10] Support free page filtering looking up
 mem_map array
Message-Id: <20120713142303.75d77c4b8ad5426f1d62ea0c@mxc.nes.nec.co.jp>
In-Reply-To: <20120629152337.4c281342.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120628173757.19702.75678.stgit@fedora-machine>
 <20120629152337.4c281342.kumagai-atsushi@mxc.nes.nec.co.jp>
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
To: kexec@lists.infradead.org, d.hatayama@jp.fujitsu.com

Hello,

On Fri, 29 Jun 2012 15:23:37 +0900
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> Hello HATAYAMA-san,
> 
> On Fri, 29 Jun 2012 02:37:57 +0900
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
> > Sorry for late posting. I made RFC patch set for free page filtering
> > looking up mem_map array. Unlike exiting method looking up free page
> > list, this is done in constant space.
> > 
> > I intend this patch set to be merged with Kumagai-san's cyclic patch
> > set, so I mark these with RFC. See TODO below. Also, I have yet to
> > test the logic for old kernels from v2.6.15 to v2.6.17.
> > 
> > This new free page filtering needs the following values.
> > 
> >   - OFFSET(page._mapcount)
> >   - OFFSET(page.private)
> >   - SIZE(pageflags)
> >   - NUMBER(PG_buddy)
> >   - NUMBER(PG_slab)
> >   - NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)
> > 
> > Unfortunately, OFFSET(_mapcount) and OFFSET(private) fields of page
> > structure cannot be obtained from VMLINUX using the exiting library in
> > makedumpfile since two members are anonymous components of union
> > types. We need a new interface for them.
> > 
> > To try to use this patch set, it's handy to pass manually editted
> > VMCOREINFO file via -i option.
> > 
> > TODO
> > 
> >   1. Add new values in VMCOREINFO on the upstream kernel.
> > 
> >   2. Decide when to use this logic instead of the existing free list
> >   logic. Option is 1) introduce new dump level or 2) use it
> >   automatically if --cyclic is specified. This patch chooses 1) only
> >   for RFC use.
> > 
> >   3. Consider how to deal with old kernels on which we cannot add the
> >   values in VMCOREINFO. Options is 1) to force users to use VMLINUX,
> >   2) to cover them full hard coding or 3) to give up support on full
> >   range of kernel versions ever.
> 
> Thank you always for your work.
> 
> I will review your patches and measure executing time with v2 patch
> of cyclic processing. If your patches are effective, then I will 
> consider TODO above.
> Please wait for a while.

I did performance measuring with v2 patches of cyclic processing and HATAYAMA-san's patches.
And I fixed v2 patches to reduce wasteful process, please see the end of this mail.


How to measure:

  - The source data is a vmcore saved on the disk, the size is 5,099,292,912 bytes.
  - makedumpfile writes dumpfile to the same disk as the source data.
  - I measured the execution time with time(1) and adopted the average of 5 times.

Test Cases:

  - _mapcount:
    This logic is implemented by HATAYAMA-san.
    This logic looks up members of page structure instead of free_list 
    to filter out free pages.

  - free_list
    v2 patches choose this logic.
    This logic looks up whole free_list to filter out free pages every cycle.

  - upstream (v1.4.4):
    This logic is NOT CYCLIC, uses temporary bitmap file as usual.

Example:

  - _mapcount:
    $ time makedumpfile --cyclic -d32  -i vmcoreinfo vmcore dumpfile.d32

  - free_list:
    $ time makedumpfile --cyclic -d16  -i vmcoreinfo vmcore dumpfile.d16

  - upstream:
    $ time makedumpfile -d16  -i vmcoreinfo vmcore dumpfile.d16

Result:

  a) exclude only free pages

     BUFSIZE_CYCLIC  |                |                  execution time [sec]
         [byte]      |  num of cycle  | _mapcount (-d32) | free_list (-d16) | upstream (-d16)
   ------------------+----------------+------------------+------------------+-----------------
       1024          |      152       |      20.5204     |      28.8028     |        -
       1024 * 10     |       16       |      14.7460     |      18.7904     |        -
       1024 * 100    |        2       |      14.3962     |      17.9356     |        -
       1024 * 200    |        1       |      14.3166     |      17.8762     |     17.7928

  b) exclude all unnecessary pages

     BUFSIZE_CYCLIC  |                |                  execution time [sec]
         [byte]      |  num of cycle  | _mapcount (-d47) | free_list (-d31) | upstream (-d31)
   ------------------+----------------+------------------+------------------+-----------------
       1024          |      152       |      11.5086     |      27.2906     |        -
       1024 * 10     |       16       |       6.0740     |      10.9998     |        -
       1024 * 100    |        2       |       5.7928     |       9.1534     |        -
       1024 * 200    |        1       |       5.6378     |       8.9924     |      5.0516


I expected that the difference of execution time increases based on number of cycle,
because I think that repeating scanning free_list is high cost.
And according to result, it seems right.

_mapcount logic can be expected good performance in almost case when --cyclic is specified.
So, I think that making effort to resolve TODO is worth for us.

However, I think more consideration is needed to decide whether to choose _mapcount logic
or not when --cyclic isn't specified.


> TODO
> 
>   1. Add new values in VMCOREINFO on the upstream kernel.

I will send this request to the upstream kernel.

>   2. Decide when to use this logic instead of the existing free list
>   logic. Option is 1) introduce new dump level or 2) use it
>   automatically if --cyclic is specified. This patch chooses 1) only
>   for RFC use.

I think 2) is reasonable from the result.

>   3. Consider how to deal with old kernels on which we cannot add the
>   values in VMCOREINFO. Options is 1) to force users to use VMLINUX,
>   2) to cover them full hard coding or 3) to give up support on full
>   range of kernel versions ever.

I don't want to choose 2), I think it's inefficient.
I want to require that users prepare VMCOREINFO file with -g option from vmlinux,
if cyclic processing is needed.


Do you have any comments ?


Thanks
Atsushi Kumagai

diff --git a/makedumpfile.c b/makedumpfile.c
index 0e4660f..981d72a 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3824,6 +3824,9 @@ __exclude_unnecessary_pages(unsigned long mem_map,
 
 	for (pfn = pfn_start; pfn < pfn_end; pfn++, mem_map += SIZE(page)) {
 
+		if (info->flag_cyclic && !is_cyclic_region(pfn))
+			continue;
+
 		/*
 		 * Exclude the memory hole.
 		 */
@@ -3960,17 +3963,25 @@ exclude_unnecessary_pages_cyclic(void)
 		if (!exclude_free_page())
 			return FALSE;
 
-	for (mm = 0; mm < info->num_mem_map; mm++) {
+	/*
+	 * Exclude cache pages, cache private pages, user data pages, and free pages.
+	 */
+	if (info->dump_level & DL_EXCLUDE_CACHE ||
+	    info->dump_level & DL_EXCLUDE_CACHE_PRI ||
+	    info->dump_level & DL_EXCLUDE_USER_DATA ||
+	    info->dump_level & DL_EXCLUDE_FREE_CONST) {
+		for (mm = 0; mm < info->num_mem_map; mm++) {
 
-		mmd = &info->mem_map_data[mm];
+			mmd = &info->mem_map_data[mm];
 
-		if (mmd->mem_map == NOT_MEMMAP_ADDR)
-			continue;
+			if (mmd->mem_map == NOT_MEMMAP_ADDR)
+				continue;
 
-		if (mmd->pfn_end >= info->cyclic_start_pfn || mmd->pfn_start <= info->cyclic_end_pfn) {
-			if (!__exclude_unnecessary_pages(mmd->mem_map,
-							 mmd->pfn_start, mmd->pfn_end))
-				return FALSE;
+			if (mmd->pfn_end >= info->cyclic_start_pfn || mmd->pfn_start <= info->cyclic_end_pfn) {
+				if (!__exclude_unnecessary_pages(mmd->mem_map,
+								 mmd->pfn_start, mmd->pfn_end))
+					return FALSE;
+			}
 		}
 	}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
