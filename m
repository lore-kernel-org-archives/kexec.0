Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c92lh-0004iQ-CO
 for kexec@lists.infradead.org; Tue, 22 Nov 2016 04:33:19 +0000
Received: by mail-qt0-f182.google.com with SMTP id w33so3854903qtc.3
 for <kexec@lists.infradead.org>; Mon, 21 Nov 2016 20:32:54 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [PATCH 0/2] kexec-tools: arm64: Add dcache enabling facility
Date: Tue, 22 Nov 2016 10:02:42 +0530
Message-Id: <cover.1479788404.git.panand@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, geoff@infradead.org
Cc: Pratyush Anand <panand@redhat.com>, james.morse@arm.com, linux-arm-kernel@lists.infradead.org

It takes more that 2 minutes to verify SHA in purgatory when vmlinuz image
is around 13MB and initramfs is around 30MB. It takes more than 20 second
even when we have -O2 optimization enabled. However, if dcache is enabled
during purgatory execution then, it takes just a second in SHA verification.

Therefore, these patches adds support for dcache enabling facility during
purgatory execution. There is no change in kexec behaviour by default.
Dcache will be enabled only when --enable-dcache is passed to kexec.

Pratyush Anand (2):
  arm64: Add enable/disable d-cache support for purgatory
  arm64: Pass RAM boundary and enable-dcache flag to purgatory

 kexec/arch/arm64/include/arch/options.h |   6 +-
 kexec/arch/arm64/include/types.h        |  16 ++
 kexec/arch/arm64/kexec-arm64.c          |  25 ++-
 purgatory/arch/arm64/Makefile           |   2 +
 purgatory/arch/arm64/cache-asm.S        | 186 ++++++++++++++++++
 purgatory/arch/arm64/cache.c            | 330 ++++++++++++++++++++++++++++++++
 purgatory/arch/arm64/cache.h            |  79 ++++++++
 purgatory/arch/arm64/purgatory-arm64.c  |  11 ++
 8 files changed, 653 insertions(+), 2 deletions(-)
 create mode 100644 kexec/arch/arm64/include/types.h
 create mode 100644 purgatory/arch/arm64/cache-asm.S
 create mode 100644 purgatory/arch/arm64/cache.c
 create mode 100644 purgatory/arch/arm64/cache.h

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
