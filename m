Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 4/4] kdump: reduce unnecessary parameters of
 parse_crashkernel_{high|low}()
Date: Sat, 25 Dec 2021 15:23:27 +0800
Message-ID: <20211225072327.1807-5-thunder.leizhen@huawei.com>
In-Reply-To: <20211225072327.1807-1-thunder.leizhen@huawei.com>
References: <20211225072327.1807-1-thunder.leizhen@huawei.com>
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

Delete confusing parameters 'system_ram' and 'crash_base' of
parse_crashkernel_{high|low}(), they are only needed by the case of
"crashkernel=X@[offset]".

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/crash_core.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 97001820396295e..0ebf5efce3119c5 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -278,20 +278,20 @@ int __init parse_crashkernel(char *cmdline,
 }
 
 static int __init parse_crashkernel_high(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
+					 unsigned long long *crash_size)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
+	unsigned long long base;
+
+	return __parse_crashkernel(cmdline, 0, crash_size, &base,
 				"crashkernel=", suffix_tbl[SUFFIX_HIGH]);
 }
 
 static int __init parse_crashkernel_low(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
+					unsigned long long *crash_size)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
+	unsigned long long base;
+
+	return __parse_crashkernel(cmdline, 0, crash_size, &base,
 				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
 }
 
@@ -310,12 +310,11 @@ int __init parse_crashkernel_high_low(char *cmdline,
 				      unsigned long long *low_size)
 {
 	int ret;
-	unsigned long long base;
 
 	BUG_ON(!high_size || !low_size);
 
 	/* crashkernel=X,high */
-	ret = parse_crashkernel_high(cmdline, 0, high_size, &base);
+	ret = parse_crashkernel_high(cmdline, high_size);
 	if (ret)
 		return ret;
 
@@ -323,7 +322,7 @@ int __init parse_crashkernel_high_low(char *cmdline,
 		return -EINVAL;
 
 	/* crashkernel=Y,low */
-	ret = parse_crashkernel_low(cmdline, 0, low_size, &base);
+	ret = parse_crashkernel_low(cmdline, low_size);
 	if (ret)
 		*low_size = -1;
 
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
