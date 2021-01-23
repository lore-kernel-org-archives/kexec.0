Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l37JO-0002TE-Sh
 for kexec@lists.infradead.org; Sat, 23 Jan 2021 01:01:59 +0000
Received: by mail-ej1-x62c.google.com with SMTP id kg20so9735366ejc.4
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2021 17:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-9-pasha.tatashin@soleen.com>
 <ea2b39d7-d496-d9ac-23c9-c279ec29f5d5@arm.com>
In-Reply-To: <ea2b39d7-d496-d9ac-23c9-c279ec29f5d5@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 22 Jan 2021 20:01:21 -0500
Message-ID: <CA+CK2bAsC-ZBPh-CPhmdjdwtLshHcPOsnEu_NzJ38pvPh0YPPQ@mail.gmail.com>
Subject: Re: [PATCH v9 08/18] arm64: kexec: move relocation function setup
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

On Wed, Apr 29, 2020 at 1:01 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 26/03/2020 03:24, Pavel Tatashin wrote:
> > Currently, kernel relocation function is configured in machine_kexec()
> > at the time of kexec reboot by using control_code_page.
> >
> > This operation, however, is more logical to be done during kexec_load,
> > and thus remove from reboot time. Move, setup of this function to
> > newly added machine_kexec_post_load().
>
> This would avoid the need to special-case the cache maintenance, so its a good cleanup...

Yes, the computation should be moved from kexec-reboot to kexec-load
when possible.

>
>
> > Because once MMU is enabled, kexec control page will contain more than
> > relocation kernel, but also vector table, add pointer to the actual
> > function within this page arch.kern_reloc. Currently, it equals to the
> > beginning of page, we will add offsets later, when vector table is
> > added.
>
> If the vector table always comes second, wouldn't this be extra work to hold the value 0?
> You can control the layout of this relocation code, as it has to be written in assembly.
> I don't get why this would be necessary.
>
>
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index ae1bad0156cd..ec71a153cc2d 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -58,6 +59,17 @@ void machine_kexec_cleanup(struct kimage *kimage)
> >       /* Empty routine needed to avoid build errors. */
> >  }
> >
> > +int machine_kexec_post_load(struct kimage *kimage)
> > +{
> > +     void *reloc_code = page_to_virt(kimage->control_code_page);
> > +
> > +     memcpy(reloc_code, arm64_relocate_new_kernel,
> > +            arm64_relocate_new_kernel_size);
> > +     kimage->arch.kern_reloc = __pa(reloc_code);
>
> Could we move the two cache maintenance calls for this area in here too. Keeping it next
> to the modification makes it clearer why it is required.

Yes, I moved it.

>
> In this case we can use flush_icache_range() instead of its __variant because this now
> happens much earlier.

True.

>
>
> > +     return 0;
> > +}
>
> Regardless,
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you for your review.

Pasha

>
>
> Thanks,
>
> James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
