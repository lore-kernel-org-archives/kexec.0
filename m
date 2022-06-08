Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E910C433EF
	for <kexec@archiver.kernel.org>; Wed,  8 Jun 2022 07:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HvB9/MUncp2GjC7fuu6quU9pEmt/OsxFN/pd2Imv5c0=; b=CnopedyBPYywI/
	a8QJF9/cPvBesRCq21KAQVi6ZgyySw141c+Zpo6Ky1y43aP1utjrvsAol4CbYHl3yf8e5FffVcPDe
	9j7HyfEdwTvGT67oakjL2/Qm4gOtZaCS3OkQEdeegr0wjCLE/ZTDybI8yW3zHjVUTqBXW2zPKp90q
	iztxfR9aHPcvezcrPTLQIT6Dg3Oz8uTSnxd5N4CG3gCUqL3kpuanPdlUFe0CjLdPj3pq9D+zPMvyU
	CPDjyBzfEf54pgZaYqrZJfLxs2ntcS6GC+1C4J0uzv/Et+Bm4kdpTcVDkOGaveMHio/LOGcls0hKK
	lKN3z2vg8Cg8343J/gGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nypgP-00BNuI-UU; Wed, 08 Jun 2022 07:00:49 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nypgL-00BNsE-RL
	for kexec@lists.infradead.org; Wed, 08 Jun 2022 07:00:48 +0000
Received: by mail-pj1-x102a.google.com with SMTP id d12-20020a17090abf8c00b001e2eb431ce4so17542456pjs.1
        for <kexec@lists.infradead.org>; Wed, 08 Jun 2022 00:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=0Y71+75qvfs0BWzL6gBfrDn2lzjlHUL6hjQyt+wNtxI=;
        b=lFEEkahv8QX0NmHlMpbpwU3DLBoViwvS4Bkf2xwRJvGyqHFcvwgcjk+29VrBH/HQ0Y
         u0vev6U6R6NGWWY+5hhqbnvFYCLMBjlbwCUdjeEmeV0BjtdobRy6VRHrADqEiQkC5/CN
         4TbqzIu9w0iAUgpRStiIJANJO5mYmsnsmuRmNSyCSrkPUkR38bgV3oGaenT8prRz4wQV
         wFRYSLtZ/+LseV5K4es+xa5RfcL3ueOtoSi9HJGtCtDhF5dlrKNfvlTiegxbbiCk4vCb
         qGsNB986MXJUCxJnXwRLo9xxzl/LSoh7xEfFLlQKUD35OPJYxdViOcXpsgMnRnEXaXtm
         HgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=0Y71+75qvfs0BWzL6gBfrDn2lzjlHUL6hjQyt+wNtxI=;
        b=tZCYDTscVovjBJJLjlXA5dV64wIMlSsIG5vQuZc8nDoI/dsf7UejNN8bYU/5/qSxAg
         H/895GRHfb94zwCIrLXmBWziv+l3wVdZad112+8yBlOx+MgFAkpDXqX357kHRdsaJQKI
         qf7RDRvOQGlmd7mmlAPeiE9ad669dDYbQ/RHUlqcTcVyvYXTZaTx7CVjQ33r7H/wx0yG
         oIQ5bdfReVf9WAa3Gxqzx9jfRH1/qLOWl+q3ULjJK4U6K0HYDt1Fc6qOadsKSyACQ/t/
         e7ZkERq305neq9Uj6T1JayANu4EoN43vlLUD0j+mHZbXgpNL/Z7Ggtr3VKOAdtSWxKgM
         LjGQ==
X-Gm-Message-State: AOAM531CsIM3xzREQ4yyh2ddLr993CIvSSF+Gcr+HP5yyYPxTovwykEh
	iIViPkqy+Q9AWAqFroN9Lro7lffvc8eJIsVo
X-Google-Smtp-Source: ABdhPJx7+Tm4FFC4r7PiYQy5839YKi2Ajm/KYt944nHUrPqCBYGoBDa99piJ/g1V0Xo5JM25LyktVw==
X-Received: by 2002:a17:902:f687:b0:167:58bb:c43f with SMTP id l7-20020a170902f68700b0016758bbc43fmr22706267plg.136.1654671644069;
        Wed, 08 Jun 2022 00:00:44 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902ed9200b001675991fb7fsm8396425plj.55.2022.06.08.00.00.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jun 2022 00:00:43 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eric Biederman <ebiederm@xmission.com>,
	x86@kernel.org,
	kexec@lists.infradead.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 2/2] x86/mpparse, kexec: probe apic driver early for x2apic
Date: Wed,  8 Jun 2022 14:43:48 +0800
Message-Id: <20220608064348.66402-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220608064348.66402-1-ryncsn@gmail.com>
References: <20220608064348.66402-1-ryncsn@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220608_000045_940103_DDB0C67D 
X-CRM114-Status: GOOD (  20.33  )
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
Reply-To: Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Kairui Song <kasong@tencent.com>

Following kernel panic is observed when doing kdump/kexec on
virtual machines that uses MPTABLE, not ACPI MADT, and supports x2apic:

  Intel MultiProcessor Specification v1.4
  MPTABLE: OEM ID: BOCHSCPU
  MPTABLE: Product ID: 0.1
  MPTABLE: APIC at: 0xFEE00000
  BUG: unable to handle page fault for address: ffffffffff5fc020
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 25e15067 P4D 25e15067 PUD 25e17067 PMD 25e18067 PTE 0
  Oops: 0000 [#1] SMP NOPTI
  CPU: 0 PID: 0 Comm: swapper Not tainted 5.14.10-300.fc35.x86_64 #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1.fc35 04/01/2014
  RIP: 0010:native_apic_mem_read+0x2/0x10
  Code: 14 25 20 cd e3 82 c3 90 bf 30 08 00 00 ff 14 25 18 cd e3 82 c3 cc cc cc 89 ff 89 b7 00 c0 5f ff c3 0f 1f 80 00 00 00 00 89 ff <8b> 87 00 c0 5f ff c3 0f 1f 80 00 00 00 0
  RSP: 0000:ffffffff82e03e18 EFLAGS: 00010046
  RAX: ffffffff81064840 RBX: ffffffffff240b6c RCX: ffffffff82f17428
  RDX: c0000000ffffdfff RSI: 00000000ffffdfff RDI: 0000000000000020
  RBP: ffff888023200000 R08: 0000000000000000 R09: ffffffff82e03c50
  R10: ffffffff82e03c48 R11: ffffffff82f47468 R12: ffffffffff240b40
  R13: ffffffffff200b30 R14: 0000000000000000 R15: 00000000000000d4
  FS:  0000000000000000(0000) GS:ffffffff8365b000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffffffffff5fc020 CR3: 0000000025e10000 CR4: 00000000000006b0
  Call Trace:
   ? read_apic_id+0x15/0x30
   ? register_lapic_address+0x76/0x97
   ? default_get_smp_config+0x28b/0x42d
   ? dmi_check_system+0x1c/0x60
   ? acpi_boot_init+0x1d/0x4c3
   ? setup_arch+0xb37/0xc2a
   ? slab_is_available+0x5/0x10
   ? start_kernel+0x61/0x980
   ? load_ucode_bsp+0x4c/0xcd
   ? secondary_startup_64_no_verify+0xc2/0xcb
  Modules linked in:
  CR2: ffffffffff5fc020
  random: get_random_bytes called from oops_exit+0x35/0x60 with crng_init=0
  ---[ end trace c9e569df3bdbefd3 ]---

The panic happens within following init code:
setup_arch()
  ....
  check_x2apic()     <-- x2apic is enabled by first kernel before kexec,
                         this set x2apic_mode = 1, make sure later probes
                         will recognize pre-enabled x2apic.
  ....
  acpi_boot_init();  <-- If ACPI MADT is in use, this will switch apic driver
                         to x2apic, but it will do nothing with MPTABLE.
  x86_dtb_init();
  get_smp_config();
    default_get_smp_config();  <-- MPTABLE setup.
      check_physptr();
        smp_read_mpc();
          register_lapic_address(); <-- * panic here *
  init_apic_mappings();
  ....

The problem here is MPTABLE setup calls register_lapic_address(), which
is still using apic_flat driver, and access the apic MMIO interface. But
the address is never mapped for pre-enabled x2apic, since commit
0450193bffed6 ("x86, x2apic: Don't map lapic addr for preenabled x2apic systems"),
then it panics.

Simply map it won't work either, in x2apic mode the MMIO interface is
not usable (Intel SDM Volume 3A 10.12.2), later setups will still fail with
other errors. So it needs do a proper apic driver probe and switch to
x2apic driver to perform MSR operation instead.

Such issue is currently only seen with kdump/kexec, kernel enabled the
x2apic in first kernel and kept it enabled to 2nd kernel.

This can be easily reproduced with qemu-kvm, use -no-acpi and enable
x2apic, so x2apic with MPTABLE will be in use, then trigger kdump/kexec.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 arch/x86/kernel/mpparse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index fed721f90116..7658c8184e8c 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -202,8 +202,10 @@ static int __init smp_read_mpc(struct mpc_table *mpc, unsigned early)
 		return 0;
 
 	/* Initialize the lapic mapping */
-	if (!acpi_lapic)
+	if (!acpi_lapic) {
+		apic_early_probe();
 		register_lapic_address(mpc->lapic);
+	}
 
 	if (early)
 		return 1;
-- 
2.35.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
