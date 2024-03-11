Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802EDC54E58
	for <kexec@archiver.kernel.org>; Mon, 11 Mar 2024 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9mqaG48+wBLcRKgxz1uWAtApzfYEYHWaOh81wqqx2ZE=; b=GDtVosPt/lZTi7
	jhTFQjEDl9Nj0VmCBEqvFr9fkXsKm20waSzeSXxiPTvHM+Xh38V4sQRuLyBnpGkbo744nRTF+iFnx
	COqRrtF7sIaie0cFC8PMIZyP2O7jFJQOobgys15VRvz61Zvt7YetUi3FN7sqaEQmJYExdVxf2u4Z3
	WnAepTH5QD4tflKDysaUKWaA9kcVDxW4T9zkbX8ZJvPH04xgRNZaUOnz/tx7Qctqwp267q6n6m6uw
	yMZzEqPB5K5ybAQwRvAXjNv9wgj2DI7CI7ga2+oOrVo+jqTOO6VB1HQz5T/3pzvlmJ4oVkLAmkoFl
	1JBa7Ra/Hdt5MfWQiRzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjiLR-00000002Ggm-379V;
	Mon, 11 Mar 2024 16:17:45 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjiLJ-00000002GYF-1odL
	for kexec@lists.infradead.org;
	Mon, 11 Mar 2024 16:17:40 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4132a436086so6927215e9.2
        for <kexec@lists.infradead.org>; Mon, 11 Mar 2024 09:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173852; x=1710778652; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KhgroYwDHirsSK6NEpHEOPOQNxUnb5y1s4Aku7Fobs0=;
        b=HY7Xhv0x2tsNIiYzKNx8kcE/YcAhyHTdHwqi+rZUgtW0hwaqXZpPwn65jDIlt2lzhO
         azqfy2mY3NgjbFnbLKYNqM4cskHRxSFtb78lMBY77eUP+vvhh8s5O81sZOxoRRRVGzkJ
         v0KCWh4DOnxFtz5ITUqdYy9Y67KO/KGBpocdRqr4sjwfhubiN8nu0F3G8YI3GUfvLNrd
         Kuft2Jua9wmNFlHo7yxMcdKdmF7ItN94zsIisCD+T2ThfuzkqBuqI8Kpn73W0H/auURf
         PFoMep5iNMazJD4dNaiJFNcEhn64Ie8KPTFRcH6ogDdI/aEzMc8hzh4cJfhqT3fcleF8
         hXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173852; x=1710778652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhgroYwDHirsSK6NEpHEOPOQNxUnb5y1s4Aku7Fobs0=;
        b=RjD+vLT2hEoR2227N/62J6v9In221p1d2M2l+ZkkPIba8fBDbU64AAbSDGPkTR/WdK
         LlRNoiABVoty/dgGjaAgw+DBGyj/l9oeJumkW49DiEYZNvM99nFqD6L2KLelxmOkoYVH
         MR82/sOezzBl+gz62g5pPrhvVyQxVioT/UDilOCS8K+9peQDeFu6LcSpfXEtHZLPkQ39
         WfJoHWWWfx+oNyqQAHR9kSGZ7bV8YfxkKpj7ad1nqde2QF6OYrgCjz1R+1QbR8VWBu0E
         yfokIIzNs15c5nOjviYyORWyy8/rd4KDRBGAojdxmmAyByA25c5onSf0GTLGF8dxpraQ
         HvqA==
X-Forwarded-Encrypted: i=1; AJvYcCWj974m4Um3B7PnUog+o0tE4Pq3iRZbz8u4SyLhw1EAInoKb/wI5cLGXwewawXVXOFgMO7xOV41l1so9Z2CZg/MO1YYZEjxRlGf
X-Gm-Message-State: AOJu0YxInci/gdip0ccss0HxEGPzgKkTP1fctUQ1TebiU57TT3jYkiAM
	tP9b0O1TXelo1WddUMwJIYSzn7gb4Rl5ykDeAQkeLaJ92qvaQ71k
X-Google-Smtp-Source: AGHT+IFOXZkK2STurIgXVxbzpgve2av/2k7r2YA7lYoWxFHnDOWhnUJF1kkXWaz1HUNUDRTofP3laA==
X-Received: by 2002:a05:600c:5011:b0:413:2bcf:de2c with SMTP id n17-20020a05600c501100b004132bcfde2cmr1743625wmr.9.1710173852290;
        Mon, 11 Mar 2024 09:17:32 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab47:8200:c3b9:43af:f8e1:76f9])
        by smtp.gmail.com with ESMTPSA id ba14-20020a0560001c0e00b0033e96fe9479sm2823815wrb.89.2024.03.11.09.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:17:31 -0700 (PDT)
From: Vasant Karasulli <vsntk18@gmail.com>
To: x86@kernel.org
Cc: joro@8bytes.org,
	cfir@google.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	erdemaktas@google.com,
	hpa@zytor.com,
	jgross@suse.com,
	jslaby@suse.cz,
	keescook@chromium.org,
	kexec@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luto@kernel.org,
	martin.b.radev@gmail.com,
	mhiramat@kernel.org,
	mstunes@vmware.com,
	nivedita@alum.mit.edu,
	peterz@infradead.org,
	rientjes@google.com,
	seanjc@google.com,
	stable@vger.kernel.org,
	thomas.lendacky@amd.com,
	virtualization@lists.linux-foundation.org,
	Vasant Karasulli <vkarasulli@suse.de>
Subject: [PATCH v4 0/9] x86/sev: KEXEC/KDUMP support for SEV-ES guests
Date: Mon, 11 Mar 2024 17:17:18 +0100
Message-Id: <20240311161727.14916-1-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_091737_734962_613AE561 
X-CRM114-Status: GOOD (  25.41  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: Vasant Karasulli <vkarasulli@suse.de>

Hi,

here are changes to enable kexec/kdump in SEV-ES guests. The biggest
problem for supporting kexec/kdump under SEV-ES is to find a way to
hand the non-boot CPUs (APs) from one kernel to another.

Without SEV-ES the first kernel parks the CPUs in a HLT loop until
they get reset by the kexec'ed kernel via an INIT-SIPI-SIPI sequence.
For virtual machines the CPU reset is emulated by the hypervisor,
which sets the vCPU registers back to reset state.

This does not work under SEV-ES, because the hypervisor has no access
to the vCPU registers and can't make modifications to them. So an
SEV-ES guest needs to reset the vCPU itself and park it using the
AP-reset-hold protocol. Upon wakeup the guest needs to jump to
real-mode and to the reset-vector configured in the AP-Jump-Table.

The code to do this is the main part of this patch-set. It works by
placing code on the AP Jump-Table page itself to park the vCPU and for
jumping to the reset vector upon wakeup. The code on the AP Jump Table
runs in 16-bit protected mode with segment base set to the beginning
of the page. The AP Jump-Table is usually not within the first 1MB of
memory, so the code can't run in real-mode.

The AP Jump-Table is the best place to put the parking code, because
the memory is owned, but read-only by the firmware and writeable by
the OS. Only the first 4 bytes are used for the reset-vector, leaving
the rest of the page for code/data/stack to park a vCPU. The code
can't be in kernel memory because by the time the vCPU wakes up the
memory will be owned by the new kernel, which might have overwritten it
already.

The other patches add initial GHCB Version 2 protocol support, because
kexec/kdump need the MSR-based (without a GHCB) AP-reset-hold VMGEXIT,
which is a GHCB protocol version 2 feature.

The kexec'ed kernel is also entered via the decompressor and needs
MMIO support there, so this patch-set also adds MMIO #VC support to
the decompressor and support for handling CLFLUSH instructions.

Finally there is also code to disable kexec/kdump support at runtime
when the environment does not support it (e.g. no GHCB protocol
version 2 support or AP Jump Table over 4GB).

The diffstat looks big, but most of it is moving code for MMIO #VC
support around to make it available to the decompressor.

The previous version of this patch-set can be found here:

	https://lore.kernel.org/lkml/20220127101044.13803-1-joro@8bytes.org/

Please review.

Thanks,
   Vasant

Changes v3->v4:
        - Rebased to v6.8 kernel
	- Applied review comments by Sean Christopherson
	- Combined sev_es_setup_ap_jump_table() and sev_setup_ap_jump_table()
          into a single function which makes caching jump table address
          unnecessary
        - annotated struct sev_ap_jump_table_header with __packed attribute
	- added code to set up real mode data segment at boot time instead of
          hardcoding the value.

Changes v2->v3:

	- Rebased to v5.17-rc1
	- Applied most review comments by Boris
	- Use the name 'AP jump table' consistently
	- Make kexec-disabling for unsupported guests x86-specific
	- Cleanup and consolidate patches to detect GHCB v2 protocol
	  support

Joerg Roedel (9):
  x86/kexec/64: Disable kexec when SEV-ES is active
  x86/sev: Save and print negotiated GHCB protocol version
  x86/sev: Set GHCB data structure version
  x86/sev: Setup code to park APs in the AP Jump Table
  x86/sev: Park APs on AP Jump Table with GHCB protocol version 2
  x86/sev: Use AP Jump Table blob to stop CPU
  x86/sev: Add MMIO handling support to boot/compressed/ code
  x86/sev: Handle CLFLUSH MMIO events
  x86/kexec/64: Support kexec under SEV-ES with AP Jump Table Blob

 arch/x86/boot/compressed/sev.c          |  45 +-
 arch/x86/include/asm/insn-eval.h        |   1 +
 arch/x86/include/asm/realmode.h         |   5 +
 arch/x86/include/asm/sev-ap-jumptable.h |  30 +
 arch/x86/include/asm/sev.h              |   7 +
 arch/x86/kernel/machine_kexec_64.c      |  12 +
 arch/x86/kernel/process.c               |   8 +
 arch/x86/kernel/sev-shared.c            | 234 +++++-
 arch/x86/kernel/sev.c                   | 372 +++++-----
 arch/x86/lib/insn-eval-shared.c         | 912 ++++++++++++++++++++++++
 arch/x86/lib/insn-eval.c                | 911 +----------------------
 arch/x86/realmode/Makefile              |   9 +-
 arch/x86/realmode/rm/Makefile           |  11 +-
 arch/x86/realmode/rm/header.S           |   3 +
 arch/x86/realmode/rm/sev.S              |  85 +++
 arch/x86/realmode/rmpiggy.S             |   6 +
 arch/x86/realmode/sev/Makefile          |  33 +
 arch/x86/realmode/sev/ap_jump_table.S   | 131 ++++
 arch/x86/realmode/sev/ap_jump_table.lds |  24 +
 19 files changed, 1695 insertions(+), 1144 deletions(-)
 create mode 100644 arch/x86/include/asm/sev-ap-jumptable.h
 create mode 100644 arch/x86/lib/insn-eval-shared.c
 create mode 100644 arch/x86/realmode/rm/sev.S
 create mode 100644 arch/x86/realmode/sev/Makefile
 create mode 100644 arch/x86/realmode/sev/ap_jump_table.S
 create mode 100644 arch/x86/realmode/sev/ap_jump_table.lds


base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
--
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
