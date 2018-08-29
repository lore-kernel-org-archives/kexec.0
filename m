Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fv1HE-0005g1-0U
 for kexec@lists.infradead.org; Wed, 29 Aug 2018 14:16:57 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/3] x86/kdump/64: Change the upper limit of crashkernel
 reservation
Date: Wed, 29 Aug 2018 22:16:24 +0800
Message-Id: <20180829141624.13985-4-bhe@redhat.com>
In-Reply-To: <20180829141624.13985-1-bhe@redhat.com>
References: <20180829141624.13985-1-bhe@redhat.com>
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
To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, kirill.shutemov@linux.intel.com
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>

Restrict kdump to only reserve crashkernel below 64TB. Since the kdump
jumping may be from 5-level to 4-level, and the kdump kernel is put
above 64TB in 5-level kernel, then the jumping will fail. And the
crashkernel reservation is done during the 1st kernel bootup, there's
no way to detect the paging mode of kdump kernel at that time.

Hence change the upper limmit of crashkernel reservation to 64TB
on x86_64.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/setup.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 8fe740e22030..1a6389096782 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -451,16 +451,26 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 #define CRASH_ALIGN		(16 << 20)
 
 /*
- * Keep the crash kernel below this limit.  On 32 bits earlier kernels
- * would limit the kernel to the low 512 MiB due to mapping restrictions.
- * On 64bit, old kexec-tools need to under 896MiB.
+ * Keep the crash kernel below this limit.
+ *
+ * On 32 bits earlier kernels would limit the kernel to the low
+ * 512 MiB due to mapping restrictions.
+ *
+ * On 64bit, old kexec-tools need to be under 896MiB. The later
+ * supports to put kernel above 4G, up to system RAM top. Here
+ * kdump kernel need be restricted to be under 64TB, which is
+ * the upper limit of system RAM in 4-level paing mode. Since
+ * the kdump jumping could be from 5-level to 4-level, the jumping
+ * will fail if kernel is put above 64TB, and there's no way to
+ * detect the paging mode of the kernel which will be loaded for
+ * dumping during the 1st kernel boots up.
  */
 #ifdef CONFIG_X86_32
 # define CRASH_ADDR_LOW_MAX	(512 << 20)
 # define CRASH_ADDR_HIGH_MAX	(512 << 20)
 #else
 # define CRASH_ADDR_LOW_MAX	(896UL << 20)
-# define CRASH_ADDR_HIGH_MAX	MAXMEM
+# define CRASH_ADDR_HIGH_MAX	(1ULL < 46)
 #endif
 
 static int __init reserve_crashkernel_low(void)
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
