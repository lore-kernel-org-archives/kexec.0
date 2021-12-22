Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v18 12/17] kdump: Reduce unused parameters of
 parse_crashkernel_{high|low}
Date: Wed, 22 Dec 2021 21:08:15 +0800
Message-ID: <20211222130820.1754-13-thunder.leizhen@huawei.com>
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

The parameters 'system_ram' and 'crash_base' is only needed by the case of
"crashkernel=X@[offset]". The argument list of parse_crashkernel_suffix()
can help prove this point.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/crash_core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a037076b89a9bb2..67f5065e3c3cfcc 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -288,19 +288,19 @@ int __init parse_crashkernel(char *cmdline,
 
 #ifdef CONFIG_64BIT
 static int __init parse_crashkernel_high(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
+					 unsigned long long *crash_size)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base, SUFFIX_HIGH);
+	unsigned long long base;
+
+	return __parse_crashkernel(cmdline, 0, crash_size, &base, SUFFIX_HIGH);
 }
 
 static int __init parse_crashkernel_low(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
+					unsigned long long *crash_size)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base, SUFFIX_LOW);
+	unsigned long long base;
+
+	return __parse_crashkernel(cmdline, 0, crash_size, &base, SUFFIX_LOW);
 }
 
 static int __init reserve_crashkernel_low(unsigned long long low_size)
@@ -368,14 +368,14 @@ static int __init parse_crashkernel_in_order(char *cmdline,
 
 #ifdef CONFIG_64BIT
 	/* crashkernel=X,high */
-	ret = parse_crashkernel_high(cmdline, system_ram, crash_size, crash_base);
+	ret = parse_crashkernel_high(cmdline, crash_size);
 	if (ret || crash_size <= 0)
 		return CRASHKERNEL_MEM_NONE;
 
 	flag = CRASHKERNEL_MEM_HIGH;
 
 	/* crashkernel=Y,low */
-	ret = parse_crashkernel_low(cmdline, system_ram, low_size, crash_base);
+	ret = parse_crashkernel_low(cmdline, low_size);
 	if (!ret)
 		flag |= CRASHKERNEL_MEM_LOW;
 #endif
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
