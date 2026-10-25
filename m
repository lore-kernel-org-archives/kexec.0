Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B6606A338
	for <kexec@archiver.kernel.org>; Sun, 25 Oct 2026 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=l7QQcGnT;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=St9i9PMx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=h3QApbBlAYhRMvgt4baVTZSCZ7KrzPHAuh9ddC7G5Kg=; b=l7QQcGnTEP14keFQLCpxtyAlEo
	DnHRB7piPDspxN6dUm7zq3GX2wO7Rs72k8pnw9VqSEAPKbwcJAID3oI1NDujw0/a2MXtZDXkzJ4hy
	7x/1YCLioAoyapoJcfsTvNSS+IMewM37GSgvo7v189MmctMUw/CRvGUSP7rjH/goTE5izUpq7KzqI
	M79Af3HGzx2yWGBCRnfi5kzWGcOYn12tRP/Yqij3jJSflmXxuJjnvDVk9W/3QqGxdDEMLhGg65ns4
	dcqKSxe+fNcWZ1Pt6BXllGr2sCG3srXgNymT7X3HNZ0eLr/MTuXdBnJNbHnSei2pxxsEPhM1NNja4
	Yn2QO0kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Cm-00000001Eq9-0U2W;
	Sun, 25 Oct 2026 17:40:24 +0000
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL2Cj-00000001EoW-2A1D
	for kexec@lists.infradead.org;
	Sun, 25 Oct 2026 17:40:23 +0000
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so1756741e0c.2
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792950020; x=1793554820; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h3QApbBlAYhRMvgt4baVTZSCZ7KrzPHAuh9ddC7G5Kg=;
        b=St9i9PMxldKwNB/HN4KsZ/YbS/miDxkmAO5D9nIqJkHUsvH0En45n6FI6hrOPa76m5
         DuQEDF3iEn8SFHQPirF3UCLIEMgDp229w7mnmuLiieOkLERBM43R4MaF+J0FmRXwYvoL
         ugtnlKXwDUTsksJ6imSUPtyrRSHwiWUClCA8HiLV7ZotcvJvKzZGG7VWL4F7nteF8nmC
         4qt2yWCpqyl8sWMF9Z0JnO+zZQe4QRRNHf+kpK9SK8yTdx+HYro/UmBieJE8eJCcjf61
         h38JU7peOX8iUcSXuNzq553Ng0b4bvXTxSZjlncSRVtVORi5MiB8Y8AbpXsTvhZluQag
         ZpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792950020; x=1793554820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h3QApbBlAYhRMvgt4baVTZSCZ7KrzPHAuh9ddC7G5Kg=;
        b=rtYB8kdxdj3fAcQDvr1nq0tqQMtHtKsZBGmaJpUj+1oy85f9LbbgMaQu7tjmGqeFz4
         yQZynQ2Az2XBUVgxJU2P0nx6DuErPVfL0z0yjgW/47atDLLZTZFdF1nun7L68sPaVcK4
         319vqUD609lGS5b0kVoXdhRt9kkL+yF4P4o+c+nKeRqYfszTm1Pu6WNFG9AtnmmOLiP4
         RuW9kMtZTemfXg3daf3RWNwpgrgj53hIMVjHW2O10fHDa4rc9FZhFB8bn9P4drBub6DH
         3tOoulRABeuaWuZolAGmzJfHO4miuaPwYbNjTUqgdyBhL4hRm/IRkkD46x0yZLdsTfYj
         lACg==
X-Forwarded-Encrypted: i=1; AKwUvBzeQJurY5VqrJHEvvKVU+KYNXmyYSFvsozKN58GxI561+r4XJfi76SoEoo1Hd1+iybypFfLGg==@lists.infradead.org
X-Gm-Message-State: AFq9FYLlTxf46GCM72xnsFoBCjvgo2ukkSsH+aQ2D2bmiR045ZCWNNcS
	khAIKZWuJKhwOviAqU1rYOYTiCmWSZOYOlFGT84Y8k7t6UBTkr4Xzfv62o8nr6cIkNo=
X-Gm-Gg: AYBFou1/eKc2NIAT02EZUAkCMHIJnbGiUfhlB+wsYEV16FaSAbfwPSOccXq5TKoY0So
	uI2q6i8q+WD76blRAX4pSDFEME/R0poW/I8ztvr3HZ4erwYDeNX01uvWa3lP8NuVjlm29sfwiR7
	656TpJuRmZSvKH8HFd85o5pWOJZyTlVGz2pMClH8gyLjj665O7HjTC3KAxJ8YiK1UGvUKM1tjaJ
	876sExnMR8KOWdLYPVG/E6u5sFKlETgeOZPGjmoq/jZXjax6Y9Ue+BHRDYLM/CYgV4aUfIdzTnX
	1pNuAJb5Pgno1SU0oRXS4b7FyLUd1YDkHGQ2PjGhExwIk0sSXyObIwb+mUR6fIyjbvL5tmVfM0E
	0AhwR3/RZ5s3XIDeSdjNyQsD0Xx04AbgvD7WdZe95Qv8ug+mhdLGQNXXFgWg1QqNwn7VLfgFwp4
	VPg8MKlgFzg/KlDLTUKSxajs7op1li0hL1P/wUXTfEwrLch4H0ge6b5pt5LkXEDjiwvEuPh6Yt9
	ByBAEV4A9fT/qPzJPtYm9h/BtSVdRmXHdYNE/ojQtFfJ1zWESv0Cgas0DLjNxGWCeYXDtDmNdp8
	nO5kfTBjJIWNzz7NVpgUJ0WR3g05cukxAfL0y7KBtU1vEtxYpCnmMBxxyc/gfEyh0Bi27HhFNbM
	g
X-Received: by 2002:a05:6122:4893:b0:5ea:c45f:6c4d with SMTP id 71dfb90a1353d-5ec23326819mr1425104e0c.22.1792950020005;
        Sun, 25 Oct 2026 10:40:20 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec234673ebsm5783333e0c.13.2026.10.25.10.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:40:19 -0700 (PDT)
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
Subject: [PATCH v2 0/9] kho: add read-only Kexec Handover mode
Date: Sun, 25 Oct 2026 13:40:07 -0400
Message-ID: <20261025174017.3870481-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_104021_583962_6A82C3A4 
X-CRM114-Status: GOOD (  20.76  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_SPF_HELO_TEMPERROR,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series introduces a read-only Kexec Handover mode, enabled at boot
via 'kho_ro=<pa>' pointing to the physical address of the KHO FDT.

In standard KHO, the outgoing kernel shuts down or serializes all
devices into LUO state, releases machine control, and passes the KHO
FDT physical address through the kexec_file_load() reboot path to the
next kernel, which becomes the sole "Machine Owner" (MO), initializes
struct pages for preserved folios during early boot, and reclaims KHO
metadata and preserved pages back into the page allocator as they are
restored.

In the "Linux Caretaker" (LC) model (as well as inspection kernels or
firmware), a minimal LC kernel runs concurrently on dedicated CPUs
offlined from the MO scheduler while MO is still active or undergoing a
standard KHO-preserved kexec reboot (Live Update). LC is given
read-only access to KHO so a minimal VMM inside LC can keep VMs
responsive (<30ms VM blackout time) by servicing software-only, fully
virtualized devices (such as virtio-console, pvpanic, virtio-rng, etc.)
that do not require host hardware interrupts or global machine state,
while leaving the preserved KHO tree intact for the incoming MO kernel
to retrieve normally once it boots.

LC is never MO: it has no PCI support, does not handle device
interrupts, and is booted inside a small LUO-preserved memfd region
(e.g., ~128MB of RAM on a host with terabytes of memory). Because LC's
direct map only covers its own small memory footprint (both for
isolation and to avoid struct page overhead for host memory), the KHO
FDT, radix tree, and preserved memory all reside outside of LC's direct
map. Furthermore, because LC is configured and launched from userspace
while MO is still running rather than through a kexec reboot handoff
from a shutting-down kernel, userspace reads the KHO FDT physical
address from /sys/kernel/debug/kho/out/fdt_phys and explicitly passes
'kho_ro=<pa>' on LC's kernel command line.

Both CONFIG_KEXEC_HANDOVER and CONFIG_KEXEC_HANDOVER_READONLY can be
compiled into the same kernel image, with the active mode selected at
boot via the kernel command line ('kho=on' vs 'kho_ro=<pa>'; passing
'kho_ro=<pa>' disables regular KHO).

Overview of the series:
- Patch 1 exposes the physical address of the outgoing KHO FDT via
  /sys/kernel/debug/kho/out/fdt_phys so userspace tooling can pass it
  to a 'kho_ro=<pa>' kernel.
- Patch 2 moves the shared radix-tree key encoding, indexing, leaf
  lookup (kho_radix_find_leaf()), FDT validation, and
  kho_retrieve_subtree() helpers into a shared
  kernel/liveupdate/kexec_handover_common.c compilation unit with
  declarations in kernel/liveupdate/kexec_handover_internal.h, while
  also checking that fdt_totalsize(fdt) does not exceed PAGE_SIZE in
  kho_check_fdt() and using get_unaligned() for 64-bit FDT property
  reads in kho_retrieve_subtree().
- Patch 3 hardens kho_restore_vmalloc() and factors out shared vmalloc
  helpers by introducing kho_vmalloc_validate() and kho_vmalloc_walk()
  in kernel/liveupdate/kexec_handover_common.c to validate the
  preservation metadata header and walk the chunk list.
- Patch 4 avoids modifying ser->next and bs->head_pa in kho_block_add()
  and kho_block_set_shrink_one() when operating on an incoming block
  set, as the chain is already linked and incoming blocks must not be
  modified in KHO read-only mode.
- Patch 5 adds CONFIG_KEXEC_HANDOVER_READONLY and
  kernel/liveupdate/kexec_handover_ro.c. When booted with
  'kho_ro=<pa>', the KHO FDT is mapped and validated once in an
  early_initcall, and radix-tree nodes, leaves, and folio/vmalloc
  mappings are cached on first visit in a unified RCU-protected hash
  table for the lifetime of the read-only KHO kernel, providing
  kho_is_ro(), kho_ro_lookup_folio_order(), kho_ro_map_folio(), and
  kho_ro_map_vmalloc().
- Patch 6 wires read-only KHO mode into KHO core (kho_populate(),
  kho_memory_init(), and kho_retrieve_subtree()).
- Patch 7 updates kho_block to map incoming serialized blocks read-only
  via kho_ro_map_folio() in read-only KHO mode.
- Patches 8 and 9 extend test_kho and tools/testing/selftests/kho/vmtest.sh
  to build a single kernel with both CONFIG_KEXEC_HANDOVER=y and
  CONFIG_KEXEC_HANDOVER_READONLY=y and test both standard KHO and
  read-only KHO handover when preserved memory lies outside the boot
  kernel's initial memory range on x86_64 and arm64.

This series is based on liveupdate/next commit 27be83a12b24 ("Merge
branch 'lu-pci-preservation' into next").

Changelog:
v2:
- Expand the cover letter with the LC architecture, explaining why
  'kho_ro=<pa>' takes the FDT physical address on the command line and
  describing the expected users of the read-only KHO APIs (Suggested by
  Mike Rapoport).
- Patch 2 (Suggested by Mike Rapoport):
  - Move the shared radix-tree, FDT, and subtree retrieval helpers into
    a dedicated kernel/liveupdate/kexec_handover_common.c file instead
    of static inline functions in
    kernel/liveupdate/kexec_handover_internal.h, and factor out
    kho_radix_find_leaf() for radix leaf lookup.
  - Check that fdt_totalsize(fdt) does not exceed PAGE_SIZE in
    kho_check_fdt(), drop the "setup: " log prefix from FDT validation
    warnings, and use get_unaligned() when reading 64-bit FDT properties
    in kho_retrieve_subtree().
- Patch 3:
  - Move kho_flags_to_vmalloc() to kexec_handover_common.c alongside
    kho_vmalloc_validate() and add a shared kho_vmalloc_walk() chunk
    walker used by both kho_restore_vmalloc() and kho_ro_map_vmalloc().
- Patches 5 and 6:
  - Allow CONFIG_KEXEC_HANDOVER and CONFIG_KEXEC_HANDOVER_READONLY to be
    compiled into the same kernel image and select the active mode via
    the kernel command line ('kho_ro=<pa>' forces regular KHO disabled).
  - Split the KHO core integration (kho_populate(), kho_memory_init(),
    and kho_retrieve_subtree()) into a separate patch (Patch 6) so
    Patch 5 only introduces the read-only KHO backend.
  - Map and validate the KHO FDT and preserved-memory-map root once in
    an early_initcall so kho_ro_get_fdt() and kho_retrieve_subtree() do
    not sleep or map lazily.
  - Replace kho_ro_restore_vmalloc() (which allocated RAM and copied
    pages) with kho_ro_map_vmalloc() to map preserved kho_vmalloc
    regions read-only in place using kho_vmalloc_walk().
  - Cache radix-tree node, leaf, folio, and vmalloc mappings in a
    unified RCU-protected hash table (kho_ro_map_ht) keyed by address,
    size, and protection for the lifetime of the read-only KHO kernel,
    and drop kho_ro_unmap().
- Patch 9:
  - Build the kernel and initrd only once in vmtest.sh with both
    CONFIG_KEXEC_HANDOVER=y and CONFIG_KEXEC_HANDOVER_READONLY=y
    enabled, running both the standard KHO test and the read-only KHO
    test on the same kernel image.
Link: https://lore.kernel.org/all/20261019021111.990394-1-pasha.tatashin@soleen.com/ # v1

Pasha Tatashin (9):
  kho: expose physical address of outgoing FDT
  kho: move radix tree and FDT helpers to common file
  kho: validate preservation metadata in kho_restore_vmalloc()
  kho: do not modify incoming serialized blocks
  kho: add read-only Kexec Handover mode
  kho: support read-only KHO mode in KHO core
  kho: support read-only KHO mode in kho_block
  kho: test: support read-only KHO mode in test_kho
  selftests: kho: add read-only KHO test to vmtest.sh

 .../admin-guide/kernel-parameters.txt         |   8 +
 Documentation/admin-guide/mm/kho.rst          |   3 +
 Documentation/core-api/kho/index.rst          |   6 +
 include/linux/kexec_handover.h                |  44 +-
 kernel/liveupdate/Kconfig                     |  10 +
 kernel/liveupdate/Makefile                    |   3 +-
 kernel/liveupdate/kexec_handover.c            | 284 +++---------
 kernel/liveupdate/kexec_handover_common.c     | 298 ++++++++++++
 kernel/liveupdate/kexec_handover_debugfs.c    |  22 +-
 kernel/liveupdate/kexec_handover_internal.h   |  47 +-
 kernel/liveupdate/kexec_handover_ro.c         | 429 ++++++++++++++++++
 kernel/liveupdate/kho_block.c                 |  78 +++-
 lib/Kconfig.debug                             |   2 +-
 lib/test_kho.c                                |  71 ++-
 tools/testing/selftests/kho/arm64.conf        |   1 +
 tools/testing/selftests/kho/init.c            |  38 +-
 tools/testing/selftests/kho/vmtest.sh         |  65 ++-
 tools/testing/selftests/kho/x86.conf          |   1 +
 18 files changed, 1121 insertions(+), 289 deletions(-)
 create mode 100644 kernel/liveupdate/kexec_handover_common.c
 create mode 100644 kernel/liveupdate/kexec_handover_ro.c


base-commit: 27be83a12b246b6b3783e7d3ac5c378ff7520f25
-- 
2.56.0.307.g5fe7bd680c-goog


