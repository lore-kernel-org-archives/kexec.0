Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876EEC9830E
	for <kexec@archiver.kernel.org>; Thu, 24 Sep 2026 21:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NevIoRhVPx1e2+eEuK5IsXEei6EeRuHGTwV+ThnOoJ8=; b=X5wz20OAV5fMGxip7CGKPUGPlt
	r9uO9sJrcgQizPDWhuatPnXsX3IkAyrYwT1Ck8Hz8TgeEJXi5rFyXykH77j9TOX6xQl8IDNBtcAAc
	xUebiI64GVkX8/dW9Zd4jT8sZAU9iAhlc2VE+RKP2QAqcaDMbTvaJYfKyXXbt/AUAiKgwI6W2tmX0
	WnlhHlo1Ly/mgOFoId3gYu2YHjofQn5Au1nNH0q2kJIcpK3T2i8DW/f3DRcDwdTT3G6mc30ZzYmcy
	L885qAOszRNVks5FQY2Olh+85HmV9x9w8hsBrb5drceY5H9pF7ZICpTHZgatXrkC7ynGEGAAOglel
	fTUV7nSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9rTP-0000000CG36-3Mln;
	Thu, 24 Sep 2026 21:59:23 +0000
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9rTM-0000000CG2a-1Dd1
	for kexec@lists.infradead.org;
	Thu, 24 Sep 2026 21:59:21 +0000
Received: by mail-pz2-x10.google.com with SMTP id 41be03b00d2f7-cc1cea50dc0so47269a12.2
        for <kexec@lists.infradead.org>; Thu, 24 Sep 2026 14:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790287159; x=1790891959; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NevIoRhVPx1e2+eEuK5IsXEei6EeRuHGTwV+ThnOoJ8=;
        b=MWfpaNwTf/m1M5wovbtXrcTNxoafNUOTUrjN1xircHPFVqPGu/0AdYaE5XKK/3IJXJ
         pj0KCHV8eAWp7AmCeAW8jfmAUPgnNIKuqDVjdNwvm9cLbJsRwwk/vcxK9B5NnVioMnGq
         T7ktAluW9ilcW/LYAfmr2z95b4V8oCTKxWTG9IIWEQ+NJb1KBgqLB0zSVvhdsXLb/gNb
         WA4KGPwi0IoYczv15xF9D9mUmUtpvAcMbm+s0s60R0gVnx3/9Jw7L7QAvupcT78EhPnN
         TMBg5NP7HxMizDomJlvtWXOM8ZjdQiOpuB1jFbBTotmHHeGOjlWhs8klRkq8t3nYWvJJ
         FHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790287159; x=1790891959;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NevIoRhVPx1e2+eEuK5IsXEei6EeRuHGTwV+ThnOoJ8=;
        b=Uay4B1wHLxW6KYFaQbHPHqW2xT3h3cG5r8iqlc5fuBwmJHbKEod/T2FYI8m1lJ1Eif
         46+MZUwOIKSr0dy1nJtwQ9kTe2gwVX/KnQAYP3IyXD+tj1WuPnmLLFUsZLC1D/aXZArH
         JjGh1VkMrs1palFz731KEtwo/2jZrdZCKg7fpDdX1YI9uPGMsqiT/srdTxDUqzWCYHgh
         WQNYue/OLueLpcirSOmW09dI1mf+xI/AJKdoZdy0MTBCHvzSL2J5jSV2vL36gKzYLN5i
         Fbt/gd7F1V8uKhapbefMhqUom/EAeCG3h72ABwJfp3Wdx2DKx58CSxfvVQfD83t8Ai04
         4PBQ==
X-Gm-Message-State: AFuF++lZUQjD4aulCM4Q4J3z6A/ZsIfauMbdHpeyAzPQXBvsBtm2RGtT
	YopJDgZb7kdWe/JdIcCvyCWaClWZLfkXU6b6mvnBu9iRP/K5SXD2r6XuBD8XQAFjyg==
X-Gm-Gg: AYBFou0fGqIbl+/h5rFns/Gih+A+N13yAztLVioY3aLl/MM30tkd7NDIHdMGcZzaNe+
	UKHWQBittmB2hUP3iQTjiR4OaSvqsWJQ6TwLy7bnARIOpQ6FGVNooyS5IxDsJ84Q87astBvQcVT
	Tt545Rl/5Sg2huGZzJNrEh8kQ2y3UzjLW1f6DfFhZOXLdZuDE/hlj3U9eVxRm1V3fz1rUOxTyNN
	QfvIkhtr937um5bR4xGMSuYp6m2aYfIGCy+cVe8I9MFtxSwq0HG+7Mhkm+/q7e61QLyHEvdKbB+
	41vR/rWLnIM07uPXMaeRWIwdfJYJ7NBm8RRORTpF1iUbkNvTBrMVyux/69czhnYc4uyI51XlLNZ
	Nj71pcolH38btt67W+rZlnyH12e8YA4IpXN9BZ+b4Kr9tRyNmWgDneJLL1LFP21FQuwZv2yBvMa
	6QoDea3CjlOk9D8kB5oeul+BSz3zhSf/g3Sodw+ljQBLZMPo7nypjzfu1MEb8gnGkKwgGgUiyFx
	AIf/lfx3QynVfYB3nQ1/kjkEs8aOrH+SFInphZI
X-Received: by 2002:a05:6a20:548d:b0:3dd:a008:dc3e with SMTP id adf61e73a8af0-3de0e89e58bmr4338025637.44.1790287158837;
        Thu, 24 Sep 2026 14:59:18 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78791e4b3sm309308a12.17.2026.09.24.14.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 14:59:17 -0700 (PDT)
Date: Thu, 24 Sep 2026 21:59:11 +0000
From: David Matlack <dmatlack@google.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v9 00/13] PCI: liveupdate: PCI core support for Live
 Update
Message-ID: <arWdLyuHJwcU5tVn@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <2e88b92a-d3f2-41f7-bdbe-11fd71690606@linux.dev>
 <CALzav=eJU+fnPr-QN4s7gY_Lj8Pc3T6KXfC9kiQQ=g4rPEDMuA@mail.gmail.com>
 <d4547411-eeae-46c5-a30b-12d8cdde9329@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4547411-eeae-46c5-a30b-12d8cdde9329@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260924_145920_342246_E7BC7002 
X-CRM114-Status: GOOD (  46.33  )
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

On 2026-09-23 04:27 PM, Zhu Yanjun wrote:
> 在 2026/9/22 11:53, David Matlack 写道:
> > On Tue, Sep 22, 2026 at 11:36 AM Zhu Yanjun<yanjun.zhu@linux.dev> wrote:
> > > 在 2026/9/18 13:06, David Matlack 写道:
> > > > Future Work
> > > > -----------
> > > > 
> > > > Following this series, we expect to make further improvements to the PCI
> > > > core support for Live Update:
> > > > 
> > > >     - Allow P2P across Live Update by avoiding resizing or moving
> > > >       preserved device BARs and preserving all upstream bridge windows.
> > > > 
> > > >     - Support preserving Virtual Functions by preserving SR-IOV
> > > >       configuration on PFs and enumerating VFs after Live Update.
> > > Preserving the PCIe topology, bus numbers, ACS, and Bus Mastering across
> > > kexec is a foundational step for minimizing downtime.
> > > 
> > > As we look toward complete end-to-end support for DMA preservation
> > > across Live Update—especially for VFIO device passthrough and dma-buf
> > > sharing scenarios—IOMMU table/domain preservation becomes crucial to
> > > prevent IOMMU page faults when devices continue performing DMA during kexec.
> > > 
> > > I would like to ask about the current status and roadmap regarding IOMMU
> > > Live Update / KHO (Kexec Handover) support:
> > > 
> > > Is there an ongoing effort or RFC series for IOMMU handover / page-table
> > > preservation currently in development or under discussion?
> > > 
> > > How is the coordination between the PCI core Live Update mechanisms and
> > > the IOMMU subsystem being envisioned for preserving IOVA mappings (e.g.,
> > > restoring domains or handing over root tables)?
> > > 
> > > Any pointers to active discussion threads, RFCs, or future plans
> > > regarding IOMMU participation in Live Update would be greatly appreciated.
> > The first IOMMU series to support Live update, can be found here:
> > 
> >    https://lore.kernel.org/linux-iommu/20260921004834.2601285-1-skhawaja@google.com/
> 
> Thanks.
> 
> I have a question regarding the restoration sequencing when module
> dependencies are involved during a Live Update reboot.
> 
> For the standard hardware/driver stack, the sequence seems to naturally
> follow the kernel's early initcalls and device probing (e.g., IOMMU early
> hardware handover -> PCI bus topology/BME preservation -> IOMMU domain
> attach & DMA ownership claim -> VFIO/iommufd cdev binding).
> 
> However, if there is a custom kernel module or subsystem (let's call it
> Module A) that is not part of the standard PCI/IOMMU device probe callback
> chain, but strictly depends on the fully restored state of PCI, IOMMU, and
> VFIO/iommufd:
> 
> 1.
> 
>    What is the recommended or standardized way in the Live Update
>    architecture to guarantee that Module A's restoration happens
>    *after* all its underlying dependencies (PCI / IOMMU / VFIO) have
>    completely finished their restore processes?
> 
> 2.
> 
>    Is the expectation to rely on LUO (Live Update Orchestrator) phase
>    notification callbacks (e.g., late restore notifiers), Driver Core
>    mechanisms like |-EPROBE_DEFER| / |device_link|, or something else?
> 
> Any guidance on how cross-subsystem restoration order and async probe
> dependencies should be handled in the Live Update framework would be greatly
> appreciated.

Note: Some of what I write below is not yet merged into the Live Update
tree so may change. Samiullah Khawaja will be giving a talk about file
dependencies at LPC where some of these topics will be discussed.

LUO does not have a global "restore phase" or late-restore notifier.
Restoration is on-demand and driven by dependencies, and userspace does
the orchestration.

There are two types of objects that LUO manages:

1. FLB (File-Lifecycle-Bound) data, for shared/global state.

   An FLB is retrieved lazily the first time someone calls
   liveupdate_flb_get_incoming(). The PCI core does that from
   pci_setup_device() during enumeration, and the IOMMU driver does it
   when it initializes. So the order in which this global state is
   restored is simply the normal boot/initcall/probe order of the
   subsystems that use it. LUO does not impose any extra order.

2. Files in sessions, for per-object state (vfio cdevs, iommufds,
   memfds, ...).

   Files are retrieved either by userspace (LIVEUPDATE_SESSION_RETRIEVE_FD)
   or by kernel code (liveupdate_get_file_incoming()). Retrieval can
   happen in any order and is idempotent. When one file depends on
   another, the dependency is expressed between the two files, not
   through a global phase.

VFIO -> iommufd is an example to follow (see Samiullah's IOMMU series
[1] on top of Vipin's VFIO series [2]):

 - Outgoing: when a vfio cdev is preserved, iommufd_device_preserve()
   calls liveupdate_get_token_outgoing() on the iommufd file the device
   is attached to. That fails unless userspace has already preserved
   the iommufd in the same session, so the dependency is enforced at
   preserve time. The iommufd token is then recorded in the preserved
   device state.

 - Incoming: the recorded token is what connects the device back to its
   iommufd after kexec. Retrieving and re-attaching to the restored
   iommufd is the next phase of the IOMMU work, so that part is not in
   [1] yet. The building blocks are there, though:
   liveupdate_get_file_incoming() lets one file handler pull in a file
   it depends on by token (it is idempotent, so the order userspace
   retrieves in doesn't matter), and ->can_finish() lets a handler
   block LIVEUPDATE_SESSION_FINISH until everything it depends on is in
   a consistent state.

 - Device binding: vfio-pci's ->retrieve() simply fails (-ENODEV) if the
   preserved device is not bound to vfio-pci yet. There is no probe
   deferral inside LUO. Userspace is expected to make sure the device
   is bound (e.g. wait for udev) before retrieving the file. In the
   meantime the device is protected: the PCI core keeps bus mastering
   and BDFs stable, and the IOMMU core reattaches the preserved domain
   and claims DMA ownership, so no other driver can bind to it.

If you can share more about what Module A is and what state it needs to
carry across the update, I can try to go into more detail. But
generically I would recommend:

 - If Module A has state that must survive the Live Update, model it as
   a LUO file handler. If it depends on specific VFIO/iommufd files,
   record their tokens with liveupdate_get_token_outgoing() in your
   ->preserve(). Then in your ->retrieve(), get them back with
   liveupdate_get_file_incoming(). If something isn't ready yet (e.g.
   the device hasn't probed), fail ->retrieve() and let userspace retry,
   and use ->can_finish() to keep the session from finishing too early.

 - If Module A is a driver that binds to a device, the normal driver
   core mechanisms (-EPROBE_DEFER, device links) still apply for
   probe-time dependencies. Live Update doesn't replace them. But
   restoring the preserved state itself should probably go through LUO
   as above.

 - If Module A doesn't need to preserve anything itself but just
   consumes the restored VFIO/iommufd objects, the simplest option is to
   let userspace sequence it. Userspace already knows when the devices
   are bound and the FDs have been retrieved, so it can hand them to
   Module A at that point.

[1] https://lore.kernel.org/linux-iommu/20260921004834.2601285-1-skhawaja@google.com/
[2] https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/

