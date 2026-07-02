Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30493C43458
	for <kexec@archiver.kernel.org>; Thu,  2 Jul 2026 17:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cFmIg3hL0q3j/Hsjk04HwbZaeoVYUJNjVvmJepwmBGc=; b=CxPl7eTxrX+ZThm5VHK+1aZO2h
	DLLnY+4K1bdI+y+RVidALfP0KFW3CaiODX/TB9imygkMdEPv+ypeDQiMsrWLY39sKPSE0wR9WnrII
	tAdPj0WCDVFYI/WON2VH7YQV+U+On1TrqzkN/Q28bEn9Tc/HuuzHx50aMhwnr6y5ciu8wdq32KhwW
	NG4cUOegjaWU9EZFG7UBN6e4xlqW1I6c+jvyexfg+RA03RhhVJ5cX/hRh9WqYFVvMLEoq7pSatm1E
	Y8X9LBkhCL09nd65bEhIuiwONUXW0UfXfioVJTQf5GeOmWbTxzyneyLwyn4ZJTLCq9cbyULzxFP8v
	36eazIrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLdf-00000005Bqr-0sC4;
	Thu, 02 Jul 2026 17:55:51 +0000
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.42.203.116])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfLdb-00000005BqH-3msI
	for kexec@lists.infradead.org;
	Thu, 02 Jul 2026 17:55:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1783014947; x=1814550947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cFmIg3hL0q3j/Hsjk04HwbZaeoVYUJNjVvmJepwmBGc=;
  b=mNDGU2OTVjCTPZinyNv0A5ldXSpWkQ2mFwnN89yVKfaHHZp5CmFyPMRz
   VCRuYqgOSoePVpJ448KA53FA3NuBzALU1V3MXHVlYol0cdekylF4HLuhm
   iAPFEgaX30F9+mpbvGvyrKxsoInNXIt5K0MPV6AaV8UeW6vN8hs5xlTpL
   LehCneA+okJ4AhaH/I5KTsjYkmeewXkx/5EvJQtqOlziK2dF2jaNU0Ffe
   DZ6BgJW8DRMLSdjHF2+O+x69zYe2qMcwd3zOIW7L/4lvKI211PxWoLT1r
   AcApw9e158ofqSPljoaGmP34eCTTFd41trtLGYobOv7cxs9/cQKf0zCEj
   A==;
X-CSE-ConnectionGUID: x2XGedNhRU+MjL1IjezJNg==
X-CSE-MsgGUID: 6OL4jp4yTPCWXa1bmw4Crw==
X-IronPort-AV: E=Sophos;i="6.25,144,1779148800"; 
   d="scan'208";a="22965889"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 17:55:47 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:18776]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.225:2525] with esmtp (Farcaster)
 id 809b607f-dbc9-423e-b071-6f20917d738b; Thu, 2 Jul 2026 17:55:47 +0000 (UTC)
X-Farcaster-Flow-ID: 809b607f-dbc9-423e-b071-6f20917d738b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 2 Jul 2026 17:55:46 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43; Thu, 2 Jul 2026
 17:55:43 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Tejun Heo
	<tj@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, "David
 Matlack" <dmatlack@google.com>, Samiullah Khawaja <skhawaja@google.com>,
	Alexander Graf <graf@amazon.com>, <linux-mm@kvack.org>,
	<kexec@lists.infradead.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 13/14] Documentation: add lazy sysfs initialisation and device_sysfs_entry docs
Date: Thu, 2 Jul 2026 19:51:13 +0200
Message-ID: <20260702175114.24659-9-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702175114.24659-1-sakacpav@amazon.de>
References: <20260702174033.32116-1-sakacpav@amazon.de>
 <20260702175114.24659-1-sakacpav@amazon.de>
MIME-Version: 1.0
X-Originating-IP: [172.19.96.155]
X-ClientProxiedBy: EX19D035UWA002.ant.amazon.com (10.13.139.60) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_105548_036687_D905B3DF 
X-CRM114-Status: GOOD (  29.93  )
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

Document the lazy sysfs mechanism and its declarative walker:

  - Documentation/driver-api/sysfs-lazy.rst: developer guide
    covering overview, opting-in, populate callbacks (per-device
    walker and the iommu_group small-table pattern), locking,
    teardown, known limitations, and a "See also" section
    pointing to the KUnit tests and the kselftest.

  - Documentation/ABI/testing/sysfs-lazy: userspace-visible
    semantics - lookup vs readdir trigger points, stat() behaviour
    on known and unknown names, inotify / fanotify interaction,
    udev cold-plug compatibility, and the list of currently
    opted-in device classes (SR-IOV VFs, VFIO, iommu_groups).

  - Documentation/driver-api/index.rst: add sysfs-lazy to the
    toctree.

  - MAINTAINERS: add F: entries for the new docs, the KUnit test
    drivers/base/test/device_sysfs_apply_test.c, and the
    tools/testing/selftests/sysfs-lazy/ directory (added in the
    next commit) under DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: driver-core@lists.linux.dev
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 Documentation/ABI/testing/sysfs-lazy    |  77 +++++++++++++
 Documentation/driver-api/index.rst      |   1 +
 Documentation/driver-api/sysfs-lazy.rst | 146 ++++++++++++++++++++++++
 MAINTAINERS                             |   4 +
 4 files changed, 228 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-lazy
 create mode 100644 Documentation/driver-api/sysfs-lazy.rst

diff --git a/Documentation/ABI/testing/sysfs-lazy b/Documentation/ABI/testing/sysfs-lazy
new file mode 100644
index 0000000000000..3a1b2a0e97e1c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-lazy
@@ -0,0 +1,77 @@
+What:		/sys/devices/.../
+		/sys/kernel/iommu_groups/<N>/
+Date:		May 2026
+KernelVersion:	7.1
+Contact:	Pavol Sakac <sakacpav@amazon.de>
+Description:
+		This entry documents the *realisation timing* contract
+		for sysfs entries under devices that have opted into
+		lazy population.  All attribute names, contents, modes,
+		and ownership are identical to the eager-device tree;
+		only the moment of creation differs.  The opt-in set is
+		enumerated in "Currently opted-in device classes" below.
+
+		When a device driver sets the sysfs_lazy flag on a struct
+		device before calling device_add(), the kernel defers
+		creation of attribute files, attribute groups, and
+		class/bus/driver symlinks under that device's sysfs
+		directory.
+
+		These entries are materialised on demand:
+
+		- A lookup (open, stat, readlink) of a specific filename
+		  triggers creation of that single file or symlink via
+		  the ktype->populate callback, which drives
+		  device_sysfs_apply() with DEV_SYSFS_ADD_ONE.
+		- A directory listing (readdir / getdents) triggers
+		  creation of all deferred entries at once via the
+		  ktype->populate_all callback, which drives
+		  device_sysfs_apply() with DEV_SYSFS_ADD_ALL.
+
+		A stat() call on a not-yet-realised filename:
+
+		- If the name corresponds to a known row (including one
+		  owned by dev->type->entries), the attribute or
+		  symlink is created and stat() succeeds with the same
+		  metadata an eager device would show.
+		- If the name is unknown, stat() returns -ENOENT and
+		  kernfs caches a negative dentry.  Transient errors
+		  (-ENOMEM, -EBUSY) propagate unchanged and are NOT
+		  negative-cached; the next lookup retries.
+		  access(F_OK) behaves identically to stat().
+
+		readdir() returns the full set of names the device
+		would expose if eager - applies_to gating is evaluated
+		during populate_all(), so the visible set exactly
+		matches the eager-device tree.
+
+		Once a row's entry is realised, it persists for the
+		lifetime of the device.  A second open()/stat() is a
+		plain kernfs lookup and involves no walker invocation.
+
+		What does NOT change relative to an eager device:
+
+		- The set of files and their names (applies_to is the
+		  single gate, identical between eager and lazy paths).
+		- File contents, permissions, ownership, and SELinux
+		  labels.
+		- The device directory itself (always eager) and its
+		  parent chain.
+
+		Interaction with inotify / fanotify:
+		  Watchers see IN_CREATE events at first-access time,
+		  not at device_add() time.
+
+		Interaction with udev / systemd-udevd:
+		  udev cold-plug works without modification.  udev
+		  reads the device directory on KOBJ_ADD, which
+		  triggers readdir -> full realisation.
+
+		Currently opted-in device classes:
+
+		- PCI SR-IOV Virtual Functions (drivers/pci/iov.c)
+		- VFIO group and vfio-dev children (drivers/vfio/)
+		- IOMMU groups (/sys/kernel/iommu_groups/<N>/,
+		  drivers/iommu/iommu.c)
+
+Users:		udev, systemd-udevd, libvirt, DPDK, SPDK
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index eaf7161ff9578..b1807ca6cd1ce 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -23,6 +23,7 @@ of interest to most developers working on device drivers.
    driver-model/index
    device_link
    infrastructure
+   sysfs-lazy
    ioctl
    pm/index
 
diff --git a/Documentation/driver-api/sysfs-lazy.rst b/Documentation/driver-api/sysfs-lazy.rst
new file mode 100644
index 0000000000000..5fbd7732afe0d
--- /dev/null
+++ b/Documentation/driver-api/sysfs-lazy.rst
@@ -0,0 +1,146 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+Lazy sysfs initialisation
+=========================
+
+Overview
+========
+
+``device_add()`` normally creates every sysfs attribute, attribute
+group, and class/bus/driver symlink under a new device's directory
+synchronously.  For populations created in bulk - hundreds of PCI
+SR-IOV VFs, fleets of vfio-dev children - that work dominates
+``device_add()`` latency yet the resulting sysfs nodes are rarely
+read.
+
+Lazy sysfs defers attribute creation until the directory is first
+opened by userspace.  The device directory itself, its parent chain,
+and uevent broadcast remain eager; only the *content* of the
+directory is deferred.
+
+Opting in
+=========
+
+A subsystem opts a device in by:
+
+1. Calling ``device_set_sysfs_lazy(dev)`` before ``device_add()``.
+2. Making the kernfs directory created by ``device_add()`` a lazy
+   directory via ``kernfs_set_lazy()``.
+
+``kernfs_set_lazy()`` flips ``KERNFS_LAZY`` on a directory under
+``kernfs_rwsem`` and returns ``-EINVAL`` for namespaced nodes (a
+non-NULL namespace tag or the ``KERNFS_NS`` flag) and non-directory
+nodes: lazy dispatch does not carry an active namespace tag into the
+populate callback.
+
+The flag is set once and never cleared.
+
+Populate callbacks
+==================
+
+A lazy directory's first ``readdir(3)`` or ``open(2)`` of a
+not-yet-created child invokes one of two callbacks defined on
+``struct kobj_type``::
+
+    int (*populate)(struct kobject *kobj, const char *name);
+    void (*populate_all)(struct kobject *kobj);
+
+``populate(name)`` runs on a named lookup miss and creates the single
+matching attribute.  ``populate_all()`` runs on the first
+``readdir(3)`` and creates every attribute the device exposes.
+
+For a ``struct device``, the driver core wires both callbacks to
+``device_sysfs_apply()``, which walks an immutable
+``device_sysfs_entry`` table.  Each row declares an
+``applies_to(dev)`` predicate, a ``create(dev, name)`` action, and a
+``remove(dev)`` action.  The walker dispatches the rows whose
+predicate passes for ``@dev``; the rows themselves call
+``sysfs_create_file()``, ``sysfs_create_link()``, or
+``sysfs_create_group()`` directly.
+
+The same pattern is used by ``iommu_group``: a lazy ``iommu_group``
+kobject's ``populate``/``populate_all`` walks a small fixed table of
+group attributes (``reserved_regions``, ``type``).
+
+Locking
+=======
+
+Each lazy device holds ``dev->sysfs_lazy->lock`` (a mutex).  All
+three populate paths take it::
+
+    populate(name)      -> mutex_lock(lock)
+                          walk(ADD_ONE, name)
+                          mutex_unlock
+    populate_all()      -> if (test_bit(POPULATED)) return;
+                          mutex_lock(lock)
+                          if (test_bit(POPULATED)) goto out;
+                          if (dev->p->dead)        goto out;
+                          walk(ADD_ALL, NULL)
+                          set_bit(POPULATED)
+                          mutex_unlock
+    REMOVE_ALL teardown -> mutex_lock(lock)
+                          walk(REMOVE_ALL, NULL)
+                          mutex_unlock
+
+The ``dev->sysfs_lazy->populated`` bool is the
+``populate_all()`` once-latch.  The unlocked read fast path is a
+performance optimisation; the field is only authoritative under
+``lock``.  A stale false on the fast path harmlessly retakes
+the mutex and re-checks.
+
+Lock ordering: ``lock`` nests inside any caller-held VFS or
+kernfs lock that brought us into ``populate``/``populate_all``.  No
+sysfs / kernfs operation that requires ``kernfs_rwsem`` write may be
+issued while holding ``lock``.
+
+The ``iommu_group`` path uses the same pattern:
+``group->sysfs_lazy.lock`` and
+``group->sysfs_lazy.populated``.
+
+Teardown
+========
+
+``device_del()`` sets ``dev->p->dead`` *before* the
+``REMOVE_ALL`` walker call and takes ``lock`` around it.
+Any populate callback racing with ``device_del()``:
+
+1. Either takes the lock first and runs against a not-yet-dead
+   device (its created files are torn down a moment later by
+   ``REMOVE_ALL``, which is idempotent against the row's
+   ``remove()``); or
+2. Sees ``dev->p->dead == true`` after acquiring the lock and bails
+   without creating anything.
+
+Either way, the device exits with a quiesced sysfs subtree and no
+populate callback sees a half-deleted device.
+
+``iommu_group_release()`` follows the same dead-flag + lock-then-walk
+contract.
+
+Known limitations
+=================
+
+* Lazy sysfs is only available for devices whose populate path is
+  driven through ``device_sysfs_entry`` rows.  Subsystems with bespoke
+  ``device_add()``-time sysfs creation must migrate before opting in.
+* Namespaced kobjects cannot be marked lazy: ``kernfs_set_lazy()``
+  rejects them because the populate callback does not carry the
+  active namespace tag.
+* The directory's eager skeleton (the directory inode itself and the
+  ``uevent`` file emitted by ``device_add()``) is not deferred.
+* Per-attribute creation cost is unchanged.  Lazy sysfs amortises
+  the cost across first-access events instead of paying it during
+  ``device_add()``.
+
+See also
+========
+
+* ``include/linux/kernfs.h`` - ``kernfs_set_lazy()``, ``KERNFS_LAZY``.
+* ``drivers/base/core.c`` - ``device_sysfs_apply()``,
+  ``driver_core_sysfs_entries[]``.
+* ``drivers/iommu/iommu.c`` - ``iommu_group_lazy_attrs[]``.
+* ``drivers/base/test/device_sysfs_apply_test.c`` - KUnit walker
+  contract tests.
+* ``tools/testing/selftests/sysfs-lazy/`` - userspace VFS-level
+  parity tests.
diff --git a/MAINTAINERS b/MAINTAINERS
index 5d8a887c868ed..1424e641d535f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7800,9 +7800,12 @@ M:	Danilo Krummrich <dakr@kernel.org>
 L:	driver-core@lists.linux.dev
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git
+F:	Documentation/ABI/testing/sysfs-lazy
 F:	Documentation/core-api/kobject.rst
 F:	Documentation/driver-api/driver-model/
+F:	Documentation/driver-api/sysfs-lazy.rst
 F:	drivers/base/
+F:	drivers/base/test/device_sysfs_apply_test.c
 F:	fs/debugfs/
 F:	fs/sysfs/
 F:	include/linux/device/
@@ -7830,6 +7833,7 @@ F:	samples/rust/rust_debugfs_scoped.rs
 F:	samples/rust/rust_driver_platform.rs
 F:	samples/rust/rust_driver_faux.rs
 F:	samples/rust/rust_soc.rs
+F:	tools/testing/selftests/sysfs-lazy/
 
 DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
 M:	Nishanth Menon <nm@ti.com>
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


