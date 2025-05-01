Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D54DC369DC
	for <kexec@archiver.kernel.org>; Thu,  1 May 2025 22:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VNCJTv4QrQ4B3OaOPUv7KzHf9QRM+3nfyGYGMjnG7a4=; b=raxcrqFJ3sjLOY1nTDzu7IOzcG
	rFy1vifmRYl5QmD1Dk8Yv9BK8wGsNW8+iZsQLLA6rU0e5Lah87LGw0y/rGfdAD3/vkazgr2qbhiU3
	kfI1+O9RNQLba1AtbkVPZZMLPH0NSGet4vSNtRhIOjpMv8ZrkxhbWNFXFhhxx/kvXTms/SO03LZCP
	aJFP+jf8ZEaSESigKsjhWumTUDHWtGw4skTNa7qfTZpMUDfEYLj0vYVvpGpB9RF/m8KvpxG0mrPN5
	ONDw+/5V2bwOPOIyVkaNjJlxj0PIRfQHMUNBOC2/cUp+8FlJ8f0Y9Jhnlq5yphidtY4us0I/t6sGM
	0aRE0gdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAcqB-000000008Bm-2cOp;
	Thu, 01 May 2025 22:57:15 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAcoA-000000006zn-0knR
	for kexec@lists.infradead.org;
	Thu, 01 May 2025 22:55:11 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-22647ff3cf5so10997315ad.0
        for <kexec@lists.infradead.org>; Thu, 01 May 2025 15:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746140108; x=1746744908; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VNCJTv4QrQ4B3OaOPUv7KzHf9QRM+3nfyGYGMjnG7a4=;
        b=v8oaGBiNGHK8z5MGOZpghuENo5WKtvD2A3E0CPEnPLlOhhx1Hv0F7xeCu4lg/pLYGe
         DoHdev+YFtoZX6zn5ekeeiQtgkimm8AykzPZ3T0BWd1QG9qDBZNAA+QYjfKWIChCv/mq
         qsElJLU//CbiEKGAMHcC4g/KTBIFZysxMzPzqzWAYp+E5P3PwoNxXgF3gklAnGi/Jo74
         uJgNC/GGlPIXoQp89YwojFRly4COm439TRWLw9gs+4ngItKRsuIiixU1wSu3Ewaep5MX
         qG6ftIlfDzRJTlfO09LOXoZjJPlC5SiK9mB2rA0F4eiYvRUux9xXHUmVMCn7KXLy3bbL
         zv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746140108; x=1746744908;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNCJTv4QrQ4B3OaOPUv7KzHf9QRM+3nfyGYGMjnG7a4=;
        b=GWvAJUs5ueR+FgG4QxEjY51WctSUsXnUOlHe86uRtLseu49XMi8lEAzobkHwKkPhfd
         SUn8ND8e4Jop5kPw7fERVja9/eIXkHLY5zzGPjqDrqpeJ6UjYw5s8zyDD0k84F6182XE
         4e0dek/xIyoY86n1pEQuxfRUIicJPIYyWay/kbBYKNYjeyO952XlgciPu8/fCfOXVTeQ
         4JG+zJ1OGCIT6tvvvwegsYGQz+cI70KEjc9Nx6800dPbNxegf3Sr8GAC++9Px22vD4wb
         hp+s1CyZlqUZkATLjiQq5lwWK6Mfi5tpA6PEK1MDe8aCktAZ/WukTsrQ+gMgmFxdzTMG
         PreQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9vYZZ9QdVsoHj7H3KHYymdJdCSb8953bvb8A9oMnLu9EDe0qjl4ywuTMJxQtSKEwha0Wi8g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9dmJAxuxVKnENBrQFcN+qv6ovXa0zeUE8vZ6xqMXJCmTjmr7p
	jy0vVdo5RMxjK5SQJ88Kkcyitf2ayT9VjcUSvz7P8HcKa7urLIYJdIsbwiNWKko+WmoNF6dgB23
	KcdIH8YtgqHwEBFAL2Q==
X-Google-Smtp-Source: AGHT+IFePvYLQ7V/eNV1P0Df7Ad2UiG5bDddcjGCSvEDCx2UtHLEg2L60VhGmHjpnGQSrNOz/HnaGeMSNQbxH4SP
X-Received: from pllw8.prod.google.com ([2002:a17:902:7b88:b0:22d:a5a9:8117])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:eccb:b0:224:c76:5e56 with SMTP id d9443c01a7336-22e10305acemr11904165ad.27.1746140108428;
 Thu, 01 May 2025 15:55:08 -0700 (PDT)
Date: Thu,  1 May 2025 15:54:07 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250501225425.635167-1-changyuanl@google.com>
Subject: [PATCH v7 00/18] kexec: introduce Kexec HandOver (KHO)
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: changyuanl@google.com, akpm@linux-foundation.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, 
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, 
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_155510_222050_FB9C1C5D 
X-CRM114-Status: GOOD (  37.81  )
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

Hi,

This is the version 7 of "kexec: introduce Kexec HandOver (KHO)" series
(https://lore.kernel.org/lkml/20250411053745.1817356-1-changyuanl@google.com/)
form Alexander Graf, Mike Rapoport, and Changyuan Lyu.

The patches are also available in git:
https://github.com/googleprodkernel/linux-liveupdate/tree/kho/v7.

Section "How to Use" below includes steps for you to try KHO.

v6 -> v7:
  - Remove `struct kho_serialization *` from kho_preserve_phys() and
    kho_preserve_folio() parameter list, which allows KHO users to
    preserve memory anytime before KHO finalization, not only just in
    notifier callbacks (v6).
  - Include the change [1] suggested by [2]
  - Split "x86: add KHO support" into small patches suggested by [3]
  - Include asm/early_ioremap.h [4]
  - Make KHO depend on 64BIT on x86 [5]
  - KHO fields (16 bytes) are defined in struct kimage unconditionally [5],
    replace a few #ifdef with IS_ENABLED().
  - Rebase the patchset to v6.15-rc4 such that tests in
    tools/testing/memblock can pass.

[1] https://lore.kernel.org/lkml/20250424083258.2228122-1-changyuanl@google.com/
[2] https://lore.kernel.org/lkml/aAeaJ2iqkrv_ffhT@kernel.org/
[3] https://lore.kernel.org/lkml/35c58191-f774-40cf-8d66-d1e2aaf11a62@intel.com/
[4] https://lore.kernel.org/lkml/20250424093302.3894961-1-arnd@kernel.org/
[5] https://lore.kernel.org/lkml/e90b81a4-a912-4174-b6e9-46a6ddd92ee3@intel.com/

Best,
Changyuan

= Original cover letter =

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
context pages and physical memory. See "pkernfs: Persisting guest memory
and kernel/device state safely across kexec" Linux Plumbers
Conference 2023 presentation for details:

  https://lpc.events/event/17/contributions/1485/

To start us on the journey to support all the use cases above, this patch
implements basic infrastructure to allow hand over of kernel state across
kexec (Kexec HandOver, aka KHO). As a really simple example target, we use
memblock's reserve_mem.
With this patch set applied, memory that was reserved using "reserve_mem"
command line options remains intact after kexec and it is guaranteed to
reside at the same physical address.

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
Linux. KHO is enabled in the kernel command line by `kho=on`. When the root
user enables KHO through /sys/kernel/debug/kho/out/finalize, the kernel
invokes callbacks to every KHO users to register preserved memory regions,
which contain drivers' states.

When the actual kexec happens, the fdt is part of the image
set that we boot into. In addition, we keep "scratch regions" available
for kexec: physically contiguous memory regions that are guaranteed to
not have any memory that KHO would preserve.  The new kernel bootstraps
itself using the scratch regions and sets all handed over memory as in use.
When drivers initialize that support KHO, they introspect the fdt, restore
preserved memory regions, and retrieve their states stored in the preserved
memory.

== Limitations ==

Currently KHO is only implemented for file based kexec. The kernel
interfaces in the patch set are already in place to support user space
kexec as well, but it is still not implemented it yet inside kexec tools.

== How to Use ==

To use the code, please boot the kernel with the "kho=on" command line
parameter. KHO will automatically create scratch regions. If you want to set
the scratch size explicitly you can use "kho_scratch=" command line parameter.
For instance, "kho_scratch=16M,512M,256M" will reserve a 16 MiB low
memory scratch area, a 512 MiB global scratch region, and 256 MiB
per NUMA node scratch regions on boot.

Make sure to have a reserved memory range requested with reserv_mem
command line option, for example, "reserve_mem=64m:4k:n1".

Then before you invoke file based "kexec -l", finalize
KHO FDT:

  # echo 1 > /sys/kernel/debug/kho/out/finalize

You can preview the generated FDT using `dtc`,

  # dtc /sys/kernel/debug/kho/out/fdt
  # dtc /sys/kernel/debug/kho/out/sub_fdts/memblock

`dtc` is available on ubuntu by `sudo apt-get install device-tree-compiler`.

Now kexec into the new kernel,

  # kexec -l Image --initrd=initrd -s
  # kexec -e

(The order of KHO finalization and "kexec -l" does not matter.)

The new kernel will boot up and contain the previous kernel's reserve_mem
contents at the same physical address as the first kernel.

You can also review the FDT passed from the old kernel,

  # dtc /sys/kernel/debug/kho/in/fdt
  # dtc /sys/kernel/debug/kho/in/sub_fdts/memblock

== Changelog ==

v5 -> v6:
  - Rebase the patchset on v6.15-rc1.
  - Revert hashtable-based API introduced in V5.
  - In kho_parse_scratch_size(), replace simple_strtoul() with kstrtouint().
  - Make KHO focus on memory preservation. Subsystem's metadata is not
    saved into KHO root tree, instead Subsystems allocate and create their
    own FDT and use KHO to preserve the FDT's underlying folios, suggested
    by [6].
  - Subsystem's own FDT is presented at debugfs kho/(in|out)/sub_fdts/$name.
  - Remove `fdt_max`, limit KHO root FDT to 1 page [6].
  - Move linked pages of bitmaps of preserved memory from
    /preserved-memory.metadata to preserved-memory-map of KHO root FDT
    as suggested in [1].
  - Add struct kho_serialization to hold the root FDT and struct
    kho_mem_track, and pass it through notifiers, as suggested in [2].
  - Update the KHO example of memblock. memblock now prepares its own FDT
    early. In the notifier callback, it only preserves the memory and saves
    its own FDT blob address to KHO root tree.
  - Add the doc of KHO property in node 'chosen' to
    github.com/devicetree-org/dt-schema [3] as requested in [4].
  - Add back YAML files to describe KHO and memblock FDT bindings as requested
    in [2]
  - Remove kho_restore_phys().
  - Move documentations to Documentation/admin-guide/kho.rst and
    Documentation/core-api/kho as requested in [5].
  - Split KHO from kexec in MAINTAINERS.
  - kho_restore_folio() refuses to create folios larger than
    MAX_PAGE_ORDER [7].
  - Fix the bug on arm64 reported in [8].
  - Fix the bug in kho_preserve_phys() reported in [9].
  - Check KHO root node "compatible" in kho_populate().

Since the discussion of the data format for serializing preserved memory [10] is
still going on, this version goes with the original xarray+bitmap approach
and save the optimization for future versions/patches.

[1] https://lore.kernel.org/all/20250212152336.GA3848889@nvidia.com/
[2] https://lore.kernel.org/all/20250321134629.GA252045@nvidia.com/
[3] https://github.com/devicetree-org/dt-schema/pull/158
[4] https://lore.kernel.org/all/55a5e3f3-1b3f-469b-bde0-69abfff826e4@kernel.org/
[5] https://lore.kernel.org/all/87wmcj69sg.fsf@trenco.lwn.net/
[6] https://lore.kernel.org/all/Z+GIRecXeYXiPrYv@nvidia.com/
[7] https://lore.kernel.org/all/mafs05xjmqsqc.fsf@amazon.de/
[8] https://lore.kernel.org/all/20250411034748.1781232-1-changyuanl@google.com/
[9] https://lore.kernel.org/all/20250411040207.1785245-1-changyuanl@google.com/
[10] https://lore.kernel.org/all/20250320015551.2157511-10-changyuanl@google.com/

v4 -> v5:
  - New: Preserve folios and address ranges in bitmaps [1]. Removed the
    `mem` property.
  - New: Hash table based API for manipulating the KHO state tree.
  - Change the concept of "active phase" to "finalization phase". KHO
    users can add/remove data into/from KHO DT anytime before the
    finalization phase.
  - Decouple kexec_file_load and KHO FDT creation. kexec_file_load can be
    done before KHO FDT is created.
  - Update the example usecase (reserve_mem) using the new KHO API,
    replace underscores with dashes in reserve-mem fdt generation.
  - Drop the YAMLs for now and add a brief description of KHO FDT before
    KHO schema is stable.
  - Move all sysfs interfaces to debugfs.
  - Fixed the memblock test reported in [2].
  - Incorporate fix for kho_locate_mem_hole() with !CONFIG_KEXEC_HANDOVER
    [3] into "kexec: Add KHO support to kexec file loads".

[1] https://lore.kernel.org/all/20250212152336.GA3848889@nvidia.com/
[2] https://lore.kernel.org/all/20250217040448.56xejbvsr2a73h4c@master/
[3] https://lore.kernel.org/all/20250214125402.90709-1-sourabhjain@linux.ibm.com/

v3 -> v4:
  - Major rework of scrach management. Rather than force scratch memory
    allocations only very early in boot now we rely on scratch for all
    memblock allocations.
  - Use simple example usecase (reserv_mem instead of ftrace)
  - merge all KHO functionality into a single kernel/kexec_handover.c file
  - rename CONFIG_KEXEC_KHO to CONFIG_KEXEC_HANDOVER

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

Alexander Graf (12):
  memblock: Add support for scratch memory
  kexec: add Kexec HandOver (KHO) generation helpers
  kexec: add KHO parsing support
  kexec: add KHO support to kexec file loads
  kexec: add config option for KHO
  arm64: add KHO support
  x86/kexec: add support for passing kexec handover (KHO) data
  x86/e820: temporarily enable KHO scratch for memory below 1M
  x86/boot: make sure KASLR does not step over KHO preserved memory
  x86/Kconfig: enable kexec handover for 64 bits
  memblock: add KHO support for reserve_mem
  Documentation: add documentation for KHO

Arnd Bergmann (1):
  kexec: include asm/early_ioremap.h

Mike Rapoport (Microsoft) (5):
  memblock: add MEMBLOCK_RSRV_KERN flag
  memblock: introduce memmap_init_kho_scratch()
  kexec: enable KHO support for memory preservation
  x86/setup: use memblock_reserve_kern for memory used by kernel
  Documentation: KHO: Add memblock bindings

 .../admin-guide/kernel-parameters.txt         |   25 +
 Documentation/admin-guide/mm/index.rst        |    1 +
 Documentation/admin-guide/mm/kho.rst          |  120 ++
 Documentation/core-api/index.rst              |    1 +
 Documentation/core-api/kho/bindings/kho.yaml  |   43 +
 .../kho/bindings/memblock/memblock.yaml       |   39 +
 .../kho/bindings/memblock/reserve-mem.yaml    |   40 +
 .../core-api/kho/bindings/sub-fdt.yaml        |   27 +
 Documentation/core-api/kho/concepts.rst       |   74 +
 Documentation/core-api/kho/fdt.rst            |   80 ++
 Documentation/core-api/kho/index.rst          |   13 +
 MAINTAINERS                                   |   12 +
 arch/arm64/Kconfig                            |    3 +
 arch/x86/Kconfig                              |    3 +
 arch/x86/boot/compressed/kaslr.c              |   52 +-
 arch/x86/include/asm/setup.h                  |    2 +
 arch/x86/include/uapi/asm/setup_data.h        |   13 +-
 arch/x86/kernel/e820.c                        |   18 +
 arch/x86/kernel/kexec-bzimage64.c             |   37 +
 arch/x86/kernel/setup.c                       |   42 +-
 arch/x86/realmode/init.c                      |    2 +
 drivers/of/fdt.c                              |   34 +
 drivers/of/kexec.c                            |   42 +
 include/linux/kexec.h                         |    5 +
 include/linux/kexec_handover.h                |  109 ++
 include/linux/memblock.h                      |   41 +-
 kernel/Kconfig.kexec                          |   14 +
 kernel/Makefile                               |    1 +
 kernel/kexec_file.c                           |   13 +
 kernel/kexec_handover.c                       | 1261 +++++++++++++++++
 kernel/kexec_internal.h                       |   16 +
 mm/Kconfig                                    |    4 +
 mm/internal.h                                 |    2 +
 mm/memblock.c                                 |  324 ++++-
 mm/mm_init.c                                  |   19 +-
 tools/testing/memblock/tests/alloc_api.c      |   22 +-
 .../memblock/tests/alloc_helpers_api.c        |    4 +-
 tools/testing/memblock/tests/alloc_nid_api.c  |   20 +-
 38 files changed, 2533 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/kho.rst
 create mode 100644 Documentation/core-api/kho/bindings/kho.yaml
 create mode 100644 Documentation/core-api/kho/bindings/memblock/memblock.yaml
 create mode 100644 Documentation/core-api/kho/bindings/memblock/reserve-mem.yaml
 create mode 100644 Documentation/core-api/kho/bindings/sub-fdt.yaml
 create mode 100644 Documentation/core-api/kho/concepts.rst
 create mode 100644 Documentation/core-api/kho/fdt.rst
 create mode 100644 Documentation/core-api/kho/index.rst
 create mode 100644 include/linux/kexec_handover.h
 create mode 100644 kernel/kexec_handover.c


base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
--
2.49.0.906.g1f30a19c02-goog

