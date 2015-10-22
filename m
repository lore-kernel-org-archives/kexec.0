Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 22 Oct 2015 13:15:48 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 13/16] arm64: kdump: add kdump support
Message-ID: <20151022051548.GD11227@dhcp-129-115.nay.redhat.com>
References: <cover.1445297709.git.geoff@infradead.org>
 <ef50b13d545f37a9fa95c5e6856e35f324798d00.1445297709.git.geoff@infradead.org>
 <20151022032534.GC11227@dhcp-129-115.nay.redhat.com>
 <5628662B.1020605@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5628662B.1020605@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI@infradead.org, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, christoffer.dall@linaro.org

On 10/22/15 at 01:29pm, AKASHI Takahiro wrote:
> Hi Dave,
> 
> Thank you for your comment.
> 
> On 10/22/2015 12:25 PM, Dave Young wrote:
> >Hi, AKASHI,
> >
> >On 10/19/15 at 11:38pm, Geoff Levand wrote:
> >>From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >>
> >>On crash dump kernel, all the information about primary kernel's core
> >>image is available in elf core header specified by "elfcorehdr=" boot
> >>parameter. reserve_elfcorehdr() will set aside the region to avoid any
> >>corruption by crash dump kernel.
> >>
> >>Crash dump kernel will access the system memory of primary kernel via
> >>copy_oldmem_page(), which reads one page by ioremap'ing it since it does
> >>not reside in linear mapping on crash dump kernel.
> >>Please note that we should add "mem=X[MG]" boot parameter to limit the
> >>memory size and avoid the following assertion at ioremap():
> >>	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
> >>		return NULL;
> >>when accessing any pages beyond the usable memories of crash dump kernel.
> >
> >How does kexec-tools pass usable memory ranges to kernel? using dtb?
> >Passing an extra mem=X sounds odd in the design. Kdump kernel should get
> >usable ranges and hanle the limit better than depending on an extern kernel
> >param.
> 
> Well, regarding "depending on an external kernel param,"
> - this limitation ("mem=") is compatible with arm(32) implementation although
>   it is not clearly described in kernel's Documentation/kdump/kdump.txt.
> - "elfcorehdr" kernel parameter is mandatory on x86 as well as on arm/arm64.
>   The parameter is explicitly generated and added by kexec-tools.
> 
> Do I miss your point?

Arm previously use atag_mem tag for memory kernel uses, with dtb, Booting.txt
says: The boot loader must pass at a minimum the size and location of the
system memory

In arm64 booting.txt, it does mentions about dtb but without above sentence.

So if you are using dtb to pass memory I think the extra mem= should be not
necessary unless there's other limitations dtb can not been used.

One thing I'm confused is mem= only pass the memory size, where does you pass
the start addresses? What if there's multiple sections such as some reserved
ranges 2nd kernel also need?

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
