Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hnpMn-0007ee-1p
 for kexec@lists.infradead.org; Wed, 17 Jul 2019 19:13:31 +0000
Received: by mail-ed1-x544.google.com with SMTP id x19so21274099eda.12
 for <kexec@lists.infradead.org>; Wed, 17 Jul 2019 12:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190716165641.6990-1-pasha.tatashin@soleen.com>
 <4c8a3a11-adc2-efa4-f765-6be338546ae4@arm.com>
In-Reply-To: <4c8a3a11-adc2-efa4-f765-6be338546ae4@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 17 Jul 2019 15:13:15 -0400
Message-ID: <CA+CK2bBj9UsQZCLsy-S8c_Kd5SRAPvtdS8s9P_Fdg+VifTbT5w@mail.gmail.com>
Subject: Re: [RFC v1 0/4] arm64: MMU enabled kexec kernel relocation
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
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, "Eric W. Biederman" <ebiederm@xmission.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi James,

Thank you for taking a look at this work.

> After a quick skim:
>
> This will map 'nomap' regions of memory with cacheable attributes. This is a non-starter.
> These regions were described by firmware as having content that was/is written with
> different attributes. The attributes must match whenever it is mapped, otherwise we have a
> loss of coherency. Mapping this stuff as cacheable means the CPU can prefetch it into the
> cache whenever it likes.

> It may be important that we do not ever map some of these regions, even though its
> described as memory. On AMD-Seattle the bottom page of memory is reserved by firmware for
> its own use; it is made secure-only, and any access causes an
> external-abort/machine-check. UEFI describes this as 'Reserved', and we preserve this in
> the kernel as 'nomap'. The equivalent DT support uses memreserve, possibly with the
> 'nomap' attribute.
>
> Mapping a 'new'/unknown region with cacheable attributes can never be safe, even if we
> trusted kexec-tool to only write the kernel to memory. The host may be using a bigger page
> size causing more memory to become cacheable than was intended.
> Linux's EFI support rounds the UEFI memory map to the largest support page size, (and
> winges about firmware bugs).
> If we're allowing kexec to load images in a region not described as IORESOURCE_SYSTEM_RAM,
> that is a bug we should fix.

We are allowing this. If you consider this to be a bug, I will fix it,
and this will actually simplify the idmap page table. User will
receive an error during kexec load if a request is made to load into
!IORESOURCE_SYSTEM_RAM region.

>
> The only way to do this properly is to copy the linear mapping. The arch code has lots of
> complex code to generate it correctly at boot, we do not want to duplicate it.
> (this is why hibernate copies the linear mapping)

As I understand, you would like to take a copy of idmap page table,
and add entries only for segment
sources and destinations into the new page table?

If so, there is a slight problem: arch hook machine_kexec_prepare() is
called prior to loading segments from userland. We can solve this by
adding another hook that is called after kimage_terminate().

> These patches do not remove the running page tables from TTBR1. As you overwrite the live
> page tables you will corrupt the state of the CPU. The page-table walker may access things
> that aren't memory, cache memory that shouldn't be cached (see above), and allocate
> conflicting entries in the TLB.

Indeed. However, I was following what is done in create_safe_exec_page():
https://soleen.com/source/xref/linux/arch/arm64/kernel/hibernate.c?r=af873fce#263

ttbr1 is not removed there. Am I missing something, or is not yet
configured there?

I will set ttbr1 to zero page.

> You cannot use the mm page table helpers to build an idmap on arm64. The mm page table
> helpers have a compile-time VA_BITS, and we support systems where there is no memory below
> 1<<VA_BITS. (crazy huh!). Picking on AMD-Seattle again: if you boot a 4K 39bit VA kernel,
> the idmap will have more page table levels than the page table helpers can build. This is
> why there are special helpers to load the idmap, and twiddle TCR_EL1.T0SZ.
> You already need to copy the linear-map, so using an idmap is extra work. You want to work
> with linear-map addresses, you probably need to add the field to the appropriate structure.

OK. Makes sense. I will do the way hibernate setup this table. I was
indeed following x86, hoping that eventually it would be possible to
unite: kasan, hibernate, and kexec implementation of this page table.

>
> The kexec relocation code still runs at EL2. You can't use a copy of the linear map here
> as there is only one TTBR on v8.0, and you'd need to setup EL2 as its been torn back to
> the hyp-stub.

As I understand normally on baremetal kexec runs at EL1 not EL2. On my
machine is_kernel_in_hyp_mode() == false in cpu_soft_restart.

This is the reason hibernate posts EL2 in a holding pen while it rewrites
> all of memory, then calls back to fixup EL2. Keeping the rewrite phase at EL1 means it
> doesn't need independently tweaking/testing. You need to do something similar, either
> calling EL2 to start the new image, or disabling the MMU at EL1 to start the new image there.

OK, I will study how hibernate does this. I was thinking that if we
are running in EL2 we can simply configure TTBR0_EL2 instead of
TTBR0_EL1. But, I need to understand this better.

>
> You will need to alter the relocation code to do nothing for kdump, as no relocation is
> required and building page-tables is extra work where the kernel may croak, preventing us
> from reaching kdump.

Yes, I was planning to do nothing for kdump, which involves not
allocating page table. It is not part of the current patchest, as the
current series is not ready.

>
> Finally, having this independent idmap machinery isn't desirable from a maintenance
> perspective. Please start with the hibernate code that already solves a very similar
> problem, as it already has most of these problems covered.

OK.

> > This patch series works in terms, that I can kexec-reboot both in QEMU
>
> I wouldn't expect Qemu's emulation of the MMU and caches to be performance accurate.

I am not measuring performance in QEMU, I use it for
development/verification only. The performance is measured on real
hardware only.

>
> > and on a physical machine. However, I do not see performance improvement
> > during relocation. The performance is just as slow as before with disabled
> > caches.
>
> > Am I missing something? Perhaps, there is some flag that I should also
> > enable in page table? Please provide me with any suggestions.
>
> Some information about the physical machine you tested this on would help.
> I'm guessing its v8.0, and booted at EL2....

I am using Broadcom's Stingray SoC. Because  is_kernel_in_hyp_mode()
returns false, I believe it is EL1. How can I boot it at EL2?

So, I am still confused why I do not see performance improvements
during relocation on this machine. Any theories?

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
