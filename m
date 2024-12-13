Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1521E7717D
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 07:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gqevmRXHTrfTUbXj2FGyW5LQbrY8ZybcfHoKnqMvEDc=; b=lbdKPkoIPZh3EDfw16coL63gFO
	meMs0oFPEWSW025yOebykA7UO2BJTJSyg352Q8wraOlWfUvrrr0hCnUyz07xrnrsbTwIZsnzz9i16
	Zdeu+hWjNZcFr5AWKKo3L+A4v6b5R71eGrnLSi3pphNvYJ3ZYeU7413MUIkT6TKHOsDVCwYTP3Mib
	k5M4YoxqtF+Lio4xvv9AOI73QFdzHrVf3fqm8MxTebYwNq1IB6qqTa4/aTjyM9VZhe/tGgNVv9Vbl
	bbZaRPhErQiN9OPd4fTA/OfTANuKzyTpuKTyM1GVUr00SgJaHT3M4SayZ24R1iQDERm0VcVEk6Msn
	S4FpB8TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM0J2-00000002zDq-0LBu;
	Fri, 13 Dec 2024 07:41:48 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM0Im-00000002z9x-3PKJ
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 07:41:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734075692; x=1765611692;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=qe/DRkZqurcuEiMRLcjhf4qFchIOWtU4Kj0uAbt85Uk=;
  b=XDTuvEjxqobaDTOaH5Wn5Lwlc3m8uI3bUetkPmHIwMdbc0mGYYLLiA6q
   HFjWnjNDFfu3H621r/aT8wjzgMacRmmznJvws3WGuRkFotADxpQSPG9OF
   x9k53BgvEn3lcmolWp5GjPP6Gkhy3TYIc6T7pRt7F7DefgCbwlu3NIm6f
   oybr6Jtsh9svtpfASQQMmaQ4RHnpZEBBZFSghnbjdqCzRX6pwpCYHrd7L
   R1iO3p8Xw5VTZPJoOKVlb2Lhy5uAw4z3iMm/vdL+TzoK6Cioxr2Q8aRPU
   FgUs3GWmW/QXxRIUgE7qybAVWwdvpw84hO5q/kVcK/d2WdbWGp3ipBDNi
   g==;
X-CSE-ConnectionGUID: nGs4iq5ASvqinwIwaCTXYw==
X-CSE-MsgGUID: bCzJZwWEQhKCB8VRHuL/pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="59916759"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="59916759"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 23:41:30 -0800
X-CSE-ConnectionGUID: KwcmarQeTGKFseYtnaVssQ==
X-CSE-MsgGUID: cfzBmJPnRUO8J/8tfieSog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="101489393"
Received: from hongyuni-mobl.ccr.corp.intel.com (HELO [10.124.244.96]) ([10.124.244.96])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 23:41:26 -0800
Message-ID: <44ddaae9-fde0-4bd9-8662-ee88141ff0a3@linux.intel.com>
Date: Fri, 13 Dec 2024 15:41:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/20] x86/kexec: Mark relocate_kernel page as ROX
 instead of RWX
From: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>, kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-14-dwmw2@infradead.org>
 <5bb26488-f5fb-4186-92c3-de6a07631f91@linux.intel.com>
 <b4104c271b461dc1958ffac299d6741746a0728a.camel@infradead.org>
 <56fdfffc-9a5e-4f9e-ae5b-57dd27d647cc@linux.intel.com>
Content-Language: en-US
In-Reply-To: <56fdfffc-9a5e-4f9e-ae5b-57dd27d647cc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_234132_895422_63C694D2 
X-CRM114-Status: GOOD (  18.87  )
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



On 2024/12/13 14:45, Ning, Hongyu wrote:
> 
> 
> On 2024/12/12 18:13, David Woodhouse wrote:
>> On Thu, 2024-12-12 at 11:03 +0800, Ning, Hongyu wrote:
>>>
>>> Hi David,
>>>
>>> I've hit some kdump/kexec regression issue for guest kernel in KVM/QEMU
>>> based VM and reported in https://bugzilla.kernel.org/show_bug.cgi? 
>>> id=219592.
>>>
>>> based on further git bisect, it seems to be related with this commit,
>>> would you help to take a look?
>>
>> Thanks for the report; I'll take a look. Please could you share your
>> kernel .config?
>>
> 
> kernel config updated in the bugzilla https://bugzilla.kernel.org/ 
> show_bug.cgi?id=219592
> 
>> Also, you say that this is in QEMU running on an IA64 host. Is that
>> true, or did you mean x86_64 host? Are you using OVMF or SeaBIOS as the
>> QEMU firmware?
>>
> 
> You're right, it's x86_64 host, I miss-selected it in bugzilla.
> I'm using OVMF as the QEMU firmware.
> 
>> In the short term, I think that just reverting the 'offending' commit
>> should be OK. I'd *prefer* not to leave the page RWX for the whole time
>> period that the image is loaded, but that's how it's been on i386 for
>> ever anyway.
> 
> And your latest patch https://lore.kernel.org/ 
> kexec/9c68688625f409104b16164da30aa6d3eb494e5d.camel@infradead.org/ 
> could fix this issue now.

my local email app went wrong, didn't receive latest patch in email thread.

later version patch 
https://lore.kernel.org/kexec/ed7dd45f89e8f286478791137447a21d53735dbd.camel@infradead.org/ 
could fix this issue too.

