Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73835C4332F
	for <kexec@archiver.kernel.org>; Thu, 14 Dec 2023 14:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=djYn9WbOap921VMlsntfgyzfULsKU9Z6hI5ucnPnBus=; b=2tmQb+8bhbMlsrbzLU75JltBzC
	5Oq6tSY9aIJClo6QKAZI1GNslHYkMiER1KV2eVd7YuHhtYZA7x7R8HWFgbm7+m/BFTtHTesgf1Lre
	OHjZCdZSbgl4DZWi60nJYcv1BMSnkWv47xmRnJf7vS+wPrR8WO9DJOBau69VJ4SBEDQs8o45qnOOj
	3ap+G13Wv3bwB3JC3TaUenApgJZLhVRHr0qc2BxTYu6nAXuloVc6mJK8Eg746nqsaON0r/lKnK2au
	KIRIJ5sh8HhDuZgBGmQbUvAz5NX+fgM3xCR9dRpe7F+yTQ7iK222pnqiEt8gKTuN1r2edkXuMtUbR
	ZPxKmTMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDnBT-000bcT-0r;
	Thu, 14 Dec 2023 14:59:31 +0000
Received: from out03.mta.xmission.com ([166.70.13.233])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDnBO-000bZ4-2w;
	Thu, 14 Dec 2023 14:59:29 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:55106)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rDnBD-00298x-8O; Thu, 14 Dec 2023 07:59:15 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:48054 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rDnBC-009bes-10; Thu, 14 Dec 2023 07:59:14 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Alexander Graf <graf@amazon.com>
Cc: <linux-kernel@vger.kernel.org>,  <linux-trace-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <devicetree@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>,  <kexec@lists.infradead.org>,
  <linux-doc@vger.kernel.org>,  <x86@kernel.org>,  "H. Peter Anvin"
 <hpa@zytor.com>,  Andy Lutomirski <luto@kernel.org>,  Peter Zijlstra
 <peterz@infradead.org>,  "Rob Herring" <robh+dt@kernel.org>,  Steven
 Rostedt <rostedt@goodmis.org>,  "Andrew Morton"
 <akpm@linux-foundation.org>,  Mark Rutland <mark.rutland@arm.com>,  "Tom
 Lendacky" <thomas.lendacky@amd.com>,  Ashish Kalra <ashish.kalra@amd.com>,
  James Gowans <jgowans@amazon.com>,  Stanislav Kinsburskii
 <skinsburskii@linux.microsoft.com>,  <arnd@arndb.de>,
  <pbonzini@redhat.com>,  <madvenka@linux.microsoft.com>,  Anthony Yznaga
 <anthony.yznaga@oracle.com>,  Usama Arif <usama.arif@bytedance.com>,
  David Woodhouse <dwmw@amazon.co.uk>,  Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
References: <20231213000452.88295-1-graf@amazon.com>
Date: Thu, 14 Dec 2023 08:58:49 -0600
In-Reply-To: <20231213000452.88295-1-graf@amazon.com> (Alexander Graf's
	message of "Wed, 13 Dec 2023 00:04:37 +0000")
Message-ID: <87r0jo7rva.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1rDnBC-009bes-10;;;mid=<87r0jo7rva.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/OhbNhEazZ4D40H/sN4yD6DjQIF1U06u0=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 00/15] kexec: Allow preservation of ftrace buffers
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_065926_972666_6DF355A2 
X-CRM114-Status: GOOD (  37.01  )
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

Alexander Graf <graf@amazon.com> writes:

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

What you are describe in many ways is the same problem as
kexec-on-panic.  The goal of leaving devices running absolutely requires
carving out memory for the new kernel to live in while it is coming up
so that DMA from a device that was not shutdown down does not stomp the
kernel coming up.

If I understand the virtualization case some of those virtual machines
are going to have virtual NICs that are going to want to DMA memory to
the host system.  Which if I understand things correctly means that
among the devices you explicitly want to keep running there is a not
a way to avoid the chance of DMA coming in while the kernel is being
changed.

There is also a huge maintenance challenge associated with all of this.

If you go with something that is essentially kexec-on-panic and then
add a little bit to help find things in the memory of the previous
kernel while the new kernel is coming up I can see it as a possibility.

As an example I think preserving ftrace data of kexec seems bizarre.
I don't see how that is an interesting use case at all.  Not in
the situation of preserving virtual machines, and not in the situation
of kexec on panic.

If you are doing an orderly shutdown and kernel switch you should be
able to manually change the memory.  If you are not doing an orderly
shutdown then I really don't get it.

I don't hate the capability you are trying to build.

I have not read or looked at most of this so I am probably
missing subtle details.

As you are currently describing things I have the sense you have
completely misframed the problem and are trying to solve the wrong parts
of the problem.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
