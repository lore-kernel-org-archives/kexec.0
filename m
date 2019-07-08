Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hkaz2-0001QD-0M
 for kexec@lists.infradead.org; Mon, 08 Jul 2019 21:15:38 +0000
Received: by mail-qt1-x842.google.com with SMTP id h24so19574707qto.0
 for <kexec@lists.infradead.org>; Mon, 08 Jul 2019 14:15:35 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: [v1 3/5] kexec: export common crashkernel/kexeckernel parser
Date: Mon,  8 Jul 2019 17:15:26 -0400
Message-Id: <20190708211528.12392-4-pasha.tatashin@soleen.com>
In-Reply-To: <20190708211528.12392-1-pasha.tatashin@soleen.com>
References: <20190708211528.12392-1-pasha.tatashin@soleen.com>
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
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

To reserve memory for normal kexec reboot, the new parameter:
kexeckernel=size[KMG][@offset[KMG]] is used. Its syntax is the
same as craskernel=, therefore they can use the same function to
parse parameter settings.

Rename: __parse_crashkernel() to parse_crash_or_kexec_kernel(), and
make it public.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++++
 include/linux/crash_core.h                    |  6 +++++
 kernel/crash_core.c                           | 27 ++++++++++---------
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5c7a0f5b0a2f..0f5ce665c7f5 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -739,6 +739,13 @@
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
 
+	kexeckernel=size[KMG][@offset[KMG]]
+			[KNL] Using kexec, Linux can reboot to a new kernel.
+			This parameter reserves the physical memory region
+			[offset, offset + size] for that kernel. If '@offset' is
+			omitted, then a suitable offset is selected
+			automatically.
+
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests
 
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 525510a9f965..e90789ff0bec 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -74,5 +74,11 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
+int parse_crash_or_kexec_kernel(char *cmdline,
+				unsigned long long system_ram,
+				unsigned long long *crash_size,
+				unsigned long long *crash_base,
+				const char *name,
+				const char *suffix);
 
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 9f1557b98468..11e0f9837a32 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -224,12 +224,12 @@ static __init char *get_last_crashkernel(char *cmdline,
 	return ck_cmdline;
 }
 
-static int __init __parse_crashkernel(char *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base,
-			     const char *name,
-			     const char *suffix)
+int __init parse_crash_or_kexec_kernel(char *cmdline,
+				       unsigned long long system_ram,
+				       unsigned long long *crash_size,
+				       unsigned long long *crash_base,
+				       const char *name,
+				       const char *suffix)
 {
 	char	*first_colon, *first_space;
 	char	*ck_cmdline;
@@ -270,8 +270,9 @@ int __init parse_crashkernel(char *cmdline,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-					"crashkernel=", NULL);
+	return parse_crash_or_kexec_kernel(cmdline, system_ram, crash_size,
+					   crash_base, "crashkernel=",
+					   NULL);
 }
 
 int __init parse_crashkernel_high(char *cmdline,
@@ -279,8 +280,9 @@ int __init parse_crashkernel_high(char *cmdline,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				"crashkernel=", suffix_tbl[SUFFIX_HIGH]);
+	return parse_crash_or_kexec_kernel(cmdline, system_ram, crash_size,
+					   crash_base, "crashkernel=",
+					   suffix_tbl[SUFFIX_HIGH]);
 }
 
 int __init parse_crashkernel_low(char *cmdline,
@@ -288,8 +290,9 @@ int __init parse_crashkernel_low(char *cmdline,
 			     unsigned long long *crash_size,
 			     unsigned long long *crash_base)
 {
-	return __parse_crashkernel(cmdline, system_ram, crash_size, crash_base,
-				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
+	return parse_crash_or_kexec_kernel(cmdline, system_ram, crash_size,
+					   crash_base, "crashkernel=",
+					   suffix_tbl[SUFFIX_LOW]);
 }
 
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
-- 
2.22.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
