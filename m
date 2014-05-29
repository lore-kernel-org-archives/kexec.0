Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([119.145.14.64])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wpwdf-0005oL-NU
 for kexec@lists.infradead.org; Thu, 29 May 2014 09:28:44 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 0/2] geneate correct PAGE_OFFSET for vmcore
Date: Thu, 29 May 2014 17:20:01 +0800
Message-ID: <1401355203-63794-1-git-send-email-wangnan0@huawei.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: Dave Anderson <anderson@redhat.com>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>, Wang Nan <wangnan0@huawei.com>

This two patches corrects PAGE_OFFSET for generated vmcore.

Original code uses fix PAGE_OFFSET: 0xc0000000. For kernel with
CONFIG_VMSPLIT_1G/2G, generated /proc/vmcore is incorrect. See
discussion:
  http://lists.infradead.org/pipermail/kexec/2014-May/011844.html

The first patch detects page_offset dynamically according to
/proc/kallsyms, the second patch intorduces a --page-offset option for
systems without KALLSYMS or /proc

Wang Nan (2):
  kexec-tools: detect page_offset dynamically
  kexec-tools: add --page-offset option for ARM

 kexec/arch/arm/crashdump-arm.c        | 64 ++++++++++++++++++++++++++++++++++-
 kexec/arch/arm/crashdump-arm.h        |  4 ++-
 kexec/arch/arm/include/arch/options.h |  4 ++-
 kexec/arch/arm/kexec-zImage-arm.c     |  7 ++++
 4 files changed, 76 insertions(+), 3 deletions(-)

-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
