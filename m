Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WBLTG-00010I-IC
 for kexec@lists.infradead.org; Thu, 06 Feb 2014 09:42:12 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2] vmcore: copy fractional pages into buffers in the
 kdump 2nd kernel
Date: Thu, 6 Feb 2014 09:38:35 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971E6D19@BPXM01GP.gisp.nec.co.jp>
References: <52A579EE.6090107@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971E47E1@BPXM01GP.gisp.nec.co.jp>
 <52EB73A1.3080409@jp.fujitsu.com>
In-Reply-To: <52EB73A1.3080409@jp.fujitsu.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 2014/01/31 18:58:08, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> (2014/01/31 11:36), Atsushi Kumagai wrote:
> > Hello HATAYAMA-san,
> >
> > On 2013/12/09 17:06:18, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> >> This is a patch for fixing mmap failure due to fractional page issue.
> >>
> >> This patch might be still a bit too large as a single patch and might need to split.
> >> If you think patch refactoring is needed, please suggest.
> >>
> >> Change Log:
> >>
> >> v1 => v2)
> >>
> >> - Copy fractional pages from 1st kernel to 2nd kernel to reduce read
> >>    to the fractional pages for reliability.
> >>
> >> - Deal with the case where multiple System RAM areas are contained in
> >>    a single fractional page.
> >>
> >> Test:
> >>
> >> Tested on X86_64. Fractional pages are created using memmap= kernel
> >> parameter on the kdump 1st kernel.
> >
> > Could you tell me more details about how to reproduce this ?
> > I tried to create such fractional pages to test the patch at
> > the end of this mail, by using memmap= kernel parameter as you said
> > like below:
> >
> >    # cat /proc/iomem
> >    ...
> >    100000000-10fff57ff : System RAM
> >    10fff5800-1100057ff : reserved
> >    110005800-11fffffff : System RAM
> >
> > However, I couldn't face the mmap() failure and makedumpfile worked
> > normally even using mmap() on linux-3.12.1. What am I missing here ?
> >
> 
> This patch set tries to reduce potential risk on accessing i.e. creating
> page tables reading memory outside System RAM regions. The potential risk
> I intend here is for example effect of accessing mmio region.
> 
> If you didn't see any failure except for mmap() failure on fractional pages,
> there's no potential risk on your system in the sense of what I mean above.
> Or you could probably see different behavior by choosing other System RAM
> region that resides in the memory that is used for something special.

Thanks for your response, but I couldn't see even the mmap() failure caused
by a sanity check in remap_pfn_range().
I'll describe what I did for debugging as below.

First, the 1st kernel's memory map I prepared and its PT_LOAD are here.

   # cat /proc/iomem

   ...
   100000000-10fff57ff : System RAM
   10fff5800-1100057ff : ACPI Tables
   110005800-11fffffff : System RAM

   ...

   Type           Offset             VirtAddr           PhysAddr
                  FileSiz            MemSiz              Flags  Align
   LOAD           0x00000000d07ca000 0xffff880100000000 0x0000000100000000
                  0x000000000fff5800 0x000000000fff5800  RWE    0
   LOAD           0x00000000e07c0800 0xffff880110005800 0x0000000110005800
                  0x000000000fffa800 0x000000000fffa800  RWE    0


The fractional page I expected was [0x10fff5000 - 0x10fff57ff],
so its file offset was [0xe07bf000 - 0xe07bf7ff].

Second, I prepared a patch to make sure whether the fractional page was
mapped with mmap() or not as below:


diff --git a/makedumpfile.c b/makedumpfile.c
index 7536274..b6abd31 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -251,11 +251,16 @@ update_mmap_range(off_t offset, int initial) {

        map_size = MIN(max_offset - start_offset, info->mmap_region_size);

+       if (start_offset <= 0xe07bf000 && 0xe07bf000 <= (start_offset + map_size)) {
+               MSG("Try mapping [%llx-%llx] with mmap()\n",
+                   (ulonglong)start_offset,
+                   (ulonglong)(start_offset + map_size));
+       }
+
        info->mmap_buf = mmap(NULL, map_size, PROT_READ, MAP_PRIVATE,
                                     info->fd_memory, start_offset);


Finally, I run makedumpfile_v1.5.5 with only the debug patch above in
2nd kernel (linux-3.12.1):

    # makedumpfile -D -c /proc/vmcore ./dumpfile.c
    ...
    
    mmap() is available on the kernel.
    Copying data                       : [ 92.9 %] -Try mapping [e03f9000-e07f9000] with mmap()
    Copying data                       : [100.0 %] |
    Writing erase info...
    offset_eraseinfo: 12ad1218, size_eraseinfo: 0

    The dumpfile is saved to ./dumpfile.c.

    makedumpfile Completed.
    #


According to this result, mmap() for the fractional page seemed to
succeed even without any fix, so I suspect that I misunderstand
something about the mmap() issue reported by Vivek.
Perhaps, can a fractional page pass that sanity check depending on
the situation ?

At least, I confirmed that the my patch I sent truncates mmap() regions
as I expected with the debug patch above, so I think there is no problem
with it.


Thanks
Atsushi Kumagai

> Also, in early phase, our design didn't care about this kind of fractional pages
> because we don't think there were many such systems on real world. But the
> bug report came earlier than we expected. So, I think we should design
> carefully here around at least as long as they can be done relatively simply.
> # Sorry for delaying my work...
> 
> Of course, I think both kernel and makedumpfile address the issue together
> to reduce potential risk as much as possible.
> 
> -- 
> Thanks.
> HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
