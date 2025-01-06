Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D423E77188
	for <kexec@archiver.kernel.org>; Mon,  6 Jan 2025 16:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bt0whyUkl7VLEabtXclh1D6ZFNGfSTDPc1jOnWd6UNw=; b=ZNcIDKD4fq1cTG6lObEiUHtx6B
	9pLrwpyW/p4T4qb+83RL9ryF/Ds+mnr4G78Ul1ODncEP7MSWM3LF1GfMZHwJZV6lQusLVQRpszElR
	eJUzSY4vKBfjIIKGafSFU7qUD1Pego5kO6vQPnpnC0WjDkhkHzU0Go5Pe907v/REW6WKua3ZtF3ey
	PMSLc9SJbS3RjygzvwTih+JP0Tj24Zmtzn84Wq76a0pf80QjXhHJUmRX9r96P4GM2Fl0FoXU1boAE
	H67EUctZHCGjtsbyd6mIjj0uTjyHu4HJbCt+m/Zq8KrbcMYLxQSkMR7Zbgee2aRfFqgIR8GYfF9AN
	8Tg8h7Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUpx7-00000001xOT-3pll;
	Mon, 06 Jan 2025 16:27:41 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUpx6-00000001xNZ-1ZZP
	for kexec@lists.infradead.org;
	Mon, 06 Jan 2025 16:27:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B6D36A41AEB
	for <kexec@lists.infradead.org>; Mon,  6 Jan 2025 16:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4739AC4CED6
	for <kexec@lists.infradead.org>; Mon,  6 Jan 2025 16:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736180859;
	bh=65mnyZxXsXhDajQETPyf5L6mah967pUOlsc+i8R9Tz4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UEm5lB4nWEGg2hbOmc/GFSAS4hOcGhCJF44zhserd9Q/HuBO4LCpG5C0wZbToib9l
	 Urs2xgEufpKl8CH+e5oTfEFEjyvRU9y5/0P5Z42oGl/aJgxIiGEdHwo+LaPbrlsb9g
	 5RXve3T+4w8BXd/EbME1orJ64yWKKUVapezpE4GL/FtO+w0sP9bg4bWIT8+4Tz+ZCX
	 Km0Unfvkn0K+++xmZFk9VVgpjy6P8KchOOYAXqERvJjwIb1PudBqraLZF2EUykLo1f
	 gGpbRCXDYekcj481Csopo33HN2+fthivAzrJdQisz8/xZEwLEPuN7e0aExvNrxX2xm
	 75BuFO7JiOUfA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30219437e63so163123041fa.1
        for <kexec@lists.infradead.org>; Mon, 06 Jan 2025 08:27:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDfw3Ij0/NFHOEihyBwQmkFrDmoQxtO0p5OODyGlCzcLlgX3eEHEb60Mhwj/xx0xYTOAYGPw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxl8pXlrgRXldzxz3Og0h0YruCwRYo6Mbq7FX/1/urYVC5UYMb5
	v2B5WGrHXIuBIQKosiTXmBC1Tpd+5LZ5+iEYbns3gGXWsfj8QvOpyBOmgLSgGnR3/ynRKQInOGF
	aDiUZjtCPl9owG2reL2akce6yiwM=
X-Google-Smtp-Source: AGHT+IGMfGiJYsWjACJBCIXOo0uHL7/EcueBgsMBBsAjYMndKnkei08e8K12+PPh2HbfsWpfhce+h65G7hwIJaUDLXE=
X-Received: by 2002:a05:6512:3d06:b0:542:223c:30f5 with SMTP id
 2adb3069b0e04-54229474cf7mr15338316e87.24.1736180857614; Mon, 06 Jan 2025
 08:27:37 -0800 (PST)
MIME-Version: 1.0
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-9-dwmw2@infradead.org>
 <CAMj1kXEvpPbkeUb-2nt28M0yCNzo6NqauCcCNpj2psoVRH+C=A@mail.gmail.com>
 <6C7C48A4-4BF6-435F-B40D-D667DDB6F8C1@infradead.org> <CAMj1kXF5C8TF02obuNrd6tZBZg0_Yz_VskGuNMnmoqyjLRAVRg@mail.gmail.com>
 <de9b93a9f6088322ad5bed79b069a49203517dd7.camel@infradead.org>
 <CAMj1kXEXPTdm=oA7+WPPBcCX69x_N_Y8woaaNwDFh0QAZNjf5g@mail.gmail.com> <9e876a7c73574bc29a769998d87acd7c5a0f72cc.camel@infradead.org>
In-Reply-To: <9e876a7c73574bc29a769998d87acd7c5a0f72cc.camel@infradead.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 6 Jan 2025 17:27:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG=AdGHZctOtJ2A06hF056MepEwnPT4DKDMN3d4S5+-ww@mail.gmail.com>
Message-ID: <CAMj1kXG=AdGHZctOtJ2A06hF056MepEwnPT4DKDMN3d4S5+-ww@mail.gmail.com>
Subject: Re: [PATCH 8/9] x86/kexec: Cope with relocate_kernel() not being at
 the start of the page
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Eric Biederman <ebiederm@xmission.com>, 
	Sourabh Jain <sourabhjain@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Yuntao Wang <ytcoode@gmail.com>, David Kaplan <david.kaplan@amd.com>, Tao Liu <ltao@redhat.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Rong Xu <xur@google.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Simon Horman <horms@kernel.org>, Dave Young <dyoung@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, bsz@amazon.de, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_082740_549061_1E228373 
X-CRM114-Status: GOOD (  19.95  )
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

On Mon, 6 Jan 2025 at 17:13, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Mon, 2025-01-06 at 17:09 +0100, Ard Biesheuvel wrote:
> >
> > I suppose you're referring to
> >
> > #ifdef CONFIG_KEXEC_JUMP
> >         /* Saved in save_processor_state. */
> >         movq    $saved_context, %rax
> >         lgdt    saved_context_gdt_desc(%rax)
> > #endif
> >
> > Any reason not to simply use
> >
> >         lgdt    saved_context+saved_context_gdt_desc(%rip)
> >
> > here?
>
> Because the %rip isn't what you (and the linker) think it is.
>
> This code is copied into a control page which is allocated as part of
> the kexec kimage. It can only access things within that same page via
> %rip. (Which is not as much of a restriction as it sounds, as for most
> of its execution the rest of the kernel isn't even present in the page
> tables).

Ah I was looking at an older version of that file - I now see that the
preceding (%rip) references have been replaced as well.

In any case, thanks for the head's up - I'll get back to this at some
point and cc you if making any further changes here.

