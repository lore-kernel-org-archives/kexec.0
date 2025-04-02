Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526F3C36017
	for <kexec@archiver.kernel.org>; Wed,  2 Apr 2025 16:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OOFyG8Kd6+HeZN8MQhF4S2SXZyJjo0p9QJnhgx3PboY=; b=pXPKEu1F4FhvEMu7Aj57SQG2tU
	+F4ZlCZaVhQrH4xRnjso1Rbf7atQBSufQltUyTJ+UdQXQD65/P0cW9wLnkSkM4K7VeEltPULSciQg
	C0eXz5OOOOZ54WThmaD0vLMRWLFxIygSJUoXM0zIz3p2pOYW2RdwifunKzzwoKnxGPxiaQ59XEb53
	rvY5Fqs5YP7WTMlmkhnPGU6EIewVk2fcxey6MiNcZPE7VMZ/cfTUvpEUXU+HCCVA88Gsij2f8rCfq
	kdTyc7QnbCAYZEvE2ASS7/+PvLHbg0njzunIJYaPKVOwRgb13qgkfkH/WWRPaTHIgNwDH7ti77yvR
	ge3j9gpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u01Fm-00000006gLS-1syV;
	Wed, 02 Apr 2025 16:47:50 +0000
Received: from smtp-fw-80006.amazon.com ([99.78.197.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u01Fk-00000006gJi-0nVB;
	Wed, 02 Apr 2025 16:47:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1743612469; x=1775148469;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=OOFyG8Kd6+HeZN8MQhF4S2SXZyJjo0p9QJnhgx3PboY=;
  b=SOtL+glAt/3U0AWGefA+KcmsRmf8ihUbIzlSrp7AgJeY2jA5a01hgDg0
   r3594ylFDr/Nsy+YA8vaOyTjxu/8mYNZuSYyR+iUywxW7sc+aoEKV4f4m
   f81icTLXQfVtbnl8iQL9QSeZCa0+ttQi3C6rge8z+QfUSZ4gBWkGpuU+y
   c=;
X-IronPort-AV: E=Sophos;i="6.15,182,1739836800"; 
   d="scan'208";a="37483382"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 16:47:43 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:63428]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.231:2525] with esmtp (Farcaster)
 id fb8b30c2-4f1e-48a1-bd68-83c73817fafa; Wed, 2 Apr 2025 16:47:42 +0000 (UTC)
X-Farcaster-Flow-ID: fb8b30c2-4f1e-48a1-bd68-83c73817fafa
Received: from EX19D020UWA002.ant.amazon.com (10.13.138.222) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 16:47:39 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D020UWA002.ant.amazon.com (10.13.138.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 16:47:39 +0000
Received: from email-imr-corp-prod-pdx-all-2c-785684ef.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 16:47:39 +0000
Received: from dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com [172.19.91.144])
	by email-imr-corp-prod-pdx-all-2c-785684ef.us-west-2.amazon.com (Postfix) with ESMTP id A4539A03AB;
	Wed,  2 Apr 2025 16:47:38 +0000 (UTC)
Received: by dev-dsk-ptyadav-1c-43206220.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 3863F4F35; Wed,  2 Apr 2025 16:47:38 +0000 (UTC)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Changyuan Lyu <changyuanl@google.com>
CC: <akpm@linux-foundation.org>, <anthony.yznaga@oracle.com>, <arnd@arndb.de>,
	<ashish.kalra@amd.com>, <benh@kernel.crashing.org>, <bp@alien8.de>,
	<catalin.marinas@arm.com>, <corbet@lwn.net>, <dave.hansen@linux.intel.com>,
	<devicetree@vger.kernel.org>, <dwmw2@infradead.org>, <ebiederm@xmission.com>,
	<graf@amazon.com>, <hpa@zytor.com>, <jgg@nvidia.com>, <jgowans@amazon.com>,
	<kexec@lists.infradead.org>, <krzk@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <luto@kernel.org>,
	<mark.rutland@arm.com>, <mingo@redhat.com>, <pasha.tatashin@soleen.com>,
	<pbonzini@redhat.com>, <peterz@infradead.org>, <robh+dt@kernel.org>,
	<robh@kernel.org>, <rostedt@goodmis.org>, <rppt@kernel.org>,
	<saravanak@google.com>, <skinsburskii@linux.microsoft.com>,
	<tglx@linutronix.de>, <thomas.lendacky@amd.com>, <will@kernel.org>,
	<x86@kernel.org>
Subject: Re: [PATCH v5 09/16] kexec: enable KHO support for memory preservation
In-Reply-To: <20250402164453.2470750-1-changyuanl@google.com>
References: <mafs0tt7eqt6f.fsf@amazon.de>
	<20250402164453.2470750-1-changyuanl@google.com>
Date: Wed, 2 Apr 2025 16:47:38 +0000
Message-ID: <mafs0ecyaqzmd.fsf_-_@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_094748_285940_31E558F0 
X-CRM114-Status: GOOD (  30.36  )
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

Hi,

On Wed, Apr 02 2025, Changyuan Lyu wrote:

> Hi Pratyush, Thanks for suggestions!
>
> On Thu, Mar 27, 2025 at 17:28:40 +0000, Pratyush Yadav <ptyadav@amazon.de> wrote:
>> On Thu, Mar 27 2025, Jason Gunthorpe wrote:
>>
>> > On Thu, Mar 27, 2025 at 10:03:17AM +0000, Pratyush Yadav wrote:
>> >
>> >> Of course, with the current linked list structure, this cannot work. But
>> >> I don't see why we need to have it. I think having a page-table like
>> >> structure would be better -- only instead of having PTEs at the lowest
>> >> levels, you have the bitmap.
>> >
>> > Yes, but there is a trade off here of what I could write in 30 mins
>> > and what is maximally possible :) The xarray is providing a page table
>> > implementation in a library form.
>> >
>> > I think this whole thing can be optimized, especially the
>> > memblock_reserve side, but the idea here is to get started and once we
>> > have some data on what the actual preservation workload is then
>> > someone can optimize this.
>> >
>> > Otherwise we are going to be spending months just polishing this one
>> > patch without any actual data on where the performance issues and hot
>> > spots actually are.
>>
>> The memblock_reserve side we can optimize later, I agree. But the memory
>> preservation format is ABI and I think that is worth spending a little
>> more time on. And I don't think it should be that much more complex than
>> the current format.
>>
>> I want to hack around with it, so I'll give it a try over the next few
>> days and see what I can come up with.
>
> I agree with Jason that "nothing is ABI at this
> point" and it will take some time for KHO to stabilize.
>
> On the other hand if you have already came up with something working and
> simple, we can include it in the next version.

I already have something that works with zero-order pages. I am
currently implementing support for other orders. It is almost done, but
I need to test it and do a performance comparison with the current
patch. Will post something soon!

-- 
Regards,
Pratyush Yadav

