Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4508BC48297
	for <kexec@archiver.kernel.org>; Tue,  6 Feb 2024 13:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WRrRGNULZAs3waU4ps1diWqTD7as6eoIxNFrHAbIzYw=; b=GEpCIq7T5/q0lG
	4zGFmPZSMYNJrRg6WlHqZbeXGWKbKLCXrdYGmdmII4uE4nMkWxgcUW4m7i5iIxep10Ou6LDIg6peZ
	UXbJc6RKYY1dlFrsKk70XWM6qcU6Axucq4Gv5zwVqSVW6oJPuakoRfxcWsRgRU0OrsgoZfnrp+0dA
	4IpF+WTQscoqQNJUoOnnJVl6fcTvNSAPf1/A56SWaif+ccAuRKeSxJoIe1RUnuhlhTfXEbLcFxJgb
	6+JtxeP7GDllW+leYDt9uT8zZKsAtQgWcWNnWrlRZNuPPS4zpl+Na5NYIJsE+ZEzvMOF36OLtQiC6
	eKGci6EQ24mJFuzkVDRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXLjc-00000007l6C-3AZU;
	Tue, 06 Feb 2024 13:43:36 +0000
Received: from smtp-fw-80009.amazon.com ([99.78.197.220])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXLjV-00000007l2a-3SQp;
	Tue, 06 Feb 2024 13:43:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707227009; x=1738763009;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3PVinF+1/FzQadTueb/6gaePwQtYz50Y+ULO5KVmGA4=;
  b=QNBXDWs7inlOEWt4bNPoY/85vzQFSWYhNlaCBrg27pKML9ps8KnbeWPp
   mF85X7EgeSz2H0Ue34p6Qw3ioI7ycR2Am6Iuyxz0XjXFihaav8OiWzlu3
   tkZPYplMdmeU2nOrP1mIi6vLP4XHYissh5Sb9MEMwLFE6mT+DgiVhtykq
   M=;
X-IronPort-AV: E=Sophos;i="6.05,247,1701129600"; 
   d="scan'208";a="64055192"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 13:43:24 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:48152]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.177:2525] with esmtp (Farcaster)
 id 28ed5207-8056-4dc0-b7b9-869e672b3acd; Tue, 6 Feb 2024 13:43:23 +0000 (UTC)
X-Farcaster-Flow-ID: 28ed5207-8056-4dc0-b7b9-869e672b3acd
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 6 Feb 2024 13:43:23 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 13:43:17 +0000
Message-ID: <c7157097-4727-4360-80a0-20e7d8015e13@amazon.com>
Date: Tue, 6 Feb 2024 14:43:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/17] kexec: Allow preservation of ftrace buffers
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
	<rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>
References: <20240117144704.602-1-graf@amazon.com>
 <ZcHrIJ7lxpbkm5sc@pengutronix.de>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <ZcHrIJ7lxpbkm5sc@pengutronix.de>
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_054329_944100_58DC04F9 
X-CRM114-Status: GOOD (  43.98  )
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

Hey Oleksij!

On 06.02.24 09:17, Oleksij Rempel wrote:
> Hi Alexander,
>
> Nice work!
>
> On Wed, Jan 17, 2024 at 02:46:47PM +0000, Alexander Graf wrote:
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
>>
>> == Overview ==
>>
>> We introduce a metadata file that the kernels pass between each other. How
>> they pass it is architecture specific. The file's format is a Flattened
>> Device Tree (fdt) which has a generator and parser already included in
>> Linux. When the root user enables KHO through /sys/kernel/kho/active, the
>> kernel invokes callbacks to every driver that supports KHO to serialize
>> its state. When the actual kexec happens, the fdt is part of the image
>> set that we boot into. In addition, we keep a "scratch region" available
>> for kexec: A physically contiguous memory region that is guaranteed to
>> not have any memory that KHO would preserve.  The new kernel bootstraps
>> itself using the scratch region and sets all handed over memory as in use.
>> When drivers initialize that support KHO, they introspect the fdt and
>> recover their state from it. This includes memory reservations, where the
>> driver can either discard or claim reservations.
>>
>> == Limitations ==
>>
>> I currently only implemented file based kexec. The kernel interfaces
>> in the patch set are already in place to support user space kexec as well,
>> but I have not implemented it yet inside kexec tools.
>>
>> == How to Use ==
>>
>> To use the code, please boot the kernel with the "kho_scratch=" command
>> line parameter set: "kho_scratch=512M". KHO requires a scratch region.
>>
>> Make sure to fill ftrace with contents that you want to observe after
>> kexec.  Then, before you invoke file based "kexec -l", activate KHO:
>>
>>    # echo 1 > /sys/kernel/kho/active
>>    # kexec -l Image --initrd=initrd -s
>>    # kexec -e
>>
>> The new kernel will boot up and contain the previous kernel's trace
>> buffers in /sys/kernel/debug/tracing/trace.
> Assuming:
> - we wont to start tracing as early as possible, before rootfs
>    or initrd would be able to configure it.
> - traces are stored on a different device, not RAM. For example NVMEM.
> - Location of NVMEM is different for different board types, but
>    bootloader is able to give the right configuration to the kernel.


Let me try to really understand what you're tracing here. Are we talking 
about exposing boot loader traces into Linux [1]? In that case, I think 
a mechanism like [2] is what you're looking for.

Or do you want to transfer genuine Linux ftrace traces? In that case, 
why would you want to store them outside of RAM?


>
> What would be the best, acceptable for mainline, way to provide this
> kind of configuration? At least part of this information do not
> describes devices or device states, this would not fit in to devicetree
> universe. Amount of possible information would not fit in to bootconfig
> too.


We have precedence for configuration in device tree: You can use device 
tree to describe partitions on a NAND device, you can use it to specify 
MAC address overrides of devices attached to USB, etc etc. At the end of 
the day when people say they don't want configuration in device tree, 
what they mean is that device tree should be a hand over data structure 
from firmware to kernel, not from OS integrator to kernel :). If your 
firmware is the place that knows about offsets and you need to pass 
those offsets, IMHO DT is a good fit.


> Other more or less overlapping use case I have in mind is a netbootable
> embedded system with a requirement to boot as fast as possible. Since
> bootloader already established a link and got all needed ip
> configuration, it would be able to hand over etherent controller and ip
> configuration states. Wille be the KHO the way to go for this use case?


That's an interesting one too. I would lean towards "try with normal 
device tree first" here as well. It's again a very clear case of 
"firmware wants to tell OS about things it knows, but the OS doesn't 
know" to me. That means device tree should be fine to describe it.


Alex

[1] https://www.youtube.com/watch?v=RaFm5FfzFaM / 
https://edk2.groups.io/g/devel/topic/91368904
[2] 
https://github.com/agraf/linux/commit/b1fe0c296ec923e9b1f544862b0eb9365a8da7cb

>
> Regards,
> Oleksij
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |



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
