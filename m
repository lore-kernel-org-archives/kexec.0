Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338C7C4332F
	for <kexec@archiver.kernel.org>; Fri, 18 Nov 2022 19:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cUCXb8guKwqx2jRW1N0LxlUuOx10aXeCpAlP27JT/I4=; b=SmG+5V9zMTXo67sO484zk/5n68
	ujgEyw9bdGj3uSqVr8E8aqur5b4VoubKO9kves6KF17CVVT/Da/xmdgSRvCqlnKjlpcjtWWOALBN7
	QSE6hNG5vv+RUmcJYd/JlkxU81BO+qmRHQY5x0LcWsSIR0LjyrVEEwpYcCv91JO21yDAmPolXudnt
	kdY38GzP8wXn5ATfjnYg/AiPm1g2YpbeIFTf4hhdWdUDkGoHX6oBB/WTrxK2twM/NXnykjHuTV7Ka
	1rrApaPvp4j21U+0QGBWRYO4Aj4cMSXk7u/juxWwIgkfiJQjYHetNBbhs56ME4e3SXjRv2m0AlicC
	gWQwkGEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow7JX-007gpT-Jd; Fri, 18 Nov 2022 19:46:15 +0000
Received: from mga04.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow7JO-007ghZ-QY
	for kexec@lists.infradead.org; Fri, 18 Nov 2022 19:46:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668800766; x=1700336766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R9T+em6z/tLAz1Y0qKnHjqDFrAozFEbyluebZfd8mcI=;
  b=aUzGGutjZemKtwzYm1zOJBSq6zRxxdcuUqxddM5jSokw05YEZDYdQmmD
   TOnj5vR0hotDgBTn24AADb5xR8nvZO+ewBxpH/DhWh/eBkjNonzmrQ46v
   YteuGP54cUJY/QQUZrCi/oNCnUza/jLQO6bOMdn4w6WnvHk69zwiGU/Hj
   BaMP4uM1HJaOqvibM9Pm1vgrWVnYw2K2Lnq14YE7uhs0XHi+mm8lgtaU2
   ksVKV0fY0CKB0Beis4H/4rgZTXSLWhbzSlkpKOwvVwe5w6ih7HeADnhxl
   dV9RsocmJuBTFlMb4cohSGbq3AcXJXAmNcpHvoI2ungWtvzhEUhJuWDjd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="311921251"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="311921251"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 11:46:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="618123788"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="618123788"
Received: from bfan1-mobl1.amr.corp.intel.com (HELO desk) ([10.209.78.213])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 11:46:04 -0800
Date: Fri, 18 Nov 2022 11:46:02 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org,
	peterz@infradead.org, x86@kernel.org, cascardo@canonical.com,
	leit@meta.com, kexec@lists.infradead.org
Subject: Re: [RFC PATCH] x86/bugs: Explicitly clear IBRS MSR bit
Message-ID: <20221118194602.vpo4xjm4s7knm7ja@desk>
References: <20221118182110.1903650-1-leitao@debian.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221118182110.1903650-1-leitao@debian.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221118_114606_913241_700995F6 
X-CRM114-Status: GOOD (  19.00  )
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

On Fri, Nov 18, 2022 at 10:21:10AM -0800, Breno Leitao wrote:
>Currently x86_spec_ctrl_base is read at boot time, and SPEC_CTRL_IBRS
>bit is set if CONFIG_CPU_IBRS_ENTRY is enabled. There is no change in
>the bit if CONFIG_CPU_IBRS_ENTRY is not set.
>
>This is a problem when kexec-ing a kernel that has the mitigation
>disabled, from a kernel that has the mitigation enabled. In this case,
>the MSR bit is carried forward and not cleared at the boot of the new
>kernel. This might have some performance degradation that is hard to
>find.
>
>This problem does not happen if the machine is (hard) rebooted, because
>the bit will be cleared by default.
>
>Signed-off-by: Breno Leitao <leitao@debian.org>
>---
> arch/x86/kernel/cpu/bugs.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>index 3e3230cccaa7..5b59e850de6e 100644
>--- a/arch/x86/kernel/cpu/bugs.c
>+++ b/arch/x86/kernel/cpu/bugs.c
>@@ -1451,6 +1451,9 @@ static void __init spectre_v2_select_mitigation(void)
> 	if (spectre_v2_in_ibrs_mode(mode)) {
> 		x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
> 		write_spec_ctrl_current(x86_spec_ctrl_base, true);
>+	} else {
>+		x86_spec_ctrl_base = x86_spec_ctrl_base & (~SPEC_CTRL_IBRS);
>+		write_spec_ctrl_current(x86_spec_ctrl_base, true);

Can we solve this problem in a more generic way by clearing all the
known bits before any mitigation selection is done:

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5b59e850de6e..26c612792150 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -137,8 +137,15 @@ void __init check_bugs(void)
  	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
  	 * init code as it is not enumerated and depends on the family.
  	 */
-	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
+	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
  		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+		/*
+		 * Previously running software may have some controls turned ON.
+		 * Clear them and let kernel decide which controls to use.
+		 */
+		x86_spec_ctrl_base &= ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD | SPEC_CTRL_RRSBA_DIS_S);
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+	}
  
  	/* Select the proper CPU mitigations before patching alternatives: */
  	spectre_v1_select_mitigation();

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
