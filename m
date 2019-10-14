Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iK62m-0004V1-Kn
 for kexec@lists.infradead.org; Mon, 14 Oct 2019 19:30:18 +0000
Received: by mail-ed1-x542.google.com with SMTP id r9so15786972edl.10
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2019 12:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20191004185234.31471-1-pasha.tatashin@soleen.com>
 <20191004185234.31471-15-pasha.tatashin@soleen.com>
 <f1c50a5f-103e-e6d7-e93d-e873a169833e@arm.com>
In-Reply-To: <f1c50a5f-103e-e6d7-e93d-e873a169833e@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 14 Oct 2019 15:29:58 -0400
Message-ID: <CA+CK2bBU3ZkTRP8VuS7zwKLPBa+4nSdirq_ss7_aODoLe2iucA@mail.gmail.com>
Subject: Re: [PATCH v6 14/17] arm64: kexec: move relocation function setup and
 clean up
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
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

> > In addition, do some cleanup: add infor about reloction function to
>
> infor ? reloction?

Typo. I have fixed commit log. It meant to be "info about
arm64_relocate_new_kernel function"

>
>
> > kexec_image_info(), and remove extra messages from machine_kexec().
>
>
> > Make dtb_mem, always available, if CONFIG_KEXEC_FILE is not configured
> > dtb_mem is set to zero anyway.
>
> This is unrelated cleanup, please do it as an earlier patch to make it clearer what you
> are changing here.
Ok.

>
> (I'm not convinced you need to cache va<->pa)
>
>
> > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > index 12a561a54128..d15ca1ca1e83 100644
> > --- a/arch/arm64/include/asm/kexec.h
> > +++ b/arch/arm64/include/asm/kexec.h
> > @@ -90,14 +90,15 @@ static inline void crash_prepare_suspend(void) {}
> >  static inline void crash_post_resume(void) {}
> >  #endif
> >
> > -#ifdef CONFIG_KEXEC_FILE
> >  #define ARCH_HAS_KIMAGE_ARCH
> >
> >  struct kimage_arch {
> >       void *dtb;
> >       unsigned long dtb_mem;
>
> > +     unsigned long kern_reloc;
>
> This is cache-ing the physical address of an all-architectures value from struct kimage,
> in the arch specific part of struct kiamge. Why?
> (You must have the struct kimage on hand to access this thing at all!)

Because, currently only one physical page is used in order to do reboot:
control_code_page; this is where arm64_relocate_new_kernel is copied.
So, PA of control_code_page is used as a handler. But with MMU enabled
kexec reboot, a number of pages are allocated for reboot purposes,
they contain page table, arm64_relocate_new_kernel, and el2 vector
table. This is why we need handlers. control_code_page is simply one
of the pages that can contains any of the kexec reboot specific data.

> If its supposed to be a physical address, please use phys_addr_t.

Done that, also changed dtb_mem to phys_addr_t.

>
> >  };
>
>
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index 0df8493624e0..9b41da50e6f7 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -42,6 +42,7 @@ static void _kexec_image_info(const char *func, int line,
> >       pr_debug("    start:       %lx\n", kimage->start);
> >       pr_debug("    head:        %lx\n", kimage->head);
> >       pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
> > +     pr_debug("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
> >
> >       for (i = 0; i < kimage->nr_segments; i++) {
> >               pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages\n",
> > @@ -58,6 +59,19 @@ void machine_kexec_cleanup(struct kimage *kimage)
> >       /* Empty routine needed to avoid build errors. */
> >  }
> >
> > +int machine_kexec_post_load(struct kimage *kimage)
> > +{
> > +     unsigned long kern_reloc;
> > +
> > +     kern_reloc = page_to_phys(kimage->control_code_page);
>
> kern_reloc should be phys_addr_t.

Ok

>
>
> > +     memcpy(__va(kern_reloc), arm64_relocate_new_kernel,
> > +            arm64_relocate_new_kernel_size);
> > +     kimage->arch.kern_reloc = kern_reloc;
>
>
> Please move the cache maintenance in here too. This will save us doing it late during
> kdump. This will also group the mmu-on changes together.

OK, but I think we should do it in a separate patch. I assume you mean
this code to be moved to load time:

177         /* Flush the reboot_code_buffer in preparation for its execution. */
178         __flush_dcache_area(reboot_code_buffer,
arm64_relocate_new_kernel_size);
179
180         /*
181          * Although we've killed off the secondary CPUs, we don't update
182          * the online mask if we're handling a crash kernel and consequently
183          * need to avoid flush_icache_range(), which will attempt to IPI
184          * the offline CPUs. Therefore, we must use the __* variant here.
185          */
186         __flush_icache_range((uintptr_t)reboot_code_buffer,
187                              arm64_relocate_new_kernel_size);

Is it safe to do? We do not know what CPU is going to be executing
kexec reboot for us at the load time.

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
