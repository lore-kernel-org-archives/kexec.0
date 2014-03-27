Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
From: Liu Hua <sdu.liu@huawei.com>
Subject: [PATCH 0/3] add LPAE support for kexec and kernel
Date: Thu, 27 Mar 2014 16:00:37 +0800
Message-ID: <1395907240-13308-1-git-send-email-sdu.liu@huawei.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux@arm.linux.org.uk, horms@verge.net.au
Cc: kexec@lists.infradead.org, Liu Hua <sdu.liu@huawei.com>, linux-arm-kernel@lists.infradead.org

The patch series introduce LPAE support for user space
utility kexec(the last) and ARM linux kernel(the others).

I have tested the patch series in armA15 platform which have
more than 4G memory.

Liu Hua (2):
  ARM : kdump : Add LPAE support
  ARM : kdump : add arch_crash_save_vmcoreinfo

 arch/arm/include/asm/elf.h      |  4 +++-
 arch/arm/kernel/elf.c           | 33 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/machine_kexec.c |  7 +++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

Liu Hua (1):
  kexec: ARM: add LPAE support

 kexec/arch/arm/crashdump-arm.c | 23 ++++++++++++++++++++---
 kexec/kexec-iomem.c            |  8 ++++----
 kexec/kexec.h                  |  4 ++--
 3 files changed, 26 insertions(+), 9 deletions(-)

-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
