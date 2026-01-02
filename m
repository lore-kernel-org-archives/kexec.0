Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA5AFA374F
	for <kexec@archiver.kernel.org>; Fri,  2 Jan 2026 15:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=78CrL/Yw4CkwTi9IrweGEIjAaqdTs60nsqudaIitNH8=; b=jIqGdm15uf2UwPP1k4So+EOtHL
	iyXhKbkud37c0I8XTh67uZwi+tvbSzTak4orbLvXDBLUymsLxjfszXDnGSuoYQXQoTejcAjay47kK
	3F9uc358FlXmRK/gI322d1/5V+TZK25RTokuWD45k4qiQcFe0hMVY+qSdzHPnHjFFIylCm41AOCiS
	WoTJHV4Kar8bZ/mcCpAZ/7UYvtzmawARVVrggfcEdeYsLF5wzNh8tuDutfDaTzmIUur497UFoCIAG
	mAdidnNGSgn84PaJA622NPNBfgV34n7KvER9Eq+epDfloDAi8B9+XHILMXndQiZqPR5IeIZJqUWmr
	kXa4aCag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbgfw-00000008P1j-2CDl;
	Fri, 02 Jan 2026 15:02:48 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbgfu-00000008P07-2HnG
	for kexec@lists.infradead.org;
	Fri, 02 Jan 2026 15:02:47 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-430f57cd471so5738865f8f.0
        for <kexec@lists.infradead.org>; Fri, 02 Jan 2026 07:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767366164; x=1767970964; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78CrL/Yw4CkwTi9IrweGEIjAaqdTs60nsqudaIitNH8=;
        b=Epz1f04lFtuOtyB33jJvQmUHUVUTNWBrztemEHtLRhYWA6nnfan4YckJl0uiT4W8vx
         vwPjSINOWGMCSRZR3wxUdcxQH7Di0yESoCFErpUie2cq4EJkQ3yvNnfNk+2vtjlhwJ9w
         kIRdRYqUujrZFP8QY6l1ui1mGGAW12BuurWOb9iltm/kiqj5ecohV4y+DpjNmsfhCZMn
         mISzmZ4D8U4juNkBZT6jVsh+2OVnvO0nLsncsBmNo6N7En5Ohj1SxyQZNqxfjL/VlUQI
         Q+7198u+2kMmi2pzE5fQ67f1mLrkfvZCSfrBPADIcbKckrdHycvKZqEN9AtIgDJVa0dF
         LNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767366164; x=1767970964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78CrL/Yw4CkwTi9IrweGEIjAaqdTs60nsqudaIitNH8=;
        b=le5j+3nIdSCCNY3WYdoI+8lEY+G4MpgSYDQzl5NJKKvFWreLNZ5wq65r45TgruRCBR
         /En+9xJuCchAPX2SBM3/quFTLg4kL/OI+fd26KRie1i0P2csV+8h3c0t+owC/Bf0HRmm
         cKcMXRFhmAnjj5NTKSDF7XHQOyWRF20WHdkuoJ9pr4kc5A4VQFk/kRkdDjA1iakIIcbA
         H7/H9tIzy+9wk7/PHIa8t5IP9dw90Bu4Hayc7GeIjt2mLYZ4xGxyhzvSUyT4JX5Fg1IX
         qhycai8+heOcc6A0zHKo2BcZsJW+AbWk9lWtQ8z4Ez+ytDAvP4I15vUl43voK2XlvCNn
         kBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+W6MU9IVbEttlV72sJLzUhqHIbaWosIHcFuDohLmc7xEj/qXqOFFJTnSn74xUeV/rWDLiuw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxvS8GsnDLrt7EcBzFa9UN1NA5vNSlRrq9A53THD5eWOgBlE04/
	So+csO1nbA+iKt0D0RDTlbLdxyCVK2+tTbjzPe/qL//5za8Q8VkpIJwf
X-Gm-Gg: AY/fxX6yDf1TY9x3LQahDzikXe9SD90f3ok6xM+DExkY4dItjtWUkiGBWbRrIQei68u
	4TmPnQp4eL9WQMAtk2z0sLEgGD5LVRoTJLxOEROgW7qTAeK3qC+4GmJn57/rwrOZ3HnQ+km3bEP
	/mK4eGs03NaOxWzsnwoAL1lKZUgD+qTYC9reKf3ztJN+5DMz+vghxMHOExf+c/DKu6bMIImUypm
	S7HCPCHcLAIoOjqIjR9mBZK/ATRuCoiV6ZbQiA4ZeoVCSw2NcCVmcKSj81jJ/euz4yflrF+Pnjd
	nUGRDpv5S9HSEo2ookiT9wS7vQzoqBSomGQBPhwdOXD1BZl5NekDGQrUoJV8WrWZuxYV0+UDTpF
	9cCasOedIxy//Cjw1wn2MDFviOAHDZ5BBX5pE849iBF6ADyI66X9I6QqvDkffTD1TJqcC9G179e
	RRzc1Ul3tuIlegUIsi9zLf0iAgNsnvJtqw9H8o1OsgKVB+NIpzwD49z5UAu6dSJmUaBdhyGarnA
	jrMh2I=
X-Google-Smtp-Source: AGHT+IEZFYOymrxwaTRBQeTahdxbTMALR1HgSw7tJQK4/p6xOuUXwSUyCfnvrSyrvze7klp4JV9pqQ==
X-Received: by 2002:a05:6000:1865:b0:42f:bab5:9533 with SMTP id ffacd0b85a97d-4324e4cb9e0mr45530420f8f.17.1767366162677;
        Fri, 02 Jan 2026 07:02:42 -0800 (PST)
Received: from ?IPV6:2001:16a2:c8d2:2b00:183a:1350:d3a4:d89? ([2001:16a2:c8d2:2b00:183a:1350:d3a4:d89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82feasm85809097f8f.24.2026.01.02.07.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 07:02:42 -0800 (PST)
Message-ID: <2b315095-2393-45d5-b0bf-ea9fbecd2607@gmail.com>
Date: Fri, 2 Jan 2026 18:02:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] kexec: history: track previous kernel version
To: Breno Leitao <leitao@debian.org>, Alexander Graf <graf@amazon.com>,
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-mm@kvack.org, rmikey@meta.com, clm@fb.com, riel@surriel.com,
 kernel-team@meta.com
References: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
 <20260102-kho-v2-1-1747b1a3a1d6@debian.org>
Content-Language: en-GB
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20260102-kho-v2-1-1747b1a3a1d6@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_070246_614977_78AC36BD 
X-CRM114-Status: GOOD (  29.31  )
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



On 02/01/2026 17:53, Breno Leitao wrote:
> Add CONFIG_KEXEC_HISTORY to store and display the kernel version from
> the previous kexec boot.
> 
> When enabled, the current kernel's release string is saved to the
> "previous-release" property in the KHO device tree before kexec. On
> the next boot, if this property exists, the previous kernel version
> is retrieved and printed during early boot.
> 
> This helps diagnose bugs that only manifest when kexecing from
> specific kernel versions, making it easier to correlate crashes with
> the kernel that initiated the kexec.
> 
> Disabled by default to avoid overhead for users who don't need this
> information.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  kernel/Kconfig.kexec               | 13 +++++++++++++
>  kernel/liveupdate/kexec_handover.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 15632358bcf7..b770c68a3800 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -94,6 +94,19 @@ config KEXEC_JUMP
>  	  Jump between original kernel and kexeced kernel and invoke
>  	  code in physical address mode via KEXEC
>  
> +config KEXEC_HISTORY
> +	bool "Track kexec kernel history"
> +	depends on KEXEC_HANDOVER
> +	help
> +	  When enabled, the kernel will store its release version in the
> +	  KHO FDT before kexec, and the newly booted kernel will read and
> +	  print this information during early boot.
> +
> +	  This is useful for debugging and auditing to know which kernel
> +	  version performed the kexec that booted the current kernel.
> +
> +	  If unsure, say N.
> +


I think we should make this default if KHO is enabled, i.e. not have a Kconfig
option for this. The cost of storing the char array is negligable.

>  config CRASH_DUMP
>  	bool "kernel crash dumps"
>  	default ARCH_DEFAULT_CRASH_DUMP
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 73da00aeaa99..06d99627bb3c 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -21,6 +21,7 @@
>  #include <linux/page-isolation.h>
>  #include <linux/unaligned.h>
>  #include <linux/vmalloc.h>
> +#include <linux/utsname.h>
>  
>  #include <asm/early_ioremap.h>
>  
> @@ -36,6 +37,7 @@
>  #define KHO_FDT_COMPATIBLE "kho-v1"
>  #define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
>  #define PROP_SUB_FDT "fdt"
> +#define PROP_PREVIOUS_RELEASE "previous-release"
>  
>  #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
>  
> @@ -1253,6 +1255,9 @@ bool kho_finalized(void)
>  struct kho_in {
>  	phys_addr_t fdt_phys;
>  	phys_addr_t scratch_phys;
> +#ifdef CONFIG_KEXEC_HISTORY
> +	char previous_release[__NEW_UTS_LEN + 1];
> +#endif
>  	struct kho_debugfs dbg;
>  };
>  
> @@ -1332,6 +1337,10 @@ static __init int kho_out_fdt_setup(void)
>  	err |= fdt_property_string(root, "compatible", KHO_FDT_COMPATIBLE);
>  	err |= fdt_property(root, PROP_PRESERVED_MEMORY_MAP, &empty_mem_map,
>  			    sizeof(empty_mem_map));
> +#ifdef CONFIG_KEXEC_HISTORY
> +	err |= fdt_property_string(root, PROP_PREVIOUS_RELEASE,
> +				   init_uts_ns.name.release);
> +#endif
>  	err |= fdt_end_node(root);
>  	err |= fdt_finish(root);
>  
> @@ -1455,6 +1464,25 @@ void __init kho_memory_init(void)
>  	}
>  }
>  
> +#ifdef CONFIG_KEXEC_HISTORY
> +static void __init kho_print_previous_kernel(const void *fdt)
> +{
> +	const char *prev_release;
> +	int len;
> +
> +	prev_release = fdt_getprop(fdt, 0, PROP_PREVIOUS_RELEASE, &len);
> +	if (!prev_release || len <= 0)
> +		return;
> +
> +	strscpy(kho_in.previous_release, prev_release,
> +		sizeof(kho_in.previous_release));
> +	pr_info("This kernel was kexec'ed from kernel release: %s\n",
> +		kho_in.previous_release);

Maybe s/release/version everywhere? It might not be a release, but no strong opinion.

> +}
> +#else
> +static void __init kho_print_previous_kernel(const void *fdt) { }
> +#endif
> +
>  void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  			 phys_addr_t scratch_phys, u64 scratch_len)
>  {
> @@ -1527,6 +1555,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  	kho_in.scratch_phys = scratch_phys;
>  	kho_scratch_cnt = scratch_cnt;
>  	pr_info("found kexec handover data.\n");
> +	kho_print_previous_kernel(fdt);
>  
>  out:
>  	if (fdt)
> 


