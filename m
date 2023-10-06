Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29853E81E04
	for <kexec@archiver.kernel.org>; Fri,  6 Oct 2023 14:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Pk0HEYAu70LEQ2fs+Q7olj3oNr/q+7hWXYOBlCFWBf4=; b=U0oMtYpTqUfd03NppphAIPVxrL
	+RrYUIsVMsZ9qyNt9AidhDv6cbp84OlH0Ljca6q4lUrbUlYxotbB3d5z3SOmksfYVrsibMaJABFoq
	0P1FAtzoG/c0mI6JlZezClkMLs8dLMfVxKj40sie0VLLI6h8O36gKLnHGN+rz+kau3JMq5ftFJZTF
	3ydoGxjZEPma3YT5FF+kJ5G26xhYUMPz0NeIhSbmXUSi9SLIwoPPAxGMVQNY4ri4kbAYIFSjGQCx1
	4afWIWRgNooA+BDYMA1PZPNHECA5y0c1HRK8n/aw4TPvSQcDjlN3+Cl8Z/g/l0AS+laig+3ovHx0b
	Rb0soIFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qomHL-0061vI-2A;
	Fri, 06 Oct 2023 14:58:11 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qomHI-0061tC-2Q
	for kexec@lists.infradead.org;
	Fri, 06 Oct 2023 14:58:10 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2774c52c8f2so1907996a91.3
        for <kexec@lists.infradead.org>; Fri, 06 Oct 2023 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696604285; x=1697209085; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L8SLlOsSBiXlVOZqd3MNbcaSevZs0Zf6iCkneXB+UYM=;
        b=srngF/N4Cemmr9HePzChbl8vr23a98f96xU9nVacMNDbaq52CLN8wx1KK47HkbwWOO
         wk04/AdTwhg+SjAeYsDTsZlP0v4EU9MJpUs7BxJH7NuNqvINFE9N31OEngllJbUGL3dm
         XTGmNCD+bWiGWy9wK3OgMtXsKnnynMZh6n+vmT1JYPjZ9wV387jRixLxkMQ5JgnwJrbl
         KJ4vgbC6KJ80w65wFquZKWqIQHoHaX6d59QV8PhgrSlPgPvrXYxZSJw+AngUGuXETN3V
         RUz3HYGwD1MPjFCVFiYH+uv2+gsTrp640vU/eocq5EXq5e7LeE/DqaMcIyJeQz4vhVk5
         OZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696604285; x=1697209085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8SLlOsSBiXlVOZqd3MNbcaSevZs0Zf6iCkneXB+UYM=;
        b=Rfx5e3tGTPrE3s21JhUmug5iTcyjpytmbTMtF0Nvq7Psk17tGejz/DlTuNjZ6GCvXz
         nAAQC8eV32f06zZRqRW2Wk8u364RZ3UZgmLfovYBAts+MH6CpsUo4XA8MqEoEnSZEB89
         9dPacvy78YDCHuGTFXmLyXXcaZOT4brDCntTjANV6djzGfxnSKNEToqmWNHyJHPVvK8q
         q8R5YouQOHXrnYaQtBMTouDT/7jmpj53EmweFbgItiRyDBZVJZ+YUshOwfs1XY6CLZ23
         5cb0IACeFU+d0s71sdMc3ncX12nVzexnS8IprlLlUGYRTBN7FMSSsf6peRDfvRstMPFx
         JPJA==
X-Gm-Message-State: AOJu0YwXYchoSyCaUrrHPXLUnyMlnVTS7Mriz0fahfXkw0Wi5uvYCxCk
	ZynVFxQqVi7cqDCsVQTZgbMFRFr4bsY=
X-Google-Smtp-Source: AGHT+IGL88XAlpSBeihjb4Zfc5p6KDRf131bGYiWj2fWKD8BEJyproZ8L08qkjar6AMU++MXIPvMqBYldjM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e548:b0:277:5c9b:14dd with SMTP id
 ei8-20020a17090ae54800b002775c9b14ddmr137737pjb.2.1696604285539; Fri, 06 Oct
 2023 07:58:05 -0700 (PDT)
Date: Fri, 6 Oct 2023 07:58:03 -0700
In-Reply-To: <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com> <20231005131402.14611-11-kirill.shutemov@linux.intel.com>
Message-ID: <ZSAge6W4vF6ePudw@google.com>
Subject: Re: [PATCH 10/13] x86/tdx: Convert shared memory back to private on kexec
From: Sean Christopherson <seanjc@google.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima <jun.nakajima@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231006_075808_787043_BC03F62C 
X-CRM114-Status: GOOD (  17.05  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Oct 05, 2023, Kirill A. Shutemov wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7368d254d01f..b5acf9fb4c70 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
>  	select X86_MEM_ENCRYPT
>  	select X86_MCE
>  	select UNACCEPTED_MEMORY
> +	select EMERGENCY_VIRT_CALLBACK
>  	help
>  	  Support running as a guest under Intel TDX.  Without this support,
>  	  the guest kernel can not boot or run under TDX.

...

>  void __init tdx_early_init(void)
>  {
>  	struct tdx_module_args args = {
> @@ -882,6 +1007,14 @@ void __init tdx_early_init(void)
>  	 */
>  	x86_cpuinit.parallel_bringup = false;
>  
> +	machine_ops.shutdown = tdx_shutdown;
> +
> +	/*
> +	 * KVM overrides machine_ops.crash_shutdown, use emergency

This is going to be super confusing.  KVM utilizes the emergency virt callback.
The KVM paravirt guest code uses .crash_shutdown().  People that are passingly
familiar with virt and know what KVM is, but don't already know the difference
between the two are going to be all kinds of confused.

I also feel like you're playing with fire, e.g. what's to stop the hypervisor
specific paravirt guest support from using .shutdown() in the future?

And the callback is invoked for far more than just kexec().  I don't see how the
host can emulate a reboot without destroying and rebuilding the VM, e.g. it can't
stuff register state to emulate INIT or RESET.  Unless I'm missing something,
converting shared memory back to private for a shutdown or reboot is undesirable
as adds one more thing that can go wrong and prevent the system from cleanly
shutting down ASAP (for some definitions of "cleanly").

Lastly, doesn't SEV need similar behavior?  This seems like core functionality
for any guest with cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT).  Why not make the
"unshare on kexec" code common and gate it with CC_ATTR_GUEST_MEM_ENCRYPT?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
