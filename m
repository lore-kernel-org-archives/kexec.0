Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37D3C54F4C
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 12:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ARgzZjHeTdBuB8exqJqKuaM+KX+IhgDD0EDGHp8wJgQ=; b=FZ7cHjeNDPpJnO3Gi7bjYp/Hts
	o4cNP0//XdJFCeksQ0lF9fVVSgY8rs+0n5NDfsavbN8/dPzSD+FQrViqkly0IBwQzLLt9ZpfULKip
	3UHvhzN13w2bsygckIqP62Dlc22CXmLX9tcrAwv9TgLgL5DhQmV6BQup7TaA7qNY1aRIBZq60eZHE
	kwWB9KYSBgUfUTSiT28J+eah3pIkvlbYQMCWHN9ywXWkg63nv+PqJC5mG7gXQSPe7HmxDcG4XqeiU
	CN2qybZzVuXyCEczEA1giEiw0Xlq0fTJVL3L2jBUsnEYBqxzdSV0LzHZvLY61qdQLSWXtCb5ETz1C
	Y2csiIUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wogf7-00000005CqW-3bbU;
	Tue, 28 Jul 2026 12:11:57 +0000
Received: from mail-ej1-x645.google.com ([2a00:1450:4864:20::645])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wogf5-00000005CkW-0Pfw
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 12:11:56 +0000
Received: by mail-ej1-x645.google.com with SMTP id a640c23a62f3a-c15dfd34e4cso168679566b.0
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 05:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785240712; x=1785845512; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ARgzZjHeTdBuB8exqJqKuaM+KX+IhgDD0EDGHp8wJgQ=;
        b=ffk8mPjKrSFHnylBkBQCRgdBM6/pfAkIkpt3EMESVd5Md2UIh8z5d1yvxGpndmomqI
         q22cxplrcXe52ToEakc5MtX0XA3WtzkwXINlfWf+0beBHQNIKtTYyokeIBZW41HUy8YY
         zJAxVWBo/jqtPt3axUvcEpzxltERU5/L6R/iT8pJ924RApJ+XiJujYrdIcI5k2Z55KOg
         5z/KVhI+epTUw7b1xduePXG88ECJpZeVetKR2H4OlRc7egyMePs2vEMiCiSfYajG7asW
         4Gg8kDt7K5m6CPTSb778IXFnL81O85TiehtBQeAlQUTLfIV5G6RRd0TUd9q2vo6rSGnJ
         zBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785240712; x=1785845512;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ARgzZjHeTdBuB8exqJqKuaM+KX+IhgDD0EDGHp8wJgQ=;
        b=i/7ZwRq0/nADW521XCbxrMROUPW3BWmg8bPjQObmTWSgDkTycu6RacwTd01l+jKWiI
         2vB5u+deOthPiJ8u7caEwluYF5Xq5OdG7bAiRs++yUSejsKy8kHd18c8Z1LmppxP7scb
         6Vd4JbTFLkiyZR1w5++6Ed8rjsgI/CYGnjdGrbSN5n1P6uWjcJX46SzN0QrsqN1IOxm8
         iBgmtYbI/3qFSnhb6It+JCdYyWdLidP3f+lcCv7WqFaFUTxEiAALMDgMG60ch5Q5I7Y4
         W274MswS3pX+mIhjoMG8Uj8pb962taOVj1VQoFcLkUJyso8YMj68dnVf++l3KMmTA9OW
         wVuA==
X-Forwarded-Encrypted: i=1; AHgh+RohWSsm/yuJsOyWNN/+DBPB6Mxs8YiAK9ZLEhdf4ODU5/0mfrHp3hDgx5CxEW12PfAMQBVnWw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxdo4Kw+y3chZcaAjXFsU3DROIn9wMePa+qHoKiOLkWaHud3Axg
	YE7WbpQejjXCYRyVV1OTsaAR7atdfP6DW6IzylzskQAuoh/1i0bP1eQ0JZQoGVpeSX/wYiQMkXA
	wafpN+BprCMoYdAnGZQ==
X-Received: from ejjj6-n1.prod.google.com ([2002:a05:6938:a086:10b0:c15:be99:e164])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6938:a087:20b0:c16:3187:997e with SMTP id a640c23a62f3a-c1f71d61504mr70847266b.7.1785240711384;
 Tue, 28 Jul 2026 05:11:51 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:11:36 +0000
In-Reply-To: <20260728121138.1103610-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728121138.1103610-10-tarunsahu@google.com>
Subject: [PATCH v4 09/11] docs: liveupdate: Add documentation for VM and
 guest_memfd preservation
From: Tarun Sahu <tarunsahu@google.com>
To: ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Tarun Sahu <tarunsahu@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_051155_176320_D3B1B6BE 
X-CRM114-Status: GOOD (  20.13  )
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

Add Documentation/liveupdate/vmm.rst detailing VMM requirements, scope,
ordering constraints, and kernel-doc inclusions for KVM VM and
guest_memfd preservation via Live Update Orchestrator (LUO).

Also update Documentation/core-api/liveupdate.rst and MAINTAINERS.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 Documentation/core-api/liveupdate.rst |   1 +
 Documentation/liveupdate/vmm.rst      | 107 ++++++++++++++++++++++++++
 MAINTAINERS                           |   1 +
 3 files changed, 109 insertions(+)
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
index 000000000000..b8e8fb2b63c2
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
+   At this time only fully shared guest_memfd is supported. Any system that
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
+NOTE: Before Initiating the preservation/retrieval, it is necessary to make
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
index 8db8bb448b23..c032f9a0451b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14548,6 +14548,7 @@ L:	kexec@lists.infradead.org
 L:	kvm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	Documentation/liveupdate/vmm.rst
 F:	virt/kvm/guest_memfd_luo.c
 F:	virt/kvm/kvm_luo.c
 
-- 
2.55.0.229.g6434b31f56-goog


