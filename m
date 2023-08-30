Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7D4C6FA8F
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 07:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9DFCCCNhlh6Z220Xx/fWJ2y17aIv4wBX1Wluf+XAG1Q=; b=Rj9WToskcZ5ZZ2
	er/enIUMap5vZzhZjWYwqhg80cABEjoDLKsgAT//EfWTl+Vd0eZ5jWpEgpQMVcK2Uz1o8w47a9Et6
	pJ+i5pVZJJ7iCHRg37WV++NCj6Ricb92m08pcVzAEcQPer6+elrGNJ5UROQNocFS04PNg1SGUrBv8
	S5tPHjuGjvZd1UbrfhTWjixREKJhyIaEeaF7y/3B7nWTBUCsdz+ayJDishExr9rVSIM2ivERY9tsH
	NoTf1WYdO44j9xIawY1Fx2tXQU7z7l/dMxlKx91MaJ8IEcJDPIRuNeNDi1mTK0+TkhGvNIw6cE/A7
	mNLnH5OX/7azhHbUx7DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbFVi-00Cyy9-1D;
	Wed, 30 Aug 2023 07:21:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbFVg-00Cyy0-2y
	for kexec@bombadil.infradead.org;
	Wed, 30 Aug 2023 07:21:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=WqdW8Qj2xK46E3UyrwcROMadSGBZGtNxIQEEI9MRaS0=; b=c1uaBcALm0xLsy1gVXFwtj8a5Q
	enQPUI8Ko2pNZw4fLIXpDbdzhRKVV8HvVXlSLQouu4X9a2ZI+o52Pvf1lWNxmceB7lPwQ9jNqwafg
	R7LirHs/XTCk6+hbyc+z/Y2xH3oAdySVaT5BUZJC5F4MYAmBIhCQ0Irr1gWTrj0CIHROVf2MNrvyw
	fh9Kr0iaiW0DIJ8mSI0ev0GGdOJaaryMhVThBxvccA3ULjd/atLUmWOROsoVMIOu4+1v6t2Pb7vxP
	clHaW/fJlCWZqgD/EGys31tz/jaOno8QJEtx5IrKo/FNPv1C4d9ecLLDi/H4o+1aifydz9L18hVRa
	JwiNyzlg==;
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbFVb-00CChv-1G
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 07:21:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1693380059; x=1724916059;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WqdW8Qj2xK46E3UyrwcROMadSGBZGtNxIQEEI9MRaS0=;
  b=g+SzTqOxm7USjJ/cM5MLhrR21W1Lhwg1gqrCKtc8QdKuCPhgOpDYjTpY
   Mq59OWc8LhG1CHEsAX1mYdYka/j12NaEwhbiThMa5TasC/P1LnwTsmJqF
   75/Lu6c1mOc3Ku87BVU4x3MdPPwxEqLVoe+4eMNEit1CdlkTWGTV2+79a
   4=;
X-IronPort-AV: E=Sophos;i="6.02,212,1688428800"; 
   d="scan'208";a="25907343"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 07:20:50 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-b1c0e1d0.us-west-2.amazon.com (Postfix) with ESMTPS id 319AF806B6;
	Wed, 30 Aug 2023 07:20:49 +0000 (UTC)
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 30 Aug 2023 07:20:41 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 30 Aug
 2023 07:20:37 +0000
Message-ID: <82416797-01aa-471a-a737-471297e37c4c@amazon.de>
Date: Wed, 30 Aug 2023 09:20:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] Introduce persistent memory pool
Content-Language: en-GB
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC: "Gowans, James" <jgowans@amazon.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "rppt@kernel.org" <rppt@kernel.org>,
	"madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"stanislav.kinsburskii@gmail.com" <stanislav.kinsburskii@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>,
	"dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"derek.kiernan@amd.com" <derek.kiernan@amd.com>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
	<kexec@lists.infradead.org>, <iommu@lists.linux.dev>, kvm
	<kvm@vger.kernel.org>
References: <64e7cbf7.050a0220.114c7.b70dSMTPIN_ADDED_BROKEN@mx.google.com>
 <2023082506-enchanted-tripping-d1d5@gregkh>
 <c26ad989dcc6737dd295e980c78ef53740098810.camel@amazon.com>
 <20230823024500.GA25462@skinsburskii.>
 <e0ed9fb9-8e7a-44ad-976a-27362f6e537a@amazon.de>
 <20230829220740.GA26605@skinsburskii.>
From: Alexander Graf <graf@amazon.de>
In-Reply-To: <20230829220740.GA26605@skinsburskii.>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_082100_038827_6C8C0FF9 
X-CRM114-Status: GOOD (  48.04  )
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

Hi Stanislav,

On 30.08.23 00:07, Stanislav Kinsburskii wrote:
>
> On Mon, Aug 28, 2023 at 10:50:19PM +0200, Alexander Graf wrote:
>> +kexec, iommu, kvm
>>
>> On 23.08.23 04:45, Stanislav Kinsburskii wrote:
>>> +akpm, +linux-mm
>>>
>>> On Fri, Aug 25, 2023 at 01:32:40PM +0000, Gowans, James wrote:
>>>> On Fri, 2023-08-25 at 10:05 +0200, Greg Kroah-Hartman wrote:
>>>>
>>>> Thanks for adding me to this thread Greg!
>>>>
>>>>> On Tue, Aug 22, 2023 at 11:34:34AM -0700, Stanislav Kinsburskii wrote:
>>>>>> This patch addresses the need for a memory allocator dedicated to
>>>>>> persistent memory within the kernel. This allocator will preserve
>>>>>> kernel-specific states like DMA passthrough device states, IOMMU state, and
>>>>>> more across kexec.
>>>>>> The proposed solution offers a foundational implementation for potential
>>>>>> custom solutions that might follow. Though the implementation is
>>>>>> intentionally kept concise and straightforward to foster discussion and
>>>>>> feedback, it's fully functional in its current state.
>>>> Hi Stanislav, it looks like we're working on similar things. I'm looking
>>>> to develop a mechanism to support hypervisor live update for when KVM is
>>>> running VMs with PCI device passthrough. VMs with device passthrough
>>>> also necessitates passing and re-hydrating IOMMU state so that DMA can
>>>> continue during live update.
>>>>
>>>> Planning on having an LPC session on this topic:
>>>> https://lpc.events/event/17/abstracts/1629/ (currently it's only a
>>>> submitted abstract so not sure if visible, hopefully it will be soon).
>>>>
>>>> We are looking at implementing persistence across kexec via an in-memory
>>>> filesystem on top of reserved memory. This would have files for anything
>>>> that needs to be persisted. That includes files for IOMMU pgtables, for
>>>> guest memory or userspace-accessible memory.
>>>>
>>>> It may be nice to solve all kexec persistence requirements with one
>>>> solution, but we can consider IOMMU separately. There are at least three
>>>> ways that this can be done:
>>>> a) carving out reserved memory for pgtables. This is done by your
>>>> proposal here, as well as my suggestion of a filesystem.
>>>> b) pre/post kexec hooks for drivers to serialise state and pass it
>>>> across in a structured format from old to new kernel.
>>>> c) Reconstructing IOMMU state in the new kernel by starting at the
>>>> hardware registers and walking the page tables. No state passing needed.
>>>>
>>>> Have you considered option (b) and (c) here? One of the implications of
>>>> (b) and (c) are that they would need to hook into the buddy allocator
>>>> really early to be able to carve out the reconstructed page tables
>>>> before the allocator is used. Similar to how pkram [0] hooks in early to
>>>> carve out pages used for its filesystem.
>>>>
>>> Hi James,
>>>
>>> We are indeed working on similar things, so thanks for chiming in.
>>> I've seen pkram proposal as well as your comments there.
>>>
>>> I think (b) will need some persistent-over-kexec memory to pass the
>>> state across kexec as well as some key-value store persisted as well.
>>> And the proposed persistent memory pool is aimed exactly for this
>>> purpose.
>>> Or do you imply some other way to pass driver's data accross kexec?
>>
>> If I had to build this, I'd probably do it just like device tree passing on
>> ARM. It's a single, physically contiguous blob of data whose entry point you
>> pass to the target kernel. IIRC ACPI passing works similarly. This would
>> just be one more opaque data structure that then needs very strict
>> versioning and forward/backward compat guarantees.
>>
> Device tree or ACPI are options indeed. However AFAIU in case of DT user
> space has to involved into the picture to modify and complie it, while
> ACPI isn't flexible or easily extendable.
> Also, AFAIU both these standards were designed with passing
> hardware-specific data in mind from bootstrap software to an OS kernel
> and thus were never really intended to be used for creating a persistent
> state accross kexec.
> To me, an attempt to use either of them to pass kernel-specific data looks
> like an abuse (or misuse) excused by the simplicity of implementation.


What I was describing above is that the Linux boot protocol already has 
natural ways to pass a DT (arm) or set of ACPI tables (x86) to the 
target kernel. Whatever we do here should either piggy back on top of 
those natural mechanisms (e.g. /chosen node in DT) or be on the same 
level (e.g. pass DT in one register, pass metadata structure in another 
register).

When it comes to the actual content of the metadata, I'm personally also 
leaning towards DT. We already have libfdt inside the kernel. It gives 
is a very simple, well understood structured file format that you can 
extend, version, etc etc. And the kernel has mechanisms to modify fdt 
contents.


>
>>> I dind't consider (c) yet, thanks for for the pointer.
>>>
>>> I have a question in this scope: how is PCI devices registers state is persisted
>>> across kexec with the files system you are working on? I.e. how does
>>> driver know, that the device shouldn't not be reinitialized?
>>
>> The easiest way to do it initially would be kernel command line options that
>> hack up the drivers. But I suppose depending on the option we go with, you
>> can also use the respective "natural" path:
>>
>> (a) A special metadata file that explains the state to the driver
>> (b) An entry in the structured file format that explains the state to the
>> target driver
>> (c) Compatible target drivers try to enumerate state from the target
>> device's register file
>>
> Command line option is the simplest way to go indeed, but from my POV
> it's good only for pointing to a particualr object, which is persisted
> somehow else. But it we have a persistence mechanism, then I think we
> can make another step forward and don't use command line at all (which
> is a bit cumbersome and errorprone due to it's human-readable and
> serialized nature).
>
> I'm leaning towards some kind of "natural" path you mentioned... I guess
> I'm a bit confused with the word "file" here, as it sounds line it
> implies a file system driver, and I'm not sure that's what we want for
> driver specific data.


Oh, I was just referring to the set of registers a device exposes :).


>
>>>>>> Potential applications include:
>>>>>>
>>>>>>     1. Allowing various in-kernel entities to allocate persistent pages from
>>>>>>        a singular memory pool, eliminating the need for multiple region
>>>>>>        reservations.
>>>>>>
>>>>>>     2. For in-kernel components that require the allocation address to be
>>>>>>        available on kernel kexec, this address can be exposed to user space and
>>>>>>        then passed via the command line.
>>>> Do you have specific examples of other state that needs to be passed
>>>> across? Trying to see whether tailoring specifically to the IOMMU case
>>>> is okay. Conceptually IOMMU state can be reconstructed starting with
>>>> hardware registers, not needing reserved memory. Other use-cases may not
>>>> have this option.
>>>>
>>> Well, basically it's IOMMU state and PCI devices to skip/avoid
>>> initializing.
>>> I bet there can be other misc (and unrelated things) like persistent
>>> filesystems, block devices, etc. But I don't have a solid set of use
>>> cases to present.
>>
>> Would be great if you could think through the problem space until LPC so we
>> can have a solid conversation there :)
>>
> Yeah, I have a few ideas I'll try to implement and share before LPC.
> Unfortunatelly I'm not planning to attend it this year, so this
> conversation will be without me.
> But I'll do my best to provide as much content to discuss as I can.


Thanks, looking forward to it! :)


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
