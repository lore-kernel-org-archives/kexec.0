Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F2CC47258
	for <kexec@archiver.kernel.org>; Wed, 17 Jan 2024 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=SzLtxnXblEM/ctw0sto4VA3qfFtcpvY+y4GZ1ojiwOA=; b=ohSvWS9kUxrpGc
	tAQRmeeRWdEZ8xdyKDLk+0Cnc/kUbPZ+7m0u/zYHr8l9T7zCHPsgqoYDu5lqyrZ1wbjiDw0iPLWT0
	gVk8CA17T6HiJxlu6Y4J+Qq/IncgZ9Yblu+6roM0IJfdHzG2xJ3zMXq8YpCrLD6ZQdf0rEUehlk31
	7dx3Prg1sKEgodYMqXNpl+0JAWgN5nMpu1NLsGpZAM/H6pZOOlJZfwi7Uvo7qHOxXtiIJjd78zhi+
	AXn43FrQgdzNIOrFEpwCnGHZbhGEo9n0dR4DsfmUc8L2XEylJB9PZuGU10JBoglqiMz+fPkONI+Hj
	dqOxqjLBmQSYm9C6hbog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ7CT-00HHCt-13;
	Wed, 17 Jan 2024 14:47:29 +0000
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ7CO-00HHAY-1F;
	Wed, 17 Jan 2024 14:47:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705502844; x=1737038844;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KI36AyxTHNxAyrC2/E2CPscnAMWQcpsDDCviRMf/ptM=;
  b=fqP3qkDOLeN/N8iYL9N9MVT1YqE9UI4v0jXiH9BWZXgoLcu/yuaAfIa0
   a4fP6wE1rTml7SQURfR45kg3eS3tKI011uliqt2KkBWlZXNoc715ASSBW
   N9moufP6jx3qL6iCrBJnoCCiErWefEPUcy1Tlveni6B1fgHYmdbt0OOO2
   8=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="390420952"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:47:13 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id 305C8A096F;
	Wed, 17 Jan 2024 14:47:11 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:35085]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.111:2525] with esmtp (Farcaster)
 id 8f49e889-7c05-4767-8fa7-e8d859bd377f; Wed, 17 Jan 2024 14:47:10 +0000 (UTC)
X-Farcaster-Flow-ID: 8f49e889-7c05-4767-8fa7-e8d859bd377f
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:47:10 +0000
Received: from dev-dsk-graf-1a-5ce218e4.eu-west-1.amazon.com (10.253.83.51) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:47:06 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-trace-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>, <x86@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, Andrew Morton
	<akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, "Tom
 Lendacky" <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>, <arnd@arndb.de>, <pbonzini@redhat.com>,
	<madvenka@linux.microsoft.com>, Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 00/17] kexec: Allow preservation of ftrace buffers
Date: Wed, 17 Jan 2024 14:46:47 +0000
Message-ID: <20240117144704.602-1-graf@amazon.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Originating-IP: [10.253.83.51]
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_064724_464851_FD139AC6 
X-CRM114-Status: GOOD (  33.94  )
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

== Overview ==

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
but I have not implemented it yet inside kexec tools.

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

== Changelog ==

v1 -> v2:
  - Removed: tracing: Introduce names for ring buffers
  - Removed: tracing: Introduce names for events
  - New: kexec: Add config option for KHO
  - New: kexec: Add documentation for KHO
  - New: tracing: Initialize fields before registering
  - New: devicetree: Add bindings for ftrace KHO
  - test bot warning fixes
  - Change kconfig option to ARCH_SUPPORTS_KEXEC_KHO
  - s/kho_reserve_mem/kho_reserve_previous_mem/g
  - s/kho_reserve/kho_reserve_scratch/g
  - Remove / reduce ifdefs
  - Select crc32
  - Leave anything that requires a name in trace.c to keep buffers
    unnamed entities
  - Put events as array into a property, use fingerprint instead of
    names to identify them
  - Reduce footprint without CONFIG_FTRACE_KHO
  - s/kho_reserve_mem/kho_reserve_previous_mem/g
  - make kho_get_fdt() const
  - Add stubs for return_mem and claim_mem
  - make kho_get_fdt() const
  - Get events as array from a property, use fingerprint instead of
    names to identify events
  - Change kconfig option to ARCH_SUPPORTS_KEXEC_KHO
  - s/kho_reserve_mem/kho_reserve_previous_mem/g
  - s/kho_reserve/kho_reserve_scratch/g
  - Leave the node generation code that needs to know the name in
    trace.c so that ring buffers can stay anonymous
  - s/kho_reserve/kho_reserve_scratch/g
  - Move kho enums out of ifdef
  - Move from names to fdt offsets. That way, trace.c can find the trace
    array offset and then the ring buffer code only needs to read out
    its per-CPU data. That way it can stay oblivient to its name.
  - Make kho_get_fdt() const

v2 -> v3:

  - Fix make dt_binding_check
  - Add descriptions for each object
  - s/trace_flags/trace-flags/
  - s/global_trace/global-trace/
  - Make all additionalProperties false
  - Change subject to reflect subsysten (dt-bindings)
  - Fix indentation
  - Remove superfluous examples
  - Convert to 64bit syntax
  - Move to kho directory
  - s/"global_trace"/"global-trace"/
  - s/"global_trace"/"global-trace"/
  - s/"trace_flags"/"trace-flags"/
  - Fix wording
  - Add Documentation to MAINTAINERS file
  - Remove kho reference on read error
  - Move handover_dt unmap up
  - s/reserve_scratch_mem/mark_phys_as_cma/
  - Remove ifdeffery
  - Remove superfluous comment

Alexander Graf (17):
  mm,memblock: Add support for scratch memory
  memblock: Declare scratch memory as CMA
  kexec: Add Kexec HandOver (KHO) generation helpers
  kexec: Add KHO parsing support
  kexec: Add KHO support to kexec file loads
  kexec: Add config option for KHO
  kexec: Add documentation for KHO
  arm64: Add KHO support
  x86: Add KHO support
  tracing: Initialize fields before registering
  tracing: Introduce kho serialization
  tracing: Add kho serialization of trace buffers
  tracing: Recover trace buffers from kexec handover
  tracing: Add kho serialization of trace events
  tracing: Recover trace events from kexec handover
  tracing: Add config option for kexec handover
  Documentation: KHO: Add ftrace bindings

 Documentation/ABI/testing/sysfs-firmware-kho  |   9 +
 Documentation/ABI/testing/sysfs-kernel-kho    |  53 ++
 .../admin-guide/kernel-parameters.txt         |  10 +
 .../kho/bindings/ftrace/ftrace-array.yaml     |  38 ++
 .../kho/bindings/ftrace/ftrace-cpu.yaml       |  43 ++
 Documentation/kho/bindings/ftrace/ftrace.yaml |  62 +++
 Documentation/kho/concepts.rst                |  88 +++
 Documentation/kho/index.rst                   |  19 +
 Documentation/kho/usage.rst                   |  57 ++
 Documentation/subsystem-apis.rst              |   1 +
 MAINTAINERS                                   |   3 +
 arch/arm64/Kconfig                            |   3 +
 arch/arm64/kernel/setup.c                     |   2 +
 arch/arm64/mm/init.c                          |   8 +
 arch/x86/Kconfig                              |   3 +
 arch/x86/boot/compressed/kaslr.c              |  55 ++
 arch/x86/include/uapi/asm/bootparam.h         |  15 +-
 arch/x86/kernel/e820.c                        |   9 +
 arch/x86/kernel/kexec-bzimage64.c             |  39 ++
 arch/x86/kernel/setup.c                       |  46 ++
 arch/x86/mm/init_32.c                         |   7 +
 arch/x86/mm/init_64.c                         |   7 +
 drivers/of/fdt.c                              |  39 ++
 drivers/of/kexec.c                            |  54 ++
 include/linux/kexec.h                         |  58 ++
 include/linux/memblock.h                      |  19 +
 include/linux/ring_buffer.h                   |  17 +-
 include/linux/trace_events.h                  |   1 +
 include/uapi/linux/kexec.h                    |   6 +
 kernel/Kconfig.kexec                          |  13 +
 kernel/Makefile                               |   2 +
 kernel/kexec_file.c                           |  41 ++
 kernel/kexec_kho_in.c                         | 298 ++++++++++
 kernel/kexec_kho_out.c                        | 526 ++++++++++++++++++
 kernel/trace/Kconfig                          |  14 +
 kernel/trace/ring_buffer.c                    | 243 +++++++-
 kernel/trace/trace.c                          |  96 +++-
 kernel/trace/trace_events.c                   |  14 +-
 kernel/trace/trace_events_synth.c             |  14 +-
 kernel/trace/trace_events_user.c              |   4 +
 kernel/trace/trace_output.c                   | 247 +++++++-
 kernel/trace/trace_output.h                   |   5 +
 kernel/trace/trace_probe.c                    |   4 +
 mm/Kconfig                                    |   4 +
 mm/memblock.c                                 |  79 ++-
 45 files changed, 2351 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-kho
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-kho
 create mode 100644 Documentation/kho/bindings/ftrace/ftrace-array.yaml
 create mode 100644 Documentation/kho/bindings/ftrace/ftrace-cpu.yaml
 create mode 100644 Documentation/kho/bindings/ftrace/ftrace.yaml
 create mode 100644 Documentation/kho/concepts.rst
 create mode 100644 Documentation/kho/index.rst
 create mode 100644 Documentation/kho/usage.rst
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
