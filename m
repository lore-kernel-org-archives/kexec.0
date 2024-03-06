Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75259C54E41
	for <kexec@archiver.kernel.org>; Wed,  6 Mar 2024 10:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YRNtWhD1cb8V7p5Ki2qSsjU/8B/nM85fZhIbMdtt6Uw=; b=xjI/aYrusKTssW
	uqmmr+M/4g2lrlopJzNUm6WZ8bEtBGsEOTYjQKWaYpKsd/vu21e6SzEp69a+ceGbQ7w2Yca2HDXL3
	4A/Qv5rdtUZY5j14Taa/Fke9ukJIkhgSgdrbYHtARpJNO2pTFHDYwugXltaiRPCmIn1Tq2cmL7v4o
	uEloIwAjjrVro17YU4ab9sLJKOoHFvc13Ur/qAMnME7T1NGQQJaC9cXjcofuMHXwbYqVAiqkdsYbn
	ZXcv/r/MqyRp3J9pCTPF2L+R1ueAhrD8sYtbdhZ8bDL5gdcdagjBynK2dNccPK8C8Y5YwvdG0SXpF
	twk2fqsPLv9MU2b0dDKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoWX-0000000HPSr-1Nvs;
	Wed, 06 Mar 2024 10:29:21 +0000
Received: from esa4.hc1455-7.c3s2.iphmx.com ([68.232.139.117])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhoWS-0000000HPPY-0OZl
	for kexec@lists.infradead.org;
	Wed, 06 Mar 2024 10:29:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1709720956; x=1741256956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L1uC7nmPQ3VWAXabC3fl20OZJAiFpMalcUh/l8cZZSY=;
  b=GwV8YsR3EAXBiNd9YWjcATOyQImpIz+4+pJ91F3VwhAw6RkAlGROKajj
   vy2V4q2Z7Dfs2EjHagLRTblkKmOYHJW52f+zdjFUbHSbtZkS3UzBX/n47
   rlyNuzqBM8ynZfQld06Jbnzy1b1ziurv2HArTaJmR0EzwoAJpvkd+7186
   ZIfmMEsVaTkevnj+B9imMjJOW9c4w6aB5+6dbIBads38X+odPRwA58nVL
   araBiKCLwIHK3ftQLMRwTCZNYbBy6wt3VHbWuHSG2Cdaf0VbwE1BaEGxL
   WJKsfFrW0Fk6Ixz29oaay6RO5SdPoZ1lttQJw79/GEo6nhHKnrh5nJsPM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="151690177"
X-IronPort-AV: E=Sophos;i="6.06,208,1705330800"; 
   d="scan'208";a="151690177"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 19:29:09 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id BEA27C6909
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:07 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id EF084CFBC8
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6F6502030C7DD
	for <kexec@lists.infradead.org>; Wed,  6 Mar 2024 19:29:06 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 8455D1A006A;
	Wed,  6 Mar 2024 18:29:04 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: y-goto@fujitsu.com,
	Alison Schofield <alison.schofield@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	hpa@zytor.com,
	Ingo Molnar <mingo@redhat.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	x86@kernel.org,
	kexec@lists.infradead.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [RFC PATCH v3 0/7] device backed vmemmap crash dump support
Date: Wed,  6 Mar 2024 18:28:39 +0800
Message-Id: <20240306102846.1020868-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28234.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28234.006
X-TMASE-Result: 10--12.047900-10.000000
X-TMASE-MatchedRID: WgnE0i2Gnm0S1H+wJnLU0xxQCXaqsX3JICcCYi/y4c1YC5LPd7BvbZVh
	8IAdHNwNV9EQFA1Eag8lMmENZ05/+9/K1ikJIsLOF+qQpCWTUjks9yCYjUR6S0u7cLcUs73+UAr
	JnwHoG3RN6oLBwrNlQwp3Fx4qZRwntpor8DSuIkBIK2DGByysyvrFoSv9vjATUYkZd9+4t2+K/w
	YsY7aZE7yLKxASOUwjkBUaTCifn9xExKw+e7wVxgPZZctd3P4BX098A7fr3Vfir9ZdeIDkfES3N
	7Ud/ZNyw3/C2qEmiGxJ7i3niaFL/WIo6q3zeo5wqhcdnP91eXGdj7YWJLs3nTb+WPFOeKNMsX5M
	tbDfIWiy+iBzQ4hgrIaPRWRVv3Ad5mMeg8RfsnWHmRpBdG9H1zX8AUEphxj0Blnw3dG9MzGjxYy
	RBa/qJcFwgTvxipFajoczmuoPCq3JpPrv+A3tItKgYcJqG5qWnoRh9cAERsgMkJ+raRGIqWxKck
	D0+Hnx
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_022916_474337_D06DD78D 
X-CRM114-Status: GOOD (  19.52  )
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

Hello folks,

Compared with the V2[1] I posted a long time ago, this time it is a
completely new proposal design.

### Background and motivate overview ###
---
Crash dump is an important feature for troubleshooting the kernel. It is the
final way to chase what happened at the kernel panic, slowdown, and so on. It
is one of the most important tools for customer support.

Currently, there are 2 syscalls(kexec_file_load(2) and kexec_load(2)) to
configure the dumpable regions. Generally, (A)iomem resources registered with
flags (IORESOURCE_SYSTEM_RAM | IORESOUCE_BUSY) for kexec_file_load(2) or
(B)iomem resources registered with "System RAM" name prefix for kexec_load(2)
are dumpable.

The pmem use cases including fsdax and devdax, could map their vmemmap to
their own devices. In this case, these part of vmemmap will not be dumped when
crash happened since these regions are satisfied with neither the above (A)
nor (B).

In fsdax, the vmemmap(struct page array) becomes very important, it is one of
the key data to find status of reverse map. Lacking of the information may
cause difficulty to analyze trouble around pmem (especially Filesystem-DAX).
That means troubleshooters are unable to check more details about pmem from
the dumpfile.

### Proposal ###
---
In this proposal, register the device backed vmemmap as a separate resource.
This resource has its own new flag and name, and then teaches kexec_file_load(2)
and kexec_load(2) to mark it as dumpable.

Proposed flag: IORESOURCE_DEVICE_BACKED_VMEMMAP
Proposed name: "Device Backed Vmemmap"

NOTE: crash-utils also needs to adapt to this new name for kexec_load()

With current proposal, the /proc/iomem should show as following for device
backed vmemmap
# cat /proc/iomem
...
fffc0000-ffffffff : Reserved
100000000-13fffffff : Persistent Memory
  100000000-10fffffff : namespace0.0
    100000000-1005fffff : Device Backed Vmemmap  # fsdax
a80000000-b7fffffff : CXL Window 0
  a80000000-affffffff : Persistent Memory
    a80000000-affffffff : region1
      a80000000-a811fffff : namespace1.0
        a80000000-a811fffff : Device Backed Vmemmap # devdax
      a81200000-abfffffff : dax1.0
b80000000-c7fffffff : CXL Window 1
c80000000-147fffffff : PCI Bus 0000:00
  c80000000-c801fffff : PCI Bus 0000:01
...

### Kdump service reloading ###
---
Once the kdump service is loaded, if changes to CPUs or memory occur,
either by hot un/plug or off/onlining, the crash elfcorehdr should also
be updated. There are 2 approaches to make the reloading more efficient.
1) Use udev rules to watch CPU and memory events, then reload kdump
2) Enable kernel crash hotplug to automatically reload elfcorehdr (>= 6.5)

This reloading also needed when device backed vmemmap layouts change, Similar
to what 1) does now, one could add the following as the first lines to the
RHEL udev rule file /usr/lib/udev/rules.d/98-kexec.rules:

# namespace updated: watch daxX.Y(devdax) and pfnX.Y(fsdax) of nd
SUBSYSTEM=="nd", KERNEL=="[dp][af][xn][0-9].*", ACTION=="bind", GOTO="kdump_reload"
SUBSYSTEM=="nd", KERNEL=="[dp][af][xn][0-9].*", ACTION=="unbind", GOTO="kdump_reload"
# devdax <-> system-ram updated: watch daxX.Y of dax
SUBSYSTEM=="dax", KERNEL=="dax[0-9].*", ACTION=="bind", GOTO="kdump_reload"
SUBSYSTEM=="dax", KERNEL=="dax[0-9].*", ACTION=="unbind", GOTO="kdump_reload"

Regarding 2), my idea is that it would need to call the memory_notify() in
devm_memremap_pages_release() and devm_memremap_pages() to trigger the crash
hotplug. This part is not yet mature, but it does not affect the whole feature
because we can still use method 1) alternatively.

[1] https://lore.kernel.org/lkml/02066f0f-dbc0-0388-4233-8e24b6f8435b@fujitsu.com/T/
--------------------------------------------
changes from V2[1]
- new proposal design

CC: Alison Schofield <alison.schofield@intel.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Baoquan He <bhe@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Ira Weiny <ira.weiny@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Vishal Verma <vishal.l.verma@intel.com>
CC: linux-cxl@vger.kernel.org
CC: linux-mm@kvack.org
CC: nvdimm@lists.linux.dev
CC: x86@kernel.org

Li Zhijian (7):
  mm: memremap: register/unregister altmap region to a separate resource
  mm: memremap: add pgmap_parent_resource() helper
  nvdimm: pmem: assign a parent resource for vmemmap region for the
    fsdax
  dax: pmem: assign a parent resource for vmemmap region for the devdax
  resource: Introduce walk device_backed_vmemmap res() helper
  x86/crash: make device backed vmemmap dumpable for kexec_file_load
  nvdimm: set force_raw=1 in kdump kernel

 arch/x86/kernel/crash.c         |  5 +++++
 drivers/dax/pmem.c              |  8 ++++++--
 drivers/nvdimm/namespace_devs.c |  3 +++
 drivers/nvdimm/pmem.c           |  9 ++++++---
 include/linux/ioport.h          |  4 ++++
 include/linux/memremap.h        |  4 ++++
 kernel/resource.c               | 13 +++++++++++++
 mm/memremap.c                   | 30 +++++++++++++++++++++++++++++-
 8 files changed, 70 insertions(+), 6 deletions(-)

-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
