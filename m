Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957D1CD98F2
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 18:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ofu2helHDgwWpEtyPAHO+f27C99XXYOA9FQdc6q7UQo=; b=0j5dA5upLKpknjT2nED70tUiCr
	48uhXJJfnzSAvhnfX954L5Dm2tAvXqZ8cCHC+vLi8S1kWWhiOmWPl9yLLz7kMb1FdVRWAeFbjwSRW
	36SLqsJEKKpWeuXjWF5/XiZjkTxGTFEUYaj6KXxAasOklU6OW+jAhuKnoZ4ULLOXOYTfqIqz6zsLx
	HrNSW8RQ/7c4JW7kAbm805oZbpLQi6jxcbaAw0tfO/lo7CvLmouLnYT9i+6m4h4fYaiH1daPIDeua
	4h6PVrdAM5TDpzSqnLYD7yNu08stMlQf3SWeNFefmH9GcojOb0f4Ss8Ic28LT8baJK9CXFAO6VHeK
	GEk0bfCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjhp-00000005JNJ-1zFV;
	Mon, 22 Jun 2026 18:49:13 +0000
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjhn-00000005JJ0-2Rfk
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 18:49:12 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-695b677095eso4862679a12.0
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154149; x=1782758949; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ofu2helHDgwWpEtyPAHO+f27C99XXYOA9FQdc6q7UQo=;
        b=Yq65Q53LCrp4bezZGPFmf39LCvBbm60j1arBS4H4DD9JGuZ1Q5EgWjI/1n1Xxbzv9M
         a5g/DF5UbtFmaodNmfOwf+T+NAC5xC8+JllopJ7iFuHCip76RZ3p3gzumlTVrwiK2o+0
         zC6lv6FgssVpLByva2k7kHKh0gRbN0qEm2KOWVHTsiYYL/fxes+zy1lk7P4W2QgGS9jr
         Q1InuiPqs59wb9Y+rz9jcGV5unCTrRTZRIZuil4w0r4jB37gesiWrWncbxhEqbVKx0/h
         tPO4dHhxw/ujk/W30nNf7dqsK9GpDk5Uim6SgZYjDedmA7pw8jM9Iq4fqm6ztn3pbLYs
         yUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154149; x=1782758949;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ofu2helHDgwWpEtyPAHO+f27C99XXYOA9FQdc6q7UQo=;
        b=CTaqaWww9LkdljUtF4MBGmf9BotwLdE+P7lCtK7aL/oxk3gDKLXnUFN77wHK+Yf1MZ
         VvavSZ7e1veykIb+/xeJEhlRsbIBaOnJQLtaPZg3q3oIxknZECBPH9uZ83BwhZUIeV7u
         zgBFu5KhfYKy5f7m0WRdiaZK8O5kFHh1GDgJPsYRfO9JK/lmLQJEmtKdSJW1CpQZSz1u
         +7EqpDED6/F7jA0HpM1q1hyS4vMLt3NE+LMn9F7mqL/PW2IpoiGcVgWybl6DmIGut02I
         dLKWfeJySqumWdLFJPZUEPxY8Y5YeMEO2ojxeINI7rekFFIujtdItwz/a5O/034QCVA+
         MFEA==
X-Forwarded-Encrypted: i=1; AFNElJ8w1vQN4HwB3MByv3Qos5pcCUK0Mk8WPBg7lVVQbsAzpSq8ndHcm4BKH6wfm8ESfl23sHEv/A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyEeQkCNBmdJBE1Pj1RqFiM4w/wVyeNMigFDm77kGAXNtptb0Gh
	nsU+PnDkmnD7FEBqmDd5tZXdvStyAlKzFb/dowEU6Z9WMJ0IrKb5xlj5JYE/tlTPju7NbNO/1yk
	CbZb85lQVudrsu6DLnw==
X-Received: from edaa20.prod.google.com ([2002:a05:6402:24d4:b0:697:c28b:9d89])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:358e:b0:697:ad7f:58dc with SMTP id 4fb4d7f45d1cf-697ad7f5a8cmr2848079a12.17.1782154148645;
 Mon, 22 Jun 2026 11:49:08 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:48:49 +0000
In-Reply-To: <20260622184851.2309827-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260622184851.2309827-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622184851.2309827-8-tarunsahu@google.com>
Subject: [PATCH v3 7/9] docs: add documentation for guest_memfd preservation
 via LUO
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_114911_661155_38A070A3 
X-CRM114-Status: GOOD (  23.63  )
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
 Documentation/liveupdate/vmm.rst      | 107 ++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 virt/kvm/guest_memfd_luo.c            |   4 +-
 4 files changed, 111 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/liveupdate/vmm.rst

diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
index 5a292d0..bac58a3 100644
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
index 0000000..8353e23
--- /dev/null
+++ b/Documentation/liveupdate/vmm.rst
@@ -0,0 +1,107 @@
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
+NOTE: Before Initiating the preservation/retirval, it is necessary to make
+sure that the kvm module is loaded (/dev/kvm must be available).
+
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
index d1d699ce..e27b677 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14420,6 +14420,7 @@ L:	kexec@lists.infradead.org
 L:	kvm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	Documentation/liveupdate/vmm.rst
 F:	virt/kvm/guest_memfd_luo.c
 F:	virt/kvm/kvm_luo.c
 
diff --git a/virt/kvm/guest_memfd_luo.c b/virt/kvm/guest_memfd_luo.c
index c242b1d..8411fe8 100644
--- a/virt/kvm/guest_memfd_luo.c
+++ b/virt/kvm/guest_memfd_luo.c
@@ -119,11 +119,11 @@ static bool kvm_gmem_luo_can_preserve(struct liveupdate_file_handler *handler, s
 	/*
 	 * Only Fully-shared guest_memfd preservation is supported
 	 */
-	if (GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
+	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
 		return 0;
 
 	/*
-	 * It makes sure that no memory can converted to private
+	 * It makes sure that no memory can be converted to private
 	 * even if it was initially fully shared (in-place conversions are
 	 * prevented).
 	 */
-- 
2.55.0.rc0.786.g65d90a0328-goog


