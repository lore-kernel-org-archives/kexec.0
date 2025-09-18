Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE64CAC5A7
	for <kexec@archiver.kernel.org>; Thu, 18 Sep 2025 22:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DbEPHi/FBJoBntQoKxRmObfSjuVxaXboS80M9e4IQLM=; b=ZL7vqrkUB7elGCZnaIiXh4c7LU
	gk/g/nEzKI+spwHzRRBR++ycM//3FvFptRl/Xbnor9GMJhDwUD+FP5nUZFxUpb6HrR+wTP+3i2EpO
	M/LEvjBLFb4QW6fTzPhrew3EKXBJZS4L/gtRKaZKuxXUs2XbV1nVTF5hSgrBkAdlFT9OxZyLWkCoY
	aZ4qf731vq4JfGopyTV94igpzSs/7BWD5a2DQabwszzOpWK6wEABdqVd5irRK6MwpVPI5FHtmGA2D
	rdZHVNaQuh8oJ3nYOa8Fly/P1JtVX5QFtt3BMFhk9VV+T9IiLQXv/+mDzN5B89DkQgbLkCQm+wo/z
	vLM959+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzN55-00000001KFo-1HAB;
	Thu, 18 Sep 2025 22:26:23 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzN53-00000001KFB-1CaU
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 22:26:22 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-7761b83fd01so1540363b3a.3
        for <kexec@lists.infradead.org>; Thu, 18 Sep 2025 15:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758234380; x=1758839180; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DbEPHi/FBJoBntQoKxRmObfSjuVxaXboS80M9e4IQLM=;
        b=WhA1zJIDLS7x3gGzCOBIW4i1/uXBTssrWg2AQZs/UVja+eNJmd6rTtBtfLiWmeyi2m
         vw2g+L7mvCAW3PLL+LtRHyyRYseJed9Pyd9NI/dQP/zuq2vMY6CQieEu3/SKYgPq4It+
         cvjQvbiWo0l3ElRFkoG//z14YCqeuGrFQz2h68T7+n+7SJ0RSfUMsgp7mXsEgnE2QbhV
         pLYGLZOTRz5BhwE5vE5OeanL+pGd8fGgLp1qYYPtmZCxPtBdpqhWYk7SwwZtGUSi83g9
         x/lhpu0autlVHcyI7WRIkQnoOCoF7gMjcA6S+fLvUBc7wj2bAb8GZ6O7qBdmUge2TUdL
         BoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234380; x=1758839180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbEPHi/FBJoBntQoKxRmObfSjuVxaXboS80M9e4IQLM=;
        b=q3nbZokPK0hLu0bhovEmyLtqoN1YPkd0tDRDUNOltdkCY7qjP1AYnpPCtE1MrxN4DQ
         BRxIL0RNTMp41adWX4MaxooXu+N/P/E+hXqFHjy5Ss3Hydh3no2TQpGpsJlXr1yptiWs
         QFSzFSEdW9zYvpvfsVFzt3I/ULe7+LhE8sk1cmxvqZwMAfh0ZiJpO0qXI9g8qQDep7xK
         jhL93GGq33vAEgHdK7Z52/weHoZ+B5CP4La1D1fKa40JPiQUSx0VQ07/M2EH6VcDVlyA
         7bsoLevoaFjtS0XXUpK/K06UM0qLSqVaaWEH+oY+xh6BI6JP3JAYuWrmJ3ZHG7ZfHVTz
         jmBA==
X-Forwarded-Encrypted: i=1; AJvYcCXpJTer+8ppsikYlewDbGYKOY/sRyo23Nvt1cMxlCIUR4bSIu8R3DQqGAhf+YIEZhOoh64kuQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyVjiG75FwW+IYw0uMZEJYYMdlHZRM5oiiCHScjG53Cl9xZexBK
	qyXT+F3Lo8y+ALqX1iyolvjoR9mYEPUF1q4y8JCjy1XwOeDBxMza7kDA
X-Gm-Gg: ASbGncuifoC12q05ecLGaJr4iA9gKlArhmEAzCO4s5vfJI3QKkqPnLyZpeD8gGGTKGm
	TVELeOqF8mkrcw6Oa7PrNln6FzOm48l7uBO356lAKqnUi+lRQ0EOHTaqymaLvLixMaPG7QMcjEi
	I8PdLGdhsgNRFjgbsZ+gT3ac9uMp2qxDd5AYaLCPhEjMmzQQtArjVvm2xyGGdgcc3PiiCH5gc0T
	8ef+DlCPHfZNXP4SmJHJAWQSkyiKeW1z5Rot09DvdvzG/+z46I3cSH1x4DToLpxnfBm2D4ke8U/
	3zghcSrrgWChsAM38Dlcej2pQ4fwf1ffVOeF0YNJ+KsI93Zwsi9wFhyAoHNwG3h13uobkoXf1aK
	66tvS3eZWXRPWjb4oM++PfpE9zKBrI+xnSenq9uK0ISYPJII=
X-Google-Smtp-Source: AGHT+IG6nLv83h+1eeTVl7MZ7TPHJ+9naz9tMMEQEalz0Qo1qnLahXUNQcADDPcryvTTLERYOekvXA==
X-Received: by 2002:a05:6a00:190a:b0:76b:ec81:bcc9 with SMTP id d2e1a72fcca58-77e4eaad25amr1209704b3a.21.1758234379999;
        Thu, 18 Sep 2025 15:26:19 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:c5c1:2e33:6cf2:beed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e5fe6de75sm407542b3a.19.2025.09.18.15.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:26:19 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: pasha.tatashin@soleen.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
Date: Thu, 18 Sep 2025 15:25:59 -0700
Message-Id: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_152621_334890_528F73C0 
X-CRM114-Status: GOOD (  14.91  )
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
- Improved fault isolation between different workloads
- Enhanced security through kernel-level separation
- Better resource utilization than traditional VM (KVM, Xen etc.)
- Potential zero-down kernel update with KHO (Kernel Hand Over)

Architecture Overview:
The implementation leverages kexec infrastructure to load and manage
multiple kernel images, with each kernel instance assigned to specific
CPU cores. Inter-kernel communication is facilitated through a dedicated
IPI framework that allows kernels to coordinate and share information
when necessary.

Key Components:
1. Enhanced kexec subsystem with dynamic kimage tracking
2. Generic IPI communication framework for inter-kernel messaging
3. Architecture-specific CPU bootstrap mechanisms (only x86 so far)
4. Proc interface for monitoring loaded kernel instances

Patch Summary:

Patch 1/7: Introduces basic multikernel support via kexec, allowing
           multiple kernel images to be loaded simultaneously.

Patch 2/7: Adds x86-specific SMP INIT trampoline for bootstrapping
           CPUs with different kernel instances.

Patch 3/7: Introduces dedicated MULTIKERNEL_VECTOR for x86 inter-kernel
           communication.

Patch 4/7: Implements generic multikernel IPI communication framework
           for cross-kernel messaging and coordination.

Patch 5/7: Adds arch_cpu_physical_id() function to obtain physical CPU
           identifiers for proper CPU management.

Patch 6/7: Replaces static kimage globals with dynamic linked list
           infrastructure to support multiple kernel images.

Patch 7/7: Adds /proc/multikernel interface for monitoring and debugging
           loaded kernel instances.

The implementation maintains full backward compatibility with existing
kexec functionality while adding the new multikernel capabilities.

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

This work enables new use cases such as running real-time kernels
alongside general-purpose kernels, isolating security-critical
applications, and providing dedicated kernel instances for specific
workloads etc..

Signed-off-by: Cong Wang <cwang@multikernel.io>

---

Cong Wang (7):
  kexec: Introduce multikernel support via kexec
  x86: Introduce SMP INIT trampoline for multikernel CPU bootstrap
  x86: Introduce MULTIKERNEL_VECTOR for inter-kernel communication
  kernel: Introduce generic multikernel IPI communication framework
  x86: Introduce arch_cpu_physical_id() to obtain physical CPU ID
  kexec: Implement dynamic kimage tracking
  kexec: Add /proc/multikernel interface for kimage tracking

 arch/powerpc/kexec/crash.c          |   8 +-
 arch/x86/include/asm/idtentry.h     |   1 +
 arch/x86/include/asm/irq_vectors.h  |   1 +
 arch/x86/include/asm/smp.h          |   7 +
 arch/x86/kernel/Makefile            |   1 +
 arch/x86/kernel/crash.c             |   4 +-
 arch/x86/kernel/head64.c            |   5 +
 arch/x86/kernel/idt.c               |   1 +
 arch/x86/kernel/setup.c             |   3 +
 arch/x86/kernel/smp.c               |  15 ++
 arch/x86/kernel/smpboot.c           | 161 +++++++++++++
 arch/x86/kernel/trampoline_64_bsp.S | 288 ++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S       |   6 +
 include/linux/kexec.h               |  22 +-
 include/linux/multikernel.h         |  81 +++++++
 include/uapi/linux/kexec.h          |   1 +
 include/uapi/linux/reboot.h         |   2 +-
 init/main.c                         |   2 +
 kernel/Makefile                     |   2 +-
 kernel/kexec.c                      | 103 +++++++-
 kernel/kexec_core.c                 | 359 ++++++++++++++++++++++++++++
 kernel/kexec_file.c                 |  33 ++-
 kernel/multikernel.c                | 314 ++++++++++++++++++++++++
 kernel/reboot.c                     |  10 +
 24 files changed, 1411 insertions(+), 19 deletions(-)
 create mode 100644 arch/x86/kernel/trampoline_64_bsp.S
 create mode 100644 include/linux/multikernel.h
 create mode 100644 kernel/multikernel.c

-- 
2.34.1


