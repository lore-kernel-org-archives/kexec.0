Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DF6E77184
	for <kexec@archiver.kernel.org>; Tue, 17 Dec 2024 10:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KfEFTjRzldII6A0QCTeAq8kqxPky8xyBGkO7cwclddI=; b=hgnbsUXp5/OE9J2U/vK7qlFXDe
	eqK2jWT+/oYvgNoy1V+/lMIB+3LBVixrlJVtf0sIol1iDt+zdkT28uM8+HG46IHEVmlYBfPR/2/Lq
	1Y8Ih9ByeIZsq8WP8rNN95T6ddVAhfMsE4ftvOUGnPwn/TqoVP1olGMHI75RX4SOQ3FyAq1zre5IN
	qoxEOIi3WyCd66ez/RwJWLjpYwiE60O1aF+iLwAqbbmHXtAsrch4ZxAkq7Mm1RSIqjJ69/vwWgxcV
	5TBUalMz2DGHsWyATe/fRTufkIQbdcfyc2OFQkQpPegfSRdjAhq0UZAmz/GuQiXkJkXJemRPPTV9I
	C7c0EDdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNUW2-0000000D47S-3BoB;
	Tue, 17 Dec 2024 10:09:22 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNUHi-0000000D0Yr-1xfi
	for kexec@lists.infradead.org;
	Tue, 17 Dec 2024 09:54:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9E94D5C6663
	for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 09:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38120C4CEEF
	for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 09:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734429273;
	bh=SoRE0tJX1dPxgkZAswnsaEB3w3bNrq2DINMKDe/N1JU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o6IpV6+vuyc51vM2lvP+tiEpU+Zz5ShtCdDSEXCAbyiJxCJVGbWazuSoy0gemcI8o
	 jpJyXanFjb0ojgpMN9h2iSTi23DokDuEF4LgZtvg170hhpGuPz7chzuRKB7Iv/vshn
	 wqFpBvF7k7cnHwVrHUAY4akLNzLJMK1rC6Ilr4GXOuWXFioP/U82al3ZFzJ4NWn7ZM
	 hMKJYZ8O5yBBF6ywg3Wfge3lxh4v6hCQ4g787rMOode6Z5e+biOzrnPka85U3LokCr
	 EvtCUp2ZQ/c+4on22mVBWd4P7qhbAZvn64XUWI45QaOeZM7IKi5ZR7tDtkJfB0mOs2
	 h7avukfclg2MQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3035210e2d1so17386191fa.2
        for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 01:54:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJALol5KcuiHJ7YWqf6J9gD/JU3yqXmZH/rFO+mX9964dPPWg97+FTRPoNZSFesPUcSn8ecg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4CYcK0ErcH3r2NGYqD/9+OmEIc1V5lMTSVzQci3o/08HufLp+
	PD0RHoPGWR4HO7Voqzm5K0OX+EDL+ZWahKFfZsxW1lWSoD3nJYawS0Eli7kcmb/rUz3aQWKpwRi
	E57eq7Nu0pfmlLZaQ1m4pdb6Y2Ts=
X-Google-Smtp-Source: AGHT+IEraci2+Hu8P9GERcUQxAvtbsJ4/vxFy/6wsAhwan+Ive8lTqEkVGL7oGBFphJM0wNJFePI6yOz/Ror9WyVZ28=
X-Received: by 2002:a05:651c:553:b0:300:32a3:a322 with SMTP id
 38308e7fff4ca-302544ae84fmr63507231fa.32.1734429271247; Tue, 17 Dec 2024
 01:54:31 -0800 (PST)
MIME-Version: 1.0
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-10-dwmw2@infradead.org>
 <CAMj1kXE2abZ8v83vSr5sDZ1QNF-WMr4XCMRhZoc9EW=JAwvdCA@mail.gmail.com>
 <A18A8675-B1FB-496E-9D8F-FAD412A3FF65@infradead.org> <CAMj1kXFiZvT1joU5gOhZTC18aYi4dPOnFbX1nsHgmnXNy6c6Wg@mail.gmail.com>
 <27388506-9BE8-4540-A444-166C49133295@infradead.org>
In-Reply-To: <27388506-9BE8-4540-A444-166C49133295@infradead.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 17 Dec 2024 10:54:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE-60BqLx4VH6Cw_s0nt=bkx=oFQuts+m6sZFeziH1sqg@mail.gmail.com>
Message-ID: <CAMj1kXE-60BqLx4VH6Cw_s0nt=bkx=oFQuts+m6sZFeziH1sqg@mail.gmail.com>
Subject: Re: [PATCH 9/9] x86/kexec: Use typedef for relocate_kernel_fn
 function prototype
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, Sourabh Jain <sourabhjain@linux.ibm.com>, 
	Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>, David Kaplan <david.kaplan@amd.com>, 
	Tao Liu <ltao@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>, Rong Xu <xur@google.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_015434_586446_DBBDA00A 
X-CRM114-Status: GOOD (  27.15  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, 17 Dec 2024 at 10:42, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On 17 December 2024 10:29:21 CET, Ard Biesheuvel <ardb@kernel.org> wrote:
> >On Tue, 17 Dec 2024 at 10:21, David Woodhouse <dwmw2@infradead.org> wrot=
e:
> >>
> >> On 17 December 2024 09:49:04 CET, Ard Biesheuvel <ardb@kernel.org> wro=
te:
> >> >On Tue, 17 Dec 2024 at 00:37, David Woodhouse <dwmw2@infradead.org> w=
rote:
> >> >>
> >> >> From: David Woodhouse <dwmw@amazon.co.uk>
> >> >>
> >> >> Both i386 and x86_64 now copy the relocate_kernel function into the=
 control
> >> >> page and execute it from there, using an open-coded function pointe=
r.
> >> >>
> >> >> Use a typedef for it instead.
> >> >>
> >> >> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> >> >> ---
> >> >>  arch/x86/include/asm/kexec.h       | 26 +++++++++++++-------------
> >> >>  arch/x86/kernel/machine_kexec_32.c |  7 +------
> >> >>  arch/x86/kernel/machine_kexec_64.c |  6 +-----
> >> >>  3 files changed, 15 insertions(+), 24 deletions(-)
> >> >>
> >> >> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/ke=
xec.h
> >> >> index 48e4f44f794f..8ad187462b68 100644
> >> >> --- a/arch/x86/include/asm/kexec.h
> >> >> +++ b/arch/x86/include/asm/kexec.h
> >> >> @@ -111,21 +111,21 @@ static inline void crash_setup_regs(struct pt=
_regs *newregs,
> >> >>  }
> >> >>
> >> >>  #ifdef CONFIG_X86_32
> >> >> -asmlinkage unsigned long
> >> >> -relocate_kernel(unsigned long indirection_page,
> >> >> -               unsigned long control_page,
> >> >> -               unsigned long start_address,
> >> >> -               unsigned int has_pae,
> >> >> -               unsigned int preserve_context);
> >> >> +typedef asmlinkage unsigned long
> >> >> +relocate_kernel_fn(unsigned long indirection_page,
> >> >> +                  unsigned long control_page,
> >> >> +                  unsigned long start_address,
> >> >> +                  unsigned int has_pae,
> >> >> +                  unsigned int preserve_context);
> >> >
> >> >linkage is not part of the type. 'asmlinkage' is #define'd to the
> >> >empty string today, so it doesn't matter, but better to omit it here.
> >>
> >> This is the i386 version. I thought ut was something like regparm(3) t=
here?
> >>
> >> And... WTF? How is the calling convention not part of the fundamental =
type of the function? If I have a pointer to such a function, using this ty=
pedef to ensure we all share the same prototype, are you telling me all the=
 users of the typedef have to remember to tag that part on for themselves?
> >
> >No. I am talking about linkage not the calling convention.
>
> Hm, I am perfectly happy to believe that my memory is failing me, especia=
lly when it comes to specifics of i386 assembler code. But are you also tel=
ling me that
> <https://kernelnewbies.org/FAQ/asmlinkage> is a lie?
>

It seems wildly out of date, at least.

Commit 96a388de5dc53a8b2 from 2007 removed the asmlinkage definition
containing regparm(0) from include/asm-i386/linkage.h, and I'm not
convinced it was ever sound to conflate linkage with calling
convention like that. Today, asmlinkage evaluates to 'extern "C"' when
using a C++ compiler, which is also not part of the type.

However, I failed to notice that this just moves code around, and only
applies to 32-bit in the first place. So I won't waste any more of
your time obsessing over this.

