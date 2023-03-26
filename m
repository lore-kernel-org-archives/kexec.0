Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF159C6FD1C
	for <kexec@archiver.kernel.org>; Sun, 26 Mar 2023 17:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R0R7gpNWpHfISajCUWSsp+TFqHfx0OWdmpnoGrv7BDk=; b=CGHtg4TiI7TKBK
	4kCRnZBnhtITZju4LYeKvZFDKGSBMZ0TEdiD4HiWbz46KdprMiHv+XI1YYDClBA1e8bJXMpbKmiJR
	SBecDZflzIRLw85yspg0qg0TMYMluJcmHheWnmphVLZ/dphFfDCn6AVZTDV5NT0RddS0Q+K8P3quB
	T3PL5k4i+suaDb8oFzi9cZkBtowc0KlBsrYMHPJ9Aa7BvIUZ1xEkZy+EB9yP6ywLtnqfGmjj2WPhI
	jZr+YWnA+m81JbmO2mAqbtvImKTom3evXLyblxeRXv1sD1HoVwvlSmHNiZqmJBZtpZv1aWtFl89bx
	TMNBXyuWVtwjL4RgRbJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgTkU-008r2U-0A;
	Sun, 26 Mar 2023 17:01:42 +0000
Received: from mga04.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgTkJ-008qxg-2k
	for kexec@lists.infradead.org;
	Sun, 26 Mar 2023 17:01:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679850091; x=1711386091;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fVZ/T0Xll5z45xFx7FBvnYRUxCDHZrN04aKO7XOOUT0=;
  b=XhmfeW8ACPTAWp9ZY1bxCwdgdOAyt215wFUHyOJHHbmP+nde56CYjNQd
   8e7lmUWQinsQRjViHVNbYFKkztxIUR/u7aSc9aqqyLIOKHEUfi+M57oO2
   wzTaqB+P1n6miK1OUjM0KEms3T06faP4zCMcpHLNonEeziGHlNq4OErPQ
   EsY9OPv5jgTXyDD4Tw9oO78ZgA0lPD0G05rEVrcPbE9J3cWQhlNshTSs4
   avzv2dAdIgU+r2L/Qu+pT7MtrXotcAPv+doexB9uuCsz8NVGZRz1Fdyik
   RR+aJ2kpRvE2/0bVSnfbJW7pgXgoL1XCp7UeERkZjTw6D/acnLYEhvzA9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="338829155"
X-IronPort-AV: E=Sophos;i="5.98,292,1673942400"; 
   d="scan'208";a="338829155"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 10:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10661"; a="633387655"
X-IronPort-AV: E=Sophos;i="5.98,292,1673942400"; 
   d="scan'208";a="633387655"
Received: from crice5-mobl.amr.corp.intel.com (HELO [10.209.3.81]) ([10.209.3.81])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2023 10:01:23 -0700
Message-ID: <b16bcda0-f190-7849-cbbb-412d328c8806@intel.com>
Date: Sun, 26 Mar 2023 10:01:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] x86: Disable kexec for TDX guests
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230325160128.21857-1-kirill.shutemov@linux.intel.com>
 <ebead33b-0594-73df-56ae-f40473ac0ffc@intel.com>
 <20230325192524.wetlbycbcsxc4plk@box>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230325192524.wetlbycbcsxc4plk@box>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_100131_955994_1638F7BA 
X-CRM114-Status: GOOD (  25.49  )
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

On 3/25/23 12:25, Kirill A. Shutemov wrote:
> On Sat, Mar 25, 2023 at 09:25:36AM -0700, Dave Hansen wrote:
>> On 3/25/23 09:01, Kirill A. Shutemov wrote:
>>> The last item is tricky. TDX guests use ACPI MADT MPWK to bring up
>>> secondary CPUs. The mechanism doesn't allow to put a CPU back offline if
>>> it has woken up.
>> ...
>>> +int arch_kexec_load(void)
>>> +{
>>> +	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
>>> +		pr_warn_once("Disable kexec: not yet supported in TDX guest\n");
>>> +		return -EOPNOTSUPP;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>
>> So, let's put all this together:
>>
>> 1. TDX implementations use MADT for wakeup exclusively right now (but
>>    are not necessarily _required_ to do so forever)
>> 2. MADT doesn't support CPU offlining
>> 3. kexec() requires offlining
>>
>> Thus, current TDX implementations can't support TDX guests.  This
>> *doesn't* say that TDX will always use the MADT for wakeups.
>>
>> Yet, the check you have here is for TDX and *not* for the MADT.
> 
> As I described in the commit message there are more than MADT that is
> required to get kexec in TDX guest.

I kinda think we should do both.

Let's make sure that all systems that depend on MADT wakeups can't
kexec() until the ACPI folks work out what to do there.

Separately, let's either fix or *mark* the kexec()-incompatible pieces
that *ARE* specific to TDX.

>> That seems wrong.
>>
>> Let's say SEV or arm64 comes along and uses the MADT for their guests.
>> They'll add another arch_kexec_load(), with a check for *their* feature.
>>
>> This all seems like you should be disabling kexec() the moment the MADT
>> CPU wakeup is used instead of making it based on TDX.
> 
> I guess we can go this path if you are fine with taking CR4.MCE and shared
> memory reverting patches (they require some rework, but I can get them
> into shape quickly). After that we can forbid kexec on machines with MADT
> if nr_cpus > 1.

This goes back to what I asked before: is anyone actually going to *use*
a single-processor system that wants to kexec()?  If not, let's not
waste the time to introduce code that is just going to bitrot.  Just
mark it broken and move on with life.

I'm also a _bit_ curious what the implications of the CR4.MCE
preservation are.  IIRC, systems are quite a bit less stable when
CR4.MCE==0.  So, maybe there are some benefits to leaving it set during
kexec() for everyone.  But, that probably also involves having a #MC
handler in the mix and that's obviously trouble while we're switching
kernels and messing around in the guts of things like paging configuration.

The CR4.MCE change is simple enough, but it also _completely_ glossed
over the implications to non-TDX users.

I guess the overall message here is: please try to think of the big
picture a _little_ outside of the TDX world.  This patch's approach is a
bit myopic.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
