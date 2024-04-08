Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29BBC67861
	for <kexec@archiver.kernel.org>; Mon,  8 Apr 2024 07:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IXxJwmgwAK1uI/Poj0AXG8R8mfeYGYxS9vxXI7xqZwE=; b=PEDFmGasUTwxLe
	bSqtfQuXE3XNUFwOkoXPrEA3HX5JMS1Uf/xVzzTXEfUlGZDJpoMUC81n1tJclC5IBbRnrpDUvw/eF
	MU38xvFGc1SA1tdMj+Yo1xTgB1NjFU65YiN6EMTttdXIAMbK9tCcQVMAXry52QoSK/Vvjr/trOylu
	uwBYPHhakpzIRAOh3MTyigmFK35/EGo6SzOzVtGlDHpQeZ+BS+zW8hhqg0Q1cuJB4QjXq4iXaSgAC
	b6MrXcqz3nBla1BTPuo1T9cfQxWqOaWRMHWoZvW1lj9Vo1F+ciA8CbtwH0Nu1sjqptU0LgtNd0g95
	+7nqU30fEBmFNs9icwkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjct-0000000EhWP-1dfD;
	Mon, 08 Apr 2024 07:41:11 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtjcl-0000000EhRM-2pBU
	for kexec@lists.infradead.org;
	Mon, 08 Apr 2024 07:41:08 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4168a5d75c4so836095e9.0
        for <kexec@lists.infradead.org>; Mon, 08 Apr 2024 00:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712562061; x=1713166861; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YmndQeC4PSRnWNm7AgzW2Pg/8QFXLvyF8S9fiEcAmmc=;
        b=IhcZvhlXL3Rs0AkLeLpfvhaHtOk7UiR9ubHyshbZ55AB14oSGwwDRTiVbhsJ/uLG2d
         bROfpdJZsLZjGvy9PsOFwwhwgIeu6CC9Cl/pBZxlBDb+0VL/RetGm8fjQ21LlIzmTGAr
         HUzSPpN09ErRJ6V5NVClisGZ1cb7lJczZgYm5p2/NkIkg8gbW3oXoigpvVDvB37Vk6PX
         9moT3IpRXb9oZyklycs2SlnnSsOVZcKWqI2ExsWl+7/PLzRGe1vSAmeiaOLCSS8n7utx
         u3ZqEpTwRguewz2QCHu16CQ8izKVk9BFFJRmVe/Q5Q0dKqK3eukvmknq2XPDJWie47M3
         DvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562061; x=1713166861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YmndQeC4PSRnWNm7AgzW2Pg/8QFXLvyF8S9fiEcAmmc=;
        b=gX6C83r/q9GLlipDKFY7MbDlO1+cEGPGMacBwcLNuznYZG5chA1W2oK+uzfjatfbiy
         fYSf6fFb3zzLCBaGREF6eQW/WCUZ0a8niDKFn4ZpchrBTQfLjPV3aBOHL/jW2xRsp5vA
         fycV0ZfgN5iQJcrPB+Fz1Fb7ULteQUZB+6pnp050s06X5IQSUpWJ2KzzWFtpEyCUETpW
         lYpV6mQM9Rk3dNmGeRLRRYE22Ws+NPFmY+jqGKGuSxYNyUybba6nbWYK/00ugtL8TIOQ
         2eh/VfbfZ+AMaicQHe9bOaq/spRo2+rR5DzEEj2flS4dCxgxBrGfanoN0noyZnjQEyU+
         oJlA==
X-Forwarded-Encrypted: i=1; AJvYcCX8jVoOcyB8EfUHUPYXP3StHF994iFixzEUuiI9JbzVKutNRKzwdUCCu/ZKSId4bJbJ8l0/QsZgvI5mArocqTx8AbZbM6ecShVd
X-Gm-Message-State: AOJu0YwbtJo37HQ818mFgCGexsFJkbyAgmxGgVu+X87nW74oBE/743xa
	y8wG4I56mOiI3P8tcQAMxDjWqMvopgVw6OmXWk0iy3C23TXRnylz
X-Google-Smtp-Source: AGHT+IGdz9RdrOljvpb36UmEtQIvLkiczH4oBTd6Tq0B5aLflz4xcAB37TEo1bC9FBjYmfIqlDbVYg==
X-Received: by 2002:a05:600c:3845:b0:416:64c0:5d26 with SMTP id s5-20020a05600c384500b0041664c05d26mr2976938wmr.12.1712562061291;
        Mon, 08 Apr 2024 00:41:01 -0700 (PDT)
Received: from vasant-suse.suse.cz ([2001:9e8:ab70:9c00:7f0b:c18e:56a6:4f2])
        by smtp.gmail.com with ESMTPSA id j3-20020adfff83000000b00341e2146b53sm8271413wrr.106.2024.04.08.00.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 00:41:00 -0700 (PDT)
From: vsntk18@gmail.com
To: x86@kernel.org
Cc: cfir@google.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	erdemaktas@google.com,
	hpa@zytor.com,
	jgross@suse.com,
	jroedel@suse.de,
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
	vkarasulli@suse.de,
	ashish.kalra@amd.com,
	michael.roth@amd.com,
	Borislav.Petkov@amd.com,
	Dhaval.Giani@amd.com
Subject: [PATCH v5 00/10] x86/sev: KEXEC/KDUMP support for SEV-ES guests
Date: Mon,  8 Apr 2024 09:40:39 +0200
Message-Id: <20240408074049.7049-1-vsntk18@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_004104_121307_E52253AE 
X-CRM114-Status: GOOD (  25.43  )
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

	https://lore.kernel.org/kvm/20240311161727.14916-1-vsntk18@gmail.com/

Please review.

Thanks,
   Vasant

Changes v4->v5:
        - Rebased to v6.9-rc2 kernel
	- Applied review comments by Tom Lendacky
	  - Exclude the AP jump table related code for SEV-SNP guests

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

Vasant Karasulli (1):
  x86/sev: Exclude AP jump table related code for SEV-SNP guests

 arch/x86/boot/compressed/sev.c          |  45 +-
 arch/x86/include/asm/insn-eval.h        |   1 +
 arch/x86/include/asm/realmode.h         |   5 +
 arch/x86/include/asm/sev-ap-jumptable.h |  30 +
 arch/x86/include/asm/sev.h              |   7 +
 arch/x86/kernel/machine_kexec_64.c      |  12 +
 arch/x86/kernel/process.c               |   8 +
 arch/x86/kernel/sev-shared.c            | 234 +++++-
 arch/x86/kernel/sev.c                   | 376 +++++-----
 arch/x86/lib/insn-eval-shared.c         | 921 ++++++++++++++++++++++++
 arch/x86/lib/insn-eval.c                | 911 +----------------------
 arch/x86/realmode/Makefile              |   9 +-
 arch/x86/realmode/init.c                |   5 +-
 arch/x86/realmode/rm/Makefile           |  11 +-
 arch/x86/realmode/rm/header.S           |   3 +
 arch/x86/realmode/rm/sev.S              |  85 +++
 arch/x86/realmode/rmpiggy.S             |   6 +
 arch/x86/realmode/sev/Makefile          |  33 +
 arch/x86/realmode/sev/ap_jump_table.S   | 131 ++++
 arch/x86/realmode/sev/ap_jump_table.lds |  24 +
 20 files changed, 1711 insertions(+), 1146 deletions(-)
 create mode 100644 arch/x86/include/asm/sev-ap-jumptable.h
 create mode 100644 arch/x86/lib/insn-eval-shared.c
 create mode 100644 arch/x86/realmode/rm/sev.S
 create mode 100644 arch/x86/realmode/sev/Makefile
 create mode 100644 arch/x86/realmode/sev/ap_jump_table.S
 create mode 100644 arch/x86/realmode/sev/ap_jump_table.lds


base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
--
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
