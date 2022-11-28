Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2471C43217
	for <kexec@archiver.kernel.org>; Mon, 28 Nov 2022 23:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LqAsoI5TTuBvLg9CLSrGweb2LWLVVSDHs4UgTYN56bk=; b=1+gjolST9XDv6+Oh/cpmsoWJyf
	biY46yMwh9ncRIO/0t5ZnF96lnbalQmG2/9QOKuAifTIxmz9yfoBNUKMNEpkPA6txkrutnrjnlbpc
	Y7DpWKAG/EPQDTw6zm3FnOKi8gBYpcEIJI4Wx30ZB14IWZin3+u5QPwjiqtlBHP+ZCAN6lLxQG+4d
	uTCuoMBBMZR1Lc93nMA1uSqiI8GIVyhtfE5bBL9nUGT/g34R5ics58hh2ieJF+svay0CfCUDMaj+w
	TIN/Q2y+iwZ36sOxFNz6klRGjxku5Wr9u16VJj5PviCFHgLMcefPMDAAN4Vc+6WExH6JVp6WJjtqD
	faQpMQxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oznh6-004nlT-VP; Mon, 28 Nov 2022 23:37:48 +0000
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oznh3-004nii-RH
	for kexec@lists.infradead.org; Mon, 28 Nov 2022 23:37:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669678665; x=1701214665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9kk6qGhgFeOe6cFwnPq1cjclCYQX66efsWsltSbytwA=;
  b=asRdI5pf6teZ79PXfuOHhabWNp4LfhhAkUVbI8OwD02kKhOzSlDDRNTW
   +cJQ3nW1ck91r6z0NFuSIk+sSk6NLJMQRh4w3gGMf9o4lnX75HAlUdd0T
   Fnuzna/wGON/HV5kdk+JZ8i+NlWuC7NyHHJSb/wA1typi4Dhg4o34ldg8
   5FdE5SiKF6AVoCqHM8ULq/EAFTpYyYSv14NsJDnQIRonLe/wRGfq6A8nt
   9zOkeBGyDj/KVPtAW0Um6aN+7Nu/0pIT5UyPq/ydP0Iw+fTI9YxLp4wZi
   DssYF0g8UzEabbjk4pC6UwikmHGvVL6eFpuUdgtbwn1F4gyT9sfXpeWcN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="377120892"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="377120892"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 15:37:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="888625766"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="888625766"
Received: from gmeghash-mobl2.amr.corp.intel.com (HELO desk) ([10.209.19.254])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 15:37:41 -0800
Date: Mon, 28 Nov 2022 15:37:39 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Breno Leitao <leitao@debian.org>, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org,
	peterz@infradead.org, x86@kernel.org, cascardo@canonical.com,
	leit@meta.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <20221128233739.dd3dzx6qkermsfri@desk>
References: <20221124104650.533427-1-leitao@debian.org>
 <Y4QD8o8kWb1V4osq@zn.tnic>
 <20221128220358.n5vk6youcdl2er35@desk>
 <Y4U40wKoSF/ze1Ud@zn.tnic>
 <20221128230219.urqiol42rikdhy2u@desk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221128230219.urqiol42rikdhy2u@desk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_153745_958272_1475E988 
X-CRM114-Status: GOOD (  15.16  )
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

On Mon, Nov 28, 2022 at 03:02:21PM -0800, Pawan Gupta wrote:
>On Mon, Nov 28, 2022 at 11:40:19PM +0100, Borislav Petkov wrote:
>>On Mon, Nov 28, 2022 at 02:03:58PM -0800, Pawan Gupta wrote:
>>>diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>>>index 3e3230cccaa7..cfc2ed2661fc 100644
>>>--- a/arch/x86/kernel/cpu/bugs.c
>>>+++ b/arch/x86/kernel/cpu/bugs.c
>>>@@ -66,7 +66,7 @@ static DEFINE_MUTEX(spec_ctrl_mutex);
>>>  */
>>> void write_spec_ctrl_current(u64 val, bool force)
>>> {
>>>-	if (this_cpu_read(x86_spec_ctrl_current) == val)
>>>+	if (!force && this_cpu_read(x86_spec_ctrl_current) == val)
>>> 		return;
>>> 	this_cpu_write(x86_spec_ctrl_current, val);
>>
>>Still looks hacky to me.
>>
>>I think it would be a lot cleaner if MSR_IA32_SPEC_CTRL gets cleaned of
>>the speculation bits in init_speculation_control() which gets run on
>>*every* CPU.
>>
>>So by the time check_bugs() gets to setup stuff, the MSR will be ready
>>to go regardless.
>>
>>I.e., something like this (not supposed to work - just to show what I
>>mean):
>>
>>diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>>index 73cc546e024d..367732c92942 100644
>>--- a/arch/x86/kernel/cpu/common.c
>>+++ b/arch/x86/kernel/cpu/common.c
>>@@ -993,9 +993,19 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
>>	 * Intel CPUs, for finer-grained selection of what's available.
>>	 */
>>	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
>>+		u64 msr;
>>+
>>		set_cpu_cap(c, X86_FEATURE_IBRS);
>>		set_cpu_cap(c, X86_FEATURE_IBPB);
>>		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
>>+
>>+		/*
>>+		 * Clear speculation control settings from a previous kernel
>>+		 * run, i.e., kexec.
>>+		 */
>>+		rdmsrl(MSR_IA32_SPEC_CTRL, msr);
>>+		if (msr & SPEC_CTRL_MASK)
>>+			wrmsr (MSR_IA32_SPEC_CTRL, msr & ~SPEC_CTRL_MASK);
>
>Yes thats a cleaner approach, except that the late microcode load will
>ruin the MSR:

Root of the original problem is x86_spec_ctrl_current is not the current
value of MSR at bootup.

How about we update x86_spec_ctrl_current before any writes to the MSR?:

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3e3230cccaa7..68ed52394fd9 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -137,8 +137,18 @@ void __init check_bugs(void)
  	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
  	 * init code as it is not enumerated and depends on the family.
  	 */
-	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
+	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
  		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+		/*
+		 * Previously running software, like kexec for example, may
+		 * have some controls turned ON.
+		 * Clear them and let the mitigations setup below set them
+		 * based on configuration.
+		 */
+		this_cpu_write(x86_spec_ctrl_current, x86_spec_ctrl_base);
+		x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
+		write_spec_ctrl_current(x86_spec_ctrl_base, true);
+	}
  
  	/* Select the proper CPU mitigations before patching alternatives: */
  	spectre_v1_select_mitigation();
@@ -2047,8 +2057,13 @@ int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
  
  void x86_spec_ctrl_setup_ap(void)
  {
-	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
+	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
+		u64 msr;
+
+		rdmsrl(MSR_IA32_SPEC_CTRL, msr);
+		this_cpu_write(x86_spec_ctrl_current, msr);
  		write_spec_ctrl_current(x86_spec_ctrl_base, true);
+	}
  
  	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
  		x86_amd_ssb_disable();

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
