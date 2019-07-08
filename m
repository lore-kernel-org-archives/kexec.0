Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hkayz-0001MT-Da
 for kexec@lists.infradead.org; Mon, 08 Jul 2019 21:15:35 +0000
Received: by mail-qk1-x743.google.com with SMTP id v22so14444732qkj.8
 for <kexec@lists.infradead.org>; Mon, 08 Jul 2019 14:15:32 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [v1 0/5] allow to reserve memory for normal kexec kernel
Date: Mon,  8 Jul 2019 17:15:23 -0400
Message-Id: <20190708211528.12392-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Currently, it is only allowed to reserve memory for crash kernel, because
it is a requirement in order to be able to boot into crash kernel without
touching memory of crashed kernel is to have memory reserved.

The second benefit for having memory reserved for kexec kernel is
that it does not require a relocation after segments are loaded into
memory.

If kexec functionality is used for a fast system update, with a minimal
downtime, the relocation of kernel + initramfs might take a significant
portion of reboot.

In fact, on the machine that we are using, that has ARM64 processor
it takes 0.35s to relocate during kexec, thus taking 52% of kernel reboot
time:

kernel shutdown	0.03s
relocation	0.35s
kernel startup	0.29s

Image: 13M and initramfs is 24M. If initramfs increases, the relocation
time increases proportionally.

While, it is possible to add 'kexeckernel=' parameters support to other
architectures by modifying reserve_crashkernel(), in this series this is
done for arm64 only.

Pavel Tatashin (5):
  kexec: quiet down kexec reboot
  kexec: add resource for normal kexec region
  kexec: export common crashkernel/kexeckernel parser
  kexec: use reserved memory for normal kexec reboot
  arm64, kexec: reserve kexeckernel region

 .../admin-guide/kernel-parameters.txt         |  7 ++
 arch/arm64/kernel/setup.c                     |  5 ++
 arch/arm64/mm/init.c                          | 83 ++++++++++++-------
 include/linux/crash_core.h                    |  6 ++
 include/linux/ioport.h                        |  1 +
 include/linux/kexec.h                         |  6 +-
 kernel/crash_core.c                           | 27 +++---
 kernel/kexec_core.c                           | 50 +++++++----
 8 files changed, 127 insertions(+), 58 deletions(-)

-- 
2.22.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
