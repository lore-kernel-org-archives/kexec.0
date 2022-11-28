Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1019C43217
	for <kexec@archiver.kernel.org>; Mon, 28 Nov 2022 23:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DmU8NvBK50Mth4KnQ1s6mf00Wf/iE7v6XQ/jyAOfzRw=; b=RGZkG/FTpU9mMrQmZgl+xYL+hi
	MWjyDAa2/k7GawBgA12JW9E4q4dfp9KYZktXgxWYDj2Y2jOUXAlipW6neXNiyxC79tysCKJiz1kRv
	UKT7nGsQ5P+nAyNECyczanaaJ46l2bqV5rfP3DGfXOIPRjP4Fe7ZtHOFgy9Urn+t8xxvE8YdtLmyy
	3OM7HFq6P2gHQGmxyCsnOO1WY93t8G73Jvf2N1YK5QZlmRYtd38v/GhGthFwyeYu9PVSDKXYw8SYi
	iieFGSnHYyjoH83Vhvqt4d10SWmBFWrbmbQFo+81i0aitCJl9jwsgJZK8Zxa8W4rrG7SRhIHOAO8x
	fj2WsZGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozn8y-004g0o-F6; Mon, 28 Nov 2022 23:02:32 +0000
Received: from mga04.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ozn8w-004fzW-8S
	for kexec@lists.infradead.org; Mon, 28 Nov 2022 23:02:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669676550; x=1701212550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iiqUjAHCO+LQ+rR+96mD8ATucD1rodYYrVb/pJ5LDbM=;
  b=ahdIPNGFxR49VxzdFIuy2HUtgfrwkrqavBRS/uklxQK2vf6eecEv86Sc
   MYVgcI1hTiQHAmP/CKLdI5KWgAisZ89TaBsxu8Zupe/w0L6IRjf+FM3C8
   B9DUk+qsJ2sZu1AeIymeOOAA1/XB14eUEtDzSOyEJPvNgwmG96smBysTP
   AglE4dg/fn2iSneED8Xemh7ANQx5SBXlhtoFFJiPY4QMw6WAD/+ZfBh7w
   2OQhP3XILD8EyZQUm6eaVwgONUOnVACH8QzFyAMOPGpbsgbfJR0gF+0K2
   IXbgrzblxkHuzQQSJggFGbQNj7Px18yOR/+YWtDBd9TV/5bOL0rhrF7HD
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="313672934"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="313672934"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 15:02:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="676216763"
X-IronPort-AV: E=Sophos;i="5.96,201,1665471600"; 
   d="scan'208";a="676216763"
Received: from gmeghash-mobl2.amr.corp.intel.com (HELO desk) ([10.209.19.254])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 15:02:21 -0800
Date: Mon, 28 Nov 2022 15:02:19 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Breno Leitao <leitao@debian.org>, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com, jpoimboe@kernel.org,
	peterz@infradead.org, x86@kernel.org, cascardo@canonical.com,
	leit@meta.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/bugs: Explicitly clear speculative MSR bits
Message-ID: <20221128230219.urqiol42rikdhy2u@desk>
References: <20221124104650.533427-1-leitao@debian.org>
 <Y4QD8o8kWb1V4osq@zn.tnic>
 <20221128220358.n5vk6youcdl2er35@desk>
 <Y4U40wKoSF/ze1Ud@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y4U40wKoSF/ze1Ud@zn.tnic>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221128_150230_317457_FDB16B87 
X-CRM114-Status: GOOD (  12.69  )
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

On Mon, Nov 28, 2022 at 11:40:19PM +0100, Borislav Petkov wrote:
>On Mon, Nov 28, 2022 at 02:03:58PM -0800, Pawan Gupta wrote:
>> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>> index 3e3230cccaa7..cfc2ed2661fc 100644
>> --- a/arch/x86/kernel/cpu/bugs.c
>> +++ b/arch/x86/kernel/cpu/bugs.c
>> @@ -66,7 +66,7 @@ static DEFINE_MUTEX(spec_ctrl_mutex);
>>   */
>>  void write_spec_ctrl_current(u64 val, bool force)
>>  {
>> -	if (this_cpu_read(x86_spec_ctrl_current) == val)
>> +	if (!force && this_cpu_read(x86_spec_ctrl_current) == val)
>>  		return;
>>  	this_cpu_write(x86_spec_ctrl_current, val);
>
>Still looks hacky to me.
>
>I think it would be a lot cleaner if MSR_IA32_SPEC_CTRL gets cleaned of
>the speculation bits in init_speculation_control() which gets run on
>*every* CPU.
>
>So by the time check_bugs() gets to setup stuff, the MSR will be ready
>to go regardless.
>
>I.e., something like this (not supposed to work - just to show what I
>mean):
>
>diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
>index 73cc546e024d..367732c92942 100644
>--- a/arch/x86/kernel/cpu/common.c
>+++ b/arch/x86/kernel/cpu/common.c
>@@ -993,9 +993,19 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
> 	 * Intel CPUs, for finer-grained selection of what's available.
> 	 */
> 	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
>+		u64 msr;
>+
> 		set_cpu_cap(c, X86_FEATURE_IBRS);
> 		set_cpu_cap(c, X86_FEATURE_IBPB);
> 		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
>+
>+		/*
>+		 * Clear speculation control settings from a previous kernel
>+		 * run, i.e., kexec.
>+		 */
>+		rdmsrl(MSR_IA32_SPEC_CTRL, msr);
>+		if (msr & SPEC_CTRL_MASK)
>+			wrmsr (MSR_IA32_SPEC_CTRL, msr & ~SPEC_CTRL_MASK);

Yes thats a cleaner approach, except that the late microcode load will
ruin the MSR:

microcode_reload_late()
   microcode_check()
     get_cpu_cap()
       init_speculation_control()

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
