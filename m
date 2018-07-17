Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ffIGf-000198-WF
 for kexec@lists.infradead.org; Tue, 17 Jul 2018 05:11:23 +0000
Received: by mail-pf0-x244.google.com with SMTP id j26-v6so2937820pfi.10
 for <kexec@lists.infradead.org>; Mon, 16 Jul 2018 22:11:11 -0700 (PDT)
Date: Tue, 17 Jul 2018 14:12:23 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v3.1 0/4] arm64: kexec,kdump: fix boot failures on
 acpi-only system
Message-ID: <20180717051222.GA11258@linaro.org>
References: <20180709234229.20181-1-takahiro.akashi@linaro.org>
 <20180712164918.GA26935@arm.com>
 <20180713003434.GZ28220@linaro.org>
 <CAKv+Gu9PT75XTXGsh1jc5roRO_d2QYKEamq42mfbsXzmerAUzA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9PT75XTXGsh1jc5roRO_d2QYKEamq42mfbsXzmerAUzA@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, "Baicar, Tyler" <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Dave Young <dyoung@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Will,

On Fri, Jul 13, 2018 at 07:49:45AM +0200, Ard Biesheuvel wrote:
> On 13 July 2018 at 02:34, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> > On Thu, Jul 12, 2018 at 05:49:19PM +0100, Will Deacon wrote:
> >> Hi Akashi,
> >>
> >> On Tue, Jul 10, 2018 at 08:42:25AM +0900, AKASHI Takahiro wrote:
> >> > This patch series is a set of bug fixes to address kexec/kdump
> >> > failures which are sometimes observed on ACPI-only system and reported
> >> > in LAK-ML before.
> >>
> >> I tried picking this up, along with Ard's fixup, but I'm seeing a build
> >> failure for allmodconfig:
> >>
> >> arch/arm64/kernel/acpi.o: In function `__acpi_get_mem_attribute':
> >> acpi.c:(.text+0x60): undefined reference to `efi_mem_attributes'
> >>
> >> I didn't investigate further. Please can you fix this?
> >
> > Because CONFIG_ACPI is on and CONFIG_EFI is off.
> >
> > This can happen in allmodconfig as CONFIG_EFI depends on
> > !CONFIG_CPU_BIG_ENDIAN, which is actually on in this case.
> >
> 
> Allowing both CONFIG_ACPI and CONFIG_CPU_BIG_ENDIAN to be configured
> makes no sense at all. Things will surely break if you start using BE
> memory accesses while parsing ACPI tables.
> 
> Allowing CONFIG_ACPI without CONFIG_EFI makes no sense either, since
> on arm64, the only way to find the ACPI tables is through a UEFI
> configuration table.


Do you agree to this?

-Takahiro AKASHI

> > Looking at __acpi_get_mem_attributes(), since there is no information
> > available on memory attributes, what we can do at best is
> >   * return PAGE_KERNEL (= cacheable) for mapped memory,
> >   * return DEVICE_nGnRnE (= non-cacheable) otherwise
> > (See a hunk to be applied on top of my patch#4.)
> >
> > I think that, after applying, acpi_os_ioremap() would work almost
> > in the same way as the original before my patchset given that
> > MAP memblock attribute is used only under CONFIG_EFI for now.
> >
> > Make sense?
> >
> 
> Let's keep your code as is but fix the Kconfig dependencies instead.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
