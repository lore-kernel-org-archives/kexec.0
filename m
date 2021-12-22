Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v18 11/17] kdump: Make parse_crashkernel_{high|low} static
Date: Wed, 22 Dec 2021 21:08:14 +0800
Message-ID: <20211222130820.1754-12-thunder.leizhen@huawei.com>
In-Reply-To: <20211222130820.1754-1-thunder.leizhen@huawei.com>
References: <20211222130820.1754-1-thunder.leizhen@huawei.com>
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
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>, Randy Dunlap <rdunlap@infradead.org>, Feng Zhou <zhoufeng.zf@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Chen Zhou <dingguo.cz@antgroup.com>, John
 Donnelly <John.p.donnelly@oracle.com>

Currently, parse_crashkernel_{high|low} is only referenced by
parse_crashkernel_in_order(), and they are in the same file. So make it
static, and move it into "#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL".

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/crash_core.h |  4 ----
 kernel/crash_core.c        | 19 ++++++++++---------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e7db..529a0a783190bfe 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -79,9 +79,5 @@ void final_note(Elf_Word *buf);
 
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
-int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
-		unsigned long long *crash_size, unsigned long long *crash_base);
-int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
-		unsigned long long *crash_size, unsigned long long *crash_base);
 
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 496dae2718cf026..a037076b89a9bb2 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -279,7 +279,15 @@ int __init parse_crashkernel(char *cmdline,
 	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base, SUFFIX_NULL);
 }
 
-int __init parse_crashkernel_high(char *cmdline,
+
+/*
+ * --------- Crashkernel reservation ------------------------------
+ */
+
+#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
+
+#ifdef CONFIG_64BIT
+static int __init parse_crashkernel_high(char *cmdline,
 			     unsigned long long system_ram,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
@@ -287,7 +295,7 @@ int __init parse_crashkernel_high(char *cmdline,
 	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base, SUFFIX_HIGH);
 }
 
-int __init parse_crashkernel_low(char *cmdline,
+static int __init parse_crashkernel_low(char *cmdline,
 			     unsigned long long system_ram,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
@@ -295,13 +303,6 @@ int __init parse_crashkernel_low(char *cmdline,
 	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base, SUFFIX_LOW);
 }
 
-/*
- * --------- Crashkernel reservation ------------------------------
- */
-
-#ifdef CONFIG_ARCH_WANT_RESERVE_CRASH_KERNEL
-
-#ifdef CONFIG_64BIT
 static int __init reserve_crashkernel_low(unsigned long long low_size)
 {
 	unsigned long long low_base = 0;
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
