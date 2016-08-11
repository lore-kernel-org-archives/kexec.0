Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXmpr-0001oC-Ss
 for kexec@lists.infradead.org; Thu, 11 Aug 2016 10:03:37 +0000
Received: by mail-yw0-f174.google.com with SMTP id u134so40580226ywg.3
 for <kexec@lists.infradead.org>; Thu, 11 Aug 2016 03:03:15 -0700 (PDT)
Date: Thu, 11 Aug 2016 15:33:10 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v24 5/9] arm64: kdump: add kdump support
Message-ID: <20160811100310.GA29357@localhost.localdomain>
References: <20160809015248.28414-2-takahiro.akashi@linaro.org>
 <20160809015615.28527-1-takahiro.akashi@linaro.org>
 <20160809015615.28527-3-takahiro.akashi@linaro.org>
 <57AB586D.3080900@arm.com>
 <20160810181827.GC24137@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160810181827.GC24137@localhost.localdomain>
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
To: James Morse <james.morse@arm.com>
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 10/08/2016:11:48:27 PM, Pratyush Anand wrote:
> On 10/08/2016:05:38:05 PM, James Morse wrote:
> > =========================%<=========================
> > diff --git a/arch/arm64/kernel/crash_dump.c b/arch/arm64/kernel/crash_dump.c
> > index 2dc54d129be1..784d4c30b534 100644
> > --- a/arch/arm64/kernel/crash_dump.c
> > +++ b/arch/arm64/kernel/crash_dump.c
> > @@ -37,6 +37,11 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> >         if (!csize)
> >                 return 0;
> > 
> > +       if (memblock_is_memory(pfn << PAGE_SHIFT) &&
> > +           !memblock_is_map_memory(pfn << PAGE_SHIFT))
> > +               /* skip this nomap memory region, reserved by firmware */
> > +               return 0;

This should return 0 or -EINVAL? because, its caller does not care properly
about 0 return value (when csize is non-zero). So either we need to return
-EINVAL or we need to fix it's caller so that pread() would know that required
number of data were not read.

> > +
> >         vaddr = ioremap_cache(__pfn_to_phys(pfn), PAGE_SIZE);
> >         if (!vaddr)
> >                 return -ENOMEM;
> > =========================%<=========================
> 
> In any case kernel must not panic, so I think we must have above hunk. However,
> we also need to look into kexec-tools that why it is asking kernel to copy those
> unneeded chunks.
> 
> I will test tomorrow with above hunk.

After that hunk it did not crash but vmcore-dmesg fails with following message:
"No program header covering vaddr 0x401ff0found kexec bug?"

It happened because vmcore-dmesg is sending wrong offset to the pread(), and so
it did not crash after the above kernel hunk but it still read garbage wrong
log_buf virtual address pointer.

vmcore-dmesg is sending wrong offset because page_offset(vp_offset) calculation
is not perfect for my case, explained here [1].

So, if I correct page_offset(vp_offset) (as arm64_mem.page_offset = ehdr.e_entry
- "kernel Code Start PA" + phys_offset), then vmcore-dmesg and vmcore copy
worked fine, however if I use makedumpfile to copy(compressed) data from
/proc/vmcore then it still generates "synchronous external abort". I think, it
generated because it would have found garbage data in EFI memory region. My
/proc/iomem shows following:

8000000000-8001e7ffff : System RAM
8001e80000-83ff17ffff : System RAM
  8002080000-8002b3ffff : Kernel code
  8002c40000-800348ffff : Kernel data
  807fe00000-80ffdfffff : Crash kernel
83ff180000-83ff1cffff : System RAM
83ff1d0000-83ff21ffff : System RAM
83ff220000-83ffe4ffff : System RAM
83ffe50000-83ffffffff : System RAM

If I clip all the region before "kernel code" and provide that clipped
input to kexec-tools then everything works fine.

~Pratyush

[1] http://lists.infradead.org/pipermail/kexec/2016-August/016834.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
