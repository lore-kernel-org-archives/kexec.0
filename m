Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i4fQD-0007RS-Sv
 for kexec@lists.infradead.org; Mon, 02 Sep 2019 06:02:39 +0000
Date: Mon, 2 Sep 2019 14:02:33 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] x86: Fix PAGE_OFFSET for kernels since 4.20
Message-ID: <20190902060233.GA13964@MiWiFi-R3L-srv>
References: <20190830091258.51133-1-buczek@molgen.mpg.de>
 <20190830092351.GE12242@MiWiFi-R3L-srv>
 <99faeaab-a4ea-e204-f4e8-9b74f86e5e43@molgen.mpg.de>
 <CACi5LpOBQCXv1v=aGjLZ0tE_qUDgcR8DtcC_uA5nC-tmm4UnZw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACi5LpOBQCXv1v=aGjLZ0tE_qUDgcR8DtcC_uA5nC-tmm4UnZw@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec mailing list <kexec@lists.infradead.org>, Donald Buczek <buczek@molgen.mpg.de>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>

On 08/30/19 at 03:35pm, Bhupesh Sharma wrote:
> On Fri, Aug 30, 2019 at 3:04 PM Donald Buczek <buczek@molgen.mpg.de> wrote:
> >
> > Dear Baoquan,
> >
> > On 8/30/19 11:23 AM, Baoquan He wrote:
> > > On 08/30/19 at 11:12am, Donald Buczek wrote:
> > >> Linux kernel commit d52888aa2753 ("x86/mm: Move LDT remap out of KASLR
> > >> region on 5-level paging") changed the base of the direct mapping
> > >> from 0xffff880000000000 to 0xffff888000000000. This was merged
> > >> into v4.20-rc2.
> > >
> > > A good catch and necessary fix, thanks.
> > >
> > > Does it have issue in makedumpfile?
> >
> > We don't use makedumpfile. We use `cp /proc/vmcore /mnt/crash.vmcore` in the panic kernel.
> 
> That shouldn't be a problem in makedumpfile as we have a generic way
> to calculate the PAGE_OFFSET value there from the PT_LOADs in the
> '/proc/kcore' file (which I mentioned in the other email conversation,
> see [0]):

Yeah, right.

> 
> static int
> get_page_offset_x86_64(void)
> {
> <..snip..>
>     if (get_num_pt_loads()) {
>         /*
>          * Linux 4.19 (only) adds KCORE_REMAP PT_LOADs, which have
>          * virt_start < __START_KERNEL_map, to /proc/kcore. In order
>          * not to select them, we select the last valid PT_LOAD.
>          */
>         for (i = 0;
>             get_pt_load(i, &phys_start, NULL, &virt_start, NULL);
>             i++) {
>             if (virt_start != NOT_KV_ADDR
>                     && virt_start < __START_KERNEL_map
>                     && phys_start != NOT_PADDR) {
>                 page_offset = virt_start - phys_start;
>             }
>         }
>         if (page_offset) {
>             info->page_offset = page_offset;
>             DEBUG_MSG("page_offset  : %lx (pt_load)\n",
>                 info->page_offset);
>             return TRUE;
>         }
>     }
> <..snip..>
> 
> Also as I mentioned in the other thread, I don't think adding
> different MACRO value for a kernel version is a long-term maintainable
> approach. Instead I am working on adding a similar functionality as
> present in makedumpfile to make the PAGE_OFFSET calculation generic.
> Only if we fail to calculate PAGE_OFFSET through a generic method
> should we fall back on MACRO values for backward compatibility.
> 
> I will try to post the patch for reviews by tomorrow.
> 
> [0]. https://lkml.org/lkml/2019/8/28/1060

Sounds a good idea, thanks for the effort.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
