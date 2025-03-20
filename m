Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1789AC36001
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iApjQxSPhTF/tl2rkU2LC3L+Sofo1JAgj9zbjrL2yA0=; b=fHteW7/wbwcoMSo2zJvIcJa5pH
	BVlyHL7xE1jbRk7EW1msWklRoY2fCy5r5FlBOKPIX8paEOXfQpNtFiwl+DJWP4taAUlIglt4wGRP0
	2p1BKBUmxaQqVllHLwgyQeZ2GujUIKEsFse2wHSaYfyOd237igk4wbDF2vczkHuBuEbeQtOjcLvby
	y/dmwaukx4l+DpJvDDWVWRM/a4P3X3MSfeIi5cEtasbkswkQ3FfHDJ3B73frjcWf6KEPf2k9+fTmh
	06Ddu4udr6J7N+ju1JdFACWQRFDLFjRfuqqx39s99SGWWLiUZQuOxCvxFogZwtGHZvUgZHv4wgmrJ
	rYJMKxJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHS6-0000000CUEm-2JBp;
	Thu, 20 Mar 2025 15:04:58 +0000
Received: from mail-pl1-f202.google.com ([209.85.214.202])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv591-0000000Aklh-1Trt
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 01:56:29 +0000
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-224347aef79so4645515ad.2
        for <kexec@lists.infradead.org>; Wed, 19 Mar 2025 18:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435786; x=1743040586; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iApjQxSPhTF/tl2rkU2LC3L+Sofo1JAgj9zbjrL2yA0=;
        b=okhhoXCzCePtuhAklcm/dy8fgA22qbaZtdgmzRgAF5hPB2AhRtolCj0VVY96Tcnzq0
         KZ1G23NjYnkN0FAjNRfymUZoCWy4F8ECiskw2qgbUcSSc8QUCDRBz7DwJAVTd49RMRaK
         sByDIluWmB1SV0+eh2iACMNqBpAOrkT4JE7lwXm53LpHReeKunl+U6o9p7sniwSWHekL
         TJfg1FL4LjOYWB1hcyhN1vf5ddzKxZ3Qp9oSqfxv1QmA/GJm2WZgjIIjzF+sQqX2iqJW
         JhPqYohe3M2YL0Zb9LN/wkiAOnOIvq3I/Cmtq5/ePELWhNhCkkpIwaLRP2AcWM8ZuiSS
         MFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435786; x=1743040586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iApjQxSPhTF/tl2rkU2LC3L+Sofo1JAgj9zbjrL2yA0=;
        b=gCmn7yD24qg8/Mu65QX5XUaP6rLM9BYau5LzzXadMWlVM7/NLCJGjcIt23MKbfRQKu
         m5RyBGy3t8D0mFg+l0sqR72Go1+q1o3laVudpFV+wMtUDYVmFxS7TJzV0HwZQ2rI0lqk
         JnN3eR7TmU82m+7Bb3+UbW4gu+xfM1XRq2SNKhZsDcYrdJTtzNhvhYowU3V5OQwdQOL1
         Mg2J8etGo7T2W5k9pltsKCG9L3wJa25kbpmlTdAyfoLoiUgCSCnxrropJWoDeCstOzDz
         Z4hsTKXAId0GuJSESeMd9EiMOpUpOYFdpHj1925tjNrVv3smipDVngstlZmJ6y36PIrP
         DIvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyZCmX78XY+PU5t9wSUSGfjW+DEUNf4BHmqlmLPs5CL/8cvaFtrmF17K3dl3cwMs2cusKqdg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwgfV6TUhUzX+5oq8z3Vzm3PcnbPR3Xf9p+T1VCw13j8K/jAVOz
	lc8qOFkya3GBWecYBuB025fTonU4ahsWVbjGIVwYQVCXtjxVx5roMhJXmprVWhtOQCIZAZbsMCu
	lxlg3uDRAsFV3Xp+rvA==
X-Google-Smtp-Source: AGHT+IGFSfyI7p/Qh0SdAoE1uQ2Phsg//Ps3doqJu8c++ecy3AeyWqH3lvhpNMjdI0PgAE047ECxcGLwH834CeR5
X-Received: from pjbpw8.prod.google.com ([2002:a17:90b:2788:b0:2fa:15aa:4d2b])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:22c1:b0:223:fd7f:2752 with SMTP id d9443c01a7336-22649a34325mr73764035ad.29.1742435786002;
 Wed, 19 Mar 2025 18:56:26 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:51 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-17-changyuanl@google.com>
Subject: [PATCH v5 16/16] Documentation: add documentation for KHO
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_185627_444113_9C18931A 
X-CRM114-Status: GOOD (  40.83  )
X-Mailman-Approved-At: Thu, 20 Mar 2025 08:04:44 -0700
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

From: Alexander Graf <graf@amazon.com>

With KHO in place, let's add documentation that describes what it is and
how to use it.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  25 ++++
 Documentation/kho/concepts.rst                |  70 +++++++++++
 Documentation/kho/fdt.rst                     |  62 +++++++++
 Documentation/kho/index.rst                   |  14 +++
 Documentation/kho/usage.rst                   | 118 ++++++++++++++++++
 Documentation/subsystem-apis.rst              |   1 +
 MAINTAINERS                                   |   1 +
 7 files changed, 291 insertions(+)
 create mode 100644 Documentation/kho/concepts.rst
 create mode 100644 Documentation/kho/fdt.rst
 create mode 100644 Documentation/kho/index.rst
 create mode 100644 Documentation/kho/usage.rst

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..d715c6d9dbb3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2698,6 +2698,31 @@
 	kgdbwait	[KGDB,EARLY] Stop kernel execution and enter the
 			kernel debugger at the earliest opportunity.
 
+	kho=		[KEXEC,EARLY]
+			Format: { "0" | "1" | "off" | "on" | "y" | "n" }
+			Enables or disables Kexec HandOver.
+			"0" | "off" | "n" - kexec handover is disabled
+			"1" | "on" | "y" - kexec handover is enabled
+
+	kho_scratch=	[KEXEC,EARLY]
+			Format: ll[KMG],mm[KMG],nn[KMG] | nn%
+			Defines the size of the KHO scratch region. The KHO
+			scratch regions are physically contiguous memory
+			ranges that can only be used for non-kernel
+			allocations. That way, even when memory is heavily
+			fragmented with handed over memory, the kexeced
+			kernel will always have enough contiguous ranges to
+			bootstrap itself.
+
+			It is possible to specify the exact amount of
+			memory in the form of "ll[KMG],mm[KMG],nn[KMG]"
+			where the first parameter defines the size of a low
+			memory scratch area, the second parameter defines
+			the size of a global scratch area and the third
+			parameter defines the size of additional per-node
+			scratch areas.  The form "nn%" defines scale factor
+			(in percents) of memory that was used during boot.
+
 	kmac=		[MIPS] Korina ethernet MAC address.
 			Configure the RouterBoard 532 series on-chip
 			Ethernet adapter MAC address.
diff --git a/Documentation/kho/concepts.rst b/Documentation/kho/concepts.rst
new file mode 100644
index 000000000000..174e23404ebc
--- /dev/null
+++ b/Documentation/kho/concepts.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. _concepts:
+
+=======================
+Kexec Handover Concepts
+=======================
+
+Kexec HandOver (KHO) is a mechanism that allows Linux to preserve state -
+arbitrary properties as well as memory locations - across kexec.
+
+It introduces multiple concepts:
+
+KHO State tree
+==============
+
+Every KHO kexec carries a state tree, in the format of flattened device tree
+(FDT), that describes the state of the system. Device drivers can register to
+KHO to serialize their state before kexec. After KHO, device drivers can read
+the FDT and extract previous state.
+
+KHO only uses the FDT container format and libfdt library, but does not
+adhere to the same property semantics that normal device trees do: Properties
+are passed in native endianness and standardized properties like ``regs`` and
+``ranges`` do not exist, hence there are no ``#...-cells`` properties.
+
+Scratch Regions
+===============
+
+To boot into kexec, we need to have a physically contiguous memory range that
+contains no handed over memory. Kexec then places the target kernel and initrd
+into that region. The new kernel exclusively uses this region for memory
+allocations before during boot up to the initialization of the page allocator.
+
+We guarantee that we always have such regions through the scratch regions: On
+first boot KHO allocates several physically contiguous memory regions. Since
+after kexec these regions will be used by early memory allocations, there is a
+scratch region per NUMA node plus a scratch region to satisfy allocations
+requests that do not require particular NUMA node assignment.
+By default, size of the scratch region is calculated based on amount of memory
+allocated during boot. The ``kho_scratch`` kernel command line option may be
+used to explicitly define size of the scratch regions.
+The scratch regions are declared as CMA when page allocator is initialized so
+that their memory can be used during system lifetime. CMA gives us the
+guarantee that no handover pages land in that region, because handover pages
+must be at a static physical memory location and CMA enforces that only
+movable pages can be located inside.
+
+After KHO kexec, we ignore the ``kho_scratch`` kernel command line option and
+instead reuse the exact same region that was originally allocated. This allows
+us to recursively execute any amount of KHO kexecs. Because we used this region
+for boot memory allocations and as target memory for kexec blobs, some parts
+of that memory region may be reserved. These reservations are irrelevant for
+the next KHO, because kexec can overwrite even the original kernel.
+
+.. _finalization_phase:
+
+KHO finalization phase
+======================
+
+To enable user space based kexec file loader, the kernel needs to be able to
+provide the FDT that describes the previous kernel's state before
+performing the actual kexec. The process of generating that FDT is
+called serialization. When the FDT is generated, some properties
+of the system may become immutable because they are already written down
+in the FDT. That state is called the KHO finalization phase.
+
+With the in-kernel kexec file loader, i.e., using the syscall
+``kexec_file_load``, KHO FDT is not created until the actual kexec. Thus the
+finalization phase is much shorter. User space can optionally choose to generate
+the FDT early using the debugfs interface.
diff --git a/Documentation/kho/fdt.rst b/Documentation/kho/fdt.rst
new file mode 100644
index 000000000000..70b508533b77
--- /dev/null
+++ b/Documentation/kho/fdt.rst
@@ -0,0 +1,62 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=======
+KHO FDT
+=======
+
+KHO uses the flattened device tree (FDT) container format and libfdt
+library to create and parse the data that is passed between the
+kernels. The properties in KHO FDT are stored in native format and can
+include any data KHO users need to preserve. Parsing of FDT subnodes is
+responsibility of KHO users, except for nodes and properties defined by
+KHO itself.
+
+KHO nodes and properties
+========================
+
+Node ``preserved-memory``
+-------------------------
+
+KHO saves a special node named ``preserved-memory`` under the root node.
+This node contains the metadata for KHO to preserve pages across kexec.
+
+Property ``compatible``
+-----------------------
+
+The ``compatible`` property determines compatibility between the kernel
+that created the KHO FDT and the kernel that attempts to load it.
+If the kernel that loads the KHO FDT is not compatible with it, the entire
+KHO process will be bypassed.
+
+Examples
+========
+
+The following example demonstrates KHO FDT that preserves two memory
+regions create with ``reserve_mem`` kernel command line parameter::
+
+  /dts-v1/;
+
+  / {
+  	compatible = "kho-v1";
+
+  	memblock {
+  		compatible = "memblock-v1";
+
+  		region1 {
+  			compatible = "reserve-mem-v1";
+  			start = <0xc07a 0x4000000>;
+			size = <0x01 0x00>;
+  		};
+
+		region2 {
+			compatible = "reserve-mem-v1";
+			start = <0xc07b 0x4000000>;
+			size = <0x8000 0x00>;
+		};
+
+  	};
+
+	preserved-memory {
+                metadata = <0x00 0x00>;
+        };
+  };
diff --git a/Documentation/kho/index.rst b/Documentation/kho/index.rst
new file mode 100644
index 000000000000..d108c3f8d15c
--- /dev/null
+++ b/Documentation/kho/index.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+========================
+Kexec Handover Subsystem
+========================
+
+.. toctree::
+   :maxdepth: 1
+
+   concepts
+   usage
+   fdt
+
+.. only::  subproject and html
diff --git a/Documentation/kho/usage.rst b/Documentation/kho/usage.rst
new file mode 100644
index 000000000000..b45dc58e8d3f
--- /dev/null
+++ b/Documentation/kho/usage.rst
@@ -0,0 +1,118 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+====================
+Kexec Handover Usage
+====================
+
+Kexec HandOver (KHO) is a mechanism that allows Linux to preserve state -
+arbitrary properties as well as memory locations - across kexec.
+
+This document expects that you are familiar with the base KHO
+:ref:`concepts <concepts>`. If you have not read
+them yet, please do so now.
+
+Prerequisites
+=============
+
+KHO is available when the ``CONFIG_KEXEC_HANDOVER`` config option is set to y
+at compile time. Every KHO producer may have its own config option that you
+need to enable if you would like to preserve their respective state across
+kexec.
+
+To use KHO, please boot the kernel with the ``kho=on`` command line
+parameter. You may use ``kho_scratch`` parameter to define size of the
+scratch regions. For example ``kho_scratch=16M,512M,256M`` will reserve a
+16 MiB low memory scratch area, a 512 MiB global scratch region, and 256 MiB
+per NUMA node scratch regions on boot.
+
+Perform a KHO kexec
+===================
+
+First, before you perform a KHO kexec, you can optionally move the system into
+the :ref:`KHO finalization phase <finalization_phase>` ::
+
+  $ echo 1 > /sys/kernel/debug/kho/out/finalize
+
+After this command, the KHO FDT is available in
+``/sys/kernel/debug/kho/out/fdt``.
+
+Next, load the target payload and kexec into it. It is important that you
+use the ``-s`` parameter to use the in-kernel kexec file loader, as user
+space kexec tooling currently has no support for KHO with the user space
+based file loader ::
+
+  # kexec -l Image --initrd=initrd -s
+  # kexec -e
+
+If you skipped finalization in the first step, ``kexec -e`` triggers
+FDT finalization automatically. The new kernel will boot up and contain
+some of the previous kernel's state.
+
+For example, if you used ``reserve_mem`` command line parameter to create
+an early memory reservation, the new kernel will have that memory at the
+same physical address as the old kernel.
+
+Unfreeze KHO FDT data
+=====================
+
+You can move the system out of KHO finalization phase by calling ::
+
+  $ echo 0 > /sys/kernel/debug/kho/out/finalize
+
+After this command, the KHO FDT is no longer available in
+``/sys/kernel/debug/kho/out/fdt``, and the states kept in KHO can be
+modified by other kernel subsystems again.
+
+debugfs Interfaces
+==================
+
+Currently KHO creates the following debugfs interfaces. Notice that these
+interfaces may change in the future. They will be moved to sysfs once KHO is
+stabilized.
+
+``/sys/kernel/debug/kho/out/finalize``
+    Kexec HandOver (KHO) allows Linux to transition the state of
+    compatible drivers into the next kexec'ed kernel. To do so,
+    device drivers will serialize their current state into an FDT.
+    While the state is serialized, they are unable to perform
+    any modifications to state that was serialized, such as
+    handed over memory allocations.
+
+    When this file contains "1", the system is in the transition
+    state. When contains "0", it is not. To switch between the
+    two states, echo the respective number into this file.
+
+``/sys/kernel/debug/kho/out/fdt_max``
+    KHO needs to allocate a buffer for the FDT that gets
+    generated before it knows the final size. By default, it
+    will allocate 10 MiB for it. You can write to this file
+    to modify the size of that allocation.
+
+``/sys/kernel/debug/kho/out/fdt``
+    When KHO state tree is finalized, the kernel exposes the
+    flattened device tree blob that carries its current KHO
+    state in this file. Kexec user space tooling can use this
+    as input file for the KHO payload image.
+
+``/sys/kernel/debug/kho/out/scratch_len``
+    To support continuous KHO kexecs, we need to reserve
+    physically contiguous memory regions that will always stay
+    available for future kexec allocations. This file describes
+    the length of these memory regions. Kexec user space tooling
+    can use this to determine where it should place its payload
+    images.
+
+``/sys/kernel/debug/kho/out/scratch_phys``
+    To support continuous KHO kexecs, we need to reserve
+    physically contiguous memory regions that will always stay
+    available for future kexec allocations. This file describes
+    the physical location of these memory regions. Kexec user space
+    tooling can use this to determine where it should place its
+    payload images.
+
+``/sys/kernel/debug/kho/in/fdt``
+    When the kernel was booted with Kexec HandOver (KHO),
+    the state tree that carries metadata about the previous
+    kernel's state is in this file in the format of flattened
+    device tree. This file may disappear when all consumers of
+    it finished to interpret their metadata.
diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
index b52ad5b969d4..5fc69d6ff9f0 100644
--- a/Documentation/subsystem-apis.rst
+++ b/Documentation/subsystem-apis.rst
@@ -90,3 +90,4 @@ Other subsystems
    peci/index
    wmi/index
    tee/index
+   kho/index
diff --git a/MAINTAINERS b/MAINTAINERS
index a000a277ccf7..d0df0b380e34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12828,6 +12828,7 @@ F:	include/linux/kernfs.h
 KEXEC
 L:	kexec@lists.infradead.org
 W:	http://kernel.org/pub/linux/utils/kernel/kexec/
+F:	Documentation/kho/
 F:	include/linux/kexec*.h
 F:	include/uapi/linux/kexec.h
 F:	kernel/kexec*
-- 
2.48.1.711.g2feabab25a-goog


