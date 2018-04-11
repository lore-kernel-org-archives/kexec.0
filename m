Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <84f6e4bceae52c95432b79562ab2d8011b1c1e5e.1523465700.git.geoff@infradead.org>
In-Reply-To: <cover.1523465700.git.geoff@infradead.org>
References: <cover.1523465700.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 2/4] crashdump-ppc64: Fix integer truncation warning
Date: Wed, 11 Apr 2018 17:03:11 +0000
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Petitboot@lists.ozlabs.org

Fixes warnings like these when building kexec for powerpc (32 bit):

  crashdump-ppc64.h: warning: large integer implicitly truncated to unsigned type

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 kexec/arch/ppc64/crashdump-ppc64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.h b/kexec/arch/ppc64/crashdump-ppc64.h
index 87beb39..b0cba8a 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.h
+++ b/kexec/arch/ppc64/crashdump-ppc64.h
@@ -14,7 +14,7 @@ void add_usable_mem_rgns(unsigned long long base, unsigned long long size);
 #define VMALLOCBASE     0xD000000000000000ULL
 
 #define __pa(x)         ((unsigned long)(x)-PAGE_OFFSET)
-#define MAXMEM          (-KERNELBASE-VMALLOCBASE)
+#define MAXMEM          (-(unsigned long)(KERNELBASE-VMALLOCBASE))
 
 #define COMMAND_LINE_SIZE       2048 /* from kernel */
 /* Backup Region, First 64K of System RAM. */
-- 
2.14.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
