Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32392C3ABBC
	for <kexec@archiver.kernel.org>; Fri,  9 May 2025 09:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g9Xx5Bx6AE8l9aAQnibOzIlzBa8etLyZf1E3FXceluo=; b=f3I3RE4h4gPuDjgb0drogSTx6+
	j4gA1OV1DI28jkS5J/a2CnjpNTaI4NTjGNehHvWqyeKZ6lOojh0Y6yeDdTcc/mZWEMjjjYv56I6Fo
	1nEvpxVPPRiMmfvkpLANRBppbELvAbX8QwaLO1pXf46UyLVkPjwfBFEolpO+JWnHLGE48ln/u0vFa
	l5unWhJ71TrvcKQd77Ecx3Uy0GmBhzK9+ciDhTqTFJlbjevUU+MASgROGTh6cZgORDGzsVxAxhkRp
	NfUELGUGWDX3OybvwOl2DtCeQXCLOkL8KF6ysVgrc88mSpIznWJXSPBej7Kl9LEX+h0P4iLHN/COx
	1fjsNY8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDJby-000000031iV-1wcY;
	Fri, 09 May 2025 09:01:42 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDIRZ-00000002nOs-1xq7
	for kexec@lists.infradead.org;
	Fri, 09 May 2025 07:46:54 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-b240fdc9c20so447638a12.3
        for <kexec@lists.infradead.org>; Fri, 09 May 2025 00:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746776812; x=1747381612; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g9Xx5Bx6AE8l9aAQnibOzIlzBa8etLyZf1E3FXceluo=;
        b=UWQ+T76+a67GZEY2G/wfWTZhr0vmgbZ5sDeOy05v/HDqBQMGBCdhJ/2dtg8oDaiZYc
         P86ydXLIb/cJakEs3IUe6xux68JKQ3m2lv5FrR1gcUHCzUskXgtArZRGUnlQwryrWdy5
         KkDeQ/NmROUl/noWM2FXkQpTd1+gg+7eMAFsK9RuiaiMy6vs+WrCQdYHW50f/awMeMBi
         9/tAcu5L8rFmj21IDSq7zmS5Nwyddkpp43JzwjUH7d0hRVpdygeKJh0Mq2/x9P+mqXyx
         B98PHnJFTW2r/jjyr5OKMig8zx+L21x4GoPXm9vKcQnWdLvBbPqGGsuJQtEsv5sDPX/8
         0WaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746776812; x=1747381612;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9Xx5Bx6AE8l9aAQnibOzIlzBa8etLyZf1E3FXceluo=;
        b=HYOLVKqWoj4FkS1tAOTnXPVnyP6ZzpU8HkLn2bPm+eecMPCcprHcOA5KZYqzUoGT1D
         ozT2tTPf94dthRXVmKquEbLv2PuYkTCZtVh8E4VMErvdnKXhQ2pPReeStULgpp6dynuG
         eAqpATBmdgAxwzf04E9b5QNBC3barNl+BTzU5XTYBDqYjgJj9iyFI6JCwb+d3oLEiBrD
         7GYTA8mpZ0vj5VN1B3MArp5h8YgkbKqNIcgbytHnXY4Shd1AkrPBEGbfsidvVmzr4hd/
         athPF7f27Rrl04cGnl+ycLied8R2Oq4ivVV+E0IReRF1u4d8xxf2S+3aHFpxonGXOby7
         tWWA==
X-Forwarded-Encrypted: i=1; AJvYcCUem36sFEpfjlYIiqf6exlddgqS9iUkm0Kv2vTIVPVb7YEG7hQJBWw6+6ABVnbwHVgVUyKejA==@lists.infradead.org
X-Gm-Message-State: AOJu0YysLukzHAG7NrKUT1D5R9BaepDcctLFoAPmiDpummOpuZxMOy8k
	2qH2wk/Z6ifVgaDcXZc0VFsfo42UKHK5er6mIpLzdOsVVjBhtdQSK2CQDB99FOHOHmvDq6qZDpH
	FCyAnUcIW7VaJXLjOuQ==
X-Google-Smtp-Source: AGHT+IFRBLwKNZOgHyRwzWB7rXEv6QczmcXY9tVl0K0kyfwj9bvM2rwgAfKyqtRRCr4JCdIb8YtBigcGf0S5jL2P
X-Received: from pgbcr6.prod.google.com ([2002:a05:6a02:4106:b0:b1f:f9aa:1ebd])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:495:b0:1f5:7280:1cf7 with SMTP id adf61e73a8af0-215abbbd50cmr2873445637.16.1746776812112;
 Fri, 09 May 2025 00:46:52 -0700 (PDT)
Date: Fri,  9 May 2025 00:46:18 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250509074635.3187114-1-changyuanl@google.com>
Subject: [PATCH v8 00/17] kexec: introduce Kexec HandOver (KHO)
From: Changyuan Lyu <changyuanl@google.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, 
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, 
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org, 
	Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_004653_519726_C7DB9ADD 
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

This is the version 8 of "kexec: introduce Kexec HandOver (KHO)" series
(https://lore.kernel.org/all/20250501225425.635167-1-changyuanl@google.com/)
form Alexander Graf, Mike Rapoport, and Changyuan Lyu.

The patches are also available in git:
https://github.com/googleprodkernel/linux-liveupdate/tree/kho/v8.

Section "How to Use" below includes steps for you to try KHO.

v7 -> v8:
  - Add `kho` prefix to reference labels in documentation and adjust the
    wording slightly [1]
  - Fold the fix from Arnd Bergmann into the base patch [2]
  - Remove the #ifdef in KASLR, update comments and changelog, as requested [3]
  - Remove kho_restore_folio() from reserve_mem_kho_retrieve_fdt() as at that
    stage, kho_mem_deserialize() has not been called yet.
  - In kho_memory_init(), call kho_restore_folio() to restore the KHO
    root FDT's folio.

[1] https://lore.kernel.org/all/aBl0kUIKryH5AUD5@archie.me/
[2] https://lore.kernel.org/all/20250501173557.1880f3aa8694352e0eb153b4@linux-foundation.org/
[3] https://lore.kernel.org/all/c348c507-c06b-4611-87f4-c498e144fa45@intel.com/

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

Mike Rapoport (Microsoft) (5):
  memblock: add MEMBLOCK_RSRV_KERN flag
  memblock: introduce memmap_init_kho_scratch()
  kexec: enable KHO support for memory preservation
  x86/setup: use memblock_reserve_kern for memory used by kernel
  Documentation: KHO: Add memblock bindings

 .../admin-guide/kernel-parameters.txt         |   25 +
 Documentation/admin-guide/mm/index.rst        |    1 +
 Documentation/admin-guide/mm/kho.rst          |  115 ++
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
 arch/x86/boot/compressed/kaslr.c              |   50 +-
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
 kernel/kexec_handover.c                       | 1266 +++++++++++++++++
 kernel/kexec_internal.h                       |   16 +
 mm/Kconfig                                    |    4 +
 mm/internal.h                                 |    2 +
 mm/memblock.c                                 |  317 ++++-
 mm/mm_init.c                                  |   19 +-
 tools/testing/memblock/tests/alloc_api.c      |   22 +-
 .../memblock/tests/alloc_helpers_api.c        |    4 +-
 tools/testing/memblock/tests/alloc_nid_api.c  |   20 +-
 38 files changed, 2524 insertions(+), 45 deletions(-)
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
2.49.0.1015.ga840276032-goog

