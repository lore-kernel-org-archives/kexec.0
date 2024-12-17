Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDD3E7717F
	for <kexec@archiver.kernel.org>; Tue, 17 Dec 2024 09:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QaqqeJP5FaImhgwZPmYupDJTCLi8v6aI506Mg/jnrXE=; b=ekoPlKTZT8cZZwSDdNDRCrCa/I
	LzHdfsPrSKvG0d9yD5unuRxaSibw/n1BlojBLkft7U26sCdEh6jZc+gCkrdg9qlDtQHR4hug9nbvM
	ApmYCvm0ZjTcd0U8DL6k3sjP4DwLJPdxxq6KsXVdXnzNIBpouYSXhLnZ02tLHs61Of71XeQWsRNIs
	QdUcEyiewPo9rOWZKGsbhtxbZQMCHtUo8uqB/ssZWUkxIwXF1UsaxP5xJPifuIrRTIBdpJfmAcbCv
	lGm1qcEJdIpqRGfLm4A/zVjl9MDFHsLXci5XslcP97O15a5ejgrZGL18GIzAVkyniYeToJTL29vOn
	hmK6r7QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTRa-0000000CoUH-10q7;
	Tue, 17 Dec 2024 09:00:42 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTGZ-0000000ClgT-0bwm
	for kexec@lists.infradead.org;
	Tue, 17 Dec 2024 08:49:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7EB23A41E7C
	for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 08:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A3AC4CEE3
	for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 08:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734425357;
	bh=EErrP47AKhS8f7AjLXgBxHV+WLf76MKb91A85DuCJKc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fRbvok7ySXjY/TJUtvxiwAW5Du3n4qSs8LjFfMzbcaK+91jsrT8vl+Au8vM36KrK5
	 KAatRxwRWkN9qQKo03zyrunjAncvP2K7dx8bGgInLEXX/Ptp69nrEnUK5L7TJH7QYU
	 HcQIFdgQnSHg2wxSv5jYJ/cFEYHg6Ae++6hWlGo3WeKWakSOkVgzlwkkOTv9aJT4pR
	 PM/T1XqO1jbetJXTShwm89ooNXjsn12zX3tAJWXLqxeUmnLn5czEB4sDpwmSi+7/Ae
	 +KR0Y4MdIYktuZpgdTfpoAOP9AYDS9SJXUyea6TcpZFHhz1VV/5iIBJ7d/Wfczgnpa
	 4d35zz5Rbk80A==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3023c51146cso49622661fa.1
        for <kexec@lists.infradead.org>; Tue, 17 Dec 2024 00:49:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQdIZN9LEKDJU55/t2pCFknThBhGfpejIhUMTWl5WHQJqOJtJA6KwNt3SXhq9aQ9MJK+Qxqw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxQ4Jjs6Sk8dQbM0oSJYutBExE5a8/usx+benEFKUcBHGgATCyL
	yvz+FmC+fnJjeleeFAinjuG4jpOOei1H1B2rxxLeIjXm34XlXU/4z7hNLGWmfnzNhyQr6IUx0Vx
	heg6wpIWJT/LGAJ9PuXQOVI3a2pg=
X-Google-Smtp-Source: AGHT+IFnAnJtxYtjTtahPb7C+dKFRSW0ndAI5UXpgRjmr+JoD9B+dlO+0+pXgTe1pqCX7ONfgosejeansQpwgUUl6PU=
X-Received: by 2002:a05:651c:508:b0:2ff:df01:2b4c with SMTP id
 38308e7fff4ca-304442d51ecmr8228111fa.4.1734425355877; Tue, 17 Dec 2024
 00:49:15 -0800 (PST)
MIME-Version: 1.0
References: <20241216233704.3208607-1-dwmw2@infradead.org> <20241216233704.3208607-10-dwmw2@infradead.org>
In-Reply-To: <20241216233704.3208607-10-dwmw2@infradead.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 17 Dec 2024 09:49:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE2abZ8v83vSr5sDZ1QNF-WMr4XCMRhZoc9EW=JAwvdCA@mail.gmail.com>
Message-ID: <CAMj1kXE2abZ8v83vSr5sDZ1QNF-WMr4XCMRhZoc9EW=JAwvdCA@mail.gmail.com>
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
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_004919_324697_1D8899AC 
X-CRM114-Status: GOOD (  21.08  )
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
> Both i386 and x86_64 now copy the relocate_kernel function into the control
> page and execute it from there, using an open-coded function pointer.
>
> Use a typedef for it instead.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  arch/x86/include/asm/kexec.h       | 26 +++++++++++++-------------
>  arch/x86/kernel/machine_kexec_32.c |  7 +------
>  arch/x86/kernel/machine_kexec_64.c |  6 +-----
>  3 files changed, 15 insertions(+), 24 deletions(-)
>
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 48e4f44f794f..8ad187462b68 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -111,21 +111,21 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
>  }
>
>  #ifdef CONFIG_X86_32
> -asmlinkage unsigned long
> -relocate_kernel(unsigned long indirection_page,
> -               unsigned long control_page,
> -               unsigned long start_address,
> -               unsigned int has_pae,
> -               unsigned int preserve_context);
> +typedef asmlinkage unsigned long
> +relocate_kernel_fn(unsigned long indirection_page,
> +                  unsigned long control_page,
> +                  unsigned long start_address,
> +                  unsigned int has_pae,
> +                  unsigned int preserve_context);

linkage is not part of the type. 'asmlinkage' is #define'd to the
empty string today, so it doesn't matter, but better to omit it here.

>  #else
> -unsigned long
> -relocate_kernel(unsigned long indirection_page,
> -               unsigned long pa_control_page,
> -               unsigned long start_address,
> -               unsigned int preserve_context,
> -               unsigned int host_mem_enc_active);
> +typedef unsigned long
> +relocate_kernel_fn(unsigned long indirection_page,
> +                  unsigned long pa_control_page,
> +                  unsigned long start_address,
> +                  unsigned int preserve_context,
> +                  unsigned int host_mem_enc_active);
>  #endif
> -
> +extern relocate_kernel_fn relocate_kernel;
>  #define ARCH_HAS_KIMAGE_ARCH
>
>  #ifdef CONFIG_X86_32
> diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
> index 1b373d79cedc..80265162aeff 100644
> --- a/arch/x86/kernel/machine_kexec_32.c
> +++ b/arch/x86/kernel/machine_kexec_32.c
> @@ -160,15 +160,10 @@ void machine_kexec_cleanup(struct kimage *image)
>   */
>  void machine_kexec(struct kimage *image)
>  {
> +       relocate_kernel_fn *relocate_kernel_ptr;
>         unsigned long page_list[PAGES_NR];
>         void *control_page;
>         int save_ftrace_enabled;
> -       asmlinkage unsigned long
> -               (*relocate_kernel_ptr)(unsigned long indirection_page,
> -                                      unsigned long control_page,
> -                                      unsigned long start_address,
> -                                      unsigned int has_pae,
> -                                      unsigned int preserve_context);
>
>  #ifdef CONFIG_KEXEC_JUMP
>         if (image->preserve_context)
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 1440f792a86d..dd75a51463a2 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -344,12 +344,8 @@ void machine_kexec_cleanup(struct kimage *image)
>   */
>  void __nocfi machine_kexec(struct kimage *image)
>  {
> -       unsigned long (*relocate_kernel_ptr)(unsigned long indirection_page,
> -                                            unsigned long pa_control_page,
> -                                            unsigned long start_address,
> -                                            unsigned int preserve_context,
> -                                            unsigned int host_mem_enc_active);
>         unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
> +       relocate_kernel_fn *relocate_kernel_ptr;
>         unsigned int host_mem_enc_active;
>         int save_ftrace_enabled;
>         void *control_page;
> --
> 2.47.0
>

