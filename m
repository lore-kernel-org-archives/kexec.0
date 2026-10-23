Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AE960A2601
	for <kexec@archiver.kernel.org>; Fri, 23 Oct 2026 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RNz4h7CZ;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=L+WKoa4+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=imLoQJ3Y32KZZxL6AOPIQXTmbB11pGW4JBEfVopbcl4=; b=RNz4h7CZRH2n5QU8X3XPB4cjl0
	PARhL1PiZYvK/ICqlS0A1pm4QFb56ulVWwMp9R8MaeBNdZFTzKE6DopVJs4QN4ycrlvA/T+xCPnz2
	04XWmR9TDO7E1Wu80mudmrXIcB2+ORG5uAmfWSfO7+FJkakPScue+gC9dONB7RLnYdBqlrYp2dp3p
	styPZ413sw9g6wkrR/pIsZEfy0O39a6I57f2JDmfwhcfcRPkhzdtg7mYFINgvKmRVq5Kfm0dE+Iwx
	FKfQ6lWfARQnsjhy3rrj2sHmyQdk3Zko8S0hJwzBBYll6EqtpiQjhn516QBJdHAZd6Qf1efvwCfdf
	jxIMcHVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKDGC-0000000GDOq-2Pcr;
	Fri, 23 Oct 2026 11:16:32 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKDG7-0000000GDMo-3IkJ;
	Fri, 23 Oct 2026 11:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792754181; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=imLoQJ3Y32KZZxL6AOPIQXTmbB11pGW4JBEfVopbcl4=;
	b=L+WKoa4+sqQAAMD0SMhfEGdWljxODtB840uN/eFNgQ0wPNskzD6aqzZKpSHrN6nHDGenNMILEsgEA3twn20N/C/28J4ijTK+XOvP9vPc+MUpatsGnBGCN290G0HI9QCOp9gXxaTuUB4LapJVuaVIUczLUfnyBjgHAW66iCxHITc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0XDM1n3D_1792754172;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XDM1n3D_1792754172 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 19:16:21 +0800
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
Subject: [PATCH 0/4] riscv: Enable kexec handover and live update
Date: Fri, 23 Oct 2026 19:16:08 +0800
Message-ID: <20261023111612.2134-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_041629_420817_35C60BA1 
X-CRM114-Status: GOOD (  14.11  )
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
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
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

RISC-V already walks those same generic paths (load_extra_segments() ->
of_kexec_alloc_and_setup_fdt(), parse_dtb() -> early_init_dt_scan()).
The one real blocker is ordering: setup_arch() runs early_ioremap_setup()
*after* parse_dtb(), so kho_populate()'s early_memremap() of the handover
FDT returns "offset + 0" -- NULL for a page aligned address -- and the
handover is dropped:

  KHO: setup: failed to memremap FDT (0x810bb000)
  KHO: disabling KHO revival

Patch 1 fixes that ordering, matching arm64/x86 and standing on its own
regardless of KHO. Patch 2 enables ARCH_SUPPORTS_KEXEC_HANDOVER as
"def_bool 64BIT && MMU" rather than arm64's "def_bool y":
ARCH_SUPPORTS_KEXEC_FILE is already 64BIT-only, and KEXEC_HANDOVER
selects CMA, which depends on MMU. Patches 3 and 4 teach the two
upstream vmtest runners about riscv64. LIVEUPDATE depends only on
KEXEC_HANDOVER, so patch 2 makes it selectable on riscv as well.

No DT schema changes are needed: linux,kho-fdt / linux,kho-scratch are
the properties arm64 introduced (commit 274cdcb1c004), and their
binding lives in the external dt-schema repository [1] rather than in
Documentation.

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/chosen.yaml

Test
----
Testing on qemu-system-riscv64 (virt, -cpu max, TCG); method and logs
under the --- of patches 3 and 4:
  - kho vmtest: "ok 1 KHO succeeded"
  - liveupdate vmtest, all four suites PASSED (simple, multi-session,
    500 files, 2000 sessions)
  - riscv defconfig with and without CONFIG_KEXEC_HANDOVER both boot to
    userspace unchanged; builds: riscv defconfig (+KHO), rv32_defconfig,
    arm64, x86_64

Additionally, a workload-continuity test was run on the same setup,
outside the selftests: a counter process was snapshot with criu 4.3,
the dump was carried across the kexec in an LUO-preserved memfd, and
criu restored it in the new kernel. The process resumed with the same
PID and open log file and kept counting from where it was dumped
(500006 -> 500007, no lost or duplicated ticks).

Chen Pei (4):
  riscv: Call early_ioremap_setup() before parsing the DTB
  riscv: Add support for kexec handover (KHO)
  selftests: kho: Add riscv support
  selftests: liveupdate: Add riscv support

 arch/riscv/Kconfig                                | 3 +++
 arch/riscv/kernel/setup.c                         | 2 +-
 tools/testing/selftests/kho/riscv.conf            | 9 +++++++++
 tools/testing/selftests/kho/vmtest.sh             | 3 ++-
 tools/testing/selftests/liveupdate/config.riscv64 | 3 +++
 tools/testing/selftests/liveupdate/run-vmtests.sh | 2 +-
 tools/testing/selftests/liveupdate/vmtest.sh      | 8 +++++++-
 7 files changed, 26 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/kho/riscv.conf
 create mode 100644 tools/testing/selftests/liveupdate/config.riscv64

-- 
2.50.1


