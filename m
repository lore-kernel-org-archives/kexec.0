Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZfRin-0005Vj-2N
 for kexec@lists.infradead.org; Fri, 25 Sep 2015 12:03:26 +0000
Subject: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Fri, 25 Sep 2015 20:28:11 +0900
Message-ID: <20150925112811.4258.54494.stgit@softrs>
In-Reply-To: <20150925112803.4258.94241.stgit@softrs>
References: <20150925112803.4258.94241.stgit@softrs>
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
To: Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>
Cc: linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

This patch introduces new boot option "noextnmi" which disables
external NMI.  This option is useful for the dump capture kernel
so that an HA application or administrator wouldn't mistakenly
shoot down the kernel by NMI.

Currently, only x86 supports this option.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/kernel-parameters.txt |    4 ++++
 arch/x86/kernel/apic/apic.c         |   17 ++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 22a4b68..8bcaccd 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2379,6 +2379,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable non-executable mappings
 
+	noextnmi	[X86]
+			Mask external NMI.  This option is useful for a
+			dump capture kernel to be shot down by NMI.
+
 	nosmap		[X86]
 			Disable SMAP (Supervisor Mode Access Prevention)
 			even if it is supported by processor.
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 24e94ce..fd47128 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -82,6 +82,12 @@
 static unsigned int disabled_cpu_apicid __read_mostly = BAD_APICID;
 
 /*
+ * Don't enable external NMI via LINT1 on BSP.  This is useful for
+ * the dump capture kernel.
+ */
+static bool apic_noextnmi;
+
+/*
  * Map cpu index to physical APIC ID
  */
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid, BAD_APICID);
@@ -1161,6 +1167,8 @@ void __init init_bsp_APIC(void)
 	value = APIC_DM_NMI;
 	if (!lapic_is_integrated())		/* 82489DX */
 		value |= APIC_LVT_LEVEL_TRIGGER;
+	if (apic_noextnmi)
+		value |= APIC_LVT_MASKED;
 	apic_write(APIC_LVT1, value);
 }
 
@@ -1380,7 +1388,7 @@ void setup_local_APIC(void)
 	/*
 	 * only the BP should see the LINT1 NMI signal, obviously.
 	 */
-	if (!cpu)
+	if (!cpu && !apic_noextnmi)
 		value = APIC_DM_NMI;
 	else
 		value = APIC_DM_NMI | APIC_LVT_MASKED;
@@ -2548,3 +2556,10 @@ static int __init apic_set_disabled_cpu_apicid(char *arg)
 	return 0;
 }
 early_param("disable_cpu_apicid", apic_set_disabled_cpu_apicid);
+
+static int __init apic_set_noextnmi(char *arg)
+{
+	apic_noextnmi = true;
+	return 0;
+}
+early_param("noextnmi", apic_set_noextnmi);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
