Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vw0-f49.google.com ([209.85.212.49])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O4zBp-00081t-TJ
	for kexec@lists.infradead.org; Thu, 22 Apr 2010 16:23:47 +0000
Received: by mail-vw0-f49.google.com with SMTP id 3so1969792vws.36
	for <kexec@lists.infradead.org>; Thu, 22 Apr 2010 09:23:45 -0700 (PDT)
From: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Subject: [PATCH 2/5] Modify parse_crashkernel* for new syntax
Date: Thu, 22 Apr 2010 18:23:09 +0200
Message-Id: <1271953392-6324-3-git-send-email-v.mayatskih@gmail.com>
In-Reply-To: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>
References: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <amwang@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

crashkernel= syntax of kernel command line was extended to allow
reservation of two memory regions for dump-capture kernel.

Syntax for simple case was changed from

    crashkernel=size[@offset]

to

    crashkernel=<low>/<high>

Where <low> and <high> are memory regions for dump-capture kernel in
usual crashkernel format (size@offset).

Crashkernel syntax, involving conditional reservation based on memory
size, was changed from

    crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]

to

    crashkernel=<range1>:<low_size1>[/<high_size1>]
                [,<range2>:<low_size2>[/high_size2],...]
                [@low_offset][/high_offset]

New syntax is backward compatible.

Signed-off-by: Vitaly Mayatskikh <v.mayatskih@gmail.com>
---
 include/linux/kexec.h |    5 ++
 kernel/kexec.c        |  116 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 93 insertions(+), 28 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 1a3b0a3..d2063f8 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -207,6 +207,11 @@ extern size_t vmcoreinfo_max_size;
 
 int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
+int __init parse_crashkernel_ext(char *cmdline, unsigned long long system_ram,
+				 unsigned long long *crash_size,
+				 unsigned long long *crash_base,
+				 unsigned long long *crash_size_hi,
+				 unsigned long long *crash_base_hi);
 int crash_shrink_memory(unsigned long new_size);
 size_t crash_get_memory_size(void);
 
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 1bd0199..b8fd6eb 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1229,23 +1229,42 @@ module_init(crash_notes_memory_init)
  */
 
 
+static char * __init parse_crashkernel_region(char		*cmdline,
+					     unsigned long long	*crash_size,
+					     unsigned long long	*crash_base)
+{
+	char *cur = cmdline;
+
+	*crash_size = memparse(cmdline, &cur);
+	if (cmdline == cur) {
+		pr_warning("crashkernel: memory value expected\n");
+		return 0;
+	}
+
+	if (*cur == '@')
+		*crash_base = memparse(cur + 1, &cur);
+	return cur;
+}
+
 /*
  * This function parses command lines in the format
  *
- *   crashkernel=ramsize-range:size[,...][@offset]
+ *   crashkernel=ramsize-range:size[/size2][,...][@offset][/offset2]
  *
  * The function returns 0 on success and -EINVAL on failure.
  */
-static int __init parse_crashkernel_mem(char 			*cmdline,
+static int __init parse_crashkernel_mem(char			*cmdline,
 					unsigned long long	system_ram,
 					unsigned long long	*crash_size,
-					unsigned long long	*crash_base)
+					unsigned long long	*crash_base,
+					unsigned long long	*crash_size_hi,
+					unsigned long long	*crash_base_hi)
 {
 	char *cur = cmdline, *tmp;
 
 	/* for each entry of the comma-separated list */
 	do {
-		unsigned long long start, end = ULLONG_MAX, size;
+		unsigned long long start, end = ULLONG_MAX, size, size_hi;
 
 		/* get the start of the range */
 		start = memparse(cur, &tmp);
@@ -1287,6 +1306,17 @@ static int __init parse_crashkernel_mem(char 			*cmdline,
 			return -EINVAL;
 		}
 		cur = tmp;
+
+		if (*cur == '/') {
+			cur++;
+			size_hi = memparse(cur, &tmp);
+			if (cur == tmp) {
+				pr_warning("Memory value expected\n");
+				return -EINVAL;
+			}
+			cur = tmp;
+		}
+
 		if (size >= system_ram) {
 			pr_warning("crashkernel: invalid size\n");
 			return -EINVAL;
@@ -1295,6 +1325,8 @@ static int __init parse_crashkernel_mem(char 			*cmdline,
 		/* match ? */
 		if (system_ram >= start && system_ram < end) {
 			*crash_size = size;
+			if (crash_size_hi)
+				*crash_size_hi = size_hi;
 			break;
 		}
 	} while (*cur++ == ',');
@@ -1310,6 +1342,17 @@ static int __init parse_crashkernel_mem(char 			*cmdline,
 						"after '@'\n");
 				return -EINVAL;
 			}
+			cur = tmp;
+			if (*cur == '/') {
+				cur++;
+				if (crash_base_hi)
+					*crash_base_hi = memparse(cur, &tmp);
+				if (cur == tmp) {
+					pr_warning("Memory value expected "
+						   "after '@'\n");
+					return -EINVAL;
+				}
+			}
 		}
 	}
 
@@ -1319,43 +1362,46 @@ static int __init parse_crashkernel_mem(char 			*cmdline,
 /*
  * That function parses "simple" (old) crashkernel command lines like
  *
- * 	crashkernel=size[@offset]
+ *	crashkernel=size[@offset][/size_hi][@offset_hi]
  *
  * It returns 0 on success and -EINVAL on failure.
  */
-static int __init parse_crashkernel_simple(char 		*cmdline,
-					   unsigned long long 	*crash_size,
-					   unsigned long long 	*crash_base)
+static int __init parse_crashkernel_simple(char			*cmdline,
+					   unsigned long long	*crash_size,
+					   unsigned long long	*crash_base,
+					   unsigned long long	*crash_size_hi,
+					   unsigned long long	*crash_base_hi)
 {
-	char *cur = cmdline;
+	char *cur = parse_crashkernel_region(cmdline, crash_size, crash_base);
 
-	*crash_size = memparse(cmdline, &cur);
-	if (cmdline == cur) {
-		pr_warning("crashkernel: memory value expected\n");
+	if (!cur) {
 		return -EINVAL;
+	} else if (*cur == '/' && crash_size_hi && crash_base_hi) {
+		cur = parse_crashkernel_region(cur + 1, crash_size_hi,
+					       crash_base_hi);
+		if (!cur)
+			return -EINVAL;
 	}
-
-	if (*cur == '@')
-		*crash_base = memparse(cur+1, &cur);
-
 	return 0;
 }
 
-/*
- * That function is the entry point for command line parsing and should be
- * called from the arch-specific code.
- */
-int __init parse_crashkernel(char 		 *cmdline,
-			     unsigned long long system_ram,
-			     unsigned long long *crash_size,
-			     unsigned long long *crash_base)
+int __init parse_crashkernel_ext(char		 *cmdline,
+				 unsigned long long system_ram,
+				 unsigned long long *crash_size,
+				 unsigned long long *crash_base,
+				 unsigned long long *crash_size_hi,
+				 unsigned long long *crash_base_hi)
 {
-	char 	*p = cmdline, *ck_cmdline = NULL;
+	char	*p = cmdline, *ck_cmdline = NULL;
 	char	*first_colon, *first_space;
 
 	BUG_ON(!crash_size || !crash_base);
 	*crash_size = 0;
 	*crash_base = 0;
+	if (crash_size_hi)
+		*crash_size_hi = 0;
+	if (crash_base_hi)
+		*crash_base_hi = 0;
 
 	/* find crashkernel and use the last one if there are more */
 	p = strstr(p, "crashkernel=");
@@ -1377,15 +1423,29 @@ int __init parse_crashkernel(char 		 *cmdline,
 	first_space = strchr(ck_cmdline, ' ');
 	if (first_colon && (!first_space || first_colon < first_space))
 		return parse_crashkernel_mem(ck_cmdline, system_ram,
-				crash_size, crash_base);
+					     crash_size, crash_base,
+					     crash_size_hi, crash_base_hi);
 	else
 		return parse_crashkernel_simple(ck_cmdline, crash_size,
-				crash_base);
+						crash_base, crash_size_hi,
+						crash_base_hi);
 
 	return 0;
 }
 
-
+/*
+ * That function is the entry point for command line parsing and should be
+ * called from the arch-specific code.
+ */
+int __init parse_crashkernel(char		 *cmdline,
+			     unsigned long long system_ram,
+			     unsigned long long *crash_size,
+			     unsigned long long *crash_base)
+{
+	return parse_crashkernel_ext(cmdline, system_ram,
+				     crash_size, crash_base,
+				     0, 0);
+}
 
 void crash_save_vmcoreinfo(void)
 {
-- 
1.7.0.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
