Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CE0CA6012
	for <kexec@archiver.kernel.org>; Fri,  9 Oct 2026 10:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NOj5jSg6BZkty3fNnyt95RQ9QyKG5uzyWU+uBTR7sow=; b=e8/fj6G2B6jjEsxAUFBIlCGa8O
	GMNJKcEr1Do+1Z1j7Pp/3BwjYZd+okYd5uqorZSU0JFntKlr6NIB4Jmw9Yqmcv/gSgZGzFOZXL+cO
	h3i76RKuH/PkCNhk7qeHmMDLLNhg31Ncg0Y47FFQKnFQhvgYUOqp5LsCp3kKBsd8GILb8PcTw3EQd
	VMAYyK3XmBRc81SK9CkuZ7leUMRUx9HwhVYymD3IjecK9/aBdqmhjF5zZBhXp0JkgAl2WWICBk1ZU
	45MQA7blXNA0wwtQkRebeR8oJRN4QpPY5EZfEmLiQdzdmM/LrTMu7d2NpciQtKflYJVw+F44wNn1g
	MP3EaKuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF7k9-000000062TT-2GjZ;
	Fri, 09 Oct 2026 10:22:25 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xF7k7-000000062Sb-1801;
	Fri, 09 Oct 2026 10:22:24 +0000
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id D541220B7168; Fri,  9 Oct 2026 03:22:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D541220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791541340;
	bh=NOj5jSg6BZkty3fNnyt95RQ9QyKG5uzyWU+uBTR7sow=;
	h=From:To:Cc:Subject:Date:From;
	b=mh2OU+6AsjHk53hHfbsWGhQ/NAG5hBOsTXMZEzJKUwZe53ZSWkCRmlJE6NxtQAhYH
	 ldzg0ic6X6iqcAVg5h1v41oj1AqsStS4eE/qkSQ53Vn//M6rAWtNp4jx5O/pSXsOvO
	 gf/KxrtySEf5tIzXZbaAGOIDPtNVt0liKaBCT1hs=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: mhklinux@outlook.com,
	wei.liu@kernel.org,
	catalin.marinas@arm.com,
	baoquan.he@linux.dev
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	will@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	arnd@arndb.de,
	hpa@zytor.com,
	maz@kernel.org,
	mark.rutland@arm.com,
	linux-hyperv@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	broonie@kernel.org,
	kees@kernel.org,
	brads@mainlining.org,
	namjain@linux.microsoft.com
Subject: [PATCH v4 0/2] hyperv: Run VMBus kexec cleanup from syscore shutdown
Date: Fri,  9 Oct 2026 03:22:11 -0700
Message-ID: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261009_032223_338437_7D64B078 
X-CRM114-Status: UNSURE (   8.74  )
X-CRM114-Notice: Please train this message.
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

Kexec reboot fails on ARM64 Hyper-V guests because the VMBus connection
and SynIC CPU hotplug state are not torn down before the secondary CPUs
are stopped. Move this cleanup into the VMBus syscore shutdown callback,
which runs after device shutdown and before architecture-specific machine
shutdown.

Patch 1 adds an exported helper for checking whether a normal kexec reboot
is in progress. Patch 2 runs the VMBus cleanup from the common syscore
shutdown path on x86 and ARM64, removes the old x86 handler interface, and
documents the shutdown ordering.

On x86, VMBus teardown now precedes hv_stimer_global_cleanup(). This relies
on commit be0cfab740e5 ("clocksource: hyper-v: Remove support for stimer
interrupts in message mode"). Older kernels that retain message-mode
stimer interrupts need an ARM64-specific backport to preserve the existing
x86 ordering.

Changes in v4:
  - Document the VMBus kexec cleanup path in the Hyper-V overview.
  - Combine adjacent kexec_in_progress checks in the x86 shutdown path.

Changes in v3:
  - Use the existing common VMBus syscore operations on all
    architectures, as suggested by Michael.
  - Remove the x86 handler pointer and the weak setup/remove interface.
  - Add an exported read-only helper for modular VMBus builds.
  - Correct the Fixes tag to the commit that enabled Hyper-V on ARM64.

Changes in v2:
  - Use syscore shutdown instead of an ARM64 machine_shutdown() hook, as
    suggested by Catalin.

Shradha Gupta (2):
  kexec: Add helper to report an active kexec reboot
  Drivers: hv: Run VMBus kexec cleanup from syscore shutdown

 Documentation/virt/hyperv/overview.rst | 12 +++++++-----
 arch/x86/kernel/cpu/mshyperv.c         | 27 ++++++---------------------
 drivers/hv/hv_common.c                 | 10 ----------
 drivers/hv/vmbus_drv.c                 | 22 ++++++++++++++--------
 include/asm-generic/mshyperv.h         |  2 --
 include/linux/kexec.h                  |  2 ++
 kernel/kexec_core.c                    |  7 +++++++
 7 files changed, 36 insertions(+), 46 deletions(-)

base-commit: be0cfab740e58b70047ef6e7e3d578f00ed5d258
-- 
2.43.0

