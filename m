Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v12 7/9] kdump: add threshold for the required memory
Date: Mon, 7 Sep 2020 21:47:43 +0800
Message-ID: <20200907134745.25732-8-chenzhou10@huawei.com>
In-Reply-To: <20200907134745.25732-1-chenzhou10@huawei.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
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
To: catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net, John.P.donnelly@oracle.com, prabhakar.pkin@gmail.com, bhsharma@redhat.com
Cc: wangkefeng.wang@huawei.com, arnd@arndb.de, linux-doc@vger.kernel.org, chenzhou10@huawei.com, xiexiuqi@huawei.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, horms@verge.net.au, nsaenzjulienne@suse.de, huawei.libin@huawei.com, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org

For crashkernel=X, if required size X is too large and leads to very
little free low memory after low allocation, the system may not work
normally.
So add a threshold and go for high allocation directly if the required
size is too large. The value of threshold is set as the half of the
low memory.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 kernel/crash_core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 3f735cb37ace..d11d597a470d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -378,6 +378,15 @@ int __init reserve_crashkernel_low(void)
 }
 
 #if defined(CONFIG_X86) || defined(CONFIG_ARM64)
+
+/*
+ * Add a threshold for required memory size of crashkernel. If required memory
+ * size is greater than threshold, just go for high allocation directly. The
+ * value of threshold is set as half of the total low memory.
+ */
+#define REQUIRED_MEMORY_THRESHOLD	(memblock_mem_size(CRASH_ADDR_LOW_MAX >> \
+			PAGE_SHIFT) >> 1)
+
 #ifdef CONFIG_KEXEC_CORE
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
@@ -422,7 +431,7 @@ void __init reserve_crashkernel(void)
 		 * So try low memory first and fall back to high memory
 		 * unless "crashkernel=size[KMG],high" is specified.
 		 */
-		if (!high)
+		if (!high && crash_size <= REQUIRED_MEMORY_THRESHOLD)
 			crash_base = memblock_find_in_range(CRASH_ALIGN,
 						CRASH_ADDR_LOW_MAX,
 						crash_size, CRASH_ALIGN);
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
