Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23336606D82B
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2g7JXtNG;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k3+9NMTv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=hZSS8pIphBraD9CLXDgq7aSqfm0V64ZlrBCsq6wroQE=; b=2g7JXtNGRthAYmFsDRZzU9ti6u
	Ei/krZzElIj8LrdLXO6ZmnsT8qV+DPsa3UzmfRRLVtybzUOWL7q2FRMryHUdkXcHVXKz/Pfe9lh/u
	DKemDYvwnTJiSrfPjeoBx/IW+KjyRUYFPLl4MSoCOTfjEipMnlNo7XCETFyiDH63tWpY03XOwkJxU
	3q+yNcSa31yL+sjLZs1GGHeuE19lRWA+vZwRAZ5PEQitkAKAGTp1IDzUZ8aYptpsDkAtAk/fBIo9s
	y6Vb2/9h0+/gMFKlEIFWsveCwlPnSyoM0qIsEa4BxTMntysHst9Co7aUxxpuGY56Hs9CHXxRb5qyG
	NP9lG8SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9ac-00000001ULc-3SWb;
	Tue, 03 Nov 2026 08:09:54 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9aU-00000001UFb-2cXj;
	Tue, 03 Nov 2026 08:09:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793693380; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hZSS8pIphBraD9CLXDgq7aSqfm0V64ZlrBCsq6wroQE=;
	b=k3+9NMTvOTcsQlIoPgLSTXIBifkXBNDcs5kuWXjFq71JvItapbbbsn30eMnAMKbhOzqcJTZYj6mxd13R9hFZhwDkvuMteIVO+v8ywaGeD0+atsUasFUXfAz6HTX1VXENidMA8BxE7vQp+jlSQgDXMz9NZ4FB9WwYQ7hb5cJtpbU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XE27KwW_1793693367;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XE27KwW_1793693367 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 16:09:39 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	alex@ghiti.fr,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	graf@amazon.com,
	shuah@kernel.org
Cc: guoren@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	kexec@lists.infradead.org
Subject: [PATCH v2 0/5] riscv: Enable kexec handover and live update
Date: Tue,  3 Nov 2026 16:09:21 +0800
Message-ID: <20261103080926.2079-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_000947_387141_6DA22F8F 
X-CRM114-Status: GOOD (  17.07  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Host kernel updates in the cloud should not require draining the
machine: next to live migration to another host, replacing the kernel
in place while preserving selected workload state ("live update") is
what KHO/LUO were built for, and LUO's documentation names hypervisor
hosts as its primary use case. This series closes the gap for riscv64
and validates it with both upstream test runners.

KHO has been architecture independent since it was merged: the outgoing
kernel publishes the handover FDT and the scratch descriptor array in
the /chosen node of the DTB it builds for the incoming kernel, and the
incoming kernel collects both while scanning that node -- which is why
the arm64 integration (commit 274cdcb1c004) needed only three lines of
arch code.

Patch 1 is generic and comes first because enabling KHO on riscv64 needs
it: is_kho_boot() runs the handover FDT address through phys_to_virt()
only to return a boolean, and on riscv64 that is a BUG() before the
linear map offset exists. Neither caller dereferences the value, so
testing the physical address is enough.

RISC-V otherwise already walks the generic paths (load_extra_segments()
-> of_kexec_alloc_and_setup_fdt(), parse_dtb() ->
early_init_dt_scan()). The remaining blocker is ordering: setup_arch()
runs early_ioremap_setup() *after* parse_dtb(), so kho_populate()'s
early_memremap() of the handover FDT returns "offset + 0" -- NULL for a
page aligned address -- and the handover is dropped:

  KHO: setup: failed to memremap FDT (0x810bb000)
  KHO: disabling KHO revival

Patch 2 fixes that ordering, matching arm64/x86 and standing on its own
regardless of KHO. Patch 3 enables ARCH_SUPPORTS_KEXEC_HANDOVER as
"def_bool 64BIT && MMU" rather than arm64's "def_bool y":
ARCH_SUPPORTS_KEXEC_FILE is already 64BIT-only, and KEXEC_HANDOVER
selects CMA, which depends on MMU. Patches 4 and 5 teach the two
upstream vmtest runners about riscv64. LIVEUPDATE depends only on
KEXEC_HANDOVER, so patch 3 makes it selectable on riscv as well.

No DT schema changes are needed: linux,kho-fdt / linux,kho-scratch are
the properties arm64 introduced (commit 274cdcb1c004), and their
binding lives in the external dt-schema repository [1] rather than in
Documentation.

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/chosen.yaml

Changes since v1:
 - New patch 1: kho: Do not translate the handover FDT address in
   is_kho_boot(), a generic fix the riscv enablement needs.
 - Rebased onto linux-next-20261102 (2637bdec0535).

Test
----
Testing on linux-next-20261102 (2637bdec0535) with qemu-system-riscv64
(virt, -cpu max, TCG); method and logs under the --- of patches 1, 4
and 5:
  - patch 1, UEFI handover boot (edk2 on pflash over OpenSBI
    fw_dynamic, DEBUG_VIRTUAL=y): a BUG_ON in the incoming kernel on the
    first handover without the patch, 29 consecutive handovers with it
  - the same two kernels handing over from a device tree boot instead:
    both succeed, so what fails is the UEFI path and not the handover
  - kho vmtest: "ok 1 KHO succeeded"
  - liveupdate vmtest, all four suites passed one by one (simple,
    multi-session, 500 files, 2000 sessions)
  - riscv defconfig with and without CONFIG_KEXEC_HANDOVER both boot to
    userspace with no oops on the console; builds: riscv defconfig
    (+KHO), rv32_defconfig, arm64 defconfig (+KHO), x86_64 defconfig
    (+KHO)

Additionally, a workload-continuity test was run outside the selftests:
a counter process was snapshot with criu 4.3, the dump was carried
across the kexec in an LUO-preserved memfd, and criu restored it in the
new kernel. The process resumed with the same PID and open log file and
kept counting from where it was dumped (500006 -> 500007, no lost or
duplicated ticks).

Chen Pei (5):
  kho: Do not translate the handover FDT address in is_kho_boot()
  riscv: Call early_ioremap_setup() before parsing the DTB
  riscv: Add support for kexec handover (KHO)
  selftests: kho: Add riscv support
  selftests: liveupdate: Add riscv support

 arch/riscv/Kconfig                                | 3 +++
 arch/riscv/kernel/setup.c                         | 2 +-
 kernel/liveupdate/kexec_handover.c                | 2 +-
 tools/testing/selftests/kho/riscv.conf            | 9 +++++++++
 tools/testing/selftests/kho/vmtest.sh             | 3 ++-
 tools/testing/selftests/liveupdate/config.riscv64 | 3 +++
 tools/testing/selftests/liveupdate/run-vmtests.sh | 2 +-
 tools/testing/selftests/liveupdate/vmtest.sh      | 8 +++++++-
 8 files changed, 27 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/kho/riscv.conf
 create mode 100644 tools/testing/selftests/liveupdate/config.riscv64


base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
-- 
2.50.1


