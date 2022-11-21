Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A83C433FE
	for <kexec@archiver.kernel.org>; Mon, 21 Nov 2022 22:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KkAPF3H0BYjxDnBMfHpHHW29PlyB7osLy6zhuLxlYIg=; b=n8AEkumaV5X+P3MP8P1988WFxR
	47EZMntwgP1ZCi/NsrnpQC061rF7qVmZIcFzUAk4eDhEEXE4x9KT+Xtr9Qenq2auQaQWz0fEUSY6w
	i4EBi0y79G89GyvvTuyu+woX/mN9HkYvqmUG4kyKzHp+I8x675qcaSZhhzVeQDfrwxTEqDo8D51o8
	vpUsBXcv+gsReSnD77wIwgPpG+FP2/iZWfeUFfm5qMnKmOqIifWhjaAbGCKfE10vEVcARhM3Y8ufb
	FU+lslRXFgHU9HwyGZ+zWX53QhWVqrcIXIFLahYCilAPEUwPObDMziX3/iO4z+Ar7mAeUuTGgrsYx
	2DGJ2rIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxF9Z-000nOG-Jl; Mon, 21 Nov 2022 22:20:37 +0000
Received: from mga03.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxF9W-000nMN-Tm
	for kexec@lists.infradead.org; Mon, 21 Nov 2022 22:20:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669069234; x=1700605234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xlW8y8zryooJmHhhVNbAI7pzH6YQli4bZCBZJRowLKg=;
  b=jrFXapKgamRXRT5UqKGCcUW7DX4Ry8I7USaFiSLpbqiPmEhdPOeosYLv
   HdoxwNglv6UC3tpdc9jXDJuqlWH19JcOq8+NOkI4c6mWv2DqseoJ+ZsPD
   actBB0IPqhr39lD3SbxkSmYv9cqHxBWsNbGdUWJ3WbJAdQ2iCKSdEqyV8
   l9J/Q/CWzCj63mhuILzgRS/f5BLulbkaGnazdHZTyWx05Z4Fe7BAZX3GZ
   s+f5xN6Seb+PO/wOZtqOWFQy6OLp2mcKqeKcIKOlWQxiiViJ4UuTtevNZ
   +dB9PvhRS++uIYFHza24ISUAb99SwNtAJhJZi9dk0g9FdZTiNgwrEFlzy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="315495589"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="315495589"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 14:20:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="747086731"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="747086731"
Received: from kmlindbe-mobl.amr.corp.intel.com (HELO desk) ([10.212.209.190])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 14:20:32 -0800
Date: Mon, 21 Nov 2022 14:20:31 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, leit@meta.com, cascardo@canonical.com,
	hpa@zytor.com, jpoimboe@kernel.org, peterz@infradead.org,
	x86@kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <20221121222031.uo2n7fv7ojusxvr4@desk>
References: <20221118194602.vpo4xjm4s7knm7ja@desk>
 <20221120120255.13054-1-leitao@debian.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221120120255.13054-1-leitao@debian.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_142035_065133_0F7A6C72 
X-CRM114-Status: GOOD (  17.38  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sun, Nov 20, 2022 at 12:02:55PM +0000, Breno Leitao wrote:
>Currently x86_spec_ctrl_base is read at boot time, and speculative bits
>are set if configs are enable, such as MSR[SPEC_CTRL_IBRS] is enabled if
>CONFIG_CPU_IBRS_ENTRY is configured. These MSR bits are not cleared if
>the CONFIGs are not set.

Also when the CONFIGs are set but the mitigations are disabled at
runtime e.g. using mitigations=off parameter.

>This is a problem when kexec-ing a kernel that has the mitigation
>disabled, from a kernel that has the mitigation enabled. In this case,
>the MSR bits are carried forward and not cleared at the boot of the new
>kernel. This might have some performance degradation that is hard to
>find.
>
>This problem does not happen if the machine is (hard) rebooted, because
>the bit will be cleared by default.
>
>This patch also defines a SPEC_CTRL_MASK macro, so, we can easily track
>and clear if eventually some new mitigation show up.
>
>Suggested-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
>Signed-off-by: Breno Leitao <leitao@debian.org>
>---
> arch/x86/include/asm/msr-index.h |  3 +++
> arch/x86/kernel/cpu/bugs.c       | 10 +++++++++-
> 2 files changed, 12 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>index 10ac52705892..672de926281e 100644
>--- a/arch/x86/include/asm/msr-index.h
>+++ b/arch/x86/include/asm/msr-index.h
>@@ -54,6 +54,9 @@
> #define SPEC_CTRL_RRSBA_DIS_S_SHIFT	6	   /* Disable RRSBA behavior */
> #define SPEC_CTRL_RRSBA_DIS_S		BIT(SPEC_CTRL_RRSBA_DIS_S_SHIFT)
>
>+#define SPEC_CTRL_MASK			(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD \
>+							| SPEC_CTRL_RRSBA_DIS_S)
>+
> #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
> #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
>
>diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>index 3e3230cccaa7..970b277d02a6 100644
>--- a/arch/x86/kernel/cpu/bugs.c
>+++ b/arch/x86/kernel/cpu/bugs.c
>@@ -137,8 +137,16 @@ void __init check_bugs(void)
> 	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
> 	 * init code as it is not enumerated and depends on the family.
> 	 */
>-	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
>+	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
> 		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>+		/*
>+		 * Previously running software may have some controls turned ON.
>+		 * Clear them and let kernel decide which controls to use.
>+		 */
>+		x86_spec_ctrl_base &= ~SPEC_CTRL_MASK;
>+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
>+	}
>+

Nit, extra newline.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
