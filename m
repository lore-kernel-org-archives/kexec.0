Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17720CD8C83
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 17:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wBqu7gqATn/ePsgOW55ydXsXkiRj2gt82F6mXc6KPbw=; b=5FXNkrPA1TY2m62OqgpitWtyyJ
	pMwY0A4JScUN/V+ycr+bPqO6j9Z/ydYb6YQv1RWYmlU6BJ5TcgidRKF2Fp3X5sOmbE3qOmuXTHHV4
	FtxNd35i3/0B1FKPdO894Y178XYr9Fb17h2OdDctqdkZCOBmMJAWF/P5Uqn9wq+lo354kwR2sQ9La
	pNGcBCXlXqOh9GzjOXKfCJ6yzJxS269ElYemmBiW1Rdv8QTFMS5gV0X9UySrncchXL10Zp0ILE4zo
	0VF1HuDHtr7SYWs4tFijNrmibBHdX26FgSs5hlzfV2aSN3LCstAde1ymSGalUpmTouKH509dg+NBT
	mgJvggIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVY2S-00000000xK6-05jN;
	Fri, 05 Jun 2026 17:08:56 +0000
Received: from mail-ej1-x649.google.com ([2a00:1450:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVY2P-00000000xFD-1E6o
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 17:08:54 +0000
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-bef1e83c990so196906766b.1
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 10:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780679331; x=1781284131; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wBqu7gqATn/ePsgOW55ydXsXkiRj2gt82F6mXc6KPbw=;
        b=Cb77HiX1Nd3ZPl6jrq0hwyk6gSRO3r1VaggaLXwPifDit1A8tew4+0M4XbekcHORR+
         znr/9r9qf22vTAbhJAHzjGIBOFBEP7sJOkb7waUEEzQeQGT6a8wNoMRd2AKLtlbLf0oI
         ZEwJfi4qjmdgWlp1SPpGE8v3eVqEhtcqLU47ayHU/LmsW9+qoF9jM4hljz0DkOKCozF+
         Qg0PZwPP9Cz9lrJfvNaNrceHTa2w6LrNkXz0Tblx6y+FgHf+F+DB1/wjPMs5OBsC9gSl
         V+tgnnQ9Va34o2aMVAcqFUg8/pgfu4Wmpct0O3PE5FDAZltBq2E04PVSu0DEUHxlczOm
         +D4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679331; x=1781284131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBqu7gqATn/ePsgOW55ydXsXkiRj2gt82F6mXc6KPbw=;
        b=nqyjsXdqW/V7HEYVJSGAFHs/Z+zfnZu2RuLW3sRdSY1QXBgTDn5Pn9O5Nx1z8PuOaA
         RWcx8QKhmiMgFrQDaYmBtEl6ZB0iKWp4biVKhSBDuma8gvu7VPzZiN4LoCFoaGxHI++K
         Fue86+67vR+O/2qDcTJ97eOyqXLTAETd7H/T78xygcyqX5mh3nI1xpWVCdr96vCxVXEN
         /uAVWQF1vBKyiqoGu5Uemux67pq1yvSJQKhlmab2F423HBCw+IxunSIIFE2HrCg5LIjt
         S2wH2gj3TZLCEkdrfn/7O4TYN70DgLaVWUFae8/3Ib8tQfeLt7cr7NA9oDHetywOVzzI
         crmw==
X-Forwarded-Encrypted: i=1; AFNElJ+Hnl34px8/Bi0J3ApajZy/swE5NSTrH9BGD6QCtSnUoSRL4+g+gqqm+B2fYrp6FklSd645wg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwdJ0MidTMZi7Lgx1NqAuj2E7hoo+JvoASCyvuzyxxmVniT/yjx
	d1WRSrNH/d/x4ttD+awbmqvMSd34gnjajAQHhGRnHmZvn4SSvK+5B4aPluHz4HAP2HD9Scbaibl
	Wxg6c8UGIhHiwnzATrw==
X-Received: from edpu11.prod.google.com ([2002:a50:eacb:0:b0:686:db44:c93])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3e20:b0:bd9:2b46:99b0 with SMTP id a640c23a62f3a-bf37330647dmr249281566b.49.1780679330530;
 Fri, 05 Jun 2026 10:08:50 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:08:33 +0000
In-Reply-To: <cover.1780676742.git.tarunsahu@google.com>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <f9430aa65709131d89d9d6be8b6e8aff4185bd63.1780676742.git.tarunsahu@google.com>
Subject: [RFC PATCH v2 08/10] docs: add documentation for guest_memfd
 preservation via LUO
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	Tarun Sahu <tarunsahu@google.com>, fvdl@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, 
	aneesh.kumar@kernel.org, skhawaja@google.com, vipinsh@google.com, 
	ackerleytng@google.com, Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, 
	dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com
Cc: linux-kselftest@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_100853_377812_4B23F58F 
X-CRM114-Status: GOOD (  19.00  )
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

Add the documentation under the "Preserving file descriptors" section
of LUO's documentation.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 Documentation/core-api/liveupdate.rst |   1 +
 Documentation/liveupdate/vmm.rst      | 103 ++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 3 files changed, 105 insertions(+)
 create mode 100644 Documentation/liveupdate/vmm.rst

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 5a292d0f3706..bac58a363151 100644
--- a/Documentation/core-api/liveupdate.rst
+++ b/Documentation/core-api/liveupdate.rst
@@ -34,6 +34,7 @@ The following types of file descriptors can be preserved
    :maxdepth: 1
 
    ../mm/memfd_preservation
+   ../liveupdate/vmm
 
 Public API
 ==========
diff --git a/Documentation/liveupdate/vmm.rst b/Documentation/liveupdate/vmm.rst
new file mode 100644
index 000000000000..0cd487a0e1a6
--- /dev/null
+++ b/Documentation/liveupdate/vmm.rst
@@ -0,0 +1,103 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+=============================
+VM & Guest_Memfd Preservation
+=============================
+
+.. kernel-doc:: virt/kvm/kvm_luo.c
+   :doc: KVM VM Preservation via LUO
+
+.. kernel-doc:: virt/kvm/guest_memfd_luo.c
+   :doc: Guest_Memfd Preservation via LUO
+
+VMM Instructions
+================
+
+This section describes the requirements, scope, conditions, and
+ordering constraints that a Virtual Machine Monitor (VMM) must adhere
+to for successful preservation and retrieval of guest_memfd files
+across a Live Update Orchestrator (LUO) sequence.
+
+Scope and Limitations
+---------------------
+
+At this stage, the scope of guest_memfd preservation is restricted to:
+
+1. **Fully Shared guest_memfd**:
+   This time only fully shared guest_memfd supported. Any system that
+   supports coco vm (which uses private guest_memfd), will not support
+   the preservation.
+
+2. **Standard Page Size**:
+   Only guest_memfd backed by standard page size (``PAGE_SIZE``,
+   order-0) pages is supported. Large/huge page backing (e.g.,
+   hugetlb guest_memfd) is not supported.
+
+Any Virtual Machine (VM) whose memory is fully backed by such
+guest_memfd files can be preserved across live update.
+
+VMM Actions and Conditions during Live Update
+---------------------------------------------
+
+During the live update sequence, the kernel introduces a *freezing*
+phase for the guest_memfd inode. Freezing prevents any modifications to
+the guest_memfd page cache. Specifically, once a guest_memfd mapping is
+frozen:
+
+- Any subsequent ``fallocate`` calls on the guest_memfd file descriptor
+  will fail and return ``-EPERM``.
+- Any new page faults (guest-side or host-userspace-side) that require
+  folio allocation will fail and return ``-EPERM``.
+
+To prevent vCPUs or VMM helper threads from failing due to these
+``-EPERM`` errors, the VMM must implement one of the following
+strategies:
+
+1. **Pause the VM (Recommended)**:
+   The VMM should pause/suspend all vCPUs before invoking the
+   preservation or freezing of the VM and guest_memfd files. This
+   ensures no new page faults or memory accesses can occur while the
+   guest_memfd is frozen.
+
+2. **Handle Fault Failures**:
+   If the VM is not paused, the VMM must be prepared to handle VM
+   exits or user page fault errors resulting from the ``-EPERM``
+   failures. The VMM must take appropriate action, such as
+   immediately pausing the VM, or aborting the live update sequence
+   (by tearing down or unpreserving the live update session).
+
+Preservation and Retrieval Ordering
+-----------------------------------
+
+Preservation Order
+~~~~~~~~~~~~~~~~~~
+
+There is no strict ordering requirement for initiating the
+preservation of the KVM VM file and the guest_memfd files; they are
+preserved independently. If kexec is triggered with guest_memfd
+preservation without preserving the vm file, kexec will fail.
+
+Retrieval Order
+~~~~~~~~~~~~~~~
+
+Similarly, there is no strict ordering required for retrieving the VM
+and guest_memfd files. Any file can be retrieved at any order.
+
+If guest_memfd file is retrieved and VM file is not retrieved, and
+luo_finish is called, then vm_file will be lost and guest_memfd file
+will be hanging around.
+
+VM & Guest_Memfd Preservation ABI
+=================================
+
+.. kernel-doc:: include/linux/kho/abi/kvm.h
+   :doc: DOC: guest_memfd Live Update ABI
+
+.. kernel-doc:: include/linux/kho/abi/kvm.h
+   :internal:
+
+See Also
+========
+
+- :doc:`/core-api/liveupdate`
+- :doc:`/userspace-api/liveupdate`
diff --git a/MAINTAINERS b/MAINTAINERS
index 16cba790a84d..ca459d032712 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14418,6 +14418,7 @@ L:	kexec@lists.infradead.org
 L:	kvm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	Documentation/liveupdate/vmm.rst
 F:	virt/kvm/guest_memfd_luo.c
 F:	virt/kvm/kvm_luo.c
 
-- 
2.54.0.1032.g2f8565e1d1-goog


