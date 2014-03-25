Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSIm4-0002bf-53
 for kexec@lists.infradead.org; Tue, 25 Mar 2014 04:15:41 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 0/3] kexec: pass initrd position in dtb
Date: Tue, 25 Mar 2014 12:09:42 +0800
Message-ID: <1395720585-76135-1-git-send-email-wangnan0@huawei.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Wang Nan <wangnan0@huawei.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

The main goal of this patch series is to pass initrd position to
secondary kernel. To makes code clear, patch 2/3 introduce a new
function to handle fdt related operations.

Without these two patches, kexec failed to work on arm.


Change from v1:

 - Remove #include "libfdt_internal.h" since it is for internal use
     for libfdt.

Change from v2:

 - Split into two logically independent patches.
 - Compute memory consumption more accurate.

Change from v3:

 - Introduces helpers in libfdt for memory usage computation.


Wang Nan (3):
  kexec: introduce helpers for computing dtb size
  kexec: introduce setup_dtb_prop to make code clear
  kexec: pass initrd position by dtb

 kexec/arch/arm/kexec-zImage-arm.c | 106 +++++++++++++++++++++++++++++---------
 kexec/libfdt/libfdt.h             |  24 +++++++++
 kexec/libfdt/libfdt_internal.h    |   3 --
 3 files changed, 105 insertions(+), 28 deletions(-)

-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
