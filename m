Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmNU3-009a5m-5S
 for kexec@lists.infradead.org; Thu, 27 May 2021 21:24:04 +0000
Received: by mail-ed1-x530.google.com with SMTP id r11so2419740edt.13
 for <kexec@lists.infradead.org>; Thu, 27 May 2021 14:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210527150526.271941-1-pasha.tatashin@soleen.com>
 <20210527150526.271941-4-pasha.tatashin@soleen.com>
 <87sg28rx3c.wl-maz@kernel.org>
In-Reply-To: <87sg28rx3c.wl-maz@kernel.org>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 27 May 2021 17:23:22 -0400
Message-ID: <CA+CK2bDvsFX_s-G5tRcE1GreNW_xLTognosUFbPPgaUK7-cafQ@mail.gmail.com>
Subject: Re: [PATCH 03/18] arm64: hyp-stub: Move elx_sync into the vectors
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
Cc: James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, James Morse <james.morse@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mm <linux-mm@kvack.org>, Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com, rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>, Selin Dag <selindag@gmail.com>, Tyler Hicks <tyhicks@linux.microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, madvenka@linux.microsoft.com

On Thu, May 27, 2021 at 11:54 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 27 May 2021 16:05:11 +0100,
> Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
> >
> > The hyp-stub's elx_sync code fits in the vector.
> >
> > With this, all of the hyp-stubs behaviour is contained in its vectors.
> > This lets kexec and hibernate copy the hyp-stub when they need its
> > behaviour, instead of re-implementing it.
> >
> > Co-developed-by: James Morse <james.morse@arm.com>
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  arch/arm64/kernel/hyp-stub.S | 64 +++++++++++++++++++-----------------
> >  1 file changed, 33 insertions(+), 31 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> > index 18a97bee3779..86af6c4e52b9 100644
> > --- a/arch/arm64/kernel/hyp-stub.S
> > +++ b/arch/arm64/kernel/hyp-stub.S
> > @@ -21,6 +21,37 @@ SYM_CODE_START_LOCAL(\label)
> >       .align 7
> >       b       \label
> >  SYM_CODE_END(\label)
> > +.endm
> > +
> > +.macro elx_sync_vector       label
> > +SYM_CODE_START_LOCAL(\label)
> > +     .align 7
> > +     cmp     x0, #HVC_SET_VECTORS
> > +     b.ne    1f
> > +     msr     vbar_el2, x1
> > +     b       9f
> > +
> > +1:   cmp     x0, #HVC_VHE_RESTART
> > +     b.eq    mutate_to_vhe
>
> Now that this has turned into a macro, what are the guarantees that
> mutate_to_vhe will be within reach of the site where this macro is
> expanded? It does work here, but what about the other expansion sites
> that will show up later in the series?
>
> What was wrong with directly branching to the original call site?
> Nothing in the commit message explains it.

Hi Marc,

I need to explain this better in the commit log. Later in the series
we create our own vector copy that is outside of the old and new
kernel so it does not get overwritten during kexec relocation. When
VHE is enabled, the vector is passed so we can switch to el2 before
jumping to the new kernel.

arm64_relocate_new_kernel() which performs the relocation runs with
MMU being enabled until relocation is done, after that disables MMU
and if vectors are passed performs:

         mov     x0, #HVC_SOFT_RESTART
         hvc     #0         /* Jumps from el2 */

It cannot call mutate_to_vhe because #HVC_VHE_RESTART is not used
here. But, if it had to it would not work as we cannot return to the
old kernel text after relocation.

Thanks,
Pasha

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
