Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B691CCD184
	for <kexec@archiver.kernel.org>; Sun, 19 Oct 2025 06:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZRMP2OfxaTGj9Ba3u31wGuIf4ugyC10QC83Sd0wi7Ek=; b=FrFbJgvqLTeF7sZxv4oQ7SaPkf
	q55rRXsM/4o7QWeZvd92IJcZHo395Y2UyJqnQk+d0XRi2zMXSB9e+fmzOSiNHEmQVY63LZ7CdCHwh
	l748uFaq3YGSM54Tg7dnh5/5XH4hRyj23Rr0cGY9r2IC4HqxvZjAKwGRDDc/fRDj5mLlmK3QPt/6F
	6OMQ7fnmITXIlhImrB3zwH8EREluW/xJKdr2PxBzUDIZTidQCRG8XYMYMrD/XFqJheCa3efE0I2N3
	p5wFENqymW+ORuCtDSRTUfhP1/yeLTFqE/t45A6oeE6FE9tJTxiKt9ve63Cnnw+noVlyBCJFJeFRF
	3+4lOFuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMiq-0000000Aiya-1EcW;
	Sun, 19 Oct 2025 06:16:52 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAMin-0000000Aixy-3JEG
	for kexec@lists.infradead.org;
	Sun, 19 Oct 2025 06:16:51 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so2913197b3a.2
        for <kexec@lists.infradead.org>; Sat, 18 Oct 2025 23:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854608; x=1761459408; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRMP2OfxaTGj9Ba3u31wGuIf4ugyC10QC83Sd0wi7Ek=;
        b=XWdVUu45FW6aSxR9jXp3//BQYgZp3muHETuBMqTyY8sZT4Qh95uXI9QxiL3RihWa95
         yye0lOnu+yLtbwgf3rL07GnnzVt3KQcyLNIRlBUVJLqateRJ5fgYlPT7EMt9SFAWuJ04
         VITZtEALjeWZv2RqfdIdLzGEtK8YAH1WBd+2mJs4O03RRn6Bc1MNZstqP31Ve8cXHLB0
         VDmm3A0CXtORNJnt681BpX13RexBj6HYvTJdISwokC0T1S2hjfRD47/5RvRxcZpbwG/F
         CbGZSRiuxUbeMZ01/y1QMduDm8LFThTnvApx9837WSLp8tG88a5FGa+ncMCDdsaC5zvL
         yKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854608; x=1761459408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRMP2OfxaTGj9Ba3u31wGuIf4ugyC10QC83Sd0wi7Ek=;
        b=AlW5XoudSr0uGUBoi3KihMmwxGhXg3ZFgE/RUWM5t9Mh7ujgDNg1bZTyLFsbf9oZVq
         FCiV7Y+Sw8tFBwLGSR7OZ5700KWXFkik88t6zToZfXFmrRSBsUeiPGBL8NWDUD9IB+uT
         lCeGCIwnyN5niw+5YUD7OypSVoJY591b5SOm0UvX4teOXy9J68sV6e+1+TnB0nBzBPWE
         pwA+amD8zaip1/zrBf1x2Zz/Td6EXUdgEtDiAUgLpvo0CXtgwmhm0ZaBHxf0e8ouHv6L
         DNCYDTwX/NFAq2IpC5a98LYx3NV/Mz9dCe2fjzMN9k9i+NPZlulrHmZ3GgvR9BRIGOcK
         IBKw==
X-Forwarded-Encrypted: i=1; AJvYcCVWx2gZRn/wQgP2DyRizppzUGbFf67tKL8zYkcvDks6vtGNaoJsKXHXzYZwRy4dQ/4D7xW2qA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwUWHKVh0j+dvhEhmNbwZiQJK5NAz6hwe8+V4iBosraqFIS8jqk
	hMzSG9ITAo1mxT1V87+kjx4qBBiYS5gk1i771HYAkRDWRtMJiWDdsky0
X-Gm-Gg: ASbGnctL1/OWPHBN+s0uOGPsc0IOJ5tz5byYvp+CchdEPgr3yUVnflfsJVQP/LAoXxU
	yWBZJ2wZq2llctGurr0/OZpXvTwb2J4uprPWQyrPvtkU4UnpnigrAp7vAA7TaGsh01EMz6zVgb3
	+pEyehtksKN4d37RCtbzs8gQCTcRKG7tAy4zurvXVQAWNEgX0mQD0DZXeKbIv9g7UVz1/Hs91WX
	xtWUZ3AfcNEh82Zkno1mNabtzmbtU8jfb+YHI+rsiZCHazSVqGSjOtg2HCSXZCcestO6xmXs5cv
	MdE3JCsjegp+vDU1rZEvfQBB8c/mov/D/vL9oQn+c7OpzsVxQDTaRgSagWF+oxLyrHSbhLcFOYC
	u7peOosB2Cf4nsDBGn+Vd941zihbEusnew9619DwKl7oldUDuq0PcWOC93tLk+u1Wa2sD47Hh15
	vm4rq3
X-Google-Smtp-Source: AGHT+IGp4+Ph5e3LiXV7d0GmlI+i90WYkt6QaEte4wvTDN2FV/GISN5U6pAGNJ2hvtEGZmBPXg14lg==
X-Received: by 2002:a05:6a20:6a1e:b0:334:9b5d:3873 with SMTP id adf61e73a8af0-334a85d9eedmr11700112637.31.1760854608328;
        Sat, 18 Oct 2025 23:16:48 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:16:47 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	stefanha@redhat.com,
	multikernel@lists.linux.dev,
	pasha.tatashin@soleen.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch v2 00/16] kernel: Introduce multikernel architecture support
Date: Sat, 18 Oct 2025 23:16:14 -0700
Message-Id: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251018_231649_844631_EC9F6169 
X-CRM114-Status: GOOD (  17.51  )
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

This patch series introduces multikernel architecture support, enabling
multiple independent kernel instances to coexist and communicate on a
single physical machine. Each kernel instance can run on dedicated CPU
cores while sharing the underlying hardware resources.

The multikernel architecture provides several key benefits:
- Better resource utilization than traditional VM (KVM, Xen etc.)
- Better performance than containers without noisy neighbor issues
- Improved fault isolation between different kernels
- Potential zero-down kernel update with KHO (Kernel HandOver)

Architecture Overview:
The implementation leverages kexec infrastructure to load and manage
multiple kernel images, with each kernel instance assigned to specific
CPU cores. Inter-kernel communication is facilitated through a dedicated
IPI framework that allows kernels to coordinate and share information
when necessary.

Key Components:
1. Enhanced kexec subsystem with dynamic kimage tracking
2. Generic physical memory allocation for multikernel and kernel
   instances
3. Multikernel-specific kernfs for managing kernel instances
4. Device-tree based mechanism for static resource allocation
5. Device-tree overlay based mechanism for dynamic resource allation
6. KHO based mechanism for device-tree sharing between kernels
7. Generic IPI communication framework for inter-kernel messaging
8. Proc interface (/proc/kimage) for monitoring loaded kernel images

The implementation maintains full backward compatibility with existing
kexec functionality while adding the new multikernel capabilities.

For the complete roadmap, please see:
https://docs.google.com/document/d/1yneO6O6C_z0Lh3A2QyT8XsH7ZrQ7-naGQT-rpdjWa_g/

For the Proof-of-Concept demo (prior to device-tree), please see:
https://www.youtube.com/watch?v=bmC4JRTSDKE

For user-space components, especially device-tree specification, please check
kerf project: https://github.com/multikernel/kerf


IMPORTANT NOTES:

1) This is a Request for Comments (RFC) submission. While the core
   architecture is functional, there are numerous implementation details
   that need improvement. The primary goal is to gather feedback on the
   high-level design and overall approach rather than focus on specific
   coding details at this stage.

2) This patch series represents only the foundational framework for
   multikernel support. It establishes the basic infrastructure and
   communication mechanisms. We welcome the community to build upon
   this foundation and develop their own solutions based on this
   framework.

3) Testing has been limited to the author's development machine using
   hard-coded boot parameters and specific hardware configurations.
   Community testing across different hardware platforms, configurations,
   and use cases would be greatly appreciated to identify potential
   issues and improve robustness. Obviously, don't use this code beyond
   testing.

Signed-off-by: Cong Wang <cwang@multikernel.io>

Changes since RFC V1:
- Switched from kexec_load() to kexec_file_load()
- Introduced generic multikernel physical memory allocation and per-instance
  virtual memory allocation
- Introduced kernfs interface for managing kernel instances
- Introduced device-tree and KHO framework for resource management and
  sharing
- Introduced messaging over IPI framework, preparing for dynamic
  resource allocation and zero-downtime upgrade
- Grouped multikernel code in the kernel/multikernel/ directory
- Reorganized and rebased all the patches

---

Cong Wang (16):
  kexec: Introduce multikernel support via kexec
  x86: Introduce SMP INIT trampoline for multikernel CPU bootstrap
  multikernel: Introduce basic multikernel subsystem infrastructure
  x86: Introduce MULTIKERNEL_VECTOR for inter-kernel communication
  x86: Introduce arch_cpu_physical_id() to obtain physical CPU ID
  multikernel: Introduce physical memory reservation and allocation
  kexec: Implement dynamic kimage tracking
  multikernel: Introduce device-tree based kernfs interface
  kexec: Integrate multikernel instance management with kexec subsystem
  Documentation: Add multikernel usage
  kexec: Add /proc/kimage interface for kimage tracking
  multikernel: Introduce per-instance memory allocation interface
  kernel: Introduce generic multikernel IPI communication framework
  multikernel: Add messaging layer for inter-kernel communication
  kexec: Integrate multikernel support with kexec_file_load()
  multikernel: Integrate Kexec HandOver framework for DTB preservation

 Documentation/multikernel/usage.rst | 215 ++++++++
 arch/powerpc/kexec/crash.c          |   8 +-
 arch/x86/include/asm/idtentry.h     |   3 +
 arch/x86/include/asm/irq_vectors.h  |   1 +
 arch/x86/include/asm/smp.h          |   7 +
 arch/x86/kernel/Makefile            |   1 +
 arch/x86/kernel/crash.c             |   4 +-
 arch/x86/kernel/head64.c            |   5 +
 arch/x86/kernel/idt.c               |   3 +
 arch/x86/kernel/kexec-bzimage64.c   |  16 +-
 arch/x86/kernel/setup.c             |  11 +-
 arch/x86/kernel/smp.c               |  17 +
 arch/x86/kernel/smpboot.c           | 159 ++++++
 arch/x86/kernel/trampoline_64_bsp.S | 288 +++++++++++
 arch/x86/kernel/vmlinux.lds.S       |   6 +
 drivers/of/kexec.c                  |  20 +-
 include/linux/kexec.h               |  30 +-
 include/linux/kexec_handover.h      |  40 ++
 include/linux/multikernel.h         | 659 ++++++++++++++++++++++++
 include/uapi/linux/kexec.h          |   5 +
 include/uapi/linux/reboot.h         |   2 +-
 kernel/Kconfig.kexec                |   2 +
 kernel/Makefile                     |   1 +
 kernel/kexec.c                      |  60 ++-
 kernel/kexec_core.c                 | 384 ++++++++++++++
 kernel/kexec_file.c                 | 158 +++++-
 kernel/kexec_handover.c             | 197 ++++++-
 kernel/multikernel/Kconfig          |  26 +
 kernel/multikernel/Makefile         |   9 +
 kernel/multikernel/core.c           | 532 +++++++++++++++++++
 kernel/multikernel/dts.c            | 466 +++++++++++++++++
 kernel/multikernel/internal.h       |   4 +
 kernel/multikernel/ipi.c            | 471 +++++++++++++++++
 kernel/multikernel/kernfs.c         | 772 ++++++++++++++++++++++++++++
 kernel/multikernel/kho.c            | 356 +++++++++++++
 kernel/multikernel/mem.c            | 376 ++++++++++++++
 kernel/multikernel/messaging.c      | 278 ++++++++++
 kernel/reboot.c                     |  10 +
 38 files changed, 5572 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/multikernel/usage.rst
 create mode 100644 arch/x86/kernel/trampoline_64_bsp.S
 create mode 100644 include/linux/multikernel.h
 create mode 100644 kernel/multikernel/Kconfig
 create mode 100644 kernel/multikernel/Makefile
 create mode 100644 kernel/multikernel/core.c
 create mode 100644 kernel/multikernel/dts.c
 create mode 100644 kernel/multikernel/internal.h
 create mode 100644 kernel/multikernel/ipi.c
 create mode 100644 kernel/multikernel/kernfs.c
 create mode 100644 kernel/multikernel/kho.c
 create mode 100644 kernel/multikernel/mem.c
 create mode 100644 kernel/multikernel/messaging.c

-- 
2.34.1


