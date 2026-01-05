Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964FCC79FA8
	for <kexec@archiver.kernel.org>; Mon,  5 Jan 2026 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96ZVS4gPaDk5eMzZGMpmnaAYVEuV2kbwUBdzUG7AkYk=; b=t9queLuWlfCgqI0Qt6NiqhbrCJ
	UD5zaUu4YNA92lFgxCPqHEX1TSFxVQBNlaMy/ns2xwXFYAg7MYpbdq6FKAb0wfZGjE6ob0msSOev4
	XW0nnHYUrmwoXrjeXdiR/Nwg0crj8VrleGf1VkQN/RhfZFKuk7p4UmIe1NoKIkBCJY+/zcNvWA+Qv
	rk2ipZ3PQyMibLz5LcCWh1m4AJfj6zayxipD9dwlqXXMKPo8w9qvdG04QcJF+L2qURt9VcqW2A3TF
	9tVfP3YUNg1jOjESCN1DGzIjwSu6KfjwLPhApRqi5hMGGL8YPHqCFMW/T3yV1OznU5gKCkN9aQbKe
	ReHRyaFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcnv2-0000000Blqo-05aO;
	Mon, 05 Jan 2026 16:59:00 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcnuy-0000000Blp1-3QHm
	for kexec@lists.infradead.org;
	Mon, 05 Jan 2026 16:58:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0852840BEA;
	Mon,  5 Jan 2026 16:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29563C19421;
	Mon,  5 Jan 2026 16:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767632335;
	bh=zxh2YPOKqizJjGe+Ap+jtqn7sHfKPE2mtySzfuL7KxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n37oW5x1mJdnPr/2tkPCC4SAFIMlmlpQ30yFoHCuZ5jEaBh/A37wRI4JIACj/DIOF
	 6EOFDxjttRbkjriHhclNIPhHxlAnMIoyycuQ02kfvNbXI+U6FU6KF7yrZfel6SbESo
	 iJY2ijYDGVzh5pvDWkd+Zbd40xkyb9Bqi9BRKL1Z98pXg/uGUohCCMMV1w8MlgSonG
	 0QywLe79udHa/Y5WnFYtXjG+pGtTsmaByII4PYl9ZK9fIakh7fGM9YBTRspFYuqaxr
	 kbXDhVCY8j6BXl+867DsT8RTvgmJZr/mXfEj5pQenu5RIsgFwMMz6/EClNwC9CmsQP
	 bwLQAd8kCHiFQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/6] kho: docs: combine concepts and FDT documentation
Date: Mon,  5 Jan 2026 18:58:36 +0200
Message-ID: <20260105165839.285270-4-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105165839.285270-1-rppt@kernel.org>
References: <20260105165839.285270-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_085856_917278_822FB42B 
X-CRM114-Status: GOOD (  27.95  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Currently index.rst in KHO documentation looks empty and sad as it only
contains links to "Kexec Handover Concepts" and "KHO FDT" chapters.

Inline contents of these chapters into index.rst to provide a single
coherent chapter describing KHO.

While on it, drop parts of the KHO FDT description that will be superseded
by addition of KHO ABI documentation.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 Documentation/core-api/kho/concepts.rst | 74 -----------------------
 Documentation/core-api/kho/fdt.rst      | 80 -------------------------
 Documentation/core-api/kho/index.rst    | 73 ++++++++++++++++++++--
 Documentation/core-api/liveupdate.rst   |  2 +-
 Documentation/mm/memfd_preservation.rst |  2 +-
 5 files changed, 70 insertions(+), 161 deletions(-)
 delete mode 100644 Documentation/core-api/kho/concepts.rst
 delete mode 100644 Documentation/core-api/kho/fdt.rst

diff --git a/Documentation/core-api/kho/concepts.rst b/Documentation/core-api/kho/concepts.rst
deleted file mode 100644
index d626d1dbd678..000000000000
--- a/Documentation/core-api/kho/concepts.rst
+++ /dev/null
@@ -1,74 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0-or-later
-.. _kho-concepts:
-
-=======================
-Kexec Handover Concepts
-=======================
-
-Kexec HandOver (KHO) is a mechanism that allows Linux to preserve memory
-regions, which could contain serialized system states, across kexec.
-
-It introduces multiple concepts:
-
-KHO FDT
-=======
-
-Every KHO kexec carries a KHO specific flattened device tree (FDT) blob
-that describes preserved memory regions. These regions contain either
-serialized subsystem states, or in-memory data that shall not be touched
-across kexec. After KHO, subsystems can retrieve and restore preserved
-memory regions from KHO FDT.
-
-KHO only uses the FDT container format and libfdt library, but does not
-adhere to the same property semantics that normal device trees do: Properties
-are passed in native endianness and standardized properties like ``regs`` and
-``ranges`` do not exist, hence there are no ``#...-cells`` properties.
-
-KHO is still under development. The FDT schema is unstable and would change
-in the future.
-
-Scratch Regions
-===============
-
-To boot into kexec, we need to have a physically contiguous memory range that
-contains no handed over memory. Kexec then places the target kernel and initrd
-into that region. The new kernel exclusively uses this region for memory
-allocations before during boot up to the initialization of the page allocator.
-
-We guarantee that we always have such regions through the scratch regions: On
-first boot KHO allocates several physically contiguous memory regions. Since
-after kexec these regions will be used by early memory allocations, there is a
-scratch region per NUMA node plus a scratch region to satisfy allocations
-requests that do not require particular NUMA node assignment.
-By default, size of the scratch region is calculated based on amount of memory
-allocated during boot. The ``kho_scratch`` kernel command line option may be
-used to explicitly define size of the scratch regions.
-The scratch regions are declared as CMA when page allocator is initialized so
-that their memory can be used during system lifetime. CMA gives us the
-guarantee that no handover pages land in that region, because handover pages
-must be at a static physical memory location and CMA enforces that only
-movable pages can be located inside.
-
-After KHO kexec, we ignore the ``kho_scratch`` kernel command line option and
-instead reuse the exact same region that was originally allocated. This allows
-us to recursively execute any amount of KHO kexecs. Because we used this region
-for boot memory allocations and as target memory for kexec blobs, some parts
-of that memory region may be reserved. These reservations are irrelevant for
-the next KHO, because kexec can overwrite even the original kernel.
-
-.. _kho-finalization-phase:
-
-KHO finalization phase
-======================
-
-To enable user space based kexec file loader, the kernel needs to be able to
-provide the FDT that describes the current kernel's state before
-performing the actual kexec. The process of generating that FDT is
-called serialization. When the FDT is generated, some properties
-of the system may become immutable because they are already written down
-in the FDT. That state is called the KHO finalization phase.
-
-Public API
-==========
-.. kernel-doc:: kernel/liveupdate/kexec_handover.c
-   :export:
diff --git a/Documentation/core-api/kho/fdt.rst b/Documentation/core-api/kho/fdt.rst
deleted file mode 100644
index 62505285d60d..000000000000
--- a/Documentation/core-api/kho/fdt.rst
+++ /dev/null
@@ -1,80 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0-or-later
-
-=======
-KHO FDT
-=======
-
-KHO uses the flattened device tree (FDT) container format and libfdt
-library to create and parse the data that is passed between the
-kernels. The properties in KHO FDT are stored in native format.
-It includes the physical address of an in-memory structure describing
-all preserved memory regions, as well as physical addresses of KHO users'
-own FDTs. Interpreting those sub FDTs is the responsibility of KHO users.
-
-KHO nodes and properties
-========================
-
-Property ``preserved-memory-map``
----------------------------------
-
-KHO saves a special property named ``preserved-memory-map`` under the root node.
-This node contains the physical address of an in-memory structure for KHO to
-preserve memory regions across kexec.
-
-Property ``compatible``
------------------------
-
-The ``compatible`` property determines compatibility between the kernel
-that created the KHO FDT and the kernel that attempts to load it.
-If the kernel that loads the KHO FDT is not compatible with it, the entire
-KHO process will be bypassed.
-
-Property ``fdt``
-----------------
-
-Generally, a KHO user serialize its state into its own FDT and instructs
-KHO to preserve the underlying memory, such that after kexec, the new kernel
-can recover its state from the preserved FDT.
-
-A KHO user thus can create a node in KHO root tree and save the physical address
-of its own FDT in that node's property ``fdt`` .
-
-Examples
-========
-
-The following example demonstrates KHO FDT that preserves two memory
-regions created with ``reserve_mem`` kernel command line parameter::
-
-  /dts-v1/;
-
-  / {
-  	compatible = "kho-v1";
-
-	preserved-memory-map = <0x40be16 0x1000000>;
-
-  	memblock {
-		fdt = <0x1517 0x1000000>;
-  	};
-  };
-
-where the ``memblock`` node contains an FDT that is requested by the
-subsystem memblock for preservation. The FDT contains the following
-serialized data::
-
-  /dts-v1/;
-
-  / {
-  	compatible = "memblock-v1";
-
-  	n1 {
-  		compatible = "reserve-mem-v1";
-  		start = <0xc06b 0x4000000>;
-  		size = <0x04 0x00>;
-  	};
-
-  	n2 {
-  		compatible = "reserve-mem-v1";
-  		start = <0xc067 0x4000000>;
-  		size = <0x04 0x00>;
-  	};
-  };
diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
index 0c63b0c5c143..03cd9afbdb2e 100644
--- a/Documentation/core-api/kho/index.rst
+++ b/Documentation/core-api/kho/index.rst
@@ -4,10 +4,73 @@
 Kexec Handover Subsystem
 ========================
 
-.. toctree::
-   :maxdepth: 1
+Overview
+========
 
-   concepts
-   fdt
+Kexec HandOver (KHO) is a mechanism that allows Linux to preserve memory
+regions, which could contain serialized system states, across kexec.
 
-.. only::  subproject and html
+KHO uses :ref:`flattened device tree (FDT) <kho_fdt>` to pass information about
+the preserved state from pre-exec kernel to post-kexec kernel and :ref:`scratch
+memory regions <kho_scratch>` to ensure integrity of the preserved memory.
+
+.. _kho_fdt:
+
+KHO FDT
+=======
+Every KHO kexec carries a KHO specific flattened device tree (FDT) blob that
+describes the preserved state. The FDT includes properties describing preserved
+memory regions and nodes that hold subsystem specific state.
+
+The preserved memory regions contain either serialized subsystem states, or
+in-memory data that shall not be touched across kexec. After KHO, subsystems
+can retrieve and restore the preserved state from KHO FDT.
+
+Subsystems participating in KHO can define their own format for state
+serialization and preservation.
+
+.. _kho_scratch:
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
+KHO finalization phase
+======================
+
+To enable user space based kexec file loader, the kernel needs to be able to
+provide the FDT that describes the current kernel's state before
+performing the actual kexec. The process of generating that FDT is
+called serialization. When the FDT is generated, some properties
+of the system may become immutable because they are already written down
+in the FDT. That state is called the KHO finalization phase.
+
+See Also
+========
+
+- :doc:`/admin-guide/mm/kho`
diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 7960eb15a81f..e2aba13494cf 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -58,4 +58,4 @@ See Also
 ========
 
 - :doc:`Live Update uAPI </userspace-api/liveupdate>`
-- :doc:`/core-api/kho/concepts`
+- :doc:`/core-api/kho/index`
diff --git a/Documentation/mm/memfd_preservation.rst b/Documentation/mm/memfd_preservation.rst
index 66e0fb6d5ef0..a8a5b476afd3 100644
--- a/Documentation/mm/memfd_preservation.rst
+++ b/Documentation/mm/memfd_preservation.rst
@@ -20,4 +20,4 @@ See Also
 ========
 
 - :doc:`/core-api/liveupdate`
-- :doc:`/core-api/kho/concepts`
+- :doc:`/core-api/kho/index`
-- 
2.51.0


