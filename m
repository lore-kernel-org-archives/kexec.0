Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8C5C4345F
	for <kexec@archiver.kernel.org>; Fri,  3 May 2024 08:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dx0aiy37BWj1kJ2XLMeLNX8LDskm8KZPUd01VEfVJns=; b=QpXyYtC6sxw2nO
	bm3LKpWq6w1VaXzAVpSIfyNpnT/nrHM6tJWzDkpXCF5d/eZ3hVBc9sJYBGe0YZ9HUC6vG1dZZNs6S
	H/dpRwtsEvWupjJM2nYHFQYCpctRjcnRlIN39m+FUpF6pq8nNWjSgE4AChdbhJlq065cJ+POAZiIR
	QPgdYrnBGqIgcsBypxhleS//qTv6hpUb1iArXhCOjqljZuRWKOlJilGHavVxE1b/lA5/UbPTrl2j/
	Z6wyq+kWRIE48JfL9m5NMVKXew1p0yPPKrbKxl7V192T7JkPcMAK5qc7vhpBaKOUpDBZuCaD7Qrxl
	PpOlDABMjn1jZNUDlLWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2oLH-0000000FfVc-3YCC;
	Fri, 03 May 2024 08:32:31 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2oLE-0000000FfSP-3Pls
	for kexec@lists.infradead.org;
	Fri, 03 May 2024 08:32:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714725149; x=1746261149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vgSYT6fxfReVODTChlrLY1yTZjM/kZAB6PbQPgue2kA=;
  b=EZXPPJDMNABwJHticgPL0uH3aaZDbh7vNRA/RRsiCZfym5kdxB/r0Kg0
   zaq6HkvtFE7z4rWd9RLwg0tmuRntkv+KrvRVcDYVy3I9NoGGDu6AfadIJ
   VaV7tJ9PC0e0b6JJnMq5rMLWX06ze/W6nnl+m1JhsBh5KQPy0A0AcKhfM
   8=;
X-IronPort-AV: E=Sophos;i="6.07,247,1708387200"; 
   d="scan'208";a="398851930"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 08:32:22 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:9532]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.38:2525] with esmtp (Farcaster)
 id 26a7d38d-e059-4d36-a735-3275faea70a5; Fri, 3 May 2024 08:32:21 +0000 (UTC)
X-Farcaster-Flow-ID: 26a7d38d-e059-4d36-a735-3275faea70a5
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 3 May 2024 08:32:21 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 3 May
 2024 08:32:15 +0000
Message-ID: <c2732461-e768-4356-82ce-a80c73997f02@amazon.com>
Date: Fri, 3 May 2024 10:32:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] x86/snp: Add kexec support
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Ashish Kalra
	<Ashish.Kalra@amd.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <seanjc@google.com>, <kai.huang@intel.com>,
	<bhe@redhat.com>, <kirill.shutemov@linux.intel.com>, <bdas@redhat.com>,
	<dionnaglaze@google.com>, <anisinha@redhat.com>, <jroedel@suse.de>,
	<ardb@kernel.org>, <kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <cover.1712694667.git.ashish.kalra@amd.com>
 <26b3b3b5-548d-4ebd-9d21-19580a41e799@amazon.com> <87msp8mmpq.fsf@redhat.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <87msp8mmpq.fsf@redhat.com>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240503_013229_091746_7A923A9C 
X-CRM114-Status: GOOD (  20.90  )
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


On 02.05.24 14:18, Vitaly Kuznetsov wrote:
> Alexander Graf <graf@amazon.com> writes:
>
>> Hey Ashish,
>>
>> On 09.04.24 22:42, Ashish Kalra wrote:
>>> From: Ashish Kalra <ashish.kalra@amd.com>
>>>
>>> The patchset adds bits and pieces to get kexec (and crashkernel) work on
>>> SNP guest.
>>
>> With this patch set (and similar for the TDX one), you enable the
>> typical kdump case, which is great!
>>
>> However, if a user is running with direct kernel boot - which is very
>> typical in SEV-SNP setup, especially for Kata Containers and similar -
>> the initial launch measurement is a natural indicator of the target
>> environment. Kexec basically allows them to completely bypass that: You
>> would be able to run a completely different environment than the one you
>> measure through the launch digest. I'm not sure it's a good idea to even
>> allow that by default in CoCo environments - at least not if the kernel
>> is locked down.
> Isn't it the same when we just allow loading kernel modules? I'm sure
> you can also achieve a 'completely different environment' with that :-)
> With SecureBoot / lockdown we normally require modules to pass signature
> check, I guess we can employ the same mechanism for kexec. I.e. in
> lockdown, we require signature check on the kexec-ed kernel. Also, it
> may make sense to check initramfs too (with direct kernel boot it's also
> part of launch measurements, right?) and there's UKI for that already).


Correct. With IMA, you even do exactly that: Enforce a signature check 
of the next binary with kexec.

The problem is that you typically want to update the system because 
something is broken; most likely your original environment had a 
security issue somewhere. From a pure SEV-SNP attestation point of view, 
you can not distinguish between the patched and unpatched environment: 
Both look the same.

So while kexec isn't the problem, it's the fact that you can't tell 
anyone that you're now running a fixed version of the code :).


> Personally, I believe that if we simply forbid kexec for CoCo in
> lockdown mode, the feature will become mostly useless in 'full stack'
> (which boot through firmware) production envrironments.


I'm happy for CoCo to stay smoke and mirrors :). But I believe that if 
you want to genuinely draw a trust chain back to an AMD/Intel 
certificate, we need to come up with a good way of making updates work 
with a working trust chain so that whoever checks whether you're running 
sanctioned code is able to validate the claim.


Alex


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
