Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B93CA5FD2
	for <kexec@archiver.kernel.org>; Thu,  1 Oct 2026 13:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EjlOJ/OcDiSNWbB30Bul6Eomt2gGaGyv7txR7jxF0iQ=; b=v3aL2832kfQ/dNx39aQzEXaKZR
	10fRBqP+9pfq20NTzGclhzqiITb+HH6VL0LLmQZHCoKxXhAESyFG/+hQPdf0njDWmwAUItddT/PHC
	dBH4Hpu69FGLRDx+LT3YjGkTirgPGsIxHZ3bGuMLtbOCgVJ3T2zteE0Mkq8tnsvZ+Oe2jY8i7oa9X
	fTAc3r698vEsA9ftt43B+PzXJMt1AeQ9owZuVO+w9yGNm32CU5bKGGZ+Gwara/kUTdErcFezG0tsq
	y8zFDQfop2mtqix/FixHWz5L/YDz5d6IDTmE0gejPzGbZtqDoFw0bW+OrHof5UTOvrrFSA2xTCMQo
	JaFw6RZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCGk8-00000009E1I-0xL6;
	Thu, 01 Oct 2026 13:22:36 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCGk5-00000009E0o-0UGJ;
	Thu, 01 Oct 2026 13:22:34 +0000
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 2A36720B7167; Thu,  1 Oct 2026 06:21:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A36720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790860898;
	bh=EjlOJ/OcDiSNWbB30Bul6Eomt2gGaGyv7txR7jxF0iQ=;
	h=From:To:Cc:Subject:Date:From;
	b=jBPcGxp4n4AL4jR6mv2YVvUBaMT7eoAQ0cdBGb+WIR1kTvSM1AjhvPMauIMe5sdfJ
	 Lm8uF823+SCZWFRggYrIXfBNUUbR2XS6f6sGK/1G+/P3O/Rtr5WZp9Yd6fFYI2t/Rc
	 mJOThD2cSzQLTihor/xm3aUC3QH7UyXxKZzNZdmE=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Baoquan He <baoquan.he@linux.dev>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Will Deacon <will@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-hyperv@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v3 0/2] hyperv: Run VMBus kexec cleanup from syscore shutdown
Date: Thu,  1 Oct 2026 06:21:25 -0700
Message-ID: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_062233_195725_729BF8E1 
X-CRM114-Status: GOOD (  12.07  )
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

Kexec reboot fails on ARM64 Hyper-V guests because the VMBus
connection and SynIC CPU hotplug state are not torn down before the
secondary CPUs are stopped. The kexec kernel consequently starts with
the previous kernel's VMBus state still active.

The previous version added an ARM64-specific syscore shutdown
implementation. This version follows Michael Kelley's review and moves
the cleanup into the existing architecture-independent VMBus syscore
operations. This removes the separate x86 handler dispatch and gives
x86 and ARM64 the same ordering:

  device_shutdown()
  syscore_shutdown()
    VMBus UNLOAD and SynIC CPU hotplug teardown
  machine_shutdown()

On x86, VMBus teardown now runs before hv_stimer_global_cleanup().
This ordering is safe after commit be0cfab740e5 ("clocksource: hyper-v:
Remove support for stimer interrupts in message mode") removed the
VMBus dependency from synthetic timer handling.

Patch 1 adds a read-only helper that reports whether a kexec reboot is
in progress. The helper is exported because HYPERV_VMBUS is tristate
and the common syscore callback must also link when VMBus is a module.
Patch 2 moves the cleanup into the common callback and removes the
obsolete architecture-specific setup/remove interface.

For stable kernels that still support message-mode stimers, an
ARM64-specific backport will be needed to preserve the existing x86
ordering.

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

 arch/x86/kernel/cpu/mshyperv.c | 17 +----------------
 drivers/hv/hv_common.c         | 10 ----------
 drivers/hv/vmbus_drv.c         | 22 ++++++++++++++--------
 include/asm-generic/mshyperv.h |  2 --
 include/linux/kexec.h          |  2 ++
 kernel/kexec_core.c            |  7 +++++++
 6 files changed, 24 insertions(+), 36 deletions(-)


base-commit: be0cfab740e58b70047ef6e7e3d578f00ed5d258
-- 
2.43.0

