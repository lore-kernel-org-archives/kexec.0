Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30E4C61DD3
	for <kexec@archiver.kernel.org>; Tue,  1 Sep 2026 20:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f1/Jwq5+t6tQe5v6CVe+ERoBwhfQo9XFyVXChFbscQ0=; b=v4868nKAhLA5+x8Q3QSLvHMJL6
	88F4s0Du2no/1rQuCAL0imSXXbRpwaW3+z0enENHFY1P7tnEn7pptxCL5kfSFdBSCNNXsj8KdnMDJ
	PvZohy71fkQFmBBpfo4EwCu23/ziMtXnvyzXnnwTLQe0oFYhYTeCssSBpyfNCXTxpB7d+M1YWlhun
	IvDM7pb+In064Z7q8tEVM469UjDp/Z9DlFidr4lwkxa0fmxSWeo5we7x6jwLxvQMfIo/z6GDoZC59
	6LxMjWCw/h/W8hKkhXhNW5jLTXeJG7LBA6l/p9RMuou7HbZZCWsc5gP8o3i7hp7TIn6VdFLfFORh8
	5zvOiJcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1Usl-0000000DJ3R-0NFi;
	Tue, 01 Sep 2026 20:14:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1Usj-0000000DJ3D-0zBc;
	Tue, 01 Sep 2026 20:14:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EF20D43345;
	Tue,  1 Sep 2026 20:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C7A1F00A3A;
	Tue,  1 Sep 2026 20:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788293696;
	bh=f1/Jwq5+t6tQe5v6CVe+ERoBwhfQo9XFyVXChFbscQ0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=bur9NIA5VjZqJ3jA9kvUAsKCinpmhYAyRbr8Hb1A0OQctcuO7N9DscX1sNVWHL1V7
	 T80F+vdakutewH2IMUKIulhBeYbTt74ZvhHoMosmzBE80N+qc3JJtFqfa+UOgi4b5H
	 nhJt07pq+F5fJOJSXkLDfT4qSN/I+piV60qOEI6PAZyKdu1ycpYXmW4JdbL3YGBRSO
	 QhxKekth0A8llYBOSGx9oqJNnoi3gtqRLBPJlVRvjImiywEubcsr5hoj1xB8ayZBwy
	 q8rGlbxN+AW6qnyVN4sOrSL4v4mH+oG0IpyaHj57TG+k/Vbf4tA5+oKuV69TJt709Q
	 ed/bhiUFFcOQA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 15/17] crash: Simplify CRASH_MAX_MEMORY_RANGES
 handling
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, 
 kees@kernel.org, thuth@redhat.com, gshan@redhat.com, jic23@kernel.org, 
 james.morse@arm.com, ardb@kernel.org, leitao@debian.org, 
 yeoreum.yun@arm.com, sourabhjain@linux.ibm.com, coxu@redhat.com, 
 tangyouling@kylinos.cn, hbathini@linux.ibm.com, adityag@linux.ibm.com, 
 ionut.nechita@windriver.com, liaoyuanhong@vivo.com, seanjc@google.com, 
 fuqiang.wang@easystack.cn, makb@juniper.net, piliu@redhat.com, 
 ebiggers@kernel.org, jbouron@amazon.com, mclapinski@google.com, 
 me@linux.beauty, graf@amazon.com, bgwin@google.com, robh@kernel.org, 
 takahiro.akashi@linaro.org, palmer@rivosinc.com, x86@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org
In-Reply-To: <20260826092541.3905933-16-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-16-ruanjinjie@huawei.com>
Date: Tue, 01 Sep 2026 23:14:00 +0300
Message-Id: <178829364021.3691424.12328056849597833403.b4-review@b4>
X-Mailer: b4 0.17-dev
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

Hi,

> Set CRASH_MAX_MEMORY_RANGES to 0 when MEMORY_HOTPLUG is disabled, then
> remove the now unnecessary IS_ENABLED(CONFIG_MEMORY_HOTPLUG) checks in
> powerpc and x86 arch_crash_get_elfcorehdr_size().
> 
> No functional change intended.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index fc0105c7af4c3..c47e3f867ea1f 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -474,9 +474,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>  	unsigned long phdr_cnt;
>  
>  	/* A program header for possible CPUs + vmcoreinfo */
> -	phdr_cnt = num_possible_cpus() + 1;
> -	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> -		phdr_cnt += CONFIG_CRASH_MAX_MEMORY_RANGES;
> +	phdr_cnt = num_possible_cpus() + 1 + CONFIG_CRASH_MAX_MEMORY_RANGES;
>  
>  	return elf64_phdr_size(phdr_cnt);
>  }
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 99eb8583d9321..116410ac90fb4 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -407,9 +407,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
>  	unsigned int sz;
>  
>  	/* kernel_map, VMCOREINFO and maximum CPUs */
> -	sz = 2 + num_possible_cpus();
> -	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> -		sz += CONFIG_CRASH_MAX_MEMORY_RANGES;
> +	sz = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
>  	sz *= sizeof(Elf64_Phdr);
>  	return sz;
>  }
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index a97ed9605602f..e6251dfe451a8 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -160,7 +160,8 @@ config CRASH_HOTPLUG
>  
>  config CRASH_MAX_MEMORY_RANGES
>  	int "Specify the maximum number of memory regions for the elfcorehdr"
> -	default 8192
> +	default 8192 if MEMORY_HOTPLUG
> +	default 0 if !MEMORY_HOTPLUG

This only sets the default, but a user can change the value explicitly.

-- 
Sincerely yours,
Mike.


