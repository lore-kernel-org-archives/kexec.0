Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH Resend] ARM: kdump: makes second kernel use strict pfn_valid
Date: Mon, 19 May 2014 09:54:03 +0800
Message-ID: <1400464443-34816-1-git-send-email-wangnan0@huawei.com>
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
To: linux@arm.linux.org.uk, Simon Horman <horms@verge.net.au>, Will Deacon <will.deacon@arm.com>
Cc: Wang Nan <wangnan0@huawei.com>, Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>, linux-arm-kernel@lists.infradead.org

When SPARSEMEM and CRASH_DUMP both selected, simple pfn_valid prevents
the second kernel ioremap first kernel's memory if the address falls
into second kernel section. This limitation requires the second kernel
occupies a full section, and elfcorehdr must resides in another section.

This patch makes crash dump kernel use strict pfn_valid, removes such
limitation.

For example:

  For a platform with SECTION_SIZE_BITS == 28 (256MiB) and
  crashkernel=128M@0x28000000 in kernel cmdline, the second
  kernel is loaded at 0x28000000. Kexec puts elfcorehdr at
  0x2ff00000, and passes 'elfcorehdr=0x2ff00000 mem=130048K' to
  second kernel. When second kernel start, it tries to use
  ioremap to retrive its elfcorehrd. In this case, elfcodehdr is at the
  same section of the second kernel, pfn_valid will recongnize
  the page as valid, so ioremap will refuse to map it.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Geng Hui <hui.geng@huawei.com>
---

I have sent this patch once, but get no response. Resend with commit
message update.

---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index db3c541..795b1d4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1800,7 +1800,7 @@ config ARCH_SELECT_MEMORY_MODEL
 	def_bool ARCH_SPARSEMEM_ENABLE
 
 config HAVE_ARCH_PFN_VALID
-	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
+	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM || CRASH_DUMP
 
 config HIGHMEM
 	bool "High Memory Support"
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
