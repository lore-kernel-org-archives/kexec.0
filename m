Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B718E7717D
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 06:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+lPsbkT7ZKpvCt6zzSO9G7BT1wjHpy+3VZSwWTGMZPM=; b=zWlf6LRO35jC1qsCGLdonYQYe/
	Sq78wF21XC8PCPoruPErPMGdl7IU5/Eje9Sbsf5tm/cgEmJm4zcupPfgXP2IVqbSkfmnppQhj0AGB
	fcpQLaom0kTI7e6O9vTPXDyFJBJVfrGOMgZJhnF3oIOD/Um0jjO4Q411JM6gW2TpJgPc1aOUBnsUv
	Cu9Vo6cTKAld/fUNksw5S+XBWlYN6gcXgamboC2+ixl1prNtG5jl40MpP8J/HItrwzOI4DBUFJlCS
	NgOa+c7uD8YTExVzEQf9q8evwchWDXcReTDBnkMGH0X9Qwz7j1XPPn9xQVm1DLccrWkVtodLm1ipD
	IQLo3Wzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLzQl-00000002tRu-1Bxg;
	Fri, 13 Dec 2024 06:45:43 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLzQf-00000002tQY-45Nt
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 06:45:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734072338; x=1765608338;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y3V3QXxnk6ioz2X6g8iJlmn+yyJNHa0oVjvimRPuvw0=;
  b=cxnREW1kocSZak5UfyaKpHvn1WCXbhLP/XQIUrDyZzHfAqc1aHT9STSs
   xS075zF4beZyzLM1LiloyWCgiJyxy+Be8fGs/XxMvqepK9XY+HpZoZKdj
   KPgrGq6wnTV7+fhblR/mliZnqA1oJfdj7aidomWIDRURf2TfZNigXtnsc
   0t0W9zAoPj1AOBue0IfFugbWJjd6U6Fz8qxMEEimfQJHQ7a5NbjZDi2om
   IKHwOTOMM+0ho0ih6d+2t0IF+OpOLvcxBY0InlOsCAt9+VUfmNr8BxFaK
   IW9XnhSbN3xgCTuPSBj1dNk/rJh9C4ObtrDdo8VQ+45GoSJ9DII93Q2Z4
   g==;
X-CSE-ConnectionGUID: ReU8J7FyTO2QDPI4pcCe7Q==
X-CSE-MsgGUID: 5se3S4h/R+yC7EJpZrfiSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34649486"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="34649486"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 22:45:34 -0800
X-CSE-ConnectionGUID: fURkU1yZRrW+hvR2JNT3GQ==
X-CSE-MsgGUID: 1kFj6ZH7RpeklJ9CO0RjLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="96529879"
Received: from hongyuni-mobl.ccr.corp.intel.com (HELO [10.124.244.96]) ([10.124.244.96])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 22:45:29 -0800
Message-ID: <56fdfffc-9a5e-4f9e-ae5b-57dd27d647cc@linux.intel.com>
Date: Fri, 13 Dec 2024 14:45:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/20] x86/kexec: Mark relocate_kernel page as ROX
 instead of RWX
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
Content-Language: en-US
From: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
In-Reply-To: <b4104c271b461dc1958ffac299d6741746a0728a.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_224538_026185_E3A5DEFF 
X-CRM114-Status: GOOD (  18.17  )
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



On 2024/12/12 18:13, David Woodhouse wrote:
> On Thu, 2024-12-12 at 11:03 +0800, Ning, Hongyu wrote:
>>
>> Hi David,
>>
>> I've hit some kdump/kexec regression issue for guest kernel in KVM/QEMU
>> based VM and reported in https://bugzilla.kernel.org/show_bug.cgi?id=219592.
>>
>> based on further git bisect, it seems to be related with this commit,
>> would you help to take a look?
> 
> Thanks for the report; I'll take a look. Please could you share your
> kernel .config?
> 

kernel config updated in the bugzilla 
https://bugzilla.kernel.org/show_bug.cgi?id=219592

> Also, you say that this is in QEMU running on an IA64 host. Is that
> true, or did you mean x86_64 host? Are you using OVMF or SeaBIOS as the
> QEMU firmware?
> 

You're right, it's x86_64 host, I miss-selected it in bugzilla.
I'm using OVMF as the QEMU firmware.

> In the short term, I think that just reverting the 'offending' commit
> should be OK. I'd *prefer* not to leave the page RWX for the whole time
> period that the image is loaded, but that's how it's been on i386 for
> ever anyway.

And your latest patch 
https://lore.kernel.org/kexec/9c68688625f409104b16164da30aa6d3eb494e5d.camel@infradead.org/ 
could fix this issue now.

