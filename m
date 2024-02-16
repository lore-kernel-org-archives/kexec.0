Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F6CC48260
	for <kexec@archiver.kernel.org>; Fri, 16 Feb 2024 15:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1i/7lZOjFNe9DBQJrtP0NFgUHMwBoYfx+v3015Xvpj0=; b=ZOLXSP8nhyj4GB
	9G+ur6Af4kMMnuAXWVLkN/yBJpQNvP05XXht5WweCQS9BjgHCVh5Ib//SaYcdoEdNVxwH7EohScY1
	DerG0BMD9K/uNIbFN3x+QnDdA8iQFQJCmjFTu7O/U5TzPJQTaO0PPWUeURPwYPyQ9/q/4rSTv25rM
	Nh4nJUT4+rTcuWDCaNvwij1DAdJGFQVtkzhi2emlCn+T0m04v/XgDpnEJfNQvs7nuGvanxSFVPnqh
	w6GXyY6eq0IjI/lJoUgMNJqaWZEzdQKInEKK5ba1UcTDvyxWi8Hn3ydYjAtTkfdrCk58jp6zAQLXC
	SpKjxhWKc77RTX/obelw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb0Ai-00000002oZQ-3pOc;
	Fri, 16 Feb 2024 15:30:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb0Ae-00000002oXx-3fnj;
	Fri, 16 Feb 2024 15:30:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:CC:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F/Eio/BjkBDvnj7lgXtt9GlxdtOY8F3NsfX7BbAdrZU=; b=TDiJaPt0wx30R4Ko0vDmEvIEi+
	dCJZTrevOXv0LUC/M5MUWJgHjHryqcBuJ8Yy5kONoZ2IXCgQCdOle6D5MOOHOrSYYUiMojsLyKc/i
	y+hPWWB3+hNZiZQSFWjNUM3hg2awh9rh4l/MdA+oCjADffJmhNZ1OQ2xyIM6OROvkzFfD4wZ9ulbv
	dv6nwj6thqHBeCJBnZo941mYfDjWJIfQqb1tAqE21fzGvcIIRi1gYrdGlOv6XVmcGavg+XPTeqV58
	HmfIGNLrbzlvj/3JiHsiKDZKm0VnyYajyOyWAw7AsXcIAgfLjTQmZQScXzmTH7FBt0Rz9G8HBEyPy
	pzPpi8nA==;
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb0AZ-0000000HXJz-22Gz;
	Fri, 16 Feb 2024 15:30:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1708097432; x=1739633432;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=F/Eio/BjkBDvnj7lgXtt9GlxdtOY8F3NsfX7BbAdrZU=;
  b=QCAMY7/tBOaGdJeqGl4KGLERsh7h6OpAmYAjYRjj6gqJKjOVsqMp4EH5
   WrbcA0YL7TZBdTemyhf2WfRAmnFBy7xKSnuNNNhL+sjNWaJjGAa3abA4u
   uZGzvEi/05t+1BBRwvp51Rqy6hUwGDmAHTPQwawRLEoN+fYIQo0eJS1CC
   8=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="327439017"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 15:29:52 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:25817]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.203:2525] with esmtp (Farcaster)
 id 745c92d6-d758-4d02-8839-5255b61b4613; Fri, 16 Feb 2024 15:29:51 +0000 (UTC)
X-Farcaster-Flow-ID: 745c92d6-d758-4d02-8839-5255b61b4613
Received: from EX19D020UWC001.ant.amazon.com (10.13.138.157) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 15:29:44 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D020UWC001.ant.amazon.com (10.13.138.157) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 15:29:44 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 16 Feb 2024 15:29:44 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id A785620CE8; Fri, 16 Feb 2024 16:29:43 +0100 (CET)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Alexander Graf <graf@amazon.com>
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
Subject: Re: [PATCH v3 00/17] kexec: Allow preservation of ftrace buffers
In-Reply-To: <20240117144704.602-1-graf@amazon.com> (Alexander Graf's message
	of "Wed, 17 Jan 2024 14:46:47 +0000")
References: <20240117144704.602-1-graf@amazon.com>
Date: Fri, 16 Feb 2024 16:29:43 +0100
Message-ID: <mafs0zfw08m1k.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_153032_823064_25AB28C8 
X-CRM114-Status: GOOD (  51.71  )
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

Hi Alex,

On Wed, Jan 17 2024, Alexander Graf wrote:

> Kexec today considers itself purely a boot loader: When we enter the new
> kernel, any state the previous kernel left behind is irrelevant and the
> new kernel reinitializes the system.
>
> However, there are use cases where this mode of operation is not what we
> actually want. In virtualization hosts for example, we want to use kexec
> to update the host kernel while virtual machine memory stays untouched.
> When we add device assignment to the mix, we also need to ensure that
> IOMMU and VFIO states are untouched. If we add PCIe peer to peer DMA, we
> need to do the same for the PCI subsystem. If we want to kexec while an
> SEV-SNP enabled virtual machine is running, we need to preserve the VM
> context pages and physical memory. See James' and my Linux Plumbers
> Conference 2023 presentation for details:

I am working on handing userspace pages across kexec. This can be useful
for applications with large in-memory state that can be time consuming
to rebuild. If they can hand over their state over kexec, it allows for
kernel upgrades with lower downtime. As a part of this problem, I have
been looking at plugging all of this into CRIU [0] so I don't have to
modify the applications to use this feature. I can just use CRIU to do
the checkpoint and restore quickly over kexec.

I hacked together some patches for this (which are not yet polished
enough to publish) and ended up implementing something like KHO in a
much more crude way. I have since refactored my patches to use KHO and I
find it quite useful. So thanks for working on this :-)

It was easy enough to get KHO working with my patches though I had to
look into your ftrace patches to get the whole picture. The
documentation can be improved to show how it can be used from the
driver/subsystem perspective. For example, I had to read your ftrace
patches to figure out I should use kho_get_fdt(), or that I should
register a notifier via kho_register_notifier(). I would be happy to
contribute some documentation improvements.

Have you done any analysis on the performance or memory overhead? If
yes, it would be nice to look at some data. I have some concerns with
performance and memory overhead, especially for more fragmented memory
but I don't yet have numbers to present you.

[0] https://github.com/checkpoint-restore/criu

>
>   https://lpc.events/event/17/contributions/1485/
>
> To start us on the journey to support all the use cases above, this
> patch implements basic infrastructure to allow hand over of kernel state
> across kexec (Kexec HandOver, aka KHO). As example target, we use ftrace:
> With this patch set applied, you can read ftrace records from the
> pre-kexec environment in your post-kexec one. This creates a very powerful
> debugging and performance analysis tool for kexec. It's also slightly
> easier to reason about than full blown VFIO state preservation.
>
> == Alternatives ==
>
> There are alternative approaches to (parts of) the problems above:
>
>   * Memory Pools [1] - preallocated persistent memory region + allocator
>   * PRMEM [2] - resizable persistent memory regions with fixed metadata
>                 pointer on the kernel command line + allocator
>   * Pkernfs [3] - preallocated file system for in-kernel data with fixed
>                   address location on the kernel command line
>   * PKRAM [4] - handover of user space pages using a fixed metadata page
>                 specified via command line

FYI, you forgot to paste the links in v3 but I can find them from v2.

From all these options, PKRAM seems somewhat useful for my use case but
with CRIU it would need to copy all the application pages to the PKRAM
FS and would need at least as much free memory as application memory.

Instead, I have built a simple system that gives an API to userspace to
hand over its pages and to request them back. It then keeps track of the
PID and PA -> VA mappings (essentially a page table). This lets me keep
the pages in-place and avoid needing lots of free memory or expensive
copying. KHO plays a crucial role there in handing those pages and page
tables across to the next kernel.

The FDT format works fairly well for my use case. Since page tables are
a stable data structure, I don't need to worry about their format
changing between kernel versions and can directly pass them through.
This might not be true for many other data structures so subsystems
using those either need to serialize them to FDT or invent their own
serialization formats.

I also wonder how the "mem" array will work for more fragmented
allocations. It might grow very large with lots of scattered elements. I
wonder how both KHO's parsing and memblock will behave in this case. I
have not yet tried stressing it so I can't say for myself.

>
> All of the approaches above fundamentally have the same problem: They
> require the administrator to explicitly carve out a physical memory
> location because they have no mechanism outside of the kernel command
> line to pass data (including memory reservations) between kexec'ing
> kernels.
>
> KHO provides that base foundation. We will determine later whether we
> still need any of the approaches above for fast bulk memory handover of for
> example IOMMU page tables. But IMHO they would all be users of KHO, with
> KHO providing the foundational primitive to pass metadata and bulk memory
> reservations as well as provide easy versioning for data.
>
> == Overview ==
>
> We introduce a metadata file that the kernels pass between each other. How
> they pass it is architecture specific. The file's format is a Flattened
> Device Tree (fdt) which has a generator and parser already included in
> Linux. When the root user enables KHO through /sys/kernel/kho/active, the
> kernel invokes callbacks to every driver that supports KHO to serialize
> its state. When the actual kexec happens, the fdt is part of the image
> set that we boot into. In addition, we keep a "scratch region" available
> for kexec: A physically contiguous memory region that is guaranteed to
> not have any memory that KHO would preserve.  The new kernel bootstraps
> itself using the scratch region and sets all handed over memory as in use.
> When drivers initialize that support KHO, they introspect the fdt and
> recover their state from it. This includes memory reservations, where the
> driver can either discard or claim reservations.
>
> == Limitations ==
>
> I currently only implemented file based kexec. The kernel interfaces
> in the patch set are already in place to support user space kexec as well,
> but I have not implemented it yet inside kexec tools.
>
> == How to Use ==
>
> To use the code, please boot the kernel with the "kho_scratch=" command
> line parameter set: "kho_scratch=512M". KHO requires a scratch region.
>
> Make sure to fill ftrace with contents that you want to observe after
> kexec.  Then, before you invoke file based "kexec -l", activate KHO:
>
>   # echo 1 > /sys/kernel/kho/active
>   # kexec -l Image --initrd=initrd -s
>   # kexec -e
>
> The new kernel will boot up and contain the previous kernel's trace
> buffers in /sys/kernel/debug/tracing/trace.
>
[...]

Overall, I think KHO is quite useful and I would be happy to see it
evolve and eventually make it into the kernel. It would certainly make
my life a lot easier.

Since I have used it in my patches, I have done some basic testing for
it. Nothing fancy, just handed a few pages across. It works as
advertised. For that,

Tested-by: Pratyush Yadav <ptyadav@amazon.de>

-- 
Regards,
Pratyush Yadav



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
