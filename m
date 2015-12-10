Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6qMX-0007id-3j
 for kexec@lists.infradead.org; Thu, 10 Dec 2015 01:49:45 +0000
Subject: [V6 PATCH 4/6] x86/apic: Introduce apic_extnmi boot option
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Thu, 10 Dec 2015 10:46:32 +0900
Message-ID: <20151210014632.25437.43778.stgit@softrs>
In-Reply-To: <20151210014624.25437.50028.stgit@softrs>
References: <20151210014624.25437.50028.stgit@softrs>
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
Cc: Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

This patch introduces new boot option, apic_extnmi:

 apic_extnmi={ bsp | all | none}

The default value is "bsp" and this is the current behavior; only
BSP receives external NMI.  "all" allows external NMIs to be
broadcast to all CPUs.  This would raise the success rate of panic
on NMI when BSP hangs up in NMI context or the external NMI is
swallowed by other NMI handlers on BSP.  If you specified "none",
any CPUs don't receive external NMIs.  This is useful for dump
capture kernel so that it wouldn't be shot down while saving a
crash dump.

V6:
- Fix comments
- Change to use strncmp to parse the value of "apic_extnmi="
- Make apic_set_extnmi() return -EINVAL if the given value is invalid

V5:
- Rename the option from "noextnmi" to "apic_extnmi"
- Add apic_extnmi=all feature
- Fix the wrong documentation about "noextnmi" (apic_extnmi=none)

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/kernel-parameters.txt |    9 +++++++++
 arch/x86/include/asm/apic.h         |    5 +++++
 arch/x86/kernel/apic/apic.c         |   35 +++++++++++++++++++++++++++++++++--
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 742f69d..74acea5 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -472,6 +472,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			Change the amount of debugging information output
 			when initialising the APIC and IO-APIC components.
 
+	apic_extnmi=	[APIC,X86] External NMI delivery setting
+			Format: { bsp (default) | all | none }
+			bsp:  External NMI is delivered only to CPU 0
+			all:  External NMIs are broadcast to all CPUs as a
+			      backup of CPU 0
+			none: External NMI is masked for all CPUs. This is
+			      useful so that a dump capture kernel won't be
+			      shot down by NMI
+
 	autoconf=	[IPV6]
 			See Documentation/networking/ipv6.txt.
 
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 7f62ad4..c80f6b6 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -23,6 +23,11 @@
 #define APIC_VERBOSE 1
 #define APIC_DEBUG   2
 
+/* Macros for apic_extnmi which controls external NMI masking */
+#define APIC_EXTNMI_BSP		0 /* Default */
+#define APIC_EXTNMI_ALL		1
+#define APIC_EXTNMI_NONE	2
+
 /*
  * Define the default level of output to be very little
  * This can be turned up by using apic=verbose for more
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 8d7df74..162d2bd 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -82,6 +82,12 @@ physid_mask_t phys_cpu_present_map;
 static unsigned int disabled_cpu_apicid __read_mostly = BAD_APICID;
 
 /*
+ * This variable controls which CPUs receive external NMIs.  By default,
+ * external NMIs are delivered only to the BSP.
+ */
+static int apic_extnmi = APIC_EXTNMI_BSP;
+
+/*
  * Map cpu index to physical APIC ID
  */
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid, BAD_APICID);
@@ -1161,6 +1167,8 @@ void __init init_bsp_APIC(void)
 	value = APIC_DM_NMI;
 	if (!lapic_is_integrated())		/* 82489DX */
 		value |= APIC_LVT_LEVEL_TRIGGER;
+	if (apic_extnmi == APIC_EXTNMI_NONE)
+		value |= APIC_LVT_MASKED;
 	apic_write(APIC_LVT1, value);
 }
 
@@ -1378,9 +1386,11 @@ void setup_local_APIC(void)
 	apic_write(APIC_LVT0, value);
 
 	/*
-	 * only the BP should see the LINT1 NMI signal, obviously.
+	 * Only the BP sees the LINT1 NMI signal by default.  This can be
+	 * modified by apic_extnmi= boot option.
 	 */
-	if (!cpu)
+	if ((!cpu && apic_extnmi != APIC_EXTNMI_NONE) ||
+	    apic_extnmi == APIC_EXTNMI_ALL)
 		value = APIC_DM_NMI;
 	else
 		value = APIC_DM_NMI | APIC_LVT_MASKED;
@@ -2557,3 +2567,24 @@ static int __init apic_set_disabled_cpu_apicid(char *arg)
 	return 0;
 }
 early_param("disable_cpu_apicid", apic_set_disabled_cpu_apicid);
+
+static int __init apic_set_extnmi(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+
+	if (!strncmp("all", arg, 3))
+		apic_extnmi = APIC_EXTNMI_ALL;
+	else if (!strncmp("none", arg, 4))
+		apic_extnmi = APIC_EXTNMI_NONE;
+	else if (!strncmp("bsp", arg, 3))
+		apic_extnmi = APIC_EXTNMI_BSP;
+	else {
+		pr_warn("Unknown external NMI delivery mode `%s' ignored\n",
+			arg);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+early_param("apic_extnmi", apic_set_extnmi);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
