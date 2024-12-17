Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B69FE7716A
	for <kexec@archiver.kernel.org>; Tue, 17 Dec 2024 09:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vemBA6SLX9RgsTvIBo8EoN6jWnxnttcIB56J02CNQMg=; b=MxLB0JAqFKuA7fppx+tiivVgXp
	F5i7fmwoSE8g/bD2mPUpZ25tQBmEfr90QQVyCPBn7FJRtDl+QWfJ9Dw2ebdKGD/Ou4Gd7LCEGMA7B
	kghNFZpLpB3YMZaTkAfAAU5ZGXkwf78jhMdsFBOhmPUvj+H3eKwGXqYi4LkcHCOSwCfOC6OduUfZ6
	ygxp8GP9gfcUlGEyrbratNgMzVpl31kGhmW8cr/5RSSGbRSv0+1EBDvfpmRRxd2U2IzwIa4J4hk9V
	KyNsEpAHxwfCyNDyuJ/L7pQpEwPD+GoDWTr7GJKHDA2VhpUeLzD13NhcJWhKisgVQCxtPu2J1nOuv
	n9BvDmIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNUIC-0000000D0eb-1pqb;
	Tue, 17 Dec 2024 09:55:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTtW-0000000CvOi-3cGQ
	for kexec@lists.infradead.org;
	Tue, 17 Dec 2024 09:29:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0CEB05C65E2
	for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 09:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF78C4CED3
	for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 09:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734427773;
	bh=/JXGSjeuFwORUWi/GcIJoWS9cDLwv2BhC9G+AZ7MvpQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WjOsiImCc/s5SPnoNqZ73CkMchLWdya0i1gowe1qsVLYDPCqVp8k/f2hrsXcwtiNn
	 cGaoWFDX82SvjxSSV2qkaAorkoxD0l5vteR/Men/NsNqattBEM1FQCJkdpBE8fXp9F
	 ZOTBMLfpRJV06sULhWx7PMzE3XLn22d4HWEwzQKyCvYzI2UimzDyTdOocPo2CT4ZE5
	 xwEai7yrhvbDAEjKs2Qj1XPveUrb9/+ZRO6yqEKD1KMUcDTgQLY3o+qE5ONYi8Ci+H
	 m47E2Xt5p/2O88A+nrilNChmiYernXkGQo6NOGUm2Kw3zOwHPf3Fqwb0/mpS7YJEdh
	 GCZIJxTTSdMCQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3022c6155edso49996661fa.2
        for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 01:29:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPV1+qBQsdhc/TLYWpIcCPRA0Bd/ywhBL5xtTGNcaDyuRaw0JRKnGOKqF/IbKt46dnG0f2/w==@lists.infradead.org
X-Gm-Message-State: AOJu0YwgdDwo+ffTpVz7loYlQlIhkyYOiy+YWsSdfsX0axsf6W/M16Mw
	ECbn0i0W1MGQXc2Z8/R6P+9/uC4D49FMe5luXmEtWUSyqjEp+s5Nh0Q5wmOfdRVd5OiLBSWxPxz
	xgs2BbEEyP+KFrOeKqBlmP1IFRvg=
X-Google-Smtp-Source: AGHT+IGOH5xXs/+jrxW1Uzgqvgm0yh2wLN2TclacuxMVFx8bCIsWqUKBZFrn5vEMXVVRDkoO62PL6n0VVePgSX65jPA=
X-Received: by 2002:a05:6512:158e:b0:53e:3740:4a86 with SMTP id
 2adb3069b0e04-5409055551emr5018316e87.18.1734427772258; Tue, 17 Dec 2024
 01:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-10-dwmw2@infradead.org>
 <CAMj1kXE2abZ8v83vSr5sDZ1QNF-WMr4XCMRhZoc9EW=JAwvdCA@mail.gmail.com> <A18A8675-B1FB-496E-9D8F-FAD412A3FF65@infradead.org>
In-Reply-To: <A18A8675-B1FB-496E-9D8F-FAD412A3FF65@infradead.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 17 Dec 2024 10:29:21 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFiZvT1joU5gOhZTC18aYi4dPOnFbX1nsHgmnXNy6c6Wg@mail.gmail.com>
Message-ID: <CAMj1kXFiZvT1joU5gOhZTC18aYi4dPOnFbX1nsHgmnXNy6c6Wg@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20241217_012935_023973_BF3F112F 
X-CRM114-Status: GOOD (  24.82  )
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

On Tue, 17 Dec 2024 at 10:21, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On 17 December 2024 09:49:04 CET, Ard Biesheuvel <ardb@kernel.org> wrote:
> >On Tue, 17 Dec 2024 at 00:37, David Woodhouse <dwmw2@infradead.org> wrot=
e:
> >>
> >> From: David Woodhouse <dwmw@amazon.co.uk>
> >>
> >> Both i386 and x86_64 now copy the relocate_kernel function into the co=
ntrol
> >> page and execute it from there, using an open-coded function pointer.
> >>
> >> Use a typedef for it instead.
> >>
> >> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> >> ---
> >>  arch/x86/include/asm/kexec.h       | 26 +++++++++++++-------------
> >>  arch/x86/kernel/machine_kexec_32.c |  7 +------
> >>  arch/x86/kernel/machine_kexec_64.c |  6 +-----
> >>  3 files changed, 15 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec=
.h
> >> index 48e4f44f794f..8ad187462b68 100644
> >> --- a/arch/x86/include/asm/kexec.h
> >> +++ b/arch/x86/include/asm/kexec.h
> >> @@ -111,21 +111,21 @@ static inline void crash_setup_regs(struct pt_re=
gs *newregs,
> >>  }
> >>
> >>  #ifdef CONFIG_X86_32
> >> -asmlinkage unsigned long
> >> -relocate_kernel(unsigned long indirection_page,
> >> -               unsigned long control_page,
> >> -               unsigned long start_address,
> >> -               unsigned int has_pae,
> >> -               unsigned int preserve_context);
> >> +typedef asmlinkage unsigned long
> >> +relocate_kernel_fn(unsigned long indirection_page,
> >> +                  unsigned long control_page,
> >> +                  unsigned long start_address,
> >> +                  unsigned int has_pae,
> >> +                  unsigned int preserve_context);
> >
> >linkage is not part of the type. 'asmlinkage' is #define'd to the
> >empty string today, so it doesn't matter, but better to omit it here.
>
> This is the i386 version. I thought ut was something like regparm(3) ther=
e?
>
> And... WTF? How is the calling convention not part of the fundamental typ=
e of the function? If I have a pointer to such a function, using this typed=
ef to ensure we all share the same prototype, are you telling me all the us=
ers of the typedef have to remember to tag that part on for themselves?

No. I am talking about linkage not the calling convention.

Look at how __efiapi is used in the kernel if you would like to
understand the difference.

