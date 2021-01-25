Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l47Dk-0005PN-Q2
 for kexec@lists.infradead.org; Mon, 25 Jan 2021 19:08:18 +0000
Received: by mail-ed1-x531.google.com with SMTP id g1so16842109edu.4
 for <kexec@lists.infradead.org>; Mon, 25 Jan 2021 11:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-16-pasha.tatashin@soleen.com>
 <e5f1ee17f8e4ac3a5f5077d85318e0ed@kernel.org>
In-Reply-To: <e5f1ee17f8e4ac3a5f5077d85318e0ed@kernel.org>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 25 Jan 2021 14:07:39 -0500
Message-ID: <CA+CK2bB=kLV7gamcpdBr0SJ1mR-JwosL8FH=AiFMUmvGc_FE6g@mail.gmail.com>
Subject: Re: [PATCH v9 15/18] arm64: kexec: kexec EL2 vectors
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
To: Marc Zyngier <maz@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, steve.capper@arm.com, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Selin Dag <selindag@gmail.com>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, James Morse <james.morse@arm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, rfontana@redhat.com, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>

> > +.macro el1_sync_64
> > +     br      x4                      /* Jump to new world from el2 */
> > +     .fill 31, 4, 0                  /* Set other 31 instr to zeroes */
> > +.endm
>
> The common idiom to write this is to align the beginning of the
> macro, and not to bother about what follows:
>
> .macro whatever
>          .align 7
>          br      x4
> .endm
>
> Specially given that 0 is an undefined instruction, and I really hate to
> see
> those in the actual text. On the contrary, .align generates NOPs.

Fixed that.

>
> > +
> > +.macro invalid_vector label
> > +\label:
> > +     b \label
> > +     .fill 31, 4, 0                  /* Set other 31 instr to zeroes */
> > +.endm
> > +
> > +/* el2 vectors - switch el2 here while we restore the memory image. */
> > +     .align 11
> > +ENTRY(kexec_el2_vectors)
>
> Please see commit 617a2f392c92 ("arm64: kvm: Annotate assembly using
> modern
> annoations"), and follow the same pattern.

Fixed that as well.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
