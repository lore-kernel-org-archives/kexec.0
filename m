Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l390V-0008Gk-RH
 for kexec@lists.infradead.org; Sat, 23 Jan 2021 02:50:38 +0000
Received: by mail-ej1-x62f.google.com with SMTP id by1so10439234ejc.0
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2021 18:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-14-pasha.tatashin@soleen.com>
 <012e19d9-97d6-805a-bfec-8c6e7104f852@arm.com>
In-Reply-To: <012e19d9-97d6-805a-bfec-8c6e7104f852@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 22 Jan 2021 21:49:58 -0500
Message-ID: <CA+CK2bCz17hX9-iPQaas_PNyBgz0sMbJT9eczy549uw74zvh6g@mail.gmail.com>
Subject: Re: [PATCH v9 13/18] arm64: kexec: add expandable argument to
 relocation function
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
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Selin Dag <selindag@gmail.com>, steve.capper@arm.com, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, rfontana@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Marc Zyngier <maz@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, May 7, 2020 at 12:22 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 26/03/2020 03:24, Pavel Tatashin wrote:
> > Currently, kexec relocation function (arm64_relocate_new_kernel) accepts
> > the following arguments:
> >
> > head:         start of array that contains relocation information.
> > entry:                entry point for new kernel or purgatory.
> > dtb_mem:      first and only argument to entry.
>
> > The number of arguments cannot be easily expended, because this
> > function is also called from HVC_SOFT_RESTART, which preserves only
> > three arguments. And, also arm64_relocate_new_kernel is written in
> > assembly but called without stack, thus no place to move extra
> > arguments to free registers.
> >
> > Soon, we will need to pass more arguments: once we enable MMU we
> > will need to pass information about page tables.
>
>
> > Another benefit of allowing this function to accept more arguments, is that
> > kernel can actually accept up to 4 arguments (x0-x3), however currently
> > only one is used, but if in the future we will need for more (for example,
> > pass information about when previous kernel exited to have a precise
> > measurement in time spent in purgatory), we won't be easilty do that
> > if arm64_relocate_new_kernel can't accept more arguments.
>
> This is a niche debug hack.
> We really don't want an ABI with purgatory. I think the register values it gets were added
> early for compatibility with kexec_file_load().
>
>
> > So, add a new struct: kern_reloc_arg, and place it in kexec safe page (i.e
> > memory that is not overwritten during relocation).
> > Thus, make arm64_relocate_new_kernel to only take one argument, that
> > contains all the needed information.
>
> Do we really not have enough registers?
>
> The PCS[0] gives you 8 arguments. In this patch you use 6.
>
>
> If this is really about the hyp-stub abi, please state that.

Yes, this is a hypervisor abi limitation. I will improve the commit
log to state it clearly.

> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index cee3be586384..b1122eea627e 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -59,13 +60,35 @@ void machine_kexec_cleanup(struct kimage *kimage)
>
> >  int machine_kexec_post_load(struct kimage *kimage)
> >  {
> >       void *reloc_code = page_to_virt(kimage->control_code_page);
> > +     struct kern_reloc_arg *kern_reloc_arg = kexec_page_alloc(kimage);
> > +
> > +     if (!kern_reloc_arg)
> > +             return -ENOMEM;
> >
> >       memcpy(reloc_code, arm64_relocate_new_kernel,
> >              arm64_relocate_new_kernel_size);
> >       kimage->arch.kern_reloc = __pa(reloc_code);
> > +     kimage->arch.kern_reloc_arg = __pa(kern_reloc_arg);
> > +     kern_reloc_arg->head = kimage->head;
> > +     kern_reloc_arg->entry_addr = kimage->start;
> > +     kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;
>
> These kern_reloc_arg values are written via the cacheable linear map.
> They are read in arm64_relocate_new_kernel() where the MMU is disabled an all memory
> access are non-cacheable.
>
> To ensure you read the values you wrote, you must clean kern_reloc_arg to the PoC.

Thank you for catching this, I added:
 __flush_dcache_area(kern_reloc_arg, sizeof (struct kern_reloc_arg));

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
