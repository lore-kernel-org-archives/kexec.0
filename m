Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQXZM-0005Tg-OX
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 07:39:18 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH v3 0/2] kexec: pass initrd position in dtb
Date: Thu, 20 Mar 2014 07:33:55 +0000
Message-ID: <1395300837-18687-1-git-send-email-wangnan0@huawei.com>
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
secondary kernel. To makes code clear, patch 1/2 introduce a new
function to handle fdt related operations.

Without these two patches, kexec failed to work on arm.


Change from v1:

 - Remove #include "libfdt_internal.h" since it is for internal use
    for libfdt.

Change from v2:

 - Split into two logically independent patches.
 - Compute memory consumption more accurate.



Wang Nan (2):
  kexec: introduce setup_dtb_prop to make code clear
  kexec: pass initrd position by dtb

 kexec/arch/arm/kexec-zImage-arm.c | 109 +++++++++++++++++++++++++++++---------
 1 file changed, 83 insertions(+), 26 deletions(-)

-- 
1.8.3.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
