Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0E4E7716A
	for <kexec@archiver.kernel.org>; Tue, 17 Dec 2024 08:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W/3onW9J6qyk6juEhYkTK/PHag200Hum/OSkyepKois=; b=D9Gdnz3BmHQXf5tN92WzLmqpql
	/esOUasxNUd9PODcnu008VgNeaADPFIsnL/dWCbsic1E8kx2Usg/X7MIRnpUFM+Eh9+aSiqvlD2Lp
	0bQGLAPnfwYVGT8jQhkS9QmpAgwCSNYCAe6dAAivIgwZcIqiAPSYErP0+CYKFUon2NEloTEvboXqT
	rC8QWvgOqdnDpVGRUYZZiBGP+BWFei7x/ttCEkY1kF8QbOQx5EKAGNbxjEK5sb/GuMuMRT2WrPVoK
	u24hnty83dUANCugbCZEW3DQRXuhl84AGZZCivwUoEzB+UP3wbcLk6M11+xROuKYa9d4tSZbfA5ok
	71pVNSiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTLD-0000000Cmt4-2kkE;
	Tue, 17 Dec 2024 08:54:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTF9-0000000ClHR-0EUE
	for kexec@lists.infradead.org;
	Tue, 17 Dec 2024 08:47:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 287815C64E4
	for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 08:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6808C4CEE1
	for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 08:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734425269;
	bh=Sdc+++6gPgnnOYqx/g7c38oTFPeiaCCYx369j2QdBFU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nWmPBSFwGJ9pKaFe8pVG9haHH2dzSxoWpnvgFIXUxF50wQIY8heB3Zoyc2eDbNIdx
	 wCpWtxcvIdA3PQvf6T2bTlb+hD71qc+lhyDhdrTEUSz9Opnfa/N9zgUIKJtmtztZy4
	 PZW0hAOKqOJKOc3NVXddN60nRO+T7KzziDWLShitUrMOcng/qbXAygeiTMlGFGohHB
	 z++84uaHw2eocH8Erf1QsgqFPy/pgB9NJxbBwNtdBCeVIV1ZCMi7xtUf6nhTnjMh9Q
	 +EFBr00HgFw1dAoskr/vfXA4k7i3Bz5h53GCCUugdLJRKcYO7S5ma1KKb77Q5et8EM
	 FAhIc3BprBhtg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30227ccf803so54147451fa.2
        for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 00:47:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtgc1nkcLjp/HpG1+HHvWN94nskyVnsYjwd0vwEb85qHMdeHq6YjrXgItXG0KC/+3Ov7bpuA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyFrT4ELet4/0OohMriKXMm7CAKVm1rAnvcf8xoC0vD/ktwQvCl
	KRa+N4oo2q9JSI5X8+cDoTCn/1rEUuOjZS4y0yHpDClTomz9lcSS0djbJcWJFK4x8x/Op4K+nWh
	r8ZP6+Bquc+T9pkokQZuydYL0mAI=
X-Google-Smtp-Source: AGHT+IH5eLSLKUNPUxwrLLug55kMDEvGO8iTkt7KKa2ptm7n109+n2f50khrbdJ3Mnh6LumZiUhvLgKXYRn1UmcY7B4=
X-Received: by 2002:a05:651c:1545:b0:300:26bc:4311 with SMTP id
 38308e7fff4ca-3025454ffadmr56056541fa.18.1734425267978; Tue, 17 Dec 2024
 00:47:47 -0800 (PST)
MIME-Version: 1.0
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-9-dwmw2@infradead.org>
In-Reply-To: <20241216233704.3208607-9-dwmw2@infradead.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 17 Dec 2024 09:47:36 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEvpPbkeUb-2nt28M0yCNzo6NqauCcCNpj2psoVRH+C=A@mail.gmail.com>
Message-ID: <CAMj1kXEvpPbkeUb-2nt28M0yCNzo6NqauCcCNpj2psoVRH+C=A@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20241217_004751_176004_FF5D47C0 
X-CRM114-Status: GOOD (  26.58  )
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

On Tue, 17 Dec 2024 at 00:37, David Woodhouse <dwmw2@infradead.org> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> A few places in the kexec control code page make the assumption that the
> first instruction of relocate_kernel is at the very start of the page.
>
> To allow for Clang CFI information to be added to relocate_kernel(), as
> well as the general principle of removing unwarranted assumptions, fix
> them to use the external __relocate_kernel_start symbol that the linker
> adds. This means using a separate addq and subq for calculating offsets,
> as the assembler can no longer calculate the delta directly for itself
> and relocations aren't that versatile.
>

You can still avoid the absolute relocations though, ...

> Turn the jump from relocate_kernel() to identity_mapped() into a real
> indirect 'jmp *%rsi' too, while touching it. There was no real reason
> for it to be a push+ret in the first place, and adding Clang CFI info
> will also give objtool enough visibility to start complaining 'return
> with modified stack frame' about it.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/kernel/relocate_kernel_64.S | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 1996cea909ff..d74798d78263 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -95,11 +95,10 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
>         lea     PAGE_SIZE(%rsi), %rsp
>
>         /* jump to identity mapped page */
> -       addq    $(identity_mapped - relocate_kernel), %rsi
> -       pushq   %rsi
> -       ANNOTATE_UNRET_SAFE
> -       ret
> -       int3
> +       addq    $identity_mapped, %rsi
> +       subq    $__relocate_kernel_start, %rsi

... if you turn this into

0:     addq    $identity_mapped - 0b, %rsi
       subq    $__relocate_kernel_start - 0b, %rsi


> +       ANNOTATE_RETPOLINE_SAFE
> +       jmp     *%rsi
>  SYM_CODE_END(relocate_kernel)
>
>  SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
> @@ -219,16 +218,21 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>
>         /* get the re-entry point of the peer system */
>         popq    %rbp
> -       leaq    relocate_kernel(%rip), %r8
>         movq    kexec_pa_swap_page(%rip), %r10
>         movq    pa_backup_pages_map(%rip), %rdi
>         movq    kexec_pa_table_page(%rip), %rax
>         movq    %rax, %cr3
> +
> +       /* Find start (and end) of this physical mapping of control page */
> +       leaq    (%rip), %r8
> +       ANNOTATE_NOENDBR
> +       andq    $PAGE_MASK, %r8
>         lea     PAGE_SIZE(%r8), %rsp
>         movq    $1, %r11        /* Ensure preserve_context flag is set */
>         call    swap_pages
>         movq    kexec_va_control_page(%rip), %rax
> -       addq    $(virtual_mapped - relocate_kernel), %rax
> +       addq    $virtual_mapped, %rax
> +       subq    $__relocate_kernel_start, %rax
>         pushq   %rax
>         ANNOTATE_UNRET_SAFE
>         ret
> --
> 2.47.0
>

