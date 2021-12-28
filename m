Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v19 03/13] kdump: make parse_crashkernel_{high|low}() static
Date: Tue, 28 Dec 2021 21:26:02 +0800
Message-ID: <20211228132612.1860-4-thunder.leizhen@huawei.com>
In-Reply-To: <20211228132612.1860-1-thunder.leizhen@huawei.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
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

Make parse_crashkernel_{high|low}() static, they are only referenced by
parse_crashkernel_high_low() in the same file. The latter is recommended.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/linux/crash_core.h | 4 ----
 kernel/crash_core.c        | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 2d3a64761d18998..598fd55d83c169e 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -79,10 +79,6 @@ void final_note(Elf_Word *buf);
 
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
-int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
-		unsigned long long *crash_size, unsigned long long *crash_base);
-int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
-		unsigned long long *crash_size, unsigned long long *crash_base);
 int __init parse_crashkernel_high_low(char *cmdline,
 				      unsigned long long *high_size,
 				      unsigned long long *low_size);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 8966beaf7c4fd52..3b9e01fc450b2a4 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -277,7 +277,7 @@ int __init parse_crashkernel(char *cmdline,
 					"crashkernel=", NULL);
 }
 
-int __init parse_crashkernel_high(char *cmdline,
+static int __init parse_crashkernel_high(char *cmdline,
 			     unsigned long long system_ram,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
@@ -286,7 +286,7 @@ int __init parse_crashkernel_high(char *cmdline,
 				"crashkernel=", suffix_tbl[SUFFIX_HIGH]);
 }
 
-int __init parse_crashkernel_low(char *cmdline,
+static int __init parse_crashkernel_low(char *cmdline,
 			     unsigned long long system_ram,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
