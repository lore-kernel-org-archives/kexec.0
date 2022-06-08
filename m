Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42D1C43334
	for <kexec@archiver.kernel.org>; Wed,  8 Jun 2022 07:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6PYqqnBWh87wnsiDXrNtWRdMVhb6h/wfY9qF1EeIGQU=; b=3FrByAZa3i3rXP
	AGs4tM3CZHxs96w5GrqBBKFTjFr+uZd7slDxASlypCmAMjkWYLU9vkkVfccPndcnkhL4olaRfnGJQ
	5Mej15zPcqPFrqPJF+6SJc7BkaCMep8ygcPkP67d4QXbzDfgITkuYpTFz13bjD2kY8rc5XhJbqvKF
	3S6d8BN1L4ltacXtxdF9WedMy8RePFMnprNX3kcynkC4+IzNYfzfa488Vveg85T2QL4Wt/SRtVbhv
	fCsi1wGqyL5+ouql7DcsUc3XIY4B2GsB+kwThOYuxrx4wZZhNR1CoTW0kxT1Yd2Gjt7a3lXe3nSDl
	VD/7sRpMkzM0rQo/l/wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nypgO-00BNtb-BQ; Wed, 08 Jun 2022 07:00:48 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nypgJ-00BNrE-DP
	for kexec@lists.infradead.org; Wed, 08 Jun 2022 07:00:45 +0000
Received: by mail-pg1-x532.google.com with SMTP id e66so18055752pgc.8
        for <kexec@lists.infradead.org>; Wed, 08 Jun 2022 00:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=Rzd5jHVZ1Np2+0gV097PKobFo2Ug2yArAiRpCWznZks=;
        b=aLh0VWbB1Fj/q9OJtWN0VqMIl/GoZOK4jFT0+fWjl/fewag+xCXgldmWOywnmXnyqw
         k8/+znBJuxwpoV0OzzFobfCWhSWi8eH4mMXPOyQU7mE5uYTLAAKAITieF0WVsO4bus3G
         V4IPKt2znoV5C1/Fey9GH83Ylso9UA8dzOtxM9CF6wOqtbf/AYcbMJaZy6mYf/uMxeGR
         FUkmE2CTFLX4KmlYwK+KA/6tiQL5llBBT7+g/R3yLFy/dLXYnhlapm9jJnxs4oWHyHgz
         uA96F2sTLMvBTaqRNfEIyfnyfmzpDmFV1uili7dTguU4bT/sdEx6ycAiISjicOZPMF7B
         IkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=Rzd5jHVZ1Np2+0gV097PKobFo2Ug2yArAiRpCWznZks=;
        b=yQpSqrWNp0L2GzAfZi4JrzqCwRFkHQJov2E06PRtviKlH/Vl40q1Qu/nrnHIfkaMit
         7uxTXU/WsKJVMlXU7noE9JXfJ8doFsEZFId270hlOdL/WsvUFZgn6C3ZzXnjqNqE2ROZ
         93vW4aA0lbJfHCslt6AJPKiw/jziXlPaWPXC36bWnsC4PKt9n1wTxchUR6ORdm33gOUX
         q7OyzabJKWvUt25oP9Yf5ynhojkYd7cFZiPXcjTQ3NkFCylfUcVn5YMVsXFqBaoKmveG
         3uGCk1bsgm4Otb1zPeWtyhv86Jzi+o6yEeeS6hDubcepxkkq1+R9/YEIjVG019o0MJOZ
         +T+Q==
X-Gm-Message-State: AOAM530pSGXjiZcWRAUQpBeuY2qe+7CTm830QiMpZ2XgV4XJpOEwkhv9
	+9uBZMe+PWng6sAmqcsAY/8=
X-Google-Smtp-Source: ABdhPJyJlGe2LEF3l0HaSM5jSYhC48UeQi8mEwKBpio4r4vYBKy5lMZOyvXD9jCH+FG/RDs4YsVOKg==
X-Received: by 2002:a05:6a00:a16:b0:518:ffe0:7229 with SMTP id p22-20020a056a000a1600b00518ffe07229mr68508072pfh.49.1654671638648;
        Wed, 08 Jun 2022 00:00:38 -0700 (PDT)
Received: from KASONG-MB0.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902ed9200b001675991fb7fsm8396425plj.55.2022.06.08.00.00.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jun 2022 00:00:38 -0700 (PDT)
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
Subject: [PATCH 0/2] x86/mpparse, kexec: Fix kdump/kexec kernel panic with MPTABLE and x2apic
Date: Wed,  8 Jun 2022 14:43:46 +0800
Message-Id: <20220608064348.66402-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220608_000043_493143_4C75B3B8 
X-CRM114-Status: GOOD (  12.40  )
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
qemu-kvm VMs that uses MPTABLE, not ACPI MADT, and supports x2apic:

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

It turns out MPTABLE doesn't play well with pre-enabled x2apic mode,
this series extend the apic driver interface and let MPTABLE parse
probe the driver properly.

This can be easily reproduced with qemu-kvm, use -no-acpi and enable
x2apic, so x2apic with MPTABLE will be in use, then trigger kdump/kexec.

Kairui Song (2):
  x86, apic: add a more generic early_probe
  x86/mpparse, kexec: probe apic driver early for x2apic

 arch/x86/include/asm/apic.h           |  6 ++++++
 arch/x86/kernel/apic/probe_64.c       | 16 ++++++++++++++++
 arch/x86/kernel/apic/x2apic_cluster.c |  8 +++++++-
 arch/x86/kernel/apic/x2apic_phys.c    |  8 +++++++-
 arch/x86/kernel/mpparse.c             |  4 +++-
 5 files changed, 39 insertions(+), 3 deletions(-)

-- 
2.35.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
