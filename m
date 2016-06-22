Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFnmc-0003av-Nq
 for kexec@lists.infradead.org; Wed, 22 Jun 2016 19:25:55 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MJOa90135076
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 15:25:34 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q1qp8w7a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 22 Jun 2016 15:25:34 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 05:25:31 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D593D3578056
 for <kexec@lists.infradead.org>; Thu, 23 Jun 2016 05:25:29 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MJPT7A4260304
 for <kexec@lists.infradead.org>; Thu, 23 Jun 2016 05:25:29 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MJPTHY028999
 for <kexec@lists.infradead.org>; Thu, 23 Jun 2016 05:25:29 +1000
Subject: [PATCH v2 1/2] refactor code parsing size based on memory range
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 23 Jun 2016 00:55:26 +0530
In-Reply-To: <20160622192213.11192.93613.stgit@hbathini.in.ibm.com>
References: <20160622192213.11192.93613.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Message-Id: <20160622192507.11192.84463.stgit@hbathini.in.ibm.com>
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
To: Michael Ellerman <mpe@ellerman.id.au>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

Currently, crashkernel parameter supports the below syntax to parse size
based on memory range:

	crashkernel=<range1>:<size1>[,<range2>:<size2>,...]

While such parsing is implemented for crashkernel parameter, it applies to
other parameters with similar syntax. So, move this code to a more generic
place for code reuse.

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: kexec@lists.infradead.org
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
changes in v2:
1. Rebased to latest upstream.
2. Marked few more people on cc.

 include/linux/kernel.h |    5 +++
 kernel/kexec_core.c    |   63 +++-----------------------------
 kernel/params.c        |   96 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 58 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 94aa10f..72f55e5 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -436,6 +436,11 @@ extern char *get_options(const char *str, int nints, int *ints);
 extern unsigned long long memparse(const char *ptr, char **retptr);
 extern bool parse_option_str(const char *str, const char *option);
 
+extern bool __init is_param_range_based(const char *cmdline);
+extern unsigned long long __init parse_mem_range_size(const char *param,
+						      char **str,
+						      unsigned long long system_ram);
+
 extern int core_kernel_text(unsigned long addr);
 extern int core_kernel_data(unsigned long addr);
 extern int __kernel_text_address(unsigned long addr);
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 56b3ed0..d43f5cc 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1083,59 +1083,9 @@ static int __init parse_crashkernel_mem(char *cmdline,
 	char *cur = cmdline, *tmp;
 
 	/* for each entry of the comma-separated list */
-	do {
-		unsigned long long start, end = ULLONG_MAX, size;
-
-		/* get the start of the range */
-		start = memparse(cur, &tmp);
-		if (cur == tmp) {
-			pr_warn("crashkernel: Memory value expected\n");
-			return -EINVAL;
-		}
-		cur = tmp;
-		if (*cur != '-') {
-			pr_warn("crashkernel: '-' expected\n");
-			return -EINVAL;
-		}
-		cur++;
-
-		/* if no ':' is here, than we read the end */
-		if (*cur != ':') {
-			end = memparse(cur, &tmp);
-			if (cur == tmp) {
-				pr_warn("crashkernel: Memory value expected\n");
-				return -EINVAL;
-			}
-			cur = tmp;
-			if (end <= start) {
-				pr_warn("crashkernel: end <= start\n");
-				return -EINVAL;
-			}
-		}
-
-		if (*cur != ':') {
-			pr_warn("crashkernel: ':' expected\n");
-			return -EINVAL;
-		}
-		cur++;
-
-		size = memparse(cur, &tmp);
-		if (cur == tmp) {
-			pr_warn("Memory value expected\n");
-			return -EINVAL;
-		}
-		cur = tmp;
-		if (size >= system_ram) {
-			pr_warn("crashkernel: invalid size\n");
-			return -EINVAL;
-		}
-
-		/* match ? */
-		if (system_ram >= start && system_ram < end) {
-			*crash_size = size;
-			break;
-		}
-	} while (*cur++ == ',');
+	*crash_size = parse_mem_range_size("crashkernel", &cur, system_ram);
+	if (cur == cmdline)
+		return -EINVAL;
 
 	if (*crash_size > 0) {
 		while (*cur && *cur != ' ' && *cur != '@')
@@ -1272,7 +1222,6 @@ static int __init __parse_crashkernel(char *cmdline,
 			     const char *name,
 			     const char *suffix)
 {
-	char	*first_colon, *first_space;
 	char	*ck_cmdline;
 
 	BUG_ON(!crash_size || !crash_base);
@@ -1290,12 +1239,10 @@ static int __init __parse_crashkernel(char *cmdline,
 		return parse_crashkernel_suffix(ck_cmdline, crash_size,
 				suffix);
 	/*
-	 * if the commandline contains a ':', then that's the extended
+	 * if the parameter is range based, then that's the extended
 	 * syntax -- if not, it must be the classic syntax
 	 */
-	first_colon = strchr(ck_cmdline, ':');
-	first_space = strchr(ck_cmdline, ' ');
-	if (first_colon && (!first_space || first_colon < first_space))
+	if (is_param_range_based(ck_cmdline))
 		return parse_crashkernel_mem(ck_cmdline, system_ram,
 				crash_size, crash_base);
 
diff --git a/kernel/params.c b/kernel/params.c
index a6d6149..84e40ae 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -268,6 +268,102 @@ char *parse_args(const char *doing,
 	return err;
 }
 
+/*
+ * is_param_range_based - check if current parameter is range based
+ * @cmdline: points to the parameter to check
+ *
+ * Returns true when the current paramer is range based, false otherwise
+ */
+bool __init is_param_range_based(const char *cmdline)
+{
+	char    *first_colon, *first_space;
+
+	first_colon = strchr(cmdline, ':');
+	first_space = strchr(cmdline, ' ');
+	if (first_colon && (!first_space || first_colon < first_space))
+		return true;
+
+	return false;
+}
+
+/*
+ * parse_mem_range_size - parse size based on memory range
+ * @param:  the thing being parsed
+ * @str: (input)  where parse begins
+ *                expected format - <range1>:<size1>[,<range2>:<size2>,...]
+ *       (output) On success - next char after parse completes
+ *                On failure - unchanged
+ * @system_ram: system ram size to check memory range against
+ *
+ * Returns the memory size on success and 0 on failure
+ */
+unsigned long long __init parse_mem_range_size(const char *param,
+					       char **str,
+					       unsigned long long system_ram)
+{
+	char *cur = *str, *tmp;
+	unsigned long long mem_size = 0;
+
+	/* for each entry of the comma-separated list */
+	do {
+		unsigned long long start, end = ULLONG_MAX, size;
+
+		/* get the start of the range */
+		start = memparse(cur, &tmp);
+		if (cur == tmp) {
+			printk(KERN_INFO "%s: Memory value expected\n", param);
+			return mem_size;
+		}
+		cur = tmp;
+		if (*cur != '-') {
+			printk(KERN_INFO "%s: '-' expected\n", param);
+			return mem_size;
+		}
+		cur++;
+
+		/* if no ':' is here, than we read the end */
+		if (*cur != ':') {
+			end = memparse(cur, &tmp);
+			if (cur == tmp) {
+				printk(KERN_INFO "%s: Memory value expected\n",
+					param);
+				return mem_size;
+			}
+			cur = tmp;
+			if (end <= start) {
+				printk(KERN_INFO "%s: end <= start\n", param);
+				return mem_size;
+			}
+		}
+
+		if (*cur != ':') {
+			printk(KERN_INFO "%s: ':' expected\n", param);
+			return mem_size;
+		}
+		cur++;
+
+		size = memparse(cur, &tmp);
+		if (cur == tmp) {
+			printk(KERN_INFO "%s: Memory value expected\n", param);
+			return mem_size;
+		}
+		cur = tmp;
+		if (size >= system_ram) {
+			printk(KERN_INFO "%s: invalid size\n", param);
+			return mem_size;
+		}
+
+		/* match ? */
+		if (system_ram >= start && system_ram < end) {
+			mem_size = size;
+			*str = cur;
+			break;
+		}
+	} while (*cur++ == ',');
+
+	return mem_size;
+}
+
 /* Lazy bastard, eh? */
 #define STANDARD_PARAM_DEF(name, type, format, strtolfn)      		\
 	int param_set_##name(const char *val, const struct kernel_param *kp) \


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
