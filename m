Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BC5CD6E40
	for <kexec@archiver.kernel.org>; Tue, 26 May 2026 12:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XpxfDv/ymbG6/F5PMN49YFN+lyP+DndkR6hnRIA2d6o=; b=DcIQapmhadxLXTQqFCtVzkEuJy
	Xb/0yEck0IJCAPQyIPzVbpUS0ufuXBctVDJdGsImF2BaogRvskxNGy99DbwFZ96ajoabObExeQaql
	9Sgv2AaX7zSm+sJsp//XGC7O9VPZ+F0k7BbKm6Qqda+T4dfbb1yCxXQ/wxjC3QWpiVQgbYXxt/ReM
	wXOvomkRZeAhcmi7UrIUo6qBC0iDuG/WVYFX8gsNfiDW0U0nadUve8E6ArtBGJq/l9hMY54hkqdzs
	G6+434loV/e9v3tpnIuwzSu+DWzRh/NVhwPBX4eNV1VmWWYhnxgNUqWdfDcogIzXUsVbybWeK0M92
	nAEfBv/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRrEu-00000001xgB-3FFS;
	Tue, 26 May 2026 12:50:32 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRrEo-00000001xc3-0sSa;
	Tue, 26 May 2026 12:50:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779799818; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XpxfDv/ymbG6/F5PMN49YFN+lyP+DndkR6hnRIA2d6o=;
	b=AyjgA43T973MtlzhEnVM0fp56tII6nYjzSGTMJM7VXGH3irsJaVzpXJ/CGn2Wc+ej+Q3WubFRKK0teRDjsBIQrPAEvWLiKydcZzTASmcbnBwPckq6XQyGzcGAmd9Chw++wssD2Eqbzv0RkuB1na0wRVCuzeRwAwSk2PO/bodmx4=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0X3gDNJG_1779799812;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3gDNJG_1779799812 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 20:50:14 +0800
From: fangyu.yu@linux.alibaba.com
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Nick Kossifidis <mick@ics.forth.gr>
Cc: Song Shuai <songshuaishuai@tinylab.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Richard Lyu <richard.lyu@suse.com>,
	Nam Cao <namcao@linutronix.de>,
	Jisheng Zhang <jszhang@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	guoren@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>
Subject: [PATCH v2 0/7] riscv: kexec: Fix VCPU crash on kexec/kdump under KVM
Date: Tue, 26 May 2026 20:50:02 +0800
Message-Id: <20260526125009.2404-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_055026_977403_52E181FA 
X-CRM114-Status: GOOD (  13.85  )
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

From: Fangyu Yu <fangyu.yu@linux.alibaba.com>

In a RISC-V kernel, both kexec and crashdump need to hand off execution
to the next kernel after tearing down the current kernel address space.
However, under virtualization the guest uses two-stage address
translation, and pc does not jump to stvec after setting satp to zero,
so the legacy single-step "csrw satp,0 + stvec redirect" sequence
traps with "kvm run failed Operation not supported" and the VCPU dies.

v1 (Link below) addressed the crash path only. v2 extends the same
mechanism to the normal kexec path (kexec -l/-e) and reworks the
trampoline as a shared piece of infrastructure between the two paths.

This patch set introduces a dedicated kexec trampoline text section and
builds a minimal trampoline page table for it. Both handoffs are then
reworked into a two-pass trampoline:

    1. First enter via the kernel VA, install the trampoline page table,
       and jump to the trampoline VA(=PA) of the entry stub;
    2. Continue execution with PC already on a PA, drop SATP with
       csrw satp,0 (now safe because PC re-anchoring is moot), and
       jump directly to the target -- either the crash kernel entry
       (crash path) or the per-image control_code_buffer that runs
       the relocate body with SATP=0 throughout (normal path).

With this, both kexec and crashdump in RISC-V guests become robust
against the two-stage translation.

Tested on QEMU virt under two configurations:

  * HS-mode bare (QEMU TCG) -- regression check
      - normal kexec: kexec -l/-e succeeds, second kernel boots and
                      prints the userspace SECOND BOOT marker.
      - crash kdump: panic triggers crash kernel boot, /proc/vmcore
                     opens cleanly in crash and shows the panic
                     backtrace.

  * VS-mode (L0 x86 + QEMU TCG -> L1 riscv64 + KVM -> L2)
      Before this series, both paths die with
          kvm run failed Operation not supported
      and an all-zero M-mode register dump on the SATP transition.
      After this series, both paths succeed end-to-end and the
      vmcore opens cleanly in crash.

---
Changes in v2:
    - Extend the trampoline mechanism to the normal kexec path; the
      legacy stvec trick in riscv_kexec_relocate (csrw satp,0 followed
      by jr s6 to land at PA) is replaced by a small wrapper
      riscv_kexec_relocate_entry in .kexec.tramp.text that performs
      the same two-step transition used by the crash path and then
      hands off to the PA of control_code_buffer.   
    - Page-align both ends of the .kexec.tramp.text section so no
      .rodata neighbour can leak into the identity-mapped executable
      trampoline page, and assert the section fits within one page.
    - In machine_kexec() pin t3 = 0 and the call arguments (a0..a4)
      to their ABI registers via local register asm variables and
      perform the final jr inside the inline asm block, so the
      compiler can never insert a scratch use of t3 between the
      argument setup and the trampoline entry. The bare
      "asm volatile ("li t3, 0" ::: "t3")" placebo used in v1 is
      not actually a guarantee.
    - Link to v1:
      https://lore.kernel.org/linux-riscv/20260324114527.91494-1-fangyu.yu@linux.alibaba.com/

Fangyu Yu (7):
  riscv: Add kexec trampoline text section to vmlinux.lds.S
  riscv: kexec: Place norelocate trampoline into .kexec.tramp.text
  riscv: kexec: Build trampoline page tables for crash kernel entry
  riscv: kexec: Switch to trampoline page table before norelocate
  riscv: kexec: Always build the trampoline page table
  riscv: kexec: Add the relocate-trampoline wrapper
  riscv: kexec: Route normal kexec through the trampoline page table

 arch/riscv/include/asm/kexec.h     |   5 ++
 arch/riscv/kernel/image-vars.h     |  14 ++++
 arch/riscv/kernel/kexec_relocate.S |  97 +++++++++++++++++------
 arch/riscv/kernel/machine_kexec.c  | 123 +++++++++++++++++++++++++++--
 arch/riscv/kernel/vmlinux.lds.S    |   1 +
 5 files changed, 209 insertions(+), 31 deletions(-)

-- 
2.50.1


