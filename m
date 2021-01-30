Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v14 01/11] x86: kdump: replace the hard-coded alignment with
 macro CRASH_ALIGN
Date: Sat, 30 Jan 2021 15:10:15 +0800
Message-ID: <20210130071025.65258-2-chenzhou10@huawei.com>
In-Reply-To: <20210130071025.65258-1-chenzhou10@huawei.com>
References: <20210130071025.65258-1-chenzhou10@huawei.com>
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
To: mingo@redhat.com, tglx@linutronix.de, rppt@kernel.org, dyoung@redhat.com, bhe@redhat.com, catalin.marinas@arm.com, will@kernel.org, nsaenzjulienne@suse.de, corbet@lwn.net, John.P.donnelly@oracle.com, bhsharma@redhat.com, prabhakar.pkin@gmail.com
Cc: John Donnelly <John.p.donnelly@oracle.com>, wangkefeng.wang@huawei.com, arnd@arndb.de, xiexiuqi@huawei.com, chenzhou10@huawei.com, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, horms@verge.net.au, james.morse@arm.com, huawei.libin@huawei.com, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org

Move CRASH_ALIGN to header asm/kexec.h for later use. Besides, the
alignment of crash kernel regions in x86 is 16M(CRASH_ALIGN), but
function reserve_crashkernel() also used 1M alignment. So just
replace hard-coded alignment 1M with macro CRASH_ALIGN.

Suggested-by: Dave Young <dyoung@redhat.com>
Suggested-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Tested-by: John Donnelly <John.p.donnelly@oracle.com>
---
 arch/x86/include/asm/kexec.h | 3 +++
 arch/x86/kernel/setup.c      | 5 +----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 6802c59e8252..be18dc7ae51f 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -18,6 +18,9 @@
 
 # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
 
+/* 16M alignment for crash kernel regions */
+#define CRASH_ALIGN		SZ_16M
+
 #ifndef __ASSEMBLY__
 
 #include <linux/string.h>
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3412c4595efd..da769845597d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -390,9 +390,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 
 #ifdef CONFIG_KEXEC_CORE
 
-/* 16M alignment for crash kernel regions */
-#define CRASH_ALIGN		SZ_16M
-
 /*
  * Keep the crash kernel below this limit.
  *
@@ -510,7 +507,7 @@ static void __init reserve_crashkernel(void)
 	} else {
 		unsigned long long start;
 
-		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
+		start = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base,
 						  crash_base + crash_size);
 		if (start != crash_base) {
 			pr_info("crashkernel reservation failed - memory is in use.\n");
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
