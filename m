Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVnNQ-00Cvoa-5Z
 for kexec@lists.infradead.org; Thu, 30 Sep 2021 04:08:57 +0000
Received: by mail-lf1-x12d.google.com with SMTP id i19so16661539lfu.0
 for <kexec@lists.infradead.org>; Wed, 29 Sep 2021 21:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210916231325.125533-11-pasha.tatashin@soleen.com>
 <20210929124513.GD21631@willie-the-truck>
In-Reply-To: <20210929124513.GD21631@willie-the-truck>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 30 Sep 2021 00:08:17 -0400
Message-ID: <CA+CK2bDBr_upP87hg-8EiUz3ucZ93tAaYaZrfN3JhqszF=PvvQ@mail.gmail.com>
Subject: Re: [PATCH v17 10/15] arm64: kexec: use ld script for relocation
 function
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
To: Will Deacon <will@kernel.org>
Cc: James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mm <linux-mm@kvack.org>, Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com, rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>, Selin Dag <selindag@gmail.com>, Tyler Hicks <tyhicks@linux.microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, madvenka@linux.microsoft.com

Sorry, missed two comments:

> >       /* Flush the reloc_code in preparation for its execution. */
> >       dcache_clean_inval_poc((unsigned long)reloc_code,
> > -                            (unsigned long)reloc_code +
> > -                            arm64_relocate_new_kernel_size);
> > +                            (unsigned long)reloc_code +  reloc_size);
>
> Extra whitespace.

Yeap, extra whitespace after '+', will fix it :)

>
> >       icache_inval_pou((uintptr_t)reloc_code,
> > -                      (uintptr_t)reloc_code +
> > -                      arm64_relocate_new_kernel_size);
> > +                      (uintptr_t)reloc_code + reloc_size);
> >       kexec_list_flush(kimage);
> >       kexec_image_info(kimage);
> >
> > diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
> > index b4fb97312a80..9d2400855ee4 100644
> > --- a/arch/arm64/kernel/relocate_kernel.S
> > +++ b/arch/arm64/kernel/relocate_kernel.S
> > @@ -15,6 +15,7 @@
> >  #include <asm/sysreg.h>
> >  #include <asm/virt.h>
> >
> > +.pushsection    ".kexec_relocate.text", "ax"
>
> Just use .section if you're putting the entire file in there?

Good point, I will change it to .section.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
