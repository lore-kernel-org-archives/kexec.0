Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l37WQ-0003OG-SE
 for kexec@lists.infradead.org; Sat, 23 Jan 2021 01:15:28 +0000
Received: by mail-ej1-x62f.google.com with SMTP id hs11so10270120ejc.1
 for <kexec@lists.infradead.org>; Fri, 22 Jan 2021 17:15:25 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-11-pasha.tatashin@soleen.com>
 <e6faa23d-27a8-838a-33ef-2a6ad8a5c746@arm.com>
In-Reply-To: <e6faa23d-27a8-838a-33ef-2a6ad8a5c746@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 22 Jan 2021 20:14:49 -0500
Message-ID: <CA+CK2bDJeYPzGyVkRJu2AOkvV8SJ=ea3jbAZtho8_VA416kZ4A@mail.gmail.com>
Subject: Re: [PATCH v9 10/18] arm64: kexec: cpu_soft_restart change argument
 types
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
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, steve.capper@arm.com, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, rfontana@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Marc Zyngier <maz@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Selin Dag <selindag@gmail.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Wed, Apr 29, 2020 at 1:01 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 26/03/2020 03:24, Pavel Tatashin wrote:
> > Change argument types from unsigned long to a more descriptive
> > phys_addr_t.
>
> For 'entry', which is a physical addresses, sure...
>
> > diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
> > index ed50e9587ad8..38cbd4068019 100644
> > --- a/arch/arm64/kernel/cpu-reset.h
> > +++ b/arch/arm64/kernel/cpu-reset.h
> > @@ -10,17 +10,17 @@
> >
> >  #include <asm/virt.h>
> >
> > -void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
> > -     unsigned long arg0, unsigned long arg1, unsigned long arg2);
>
> > +void __cpu_soft_restart(phys_addr_t el2_switch, phys_addr_t entry,
> > +                     phys_addr_t arg0, phys_addr_t arg1, phys_addr_t arg2);
>
> This looks weird because its re-using the hyp-stub API, because it might call the hyp-stub
> from the idmap. entry is passed in, so this isn't tied to kexec. Without tying it to
> kexec, how do you know arg2 is a physical address?
> I think it tried to be re-usable because 32bit has more users for this.

I will drop this patch. It was intended as a cleanup from suggestions
in earlier versions of this series, but I see it is not really needed.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
