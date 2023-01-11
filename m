Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36674C46467
	for <kexec@archiver.kernel.org>; Wed, 11 Jan 2023 12:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3GU19hhDp4jQLZJjcTeSNCHwsb02ILdtAGoV0Ps/E3U=; b=joJYtaI4OyeUJ4
	fyQIYAombulak3ooIokm0RHZy1fiamxVzshgPB3RrJLiwr2ZRsctpKWzQhaSo+dy1gDI+5Dt/LSex
	+QyN8RLWkQiKzw4oq22Qkqj59X4XNTDmFdqR/Uffqjpo2YcmmXqnWNbtcfd8j/n3axu4x6P1124LQ
	6gr3UWqwr1OkcWngl8pEQE2TK9mTP7sine/5aHQQU7YKG4uUjWvrUdkZLKoEkwKPibWRNYyxZcJzE
	oVa6hldoi8fiNdVy4jmcyIemrwYjMuCoruZFqoJnuhhLLIEyJe9ho9UG+FrzhvLMl6h6P6fB9wXkW
	rVOQT3pigfR+vP/BondQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFaZf-00BMWF-Pe; Wed, 11 Jan 2023 12:51:23 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFaZV-00BMTW-CH
	for kexec@lists.infradead.org; Wed, 11 Jan 2023 12:51:19 +0000
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB20E1EC068D;
	Wed, 11 Jan 2023 13:51:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1673441467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=vO5zTy5BAn2/tS5FaOPoFVGJ+RHNwETq6LModQlJjBY=;
	b=geq1j2jz4IduM2C983TeYVLyHxWFG5sAfGc2JKecLsTpFYI0fyqx+reKyDhEMmrZN2FqTD
	0kxtTPpqCpHyVuxnfoaflp5KUwkNjggd9pmLX7HTlcd2BhRF72HN2cXl7E4CT20x3sQ1Pl
	539x9nvRpVvLTVxq1JSPLDrdA99VtDk=
Date: Wed, 11 Jan 2023 13:51:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	hpa@zytor.com, jpoimboe@kernel.org, peterz@infradead.org,
	x86@kernel.org, cascardo@canonical.com, leit@meta.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <Y76wtwWN1+XPbnQx@zn.tnic>
References: <20221128153148.1129350-1-leitao@debian.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221128153148.1129350-1-leitao@debian.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230111_045114_714481_552BE05E 
X-CRM114-Status: GOOD (  28.04  )
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

On Mon, Nov 28, 2022 at 07:31:48AM -0800, Breno Leitao wrote:
> Currently x86_spec_ctrl_base is read at boot time, and speculative bits
> are set if configs are enable, such as MSR[SPEC_CTRL_IBRS] is enabled if
> CONFIG_CPU_IBRS_ENTRY is configured. These MSR bits are not cleared if
> the mitigations are disabled.
> 
> This is a problem when kexec-ing a kernel that has the mitigation
> disabled, from a kernel that has the mitigation enabled. In this case,
> the MSR bits are carried forward and not cleared at the boot of the new
> kernel. This might have some performance degradation that is hard to
> find.
> 
> This problem does not happen if the machine is (hard) rebooted, because
> the bit will be cleared by default.
> 
> Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/x86/include/asm/msr-index.h |  4 ++++
>  arch/x86/kernel/cpu/bugs.c       | 10 +++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 4a2af82553e4..22986a8f18bc 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -54,6 +54,10 @@
>  #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
>  #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
>  
> +/* A mask for bits which the kernel toggles when controlling mitigations */
> +#define SPEC_CTRL_MITIGATIONS_MASK	(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD \
> +							| SPEC_CTRL_RRSBA_DIS_S)

SPEC_CTRL_RRSBA_DIS_S is a disable bit and I presume it needs to stay enabled.
Only when spec_ctrl_disable_kernel_rrsba() runs. And I'd say perf-wise it
doesn't cost that much...

Pawan?

> +
>  #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
>  #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
>  
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 3e3230cccaa7..4030358216c8 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -137,8 +137,16 @@ void __init check_bugs(void)
>  	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
>  	 * init code as it is not enumerated and depends on the family.
>  	 */
> -	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
> +	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
>  		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> +		/*
> +		 * Previously running software, like kexec for example, may
> +		 * have some controls turned ON.
> +		 * Clear them and let the mitigations setup below set them
> +		 * based on configuration.
> +		 */

                /*
                 * Previously running kernel (kexec), may have some controls
                 * turned ON. Clear them and let the mitigations setup below
                 * rediscover them based on configuration.
                 */

There's no "previously running software, like kexec".

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
