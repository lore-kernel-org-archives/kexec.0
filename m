Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35527C4332F
	for <kexec@archiver.kernel.org>; Thu, 14 Dec 2023 16:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=73YtiJhAHCUvHobY1O0JV0AXSd+vJtM6IaLNBGaR8uY=; b=J+tT9dJCFL/Xoq
	lnzOKjQkAMW+8xOC+Td273eAReQD31SEaX7yMVC8f+AsOGmNrM/HcbSoymN71Akud4+xHinuuBUON
	pqWRnLdIHegspGRi3nWxgQN4QByDFil1vJR1kpdaEZVyA7gnn7WzMg5oqt29ZFsuc7KrJIMDZgbJf
	fEUpZWDFUEfJRuQfpQdkKWWAc9DbE7dov1LgPCz0txiiQpFN8HS7+1NG4i/IAH8DZo3ljAtALi7X/
	3kvX03axdwdgI/u87YIRN6rGn83+S2C+eEb1+o/NfhoIUAd0rMgHixmtyqyw1edSRbmrgxrqbIfKe
	OnoVEBDNqhNDQyUiEeMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDoBM-000kUn-1A;
	Thu, 14 Dec 2023 16:03:28 +0000
Received: from smtp-fw-9105.amazon.com ([207.171.188.204])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDoBJ-000kTt-1V;
	Thu, 14 Dec 2023 16:03:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702569805; x=1734105805;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pDhGMsdbTPhZPhAbCsDPbEbUZg1RUebxvn8D4u7VLXY=;
  b=Mc3ho3CT3ut7HCdUPTmUS6wWH9cRlsXXX2NFobSsLTB8x1lQOaDW7Bhq
   lPY474PkkMHe+w8iBAplA4IIv2goQQWp7whqzRLl+j5XoMkLhj8xiYZWU
   +s/G1qiRAxujtLQWAjsicOnmOHMgNnmwMJh5s6yPNqj0Y3ohroK89Z0Ym
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,276,1695686400"; 
   d="scan'208";a="691149109"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 16:03:00 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com (Postfix) with ESMTPS id 5CCD1EA853;
	Thu, 14 Dec 2023 16:02:52 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:2741]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.243:2525] with esmtp (Farcaster)
 id 8718254b-3303-4f97-9d78-8bc42d03c88f; Thu, 14 Dec 2023 16:02:51 +0000 (UTC)
X-Farcaster-Flow-ID: 8718254b-3303-4f97-9d78-8bc42d03c88f
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 16:02:48 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Dec
 2023 16:02:42 +0000
Message-ID: <c0f89d9d-98c3-4b04-9077-d92a863db088@amazon.com>
Date: Thu, 14 Dec 2023 17:02:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] kexec: Allow preservation of ftrace buffers
Content-Language: en-US
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
References: <20231213000452.88295-1-graf@amazon.com>
 <87r0jo7rva.fsf@email.froward.int.ebiederm.org>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <87r0jo7rva.fsf@email.froward.int.ebiederm.org>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_080325_567343_F827A26A 
X-CRM114-Status: GOOD (  54.57  )
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

Hey Eric,

On 14.12.23 15:58, Eric W. Biederman wrote:
> Alexander Graf <graf@amazon.com> writes:
>
>> Kexec today considers itself purely a boot loader: When we enter the new
>> kernel, any state the previous kernel left behind is irrelevant and the
>> new kernel reinitializes the system.
>>
>> However, there are use cases where this mode of operation is not what we
>> actually want. In virtualization hosts for example, we want to use kexec
>> to update the host kernel while virtual machine memory stays untouched.
>> When we add device assignment to the mix, we also need to ensure that
>> IOMMU and VFIO states are untouched. If we add PCIe peer to peer DMA, we
>> need to do the same for the PCI subsystem. If we want to kexec while an
>> SEV-SNP enabled virtual machine is running, we need to preserve the VM
>> context pages and physical memory. See James' and my Linux Plumbers
>> Conference 2023 presentation for details:
>>
>>    https://lpc.events/event/17/contributions/1485/
>>
>> To start us on the journey to support all the use cases above, this
>> patch implements basic infrastructure to allow hand over of kernel state
>> across kexec (Kexec HandOver, aka KHO). As example target, we use ftrace:
>> With this patch set applied, you can read ftrace records from the
>> pre-kexec environment in your post-kexec one. This creates a very powerful
>> debugging and performance analysis tool for kexec. It's also slightly
>> easier to reason about than full blown VFIO state preservation.
>>
>> == Alternatives ==
>>
>> There are alternative approaches to (parts of) the problems above:
>>
>>    * Memory Pools [1] - preallocated persistent memory region + allocator
>>    * PRMEM [2] - resizable persistent memory regions with fixed metadata
>>                  pointer on the kernel command line + allocator
>>    * Pkernfs [3] - preallocated file system for in-kernel data with fixed
>>                    address location on the kernel command line
>>    * PKRAM [4] - handover of user space pages using a fixed metadata page
>>                  specified via command line
>>
>> All of the approaches above fundamentally have the same problem: They
>> require the administrator to explicitly carve out a physical memory
>> location because they have no mechanism outside of the kernel command
>> line to pass data (including memory reservations) between kexec'ing
>> kernels.
>>
>> KHO provides that base foundation. We will determine later whether we
>> still need any of the approaches above for fast bulk memory handover of for
>> example IOMMU page tables. But IMHO they would all be users of KHO, with
>> KHO providing the foundational primitive to pass metadata and bulk memory
>> reservations as well as provide easy versioning for data.
> What you are describe in many ways is the same problem as
> kexec-on-panic.  The goal of leaving devices running absolutely requires
> carving out memory for the new kernel to live in while it is coming up
> so that DMA from a device that was not shutdown down does not stomp the
> kernel coming up.


Yes, part of the problem is similar: We need a safe space to boot from 
that doesn't overwrite existing data. What happens after is different: 
With panics, you're trying to rescue previous state for post-mortem 
analysis. You may even have intrinsic knowledge of the environment you 
came from, so you can optimize that rescuing. Nobody wants to continue 
running the system as if nothing happened after a panic.

With KHO, the kernels establish an ABI between each other to communicate 
any state that needs to get preserved and the rest gets reinitialized. 
After KHO, the new kernel continues executing workloads that were 
running before.

The ABI is important because the next environment may not have a chance 
to know about the previous environment's setup. Think for example of 
roll-out and roll-back scenarios: If I roll back into my previous 
environment because I determined something didn't work as expected after 
update, I'm moving the system into an environment that was built when 
the kexec source environment didn't even exist yet.


> If I understand the virtualization case some of those virtual machines
> are going to have virtual NICs that are going to want to DMA memory to
> the host system.  Which if I understand things correctly means that


No, to the *guest* system. This is about device assignment: The guest is 
in full control of the NICs that do DMA, so we have no chance to quiesce 
them.


> among the devices you explicitly want to keep running there is a not
> a way to avoid the chance of DMA coming in while the kernel is being
> changed.


Correct, because the host doesn't own the driver :).


> There is also a huge maintenance challenge associated with all of this.
>
> If you go with something that is essentially kexec-on-panic and then
> add a little bit to help find things in the memory of the previous
> kernel while the new kernel is coming up I can see it as a possibility.


That's roughly what the patch set is doing, yes. It avoids a static 
allocation ahead of time for next-kernel memory, because I only know the 
size of all components when we're actually doing the kexec. But the 
principle is similar.

The bit where the new kernel finds bits in the old memory is the KHO DT: 
A flattened device tree structure the old kernel passes to the new 
kernel. That contains all memory locations as well as additional 
metadata to "help find things" in a way that doesn't immediately break 
on every kernel change.


> As an example I think preserving ftrace data of kexec seems bizarre.
> I don't see how that is an interesting use case at all.  Not in
> the situation of preserving virtual machines, and not in the situation
> of kexec on panic.


It's super useful as self debugging aid: I already used it to profile 
the kexec path to find a few performance issues :). It's also really 
helpful - even without device assignment support yet - when you use it 
in combination with KVM trace points: You have a VM running backed by a 
DAX pmem device, then serialize its virtual device state, kexec, restore 
from the virtual device state, then the VM misbehaves.

With ftrace handover in place, you get a full trace of the flow which 
simplifies debugging of issues that happen during/because of the 
serialization/deserialization flow of KVM state.

But the main reason I chose ftrace to start with is that all other use 
cases require another concept: fd preservation. All the typical 
"objects" you want to preserve across kexec are anonymous file 
descriptors. So we need to also build a way in Linux that allows user 
space to request the kernel to preserve an fd using the kexec handover 
framework in this patch set. But that is another big discussion I wanted 
to keep separate: Ftrace is from kernel, to kernel and hence "easy".


> If you are doing an orderly shutdown and kernel switch you should be
> able to manually change the memory.  If you are not doing an orderly
> shutdown then I really don't get it.


I don't follow the paragraph above?


> I don't hate the capability you are trying to build.
>
> I have not read or looked at most of this so I am probably
> missing subtle details.
>
> As you are currently describing things I have the sense you have
> completely misframed the problem and are trying to solve the wrong parts
> of the problem.


Very well possible :). I hope the above clarifies it a bit. If not, 
please let me know where exactly it's unclear so I can elaborate.

If you have a few minutes, it would also be great if you could have a 
look at our slides [1] or even video [2] from LPC 2023 which go into 
detail of the end problem. Beware that I'm consciously *not* trying to 
solve the end problem yet: I want to take baby steps towards it. Nobody 
wants to review an 80 patches patch set where everything depends on 
everything else.


Alex


[1] 
https://lpc.events/event/17/contributions/1485/attachments/1296/2650/jgowans-preserving-across-kexec.pdf
[2] https://www.youtube.com/watch?v=cYrlV4bK1Y4




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
