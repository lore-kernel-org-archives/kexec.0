Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 1/3] ARM: Premit ioremap() to map reserved pages
Date: Wed, 22 Jan 2014 19:25:14 +0800
Message-ID: <1390389916-8711-2-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1390389916-8711-1-git-send-email-wangnan0@huawei.com>
References: <1390389916-8711-1-git-send-email-wangnan0@huawei.com>
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
To: kexec@lists.infradead.org
Cc: Wang Nan <wangnan0@huawei.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, Geng Hui <hui.geng@huawei.com>, linux-mm@kvack.org, Eric Biederman <ebiederm@xmission.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org

This patch relaxes the restriction set by commit 309caa9cc, which
prohibit ioremap() on all kernel managed pages.

Other architectures, such as x86 and (some specific platforms of) powerpc,
allow such mapping.

ioremap() pages is an efficient way to avoid arm's mysterious cache control.
This feature will be used for arm kexec support to ensure copied data goes into
RAM even without cache flushing, because we found that flush_cache_xxx can't
reliably flush code to memory.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: <stable@vger.kernel.org> # 3.4+
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Geng Hui <hui.geng@huawei.com>
---
 arch/arm/mm/ioremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index f123d6e..98b1c10 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -298,7 +298,7 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 	/*
 	 * Don't allow RAM to be mapped - this causes problems with ARMv6+
 	 */
-	if (WARN_ON(pfn_valid(pfn)))
+	if (WARN_ON(pfn_valid(pfn) && !PageReserved(pfn_to_page(pfn))))
 		return NULL;
 
 	area = get_vm_area_caller(size, VM_IOREMAP, caller);
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
