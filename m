Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0433E7716A
	for <kexec@archiver.kernel.org>; Tue, 17 Dec 2024 09:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=30v7+qhvDS1QFKXr0CTDmpwprJCsqCrICW2jZ2VfSZ0=; b=BU2NUzQWU/TBNSlLWl6gpyBlQJ
	mYis6FJi/WKUVWl1+TAHd/tm+HBTwdkW8VN0O6MhhV46PNfHFwPg5oNJgqUZoK/jem3LmpzI99IMA
	IL48eTLSo9Nc5diB/7sPXe41mLm00INjIfNM+YP8U7I76yPPKeSPmcBj8PETWlGEATu90S3R9Kr+a
	DRRK7clLVyCwGhEc5O66NPJ5C7rLRsH+ovoenPfa+sWE/d7ugtuCLwPXOMmC1fxa7KPP4mXKHVSS/
	1o9OrBsrz2RGWLfIhoOHIsVRlumLaArKq49SVKf7m0DA/mHxfwuG3MXjFFN+jR6KanMCwY0tYYYG4
	WynBJxCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNUG4-0000000D0FL-1xLF;
	Tue, 17 Dec 2024 09:52:52 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTqL-0000000CunS-1QLX
	for kexec@bombadil.infradead.org;
	Tue, 17 Dec 2024 09:26:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:Subject:Message-ID:
	Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=30v7+qhvDS1QFKXr0CTDmpwprJCsqCrICW2jZ2VfSZ0=; b=V1E0Z64WIocob8yVCG+gZKA5d3
	Ly5XNZ3we0Gv7RZOHXe895CsrzvUUx6rETHb4OvA51OmfpgemHsGWqGKxLavX76MZpdc4x7lLQslh
	oIIrzPJ3G2yeK3PztdJt2qj/zCabf7i1I8rFsl/11JwKi8XPEvr+70qScpXGs4QDtUjsBNyk4CAHD
	TM+C4/6nam9v6N1U/+PBZeNxM2BP7F5KIgbMrgbbRT6ijK0ogF4QAklqJuZ0vU/0mNpXN05S92RSx
	NAhzP6da4LLuHn8ELIfWY+LlB979UZWR7ajw2OuDNlt7VWwbUw9M1jcqGX+GLuBXIFh5+uFwdR3CG
	snwVq/Hw==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTqH-000000053DR-3AIg
	for kexec@lists.infradead.org;
	Tue, 17 Dec 2024 09:26:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E63415C6518
	for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 09:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAD1C4CEED
	for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 09:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734427569;
	bh=hKswbEz7JLeoG28GBCgAedfWMWOBDtGpXbc8u/HHjmI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pynkI9iynxvlvConQ/LuLtEUolJVp+hs+KxeHhg3Km+tXwbEEyTGaT4IlhuPrQu9B
	 X0TF+Fi3DD3IOy5DOIs6tXVY6i6S73DWFccUdg9m2uojo/besO1dGspGAkFDvxt44Q
	 qlQ9mCnvpggFjeP0VqAFe1v785BEyv9Bunc8Ywy0tIe1XSU4rgSyGg+nrcGHGjFW/Q
	 1nr1LPw0OWFKbgNBLtOLWtn9kee80FrEck8E51TOI//fhFfGQDjQ8jplvvoeGTK9y2
	 y5f6mn9QA7RBMxIOrhO39FYHU3+m/Eszf1ijQ6den1z8z24NuOU6RGDKhoBzTWH2TG
	 O8h1obyjnfDXg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30229d5b1caso51198631fa.2
        for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 01:26:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWum8xvoJ1+tkQ31CM/qN0qRM0j4qJpdVR0t/j5EVvWSJRvGXY4Q3OT8nMCpL53HxAYMysKgQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx20Dafm/aJAonHywa3lLmAeNkiM0/XTWOlTvYlGs1kHJ/I1P2M
	J5UlM8H9wtE5BQhdV4H5jPG48yIJZjOF0kjV+UlS2a7OvxikB5QkkXs7/r1g5Dkqu+myueuP2TU
	XVqPVDWVlOCOao+NAE7AzH3w4ptg=
X-Google-Smtp-Source: AGHT+IFOqeeegh7YGEN2Cczxvmja0BUcnOwexSzSaJ6JZOxd8rnph2QoXJWaeSHjouivuwLQJdaBHcf90soMs+eA3bY=
X-Received: by 2002:a05:651c:1508:b0:302:210d:3b5a with SMTP id
 38308e7fff4ca-302545b8eadmr56445501fa.39.1734427567726; Tue, 17 Dec 2024
 01:26:07 -0800 (PST)
MIME-Version: 1.0
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-9-dwmw2@infradead.org>
 <CAMj1kXEvpPbkeUb-2nt28M0yCNzo6NqauCcCNpj2psoVRH+C=A@mail.gmail.com> <6C7C48A4-4BF6-435F-B40D-D667DDB6F8C1@infradead.org>
In-Reply-To: <6C7C48A4-4BF6-435F-B40D-D667DDB6F8C1@infradead.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 17 Dec 2024 10:25:56 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF5C8TF02obuNrd6tZBZg0_Yz_VskGuNMnmoqyjLRAVRg@mail.gmail.com>
Message-ID: <CAMj1kXF5C8TF02obuNrd6tZBZg0_Yz_VskGuNMnmoqyjLRAVRg@mail.gmail.com>
Subject: Re: [PATCH 8/9] x86/kexec: Cope with relocate_kernel() not being at
 the start of the page
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
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_092614_199726_E8547552 
X-CRM114-Status: GOOD (  22.73  )
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

On Tue, 17 Dec 2024 at 10:17, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On 17 December 2024 09:47:36 CET, Ard Biesheuvel <ardb@kernel.org> wrote:
> >On Tue, 17 Dec 2024 at 00:37, David Woodhouse <dwmw2@infradead.org> wrote:
> >>
> >> From: David Woodhouse <dwmw@amazon.co.uk>
> >>
> >> A few places in the kexec control code page make the assumption that the
> >> first instruction of relocate_kernel is at the very start of the page.
> >>
> >> To allow for Clang CFI information to be added to relocate_kernel(), as
> >> well as the general principle of removing unwarranted assumptions, fix
> >> them to use the external __relocate_kernel_start symbol that the linker
> >> adds. This means using a separate addq and subq for calculating offsets,
> >> as the assembler can no longer calculate the delta directly for itself
> >> and relocations aren't that versatile.
> >>
> >
> >You can still avoid the absolute relocations though, ...
> ...
> >> +       addq    $identity_mapped, %rsi
> >> +       subq    $__relocate_kernel_start, %rsi
> >
> >... if you turn this into
> >
> >0:     addq    $identity_mapped - 0b, %rsi
> >       subq    $__relocate_kernel_start - 0b, %rsi
>
> Is there any benefit to doing so? Are absolute relocations problematic?

Every absolute relocation produces an entry in the relocation table
that needs to be applied at every boot when KASLR is in effect. Beyond
that, it doesn't matter.

I've looked into PIC codegen/PIE linking for the core kernel, which is
why this caught my eye. If that effort ever advances, I'll need to
revisit this code as well and apply the change I suggested.

