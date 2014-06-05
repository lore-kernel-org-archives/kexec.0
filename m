Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WsVrK-0008Um-B8
 for kexec@lists.infradead.org; Thu, 05 Jun 2014 11:29:27 +0000
From: Liu Hua <sdu.liu@huawei.com>
Subject: [PATCH 0/2] kexec: add LPAE support for ARM32 platform
Date: Thu, 5 Jun 2014 19:20:06 +0800
Message-ID: <1401967208-30948-1-git-send-email-sdu.liu@huawei.com>
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
To: horms@verge.net.au
Cc: wangnan0@huawei.com, liusdu@126.com, kexec@lists.infradead.org, Liu Hua <sdu.liu@huawei.com>, genghui@huawei.com


This patch series introduces LPAE support for 32-bit ARM
platform.

I have test them on LPAE enabled kernel(command: kexec ... -d):

With this patch series:

crashkernel: [0x20000000 - 0x280fffff] (129M)
memory range: [0 - 0x1fffffff] (512M)
memory range: [0x28100000 - 0x3fffffff] (383M)
memory range: [0x1e0000000 - 0x1fcbfffff] (460M)

Without:

crashkernel: [0x20000000 - 0x280fffff] (129M)
memory range: [0 - 0x1fffffff] (512M)
memory range: [0x28100000 - 0x3fffffff] (383M)
memory range: [0xe0000000 - 0xfcbfffff] (460M)

Thanks,
Liu Hua

Liu Hua (2):
  kexec: iomem: accept u64 parameters for callbacks
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
