Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EF6CCF2DA
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 02:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YAWJPU0bKj56z57yKFJ+IjOtblegGIXvDvyM4kHd1kM=; b=QhSTVInWCfkenV2rMpxXE28Rcq
	lm+URT3HdgGNvw+OICSmtFCSTCHubn53XllDDq/yzNlm0WhdhByDmd+Qc4eHsH1Lh22vXhzkNiAH/
	OPIuoiffiXE4T/1IPKxv6iVV/i6azg3cybPkL0wDXUBcuSq73yIee2iHonEG74vtOeBW3kOcomEI7
	X9S92VPkOBogwhGdAGXZ4kkbRuDcZzg39JiibOjh+w01t6gBb65466xaHryjVQvtMp/d4iivCfn55
	bj8RfovzJsq2TYO4RYvZaGFgzWMYRkt3BQUBm3RXEsymixu5eV9P4dnHwJOY/PrgszKJ59hm78LVQ
	W1EEBD2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcqO-00000006RPJ-2u8a;
	Mon, 19 Oct 2026 02:11:20 +0000
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcqL-00000006ROW-1ena
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 02:11:18 +0000
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-5eaabf28c06so1931347e0c.2
        for <kexec@lists.infradead.org>; Sun, 18 Oct 2026 19:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792375876; x=1792980676; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YAWJPU0bKj56z57yKFJ+IjOtblegGIXvDvyM4kHd1kM=;
        b=GN6pgn+7QxVBnW31PD+D64oGPrBjVj2ZWwSHVZIFT3BQR0fcI8KHjrxYmQKAkTY9FF
         aEiqoSGT1o85p6Mek81GBJ3QFjrJ473BM8dLj/jkICpN46H6Njmv+o1qqqkSGtkv+OKR
         K95vDuiWlTVGlFAEwseDx6u+dpSrEQKEiS42RJ76P/lqC+JkkMT4zFop7XBB4Hx5Jz7y
         /eOawJwPt3HCWj01eRLjjde3fUEaJamKoaXNrhsBOGoRneYpgG24NycrrKTzLkwvZ44b
         pLHEgaMqBl49v5Il1NCzik61W/omN5C8kBlWQ5o3F3lAXvxz+t/kFmcoKkOLLbgj2WWR
         GdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375876; x=1792980676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YAWJPU0bKj56z57yKFJ+IjOtblegGIXvDvyM4kHd1kM=;
        b=vnAjevjdG00GV5EuEcOmiWPNQwbUfj0uoMRynovKyV53+/iZNy2xRYXr/GNUsjuVa6
         GEzXVpayD1AeMK4rsO4Q8tTjHvo6Z4pTg1+/VY/nmpa4zlZ7hrJraGsg3puqLcUqITco
         RSXXp5opS3IUg4qeP5rw9o9kWYEGsggqvKlTCCyOU5Ao9yU16sfbuxgebqpY/nNvh8FY
         VQ1x/bAFTL8uDZ8fu0wopEP67UqkL2gOMbvQGtf32eqncs8S8JgiJGx8RZOauuyPqPii
         SeWJoRluLaDz971kGZ+pSeddoEhOOeR9k962ttFbqh9wdCEeHMI9xzqu8As/BWccffen
         +T4g==
X-Forwarded-Encrypted: i=1; AKwUvBywrw2JxC+oUOsMjrPbo5Na4rkEDEPa1y2u6K+2L6c/+WLWOYLxE4BghFivzAvnQiotniLvNQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYIS8G61Lyqt6hmL2wIvhNsUSt/D933aYdeXyuWjofEgT+2gEO+V
	js5CJOeePgxfFMN2JFcNNR+RkfGaD9YqAPuuWR0vSvZmzKfabaNtJu6XWt0GdSwqXOfORVmRBUC
	STbTh
X-Gm-Gg: AYBFou2ug8RZ3RrMPSatYTP7BmqVM+qGuHJopfyJ3oAF1GBVU5jG6tkIx0Uo5U7qLtO
	sTzw2fOZVZ03ElqvbU/VdD7PaQT38BdJ29fMuJQsHoa9Kc1CSmbiZvN50aJWNDFZEBrxwu8h5j7
	6wB74ZeVP44DoqQSFf/HJMvN3Gk6r5nECdCHcX1uGr8EZ4BghHj5TS5aOhdUYcefk+QosE/oqbb
	LPJb8K0YfYE/InQ9UEFYVfnt9szDKC2ElA9OKfIzMaCEvk5XZOvoq+wl81T09fnL4p/++9F1kTv
	iw7YGHA5VlQGGqW5MqAa3HwdyUTpmZx22XkIfea9gDhsav0BRStOyHXG1AaoU7YjJ0u3HQ6ssbc
	7KYBEPBR/YIo+o7ZBFFJ7oY7QIjVP8yeqqKQQGLlQ4eeaC8cBQQ50PPxaJv7vskxBr4hYMyl7dE
	/I3PEaq196gfunSJWU2g6EdL5mzQm9qi1Tz9PUQ8L5B9pLrUIFExzELZrm7FcUBGKYp7ARb/92u
	fU9IcTps/yOcMQKqWPVkRdvQkIqO9th3ovAz8DUsp1AIJaUENyi8gE+i1Yb6QsrpylYOEhxXLwv
	hfSK5MoY/th84N1eUOg8
X-Received: by 2002:a05:6122:4f87:b0:5ea:a21b:31c6 with SMTP id 71dfb90a1353d-5eaaa0fd89amr2353045e0c.2.1792375876111;
        Sun, 18 Oct 2026 19:11:16 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eabbd9ea2bsm4271383e0c.2.2026.10.18.19.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 19:11:15 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	kuba@kernel.org,
	enelsonmoore@gmail.com,
	bp@alien8.de,
	shuah@kernel.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	mhocko@suse.com,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vbabka@kernel.org,
	dapeng1.mi@linux.intel.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	surenb@google.com,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	elver@google.com,
	graf@amazon.com,
	lirongqing@baidu.com,
	liam@infradead.org,
	jlayton@kernel.org
Subject: [PATCH v1 0/8] kho: add read-only Kexec Handover mode
Date: Sun, 18 Oct 2026 22:11:03 -0400
Message-ID: <20261019021111.990394-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261018_191117_476066_FBA4D52C 
X-CRM114-Status: GOOD (  11.55  )
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

This series introduces a read-only Kexec Handover mode, enabled at boot
via 'kho_ro=<pa>' pointing to the physical address of the KHO FDT.

In standard KHO, the target kernel takes ownership of preserved memory
during early boot, initializes struct pages for preserved folios, and
reclaims KHO metadata and preserved pages back into the page allocator
as they are restored.

In some scenarios (such as a caretaker, inspection kernel, firmware), a
kernel needs to inspect and consume preserved KHO subtrees, radix trees,
and serialized metadata without taking ownership of or modifying the KHO
state, leaving the preserved KHO tree intact for a subsequent kernel.
In this mode, the KHO physical memory lies outside the kernel's direct
map.

To support this cleanly without duplicating KHO traversal logic:
- Patch 1 exposes the physical address of the outgoing KHO FDT via
  /sys/kernel/debug/kho/out/fdt_phys so userspace tooling can pass it
  to a 'kho_ro=<pa>' kernel.
- Patch 2 moves the shared radix-tree key encoding and indexing,
  vmalloc flag conversion, and FDT validation and subtree lookup helpers
  to kernel/liveupdate/kexec_handover_internal.h so they can be shared
  between standard and read-only KHO.
- Patch 3 hardens kho_restore_vmalloc() by introducing
  kho_vmalloc_validate() in kernel/liveupdate/kexec_handover_internal.h
  to validate the preservation metadata header and flags before
  restoring the vmalloc area.
- Patch 4 avoids modifying ser->next and bs->head_pa in kho_block_add()
  and kho_block_set_shrink_one() when operating on an incoming block
  set, as the chain is already linked and incoming blocks must not be
  modified in KHO read-only mode.
- Patch 5 adds CONFIG_KEXEC_HANDOVER_READONLY and
  kernel/liveupdate/kexec_handover_ro.c. When booted with
  'kho_ro=<pa>', preserved KHO metadata is mapped read-only
  (PAGE_KERNEL_RO), with the FDT and radix-tree nodes mapped lazily on
  first visit and kept cached, providing read-only implementations of
  kho_retrieve_subtree(), kho_restore_vmalloc(),
  kho_ro_lookup_folio_order(), kho_ro_map_folio(), and kho_ro_unmap().
- Patch 6 updates kho_block to map incoming serialized blocks read-only
  via kho_ro_map_folio() and unmap them via kho_ro_unmap() in read-only
  KHO mode.
- Patches 7 and 8 extend test_kho and tools/testing/selftests/kho/vmtest.sh
  to test read-only KHO handover when preserved memory lies outside
  the boot kernel's initial memory range on both x86_64 and arm64.

Pasha Tatashin (8):
  kho: expose physical address of outgoing FDT
  kho: move radix tree, vmalloc, and FDT helpers to internal header
  kho: validate preservation metadata in kho_restore_vmalloc()
  kho: do not modify incoming serialized blocks
  kho: add read-only Kexec Handover mode
  kho: support read-only KHO mode in kho_block
  kho: test: support read-only KHO mode in test_kho
  selftests: kho: add read-only KHO test to vmtest.sh

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/admin-guide/mm/kho.rst          |   3 +
 include/linux/kexec_handover.h                |  53 ++-
 kernel/liveupdate/Kconfig                     |  16 +
 kernel/liveupdate/Makefile                    |   4 +-
 kernel/liveupdate/kexec_handover.c            | 142 +------
 kernel/liveupdate/kexec_handover_debugfs.c    |  22 +-
 kernel/liveupdate/kexec_handover_internal.h   | 171 +++++++-
 kernel/liveupdate/kexec_handover_ro.c         | 378 ++++++++++++++++++
 kernel/liveupdate/kho_block.c                 |  92 +++--
 lib/Kconfig.debug                             |   2 +-
 lib/test_kho.c                                |  68 +++-
 tools/testing/selftests/kho/arm64.conf        |   3 +
 tools/testing/selftests/kho/init.c            |  38 +-
 tools/testing/selftests/kho/vmtest.sh         | 103 +++--
 tools/testing/selftests/kho/x86.conf          |   1 +
 16 files changed, 881 insertions(+), 221 deletions(-)
 create mode 100644 kernel/liveupdate/kexec_handover_ro.c


base-commit: 27be83a12b246b6b3783e7d3ac5c378ff7520f25
-- 
2.56.0.176.g3575e65682-goog


