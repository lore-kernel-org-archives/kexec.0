Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0B8C71153
	for <kexec@archiver.kernel.org>; Mon, 28 Aug 2023 20:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3kFww1cXGZoDvc+DihOzJOGoBJt3IZgcKMsj01sVzog=; b=Ne/6Zb6EbPjxHN
	5wNSjFirzU2tf7F1xwkSRZJIr88sYK8b1kTb0M8UnDZDvY+aKTog3lK9fEsoENbno12pehv4/rQ5S
	BtrCVBIC9ra1uR+gmClPu9HB7H7hCmKUhJXlLbC7L8uzZDEo4p42RNm1pNYwqrzmvcsTqVDLZFULk
	veTsJinkDqyRjRIquuGY2+QesE06uzGGEUB6eSVsaD+wlcoSCnHywA6luo/A2dOBbNdvLqqs3/b2/
	EWuKfjRu05zGUb9+JySNX+VMc0Eha22FlzUcCOtOtIvTU+gPbaoMcZclj4fi09vXgrrFu6myBAcMt
	v8wQEtKwYrM3UkpRZKBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qajCB-00AGBo-1k;
	Mon, 28 Aug 2023 20:50:47 +0000
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qajC8-00AGAX-11
	for kexec@lists.infradead.org;
	Mon, 28 Aug 2023 20:50:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1693255844; x=1724791844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ktiOhQrnGvQT2oDKq37JPM9wIGmpIXOUH9d4jIp7pQs=;
  b=a39V7madYI7tISqQeZ4F2SZ05or2h5xnHeDc3Q6MAMSWR03WZnbmH7My
   U8JDqeHucoWW/eHPK5dIhz0WXwjNZP/tncaNP9O2JLkgle//MOJDv26Xe
   JKXBYrFpc2wa/LLxCmhFJoA57/oR7H52FLJV5CPQC+kN0rpkImVlQ+OTo
   k=;
X-IronPort-AV: E=Sophos;i="6.02,208,1688428800"; 
   d="scan'208";a="25563562"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 20:50:32 +0000
Received: from EX19MTAUWB002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1d-m6i4x-b404fda3.us-east-1.amazon.com (Postfix) with ESMTPS id D12D7807DA;
	Mon, 28 Aug 2023 20:50:26 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 28 Aug 2023 20:50:26 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 28 Aug
 2023 20:50:21 +0000
Message-ID: <e0ed9fb9-8e7a-44ad-976a-27362f6e537a@amazon.de>
Date: Mon, 28 Aug 2023 22:50:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] Introduce persistent memory pool
Content-Language: en-GB
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, "Gowans, James"
	<jgowans@amazon.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "madvenka@linux.microsoft.com"
	<madvenka@linux.microsoft.com>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "steven.sistare@oracle.com"
	<steven.sistare@oracle.com>, "stanislav.kinsburskii@gmail.com"
	<stanislav.kinsburskii@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "anrayabh@linux.microsoft.com"
	<anrayabh@linux.microsoft.com>, "dragan.cvetic@amd.com"
	<dragan.cvetic@amd.com>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "derek.kiernan@amd.com"
	<derek.kiernan@amd.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, <kexec@lists.infradead.org>,
	<iommu@lists.linux.dev>, kvm <kvm@vger.kernel.org>
References: <64e7cbf7.050a0220.114c7.b70dSMTPIN_ADDED_BROKEN@mx.google.com>
 <2023082506-enchanted-tripping-d1d5@gregkh>
 <c26ad989dcc6737dd295e980c78ef53740098810.camel@amazon.com>
 <20230823024500.GA25462@skinsburskii.>
From: Alexander Graf <graf@amazon.de>
In-Reply-To: <20230823024500.GA25462@skinsburskii.>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_135044_424276_BA27B9F4 
X-CRM114-Status: GOOD (  58.71  )
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

+kexec, iommu, kvm

On 23.08.23 04:45, Stanislav Kinsburskii wrote:
>
> +akpm, +linux-mm
>
> On Fri, Aug 25, 2023 at 01:32:40PM +0000, Gowans, James wrote:
>> On Fri, 2023-08-25 at 10:05 +0200, Greg Kroah-Hartman wrote:
>>
>> Thanks for adding me to this thread Greg!
>>
>>> On Tue, Aug 22, 2023 at 11:34:34AM -0700, Stanislav Kinsburskii wrote:
>>>> This patch addresses the need for a memory allocator dedicated to
>>>> persistent memory within the kernel. This allocator will preserve
>>>> kernel-specific states like DMA passthrough device states, IOMMU state, and
>>>> more across kexec.
>>>> The proposed solution offers a foundational implementation for potential
>>>> custom solutions that might follow. Though the implementation is
>>>> intentionally kept concise and straightforward to foster discussion and
>>>> feedback, it's fully functional in its current state.
>> Hi Stanislav, it looks like we're working on similar things. I'm looking
>> to develop a mechanism to support hypervisor live update for when KVM is
>> running VMs with PCI device passthrough. VMs with device passthrough
>> also necessitates passing and re-hydrating IOMMU state so that DMA can
>> continue during live update.
>>
>> Planning on having an LPC session on this topic:
>> https://lpc.events/event/17/abstracts/1629/ (currently it's only a
>> submitted abstract so not sure if visible, hopefully it will be soon).
>>
>> We are looking at implementing persistence across kexec via an in-memory
>> filesystem on top of reserved memory. This would have files for anything
>> that needs to be persisted. That includes files for IOMMU pgtables, for
>> guest memory or userspace-accessible memory.
>>
>> It may be nice to solve all kexec persistence requirements with one
>> solution, but we can consider IOMMU separately. There are at least three
>> ways that this can be done:
>> a) carving out reserved memory for pgtables. This is done by your
>> proposal here, as well as my suggestion of a filesystem.
>> b) pre/post kexec hooks for drivers to serialise state and pass it
>> across in a structured format from old to new kernel.
>> c) Reconstructing IOMMU state in the new kernel by starting at the
>> hardware registers and walking the page tables. No state passing needed.
>>
>> Have you considered option (b) and (c) here? One of the implications of
>> (b) and (c) are that they would need to hook into the buddy allocator
>> really early to be able to carve out the reconstructed page tables
>> before the allocator is used. Similar to how pkram [0] hooks in early to
>> carve out pages used for its filesystem.
>>
> Hi James,
>
> We are indeed working on similar things, so thanks for chiming in.
> I've seen pkram proposal as well as your comments there.
>
> I think (b) will need some persistent-over-kexec memory to pass the
> state across kexec as well as some key-value store persisted as well.
> And the proposed persistent memory pool is aimed exactly for this
> purpose.
> Or do you imply some other way to pass driver's data accross kexec?


If I had to build this, I'd probably do it just like device tree passing 
on ARM. It's a single, physically contiguous blob of data whose entry 
point you pass to the target kernel. IIRC ACPI passing works similarly. 
This would just be one more opaque data structure that then needs very 
strict versioning and forward/backward compat guarantees.


> I dind't consider (c) yet, thanks for for the pointer.
>
> I have a question in this scope: how is PCI devices registers state is persisted
> across kexec with the files system you are working on? I.e. how does
> driver know, that the device shouldn't not be reinitialized?


The easiest way to do it initially would be kernel command line options 
that hack up the drivers. But I suppose depending on the option we go 
with, you can also use the respective "natural" path:

(a) A special metadata file that explains the state to the driver
(b) An entry in the structured file format that explains the state to 
the target driver
(c) Compatible target drivers try to enumerate state from the target 
device's register file


>
>>>> Potential applications include:
>>>>
>>>>    1. Allowing various in-kernel entities to allocate persistent pages from
>>>>       a singular memory pool, eliminating the need for multiple region
>>>>       reservations.
>>>>
>>>>    2. For in-kernel components that require the allocation address to be
>>>>       available on kernel kexec, this address can be exposed to user space and
>>>>       then passed via the command line.
>> Do you have specific examples of other state that needs to be passed
>> across? Trying to see whether tailoring specifically to the IOMMU case
>> is okay. Conceptually IOMMU state can be reconstructed starting with
>> hardware registers, not needing reserved memory. Other use-cases may not
>> have this option.
>>
> Well, basically it's IOMMU state and PCI devices to skip/avoid
> initializing.
> I bet there can be other misc (and unrelated things) like persistent
> filesystems, block devices, etc. But I don't have a solid set of use
> cases to present.


Would be great if you could think through the problem space until LPC so 
we can have a solid conversation there :)


>
>>> As you have no in-kernel users of this, it's not something we can even
>>> consider at the moment for obvious reasons (neither would you want us
>>> to.)
>>>
>>> Can you make this part of a patch series that actually adds a user,
>>> probably more than one, so that we can see if any of this even makes
>>> sense?
>> I'm very keen to see this as well. The way that the IOMMU drivers are
>> enlightened to hook into your memory pool will likely be similar to how
>> they would hook into my proposal of an in-memory filesystem.
>> Do you have code available showing the IOMMU integration?
>>
> No, I don't have such a code yet.
> But I was thinking that using such a allocator in the mempool allows
> to hide this implementation under the hood of an existent generic
> mechanism, which is then can be used to create persistent objects (file
> system, for example) on top of it.


Unfortunately it's practically impossible to have a solid conversation 
on generic mechanisms without actual users to see how they fit in with 
the real world. That's Greg's answer to your patch set and I tend to 
agree. What if (b) or (c) turn out much more viable? Then we've wasted a 
lot of effort in shaping up the allocator for no good reason.


>
>>>>   drivers/misc/Kconfig   |    7 +
>>>>   drivers/misc/Makefile  |    1
>>>>   drivers/misc/pmpool.c  |  270 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>>   include/linux/pmpool.h |   20 ++++
>>>>   4 files changed, 298 insertions(+)
>>>>   create mode 100644 drivers/misc/pmpool.c
>>>>   create mode 100644 include/linux/pmpool.h
>>> misc is not for memory pools, as this is not a driver.  please put this
>>> in the properly location instead of trying to hide it from the mm
>>> maintainers and subsystem :)
>> One of the reasons I thought a proper filesystem would be a better way
>> of exposing this functionality.
>>
> Yes, I see the point of having a file system for the goals you are
> targeting. It looks like the right way forward.
>
> What I'm not sure about is that persistent-over-kexec memory management and
> the actual preservation mechanism should be an embedded part of this file
> system.
>
> What I'm trying to propose is a part of a generic mechanism to provide
> state persistence across kexec, which can then be used by your file
> system or something else.
>
> What do you think about this approach?


IMHO we need to at least prototype each of the paths outlined above to 
be able to create a sense for what works the best. I can see problems 
with all of them - and I'm personally not convinced there will be a 
one-size-fits-all solution yet.

That said, I am happy to see you pursue similar paths to what we have in 
mind. It means there is a real gap in functionality in Linux kexec that 
we need to overcome sooner or later.


Alex





Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
