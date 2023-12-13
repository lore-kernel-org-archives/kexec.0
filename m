Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6737C4332F
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 00:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=M/EXJPiv99x8qF+a6eFdEvSr+021wNNTeE2BgFVT39M=; b=u06taU/0tR9zeH
	oT2TbY734TVdt46EYXTw089AoRGQyBvAJl/jjtqIS8jDrGVMoxnyB8mqsZCU4FBE1tcB5ZTPo/NFH
	ouQbJYD8QFm8m47jmBnn7fRx92WVigBcRpig4VxI7H6y3t+Ysb2Et+/LfKNM0xrrxINTkldZq02dH
	zNkIbjXIQ5Y9qieSeiE3Rg22TmWW0V2rM0do8f/s21mi37EDQjPCQfgP1epzvv7Ci+bGo98fY0Pgb
	iDO4DrBYjTwa152t5e0q+UdKnm+/0B5fVUDZ243tPUbGW69VDELIgB8mYgIjpkEAZUwkXq/wLKhw+
	dSG1TUrwO+OwjuGiQDSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCka-00D74p-2t;
	Wed, 13 Dec 2023 00:05:20 +0000
Received: from smtp-fw-80006.amazon.com ([99.78.197.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDCkU-00D6yt-0V;
	Wed, 13 Dec 2023 00:05:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702425914; x=1733961914;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fB4jNKUlRe6N2loXV8PJj2wVQgaVapDNdKtj8FKjX38=;
  b=HRUzJjNr6FPfuHNaSrLqO8asCsY+bJ56GRlybet8e0dHj2t1nr8odQkT
   45Aaf+2hGPhbjQDUAZm2zbk2SqBJGGlDLPk6sAaVIMz2Uiia01S7RetkZ
   t1hhof16yL4U2pqYbilohoN0gfd/XIjCx1hfK7hVnwsFTSLHNMljRDNlN
   M=;
X-IronPort-AV: E=Sophos;i="6.04,271,1695686400"; 
   d="scan'208";a="258636760"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 00:05:07 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-3e1fab07.us-east-1.amazon.com (Postfix) with ESMTPS id 2F16D80559;
	Wed, 13 Dec 2023 00:04:58 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:24714]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.64:2525] with esmtp (Farcaster)
 id a315ff1a-1500-42c3-9aab-085b45d8541a; Wed, 13 Dec 2023 00:04:58 +0000 (UTC)
X-Farcaster-Flow-ID: a315ff1a-1500-42c3-9aab-085b45d8541a
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:04:58 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 00:04:54 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Rob Herring" <robh+dt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Mark Rutland
	<mark.rutland@arm.com>, "Tom Lendacky" <thomas.lendacky@amd.com>, Ashish
 Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav
 Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH 00/15] kexec: Allow preservation of ftrace buffers
Date: Wed, 13 Dec 2023 00:04:37 +0000
Message-ID: <20231213000452.88295-1-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_160514_247860_F324D27C 
X-CRM114-Status: GOOD (  28.88  )
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

Kexec today considers itself purely a boot loader: When we enter the new
kernel, any state the previous kernel left behind is irrelevant and the
new kernel reinitializes the system.

However, there are use cases where this mode of operation is not what we
actually want. In virtualization hosts for example, we want to use kexec
to update the host kernel while virtual machine memory stays untouched.
When we add device assignment to the mix, we also need to ensure that
IOMMU and VFIO states are untouched. If we add PCIe peer to peer DMA, we
need to do the same for the PCI subsystem. If we want to kexec while an
SEV-SNP enabled virtual machine is running, we need to preserve the VM
context pages and physical memory. See James' and my Linux Plumbers
Conference 2023 presentation for details:

  https://lpc.events/event/17/contributions/1485/

To start us on the journey to support all the use cases above, this
patch implements basic infrastructure to allow hand over of kernel state
across kexec (Kexec HandOver, aka KHO). As example target, we use ftrace:
With this patch set applied, you can read ftrace records from the
pre-kexec environment in your post-kexec one. This creates a very powerful
debugging and performance analysis tool for kexec. It's also slightly
easier to reason about than full blown VFIO state preservation.

== Alternatives ==

There are alternative approaches to (parts of) the problems above:

  * Memory Pools [1] - preallocated persistent memory region + allocator
  * PRMEM [2] - resizable persistent memory regions with fixed metadata
                pointer on the kernel command line + allocator
  * Pkernfs [3] - preallocated file system for in-kernel data with fixed
                  address location on the kernel command line
  * PKRAM [4] - handover of user space pages using a fixed metadata page
                specified via command line

All of the approaches above fundamentally have the same problem: They
require the administrator to explicitly carve out a physical memory
location because they have no mechanism outside of the kernel command
line to pass data (including memory reservations) between kexec'ing
kernels.

KHO provides that base foundation. We will determine later whether we
still need any of the approaches above for fast bulk memory handover of for
example IOMMU page tables. But IMHO they would all be users of KHO, with
KHO providing the foundational primitive to pass metadata and bulk memory
reservations as well as provide easy versioning for data.

== Documentation ==

If people are happy with the approach in this patch set, I will write up
conclusive documentation including schemas for the metadata as part of its
next iteration. For now, here's a rudimentary overview:

We introduce a metadata file that the kernels pass between each other. How
they pass it is architecture specific. The file's format is a Flattened
Device Tree (fdt) which has a generator and parser already included in
Linux. When the root user enables KHO through /sys/kernel/kho/active, the
kernel invokes callbacks to every driver that supports KHO to serialize
its state. When the actual kexec happens, the fdt is part of the image
set that we boot into. In addition, we keep a "scratch region" available
for kexec: A physically contiguous memory region that is guaranteed to
not have any memory that KHO would preserve.  The new kernel bootstraps
itself using the scratch region and sets all handed over memory as in use.
When drivers initialize that support KHO, they introspect the fdt and
recover their state from it. This includes memory reservations, where the
driver can either discard or claim reservations.

== Limitations ==

I currently only implemented file based kexec. The kernel interfaces
in the patch set are already in place to support user space kexec as well,
but I have not implemented it yet.

== How to Use ==

To use the code, please boot the kernel with the "kho_scratch=" command
line parameter set: "kho_scratch=512M". KHO requires a scratch region.

Make sure to fill ftrace with contents that you want to observe after
kexec.  Then, before you invoke file based "kexec -l", activate KHO:

  # echo 1 > /sys/kernel/kho/active
  # kexec -l Image --initrd=initrd -s
  # kexec -e

The new kernel will boot up and contain the previous kernel's trace
buffers in /sys/kernel/debug/tracing/trace.



Alex

[1] https://lore.kernel.org/all/169645773092.11424.7258549771090599226.stgit@skinsburskii./
[2] https://lore.kernel.org/all/20231016233215.13090-1-madvenka@linux.microsoft.com/
[3] https://lpc.events/event/17/contributions/1485/attachments/1296/2650/jgowans-preserving-across-kexec.pdf
[4] https://lore.kernel.org/kexec/1682554137-13938-1-git-send-email-anthony.yznaga@oracle.com/


Alexander Graf (15):
  mm,memblock: Add support for scratch memory
  memblock: Declare scratch memory as CMA
  kexec: Add Kexec HandOver (KHO) generation helpers
  kexec: Add KHO parsing support
  kexec: Add KHO support to kexec file loads
  arm64: Add KHO support
  x86: Add KHO support
  tracing: Introduce names for ring buffers
  tracing: Introduce names for events
  tracing: Introduce kho serialization
  tracing: Add kho serialization of trace buffers
  tracing: Recover trace buffers from kexec handover
  tracing: Add kho serialization of trace events
  tracing: Recover trace events from kexec handover
  tracing: Add config option for kexec handover

 Documentation/ABI/testing/sysfs-firmware-kho  |   9 +
 Documentation/ABI/testing/sysfs-kernel-kho    |  53 ++
 .../admin-guide/kernel-parameters.txt         |  10 +
 MAINTAINERS                                   |   2 +
 arch/arm64/Kconfig                            |  12 +
 arch/arm64/kernel/setup.c                     |   2 +
 arch/arm64/mm/init.c                          |   8 +
 arch/x86/Kconfig                              |  12 +
 arch/x86/boot/compressed/kaslr.c              |  55 ++
 arch/x86/include/uapi/asm/bootparam.h         |  15 +-
 arch/x86/kernel/e820.c                        |   9 +
 arch/x86/kernel/kexec-bzimage64.c             |  39 ++
 arch/x86/kernel/setup.c                       |  46 ++
 arch/x86/mm/init_32.c                         |   7 +
 arch/x86/mm/init_64.c                         |   7 +
 drivers/of/fdt.c                              |  41 ++
 drivers/of/kexec.c                            |  36 ++
 include/linux/kexec.h                         |  56 ++
 include/linux/memblock.h                      |  19 +
 include/linux/ring_buffer.h                   |   9 +-
 include/linux/trace_events.h                  |   1 +
 include/trace/trace_events.h                  |   2 +
 include/uapi/linux/kexec.h                    |   6 +
 kernel/Makefile                               |   2 +
 kernel/kexec_file.c                           |  41 ++
 kernel/kexec_kho_in.c                         | 298 ++++++++++
 kernel/kexec_kho_out.c                        | 526 ++++++++++++++++++
 kernel/trace/Kconfig                          |  13 +
 kernel/trace/blktrace.c                       |   1 +
 kernel/trace/ring_buffer.c                    | 267 ++++++++-
 kernel/trace/trace.c                          |  76 ++-
 kernel/trace/trace_branch.c                   |   1 +
 kernel/trace/trace_events.c                   |   3 +
 kernel/trace/trace_functions_graph.c          |   4 +-
 kernel/trace/trace_output.c                   | 106 +++-
 kernel/trace/trace_output.h                   |   1 +
 kernel/trace/trace_probe.c                    |   3 +
 kernel/trace/trace_syscalls.c                 |  29 +
 mm/Kconfig                                    |   4 +
 mm/memblock.c                                 |  83 ++-
 40 files changed, 1901 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-kho
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-kho
 create mode 100644 kernel/kexec_kho_in.c
 create mode 100644 kernel/kexec_kho_out.c

-- 
2.40.1




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
