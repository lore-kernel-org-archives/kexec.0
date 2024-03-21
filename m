Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433F7C54E68
	for <kexec@archiver.kernel.org>; Thu, 21 Mar 2024 06:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BBz+6rABB7Nlxabwui49+XM0uWmLl/LzP4PwVdFtz8I=; b=1GqnT+I9c/rsGe
	zZSGQfJsxvCLmqypLfIkeAbddrFx6+SEV+3yDoxhHpmzAQdsmhKh4GYzBX19ZAds0CRbUJ5RUWF3B
	T86vVUwC/hOw4hdMXqVLu74xUn7QqGTIAPGRctnzRnuArRLSyBeyNz26AbZYYuuLb1D/40CBq6gRW
	TavZWIgWbD6FChCQVjxi+vXvdbFdxk4Si8yb0N0WQAXDFAYrGszc4erYQ9SUPfAHH+bvY/68cywn7
	Zwfyw+2+zUcGxpmpJW/TvVWrr00oFASBMdtdEGecE3jb+k16i+AY0zbJu4sWAEndqfEIi+6LEmQ5E
	R0f5ZYR8Kxbp7unsTo2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnBjx-000000021mI-0xi6;
	Thu, 21 Mar 2024 06:17:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnBjt-000000021l6-1iN8
	for kexec@lists.infradead.org;
	Thu, 21 Mar 2024 06:17:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711001835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9jAIuJp36kQ83ph08kGCrk7a6I+win2cjS4x9JRD5ps=;
	b=d6wqCwr59NThwEn0f8nrKmkGX5AWsWrUzIQ9jTOp/EuvVIU4f+SVOrk7Lx+uQgkSo6R8lY
	mOGDa27+SFmH+zKiofleNZMcVef2Bs8b0msO+bJ5a5CnyIcVDGujxcjOCPsr5MIiQ9OvgR
	gQeGUCtt60TYaOLnflGkNlzJE3VsKXM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-i8MNhxPtOsu-j7Qqejuaog-1; Thu, 21 Mar 2024 02:17:11 -0400
X-MC-Unique: i8MNhxPtOsu-j7Qqejuaog-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E08BC101A526;
	Thu, 21 Mar 2024 06:17:10 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C09D71121306;
	Thu, 21 Mar 2024 06:17:09 +0000 (UTC)
Date: Thu, 21 Mar 2024 14:17:02 +0800
From: Baoquan He <bhe@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"hpa@zytor.com" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [RFC PATCH v3 0/7] device backed vmemmap crash dump support
Message-ID: <ZfvQ3qbRWCZeSb62@MiWiFi-R3L-srv>
References: <20240306102846.1020868-1-lizhijian@fujitsu.com>
 <92644ab5-6467-484c-b8f3-05cba2164cc1@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <92644ab5-6467-484c-b8f3-05cba2164cc1@fujitsu.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_231721_557847_30BFB8DE 
X-CRM114-Status: GOOD (  38.97  )
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

On 03/21/24 at 05:40am, Zhijian Li (Fujitsu) wrote:
> ping
> 
> 
> Any comment is welcome.

I will have a look at this from kdump side. How do you test your code?

By the way, there's issue reported by test robot.

Thanks
Baoquan

> 
> 
> On 06/03/2024 18:28, Li Zhijian wrote:
> > Hello folks,
> > 
> > Compared with the V2[1] I posted a long time ago, this time it is a
> > completely new proposal design.
> > 
> > ### Background and motivate overview ###
> > ---
> > Crash dump is an important feature for troubleshooting the kernel. It is the
> > final way to chase what happened at the kernel panic, slowdown, and so on. It
> > is one of the most important tools for customer support.
> > 
> > Currently, there are 2 syscalls(kexec_file_load(2) and kexec_load(2)) to
> > configure the dumpable regions. Generally, (A)iomem resources registered with
> > flags (IORESOURCE_SYSTEM_RAM | IORESOUCE_BUSY) for kexec_file_load(2) or
> > (B)iomem resources registered with "System RAM" name prefix for kexec_load(2)
> > are dumpable.
> > 
> > The pmem use cases including fsdax and devdax, could map their vmemmap to
> > their own devices. In this case, these part of vmemmap will not be dumped when
> > crash happened since these regions are satisfied with neither the above (A)
> > nor (B).
> > 
> > In fsdax, the vmemmap(struct page array) becomes very important, it is one of
> > the key data to find status of reverse map. Lacking of the information may
> > cause difficulty to analyze trouble around pmem (especially Filesystem-DAX).
> > That means troubleshooters are unable to check more details about pmem from
> > the dumpfile.
> > 
> > ### Proposal ###
> > ---
> > In this proposal, register the device backed vmemmap as a separate resource.
> > This resource has its own new flag and name, and then teaches kexec_file_load(2)
> > and kexec_load(2) to mark it as dumpable.
> > 
> > Proposed flag: IORESOURCE_DEVICE_BACKED_VMEMMAP
> > Proposed name: "Device Backed Vmemmap"
> > 
> > NOTE: crash-utils also needs to adapt to this new name for kexec_load()
> > 
> > With current proposal, the /proc/iomem should show as following for device
> > backed vmemmap
> > # cat /proc/iomem
> > ...
> > fffc0000-ffffffff : Reserved
> > 100000000-13fffffff : Persistent Memory
> >    100000000-10fffffff : namespace0.0
> >      100000000-1005fffff : Device Backed Vmemmap  # fsdax
> > a80000000-b7fffffff : CXL Window 0
> >    a80000000-affffffff : Persistent Memory
> >      a80000000-affffffff : region1
> >        a80000000-a811fffff : namespace1.0
> >          a80000000-a811fffff : Device Backed Vmemmap # devdax
> >        a81200000-abfffffff : dax1.0
> > b80000000-c7fffffff : CXL Window 1
> > c80000000-147fffffff : PCI Bus 0000:00
> >    c80000000-c801fffff : PCI Bus 0000:01
> > ...
> > 
> > ### Kdump service reloading ###
> > ---
> > Once the kdump service is loaded, if changes to CPUs or memory occur,
> > either by hot un/plug or off/onlining, the crash elfcorehdr should also
> > be updated. There are 2 approaches to make the reloading more efficient.
> > 1) Use udev rules to watch CPU and memory events, then reload kdump
> > 2) Enable kernel crash hotplug to automatically reload elfcorehdr (>= 6.5)
> > 
> > This reloading also needed when device backed vmemmap layouts change, Similar
> > to what 1) does now, one could add the following as the first lines to the
> > RHEL udev rule file /usr/lib/udev/rules.d/98-kexec.rules:
> > 
> > # namespace updated: watch daxX.Y(devdax) and pfnX.Y(fsdax) of nd
> > SUBSYSTEM=="nd", KERNEL=="[dp][af][xn][0-9].*", ACTION=="bind", GOTO="kdump_reload"
> > SUBSYSTEM=="nd", KERNEL=="[dp][af][xn][0-9].*", ACTION=="unbind", GOTO="kdump_reload"
> > # devdax <-> system-ram updated: watch daxX.Y of dax
> > SUBSYSTEM=="dax", KERNEL=="dax[0-9].*", ACTION=="bind", GOTO="kdump_reload"
> > SUBSYSTEM=="dax", KERNEL=="dax[0-9].*", ACTION=="unbind", GOTO="kdump_reload"
> > 
> > Regarding 2), my idea is that it would need to call the memory_notify() in
> > devm_memremap_pages_release() and devm_memremap_pages() to trigger the crash
> > hotplug. This part is not yet mature, but it does not affect the whole feature
> > because we can still use method 1) alternatively.
> > 
> > [1] https://lore.kernel.org/lkml/02066f0f-dbc0-0388-4233-8e24b6f8435b@fujitsu.com/T/
> > --------------------------------------------
> > changes from V2[1]
> > - new proposal design
> > 
> > CC: Alison Schofield <alison.schofield@intel.com>
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: Baoquan He <bhe@redhat.com>
> > CC: Borislav Petkov <bp@alien8.de>
> > CC: Dan Williams <dan.j.williams@intel.com>
> > CC: Dave Hansen <dave.hansen@linux.intel.com>
> > CC: Dave Jiang <dave.jiang@intel.com>
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > CC: "H. Peter Anvin" <hpa@zytor.com>
> > CC: Ingo Molnar <mingo@redhat.com>
> > CC: Ira Weiny <ira.weiny@intel.com>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: Vishal Verma <vishal.l.verma@intel.com>
> > CC: linux-cxl@vger.kernel.org
> > CC: linux-mm@kvack.org
> > CC: nvdimm@lists.linux.dev
> > CC: x86@kernel.org
> > 
> > Li Zhijian (7):
> >    mm: memremap: register/unregister altmap region to a separate resource
> >    mm: memremap: add pgmap_parent_resource() helper
> >    nvdimm: pmem: assign a parent resource for vmemmap region for the
> >      fsdax
> >    dax: pmem: assign a parent resource for vmemmap region for the devdax
> >    resource: Introduce walk device_backed_vmemmap res() helper
> >    x86/crash: make device backed vmemmap dumpable for kexec_file_load
> >    nvdimm: set force_raw=1 in kdump kernel
> > 
> >   arch/x86/kernel/crash.c         |  5 +++++
> >   drivers/dax/pmem.c              |  8 ++++++--
> >   drivers/nvdimm/namespace_devs.c |  3 +++
> >   drivers/nvdimm/pmem.c           |  9 ++++++---
> >   include/linux/ioport.h          |  4 ++++
> >   include/linux/memremap.h        |  4 ++++
> >   kernel/resource.c               | 13 +++++++++++++
> >   mm/memremap.c                   | 30 +++++++++++++++++++++++++++++-
> >   8 files changed, 70 insertions(+), 6 deletions(-)
> > 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
