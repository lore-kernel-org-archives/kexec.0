Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WmjVy-0007Ud-6H
 for kexec@lists.infradead.org; Tue, 20 May 2014 12:51:30 +0000
Date: Tue, 20 May 2014 08:51:04 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <768772288.14234200.1400590264454.JavaMail.zimbra@redhat.com>
In-Reply-To: <537AD0FC.1020202@huawei.com>
References: <mailman.5.1400526001.29113.kexec@lists.infradead.org>
 <1809090930.13449697.1400528518027.JavaMail.zimbra@redhat.com>
 <537AD0FC.1020202@huawei.com>
Subject: Re: [BUG REPORT] kexec and makedumpfile can't detect PAGE_OFFSET on
 arm (Wang Nan)
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Wang Nan <wangnan0@huawei.com>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org



----- Original Message -----
> 
> On 2014/5/20 3:41, Dave Anderson wrote:
> > 
> > 
> > ----- Original Message -----
> >>
> >> Hi Atsushi and Simon,
> >>
> >> I find a problem about VMSPLIT on arm plarform, related to kexec and
> >> makedumpfile.
> >>
> >> When CONFIG_VMSPLIT_1G/2G is selected by kernel, PAGE_OFFSET is actually
> >> 0x40000000 or 0x80000000. However, kexec hard codes PAGE_OFFSET to
> >> 0xc0000000 (in kexec/arch/arm/crashdump-arm.h), which is incorrect in
> >> these situations. For example, on realview-pbx board with 1G/3G VMSPLIT,
> >> PHDRs in generated /proc/vmcore is as follow:
> >>
> >>   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
> >>   NOTE           0x001000 0x00000000 0x00000000 0x00690 0x00690     0
> >>   LOAD           0x002000 0xc0000000 0x00000000 0x10000000 0x10000000 RWE
> >>   0
> >>   LOAD           0x10002000 0xe0000000 0x20000000 0x8000000 0x8000000 RWE
> >>   0
> >>   LOAD           0x18002000 0xf0000000 0x30000000 0x10000000 0x10000000
> >>   RWE 0
> >>   LOAD           0x28002000 0x40000000 0x80000000 0x10000000 0x10000000
> >>   RWE 0
> >>
> >> Which should be:
> >>
> >>   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
> >>   ...
> >>   LOAD            ...     0x40000000 0x00000000 0x10000000 0x10000000 RWE
> >>   0
> >>   LOAD            ...     0x60000000 0x20000000 0x8000000 0x8000000 RWE 0
> >>   LOAD            ...     0x70000000 0x30000000 0x10000000 0x10000000 RWE
> >>   0
> >>   LOAD            ...     0xc0000000 0x80000000 0x10000000 0x10000000 RWE
> >>   0
> >>
> >> I don't know why crash utility can deal with it without problem,
> > 
> > For ARM the crash utility masks the symbol value of "_stext" with 0x1fffffff
> > to determine the PAGE_OFFSET value, which was basically copied from the way
> > it was done for i386.
> > 
> 
> kexec-tools can do the same thing by reading /proc/kallsyms (crashdump-x86.c has already done this).
> However, KALLSYMS and KALLSYMS_ALL are turned off on some embedded systems with memory limitation,
> which is common on ARM.

But you could use VMCOREINFO_SYMBOL(_stext), right?

Dave
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
