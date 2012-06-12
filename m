Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SeMe5-0005bL-0J
 for kexec@lists.infradead.org; Tue, 12 Jun 2012 08:40:15 +0000
Date: Tue, 12 Jun 2012 17:30:04 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC PATCH 2/4] makedumpfile: Add partial bitmap for cyclic.
Message-Id: <20120612173004.c662378a.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120607150436.4c1d35cb.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120531140103.264cc0c4.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120604.121957.454958033.d.hatayama@jp.fujitsu.com>
 <20120607150436.4c1d35cb.kumagai-atsushi@mxc.nes.nec.co.jp>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

Hello HATAYAMA-san,

On Thu, 7 Jun 2012 15:04:36 +0900
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> On Mon, 04 Jun 2012 12:19:57 +0900 (JST)
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
> > > + */
> > > +#define BUFSIZE_CYCLIC	        (8192)
> > > +#define PFN_CYCLIC		(BUFSIZE_CYCLIC * BITPERBYTE)
> > > +
> > > +
> > > +/*
> > >   * Minimam vmcore has 2 ProgramHeaderTables(PT_NOTE and PT_LOAD).
> > 
> > How did you choose this buffer size? Best performance? I think the
> > performacne varies according to this buffer size, and to evaluate it,
> > it's useful to be able to specify the size through command-line.
>
> Honestly, the buffer size has no means, I defined it without a specific reason
> at first.
> 
> However, it's understandable that the size is important key for performance and
> I agree with your opinion that enabling to specify the size is useful.
> 
> But, I noticed just now, prototype with increased buffer size isn't work correctly.
> 
>  - BUFSIZE_CYCLIC = 8192:
> 
>     $ makedumpfile -Kcd31 vmcore testdump.Kcd31
>     ...
>     The dumpfile is saved to testdump.Kcd31.
> 
>     makedumpfile Completed.
>     $ ls -l testdump.*
>     -rw------- 1 kumagai kumagai 21167309  6月  7 13:55 testdump.Kcd31
>     -rw------- 1 kumagai kumagai 21167309  6月  7 13:28 testdump.cd31
>     $
> 
>  - BUFSIZE_CYCLIC = 16384:
> 
>     $ makedumpfile -Kcd31 vmcore testdump.Kcd31
>     ...
>     The dumpfile is saved to testdump.Kcd31.
> 
>     makedumpfile Completed.
>     $ ls -l testdump.*
>     -rw------- 1 kumagai kumagai 18836948  6月  7 13:59 testdump.Kcd31
>     -rw------- 1 kumagai kumagai 21167309  6月  7 13:28 testdump.cd31
>     $
> 
> 
> I must review my code quickly.

I found my mistake in the process of incraesing target region and
show the modification at the end of this email.

On Mon, 4 Jun 2012 16:54:49 +0900
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
[...]
> After received your mail, I measured executing time with the patch below.
> The result below was measured in 5GB memory machine.
> 
> Result:
>   a. makedumpfile -Kcd31 
>     excluding time:   6.55 [sec]
>     writing time:     5.89 [sec]

I measured executing time with BUFSIZE=8192 on 4 June as above.
Additionally, I measured executing time with BUFSIZE=16384, 24576 and 32768
in the same environment.

Result:
    ------------------------------------------------------------------------
    buffer size [byte]	     excluding time [sec]        writing time [sec]
    ------------------------------------------------------------------------
    	  8192		 	    6.55			 5.89
    	 16384		 	    3.49			 5.91
    	 24576		 	    2.39			 5.96
    	 32768		 	    1.83			 5.96
    ------------------------------------------------------------------------

It seems that the buffer size is really effective in performance.
Even if we choose the way without tracing free_list, the overhead of cyclic processing
will be reduced, so I expect some speedup.

If enabling to specify the buffer size, I think the information for decision of 
buffer size is needed. How do you decide the buffer size ?


Thanks
Atsushi Kumagai


diff --git a/makedumpfile.c b/makedumpfile.c
index 919e266..adc0415 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2797,7 +2797,7 @@ set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val)
 {
        int byte, bit;

-       if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn < pfn)
+       if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn <= pfn)
                return FALSE;

        /*
@@ -3871,7 +3871,7 @@ exclude_unnecessary_pages_cyclic(void)
                if (mmd->mem_map == NOT_MEMMAP_ADDR)
                        continue;

-               if (mmd->pfn_end >= info->cyclic_start_pfn || mmd->pfn_start <= info->cyclic_end_pfn) {
+               if (!(mmd->pfn_end - 1 < info->cyclic_start_pfn && mmd->pfn_start >= info->cyclic_end_pfn)) {
                        if (!__exclude_unnecessary_pages(mmd->mem_map,
                                                         mmd->pfn_start, mmd->pfn_end))
                                return FALSE;
@@ -5470,23 +5470,25 @@ int
 write_kdump_bitmap_cyclic(void)
 {
        off_t offset;
-
+       int increment;
        int ret = FALSE;

+       increment = divideup(info->cyclic_end_pfn - info->cyclic_start_pfn, BITPERBYTE);
+
        if (info->flag_elf_dumpfile)
                return FALSE;

        offset = info->offset_bitmap1;
        if (!write_buffer(info->fd_dumpfile, offset,
-                         info->partial_bitmap1, BUFSIZE_CYCLIC, info->name_dumpfile))
+                         info->partial_bitmap1, increment, info->name_dumpfile))
                goto out;

        offset += info->len_bitmap / 2;
        if (!write_buffer(info->fd_dumpfile, offset,
-                         info->partial_bitmap2, BUFSIZE_CYCLIC, info->name_dumpfile))
+                         info->partial_bitmap2, increment, info->name_dumpfile))
                goto out;

-       info->offset_bitmap1 += BUFSIZE_CYCLIC;
+       info->offset_bitmap1 += increment;

        ret = TRUE;
 out:
@@ -5508,9 +5510,12 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
         */
        d_exclude_start = getdtime();
        for (info->cyclic_start_pfn = 0, info->cyclic_end_pfn = PFN_CYCLIC;
-            info->cyclic_end_pfn <= info->max_mapnr;
+            info->cyclic_start_pfn < info->max_mapnr;
             info->cyclic_start_pfn += PFN_CYCLIC, info->cyclic_end_pfn += PFN_CYCLIC) {

+               if (info->cyclic_end_pfn > info->max_mapnr)
+                       info->cyclic_end_pfn = info->max_mapnr;
+
                info->num_dumpable += get_num_dumpable_cyclic();
        }
        d_exclude_end = getdtime();
@@ -5546,9 +5551,12 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_data *cd_header, struct cache_d
         * Write pages and bitmap cyclically.
         */
        for (info->cyclic_start_pfn = 0, info->cyclic_end_pfn = PFN_CYCLIC;
-            info->cyclic_end_pfn <= info->max_mapnr;
+            info->cyclic_start_pfn < info->max_mapnr;
             info->cyclic_start_pfn += PFN_CYCLIC, info->cyclic_end_pfn += PFN_CYCLIC) {

+               if (info->cyclic_end_pfn > info->max_mapnr)
+                       info->cyclic_end_pfn = info->max_mapnr;
+
                d_exclude_start = getdtime();
                if (!create_1st_bitmap_cyclic())
                        return FALSE;
diff --git a/makedumpfile.h b/makedumpfile.h
index d0f6032..be4d8e0 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1416,7 +1414,7 @@ is_dumpable(struct dump_bitmap *bitmap, unsigned long long pfn)
 static inline int
 is_dumpable_cyclic(char *bitmap, unsigned long long pfn)
 {
-       if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn < pfn)
+       if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn <= pfn)
                return FALSE;
        else
                return is_on(bitmap, pfn - info->cyclic_start_pfn);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
