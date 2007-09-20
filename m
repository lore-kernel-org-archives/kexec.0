Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IYPhS-0005aN-Fw
	for kexec@lists.infradead.org; Thu, 20 Sep 2007 18:20:31 +0100
Message-Id: <20070920171846.062209000@stravinsky.suse.de>
References: <20070920171845.774383000@stravinsky.suse.de>
Date: Thu, 20 Sep 2007 19:18:46 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [patch 1/7] Extended crashkernel command line
Content-Disposition: inline; filename=crashkernel-generic
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

This is the generic part of the patch. It adds a parse_crashkernel() function
in kernel/kexec.c that is called by the architecture specific code that
actually reserves the memory. That function takes the whole command line and
looks itself for "crashkernel=" in it.

If there are multiple occurrences, then the last one is taken.  The advantage
is that if you have a bootloader like lilo or elilo which allows you to append
a command line parameter but not to remove one (like in GRUB), then you can add
another crashkernel value for testing at the boot command line and this one
overwrites the command line in the configuration then.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 include/linux/kexec.h |    2 
 kernel/kexec.c        |  141 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)

--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -179,6 +179,8 @@ extern note_buf_t *crash_notes;
 extern u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
 extern unsigned int vmcoreinfo_size;
 extern unsigned int vmcoreinfo_max_size;
+int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
+		unsigned long long *crash_size, unsigned long long *crash_base);
 
 
 #else /* !CONFIG_KEXEC */
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1146,6 +1146,147 @@ static int __init crash_notes_memory_ini
 }
 module_init(crash_notes_memory_init)
 
+
+/*
+ * parsing the "crashkernel" commandline
+ *
+ * this code is intended to be called from architecture specific code
+ */
+
+
+/*
+ * This function parses command lines in the format
+ *
+ *   crashkernel=<ramsize-range>:<size>[,...][@<base>]
+ *
+ * The function returns 0 on success and -EINVAL on failure.
+ */
+static int __init parse_crashkernel_mem(char 			*cmdline,
+					unsigned long 		system_ram,
+					unsigned long long 	*crash_size,
+					unsigned long long 	*crash_base)
+{
+	char *cur = cmdline;
+
+	/* for each entry of the comma-separated list */
+	do {
+		unsigned long long start = 0, end = ULLONG_MAX;
+		unsigned long long size = -1;
+
+		/* get the start of the range */
+		start = memparse(cur, &cur);
+		if (*cur != '-') {
+			printk(KERN_WARNING "crashkernel: '-' expected\n");
+			return -EINVAL;
+		}
+		cur++;
+
+		/* if no ':' is here, than we read the end */
+		if (*cur != ':') {
+			end = memparse(cur, &cur);
+			if (end <= start) {
+				printk(KERN_WARNING "crashkernel: end <= start\n");
+				return -EINVAL;
+			}
+		}
+
+		if (*cur != ':') {
+			printk(KERN_WARNING "crashkernel: ':' expected\n");
+			return -EINVAL;
+		}
+		cur++;
+
+		size = memparse(cur, &cur);
+		if (size < 0) {
+			printk(KERN_WARNING "crashkernel: invalid size\n");
+			return -EINVAL;
+		}
+
+		/* match ? */
+		if (system_ram >= start  && system_ram <= end) {
+			*crash_size = size;
+			break;
+		}
+	} while (*cur++ == ',');
+
+	if (*crash_size > 0) {
+		while (*cur != ' ' && *cur != '@')
+			cur++;
+		if (*cur == '@')
+			*crash_base = memparse(cur+1, &cur);
+	}
+
+	return 0;
+}
+
+/*
+ * That function parses "simple" (old) crashkernel command lines like
+ *
+ * 	crashkernel=size[@base]
+ *
+ * It returns 0 on success and -EINVAL on failure.
+ */
+static int __init parse_crashkernel_simple(char 		*cmdline,
+					   unsigned long long 	*crash_size,
+					   unsigned long long 	*crash_base)
+{
+	char *cur = cmdline;
+
+	*crash_size = memparse(cmdline, &cur);
+	if (cmdline == cur)
+		return -EINVAL;
+
+	if (*cur == '@')
+		*crash_base = memparse(cur+1, &cur);
+
+	return 0;
+}
+
+/*
+ * That function is the entry point for command line parsing and should be
+ * called from the arch-specific code.
+ */
+int __init parse_crashkernel(char 		 *cmdline,
+			     unsigned long long system_ram,
+			     unsigned long long *crash_size,
+			     unsigned long long *crash_base)
+{
+	char 	*p = cmdline, *ck_cmdline = NULL;
+	char	*first_colon, *first_space;
+
+	*crash_size = 0;
+	*crash_base = 0;
+
+	/* find crashkernel and use the last one if there are more */
+	p = strstr(p, "crashkernel=");
+	while (p) {
+		ck_cmdline = p;
+		p = strstr(p+1, "crashkernel=");
+	}
+
+	if (!ck_cmdline)
+		return -EINVAL;
+
+	ck_cmdline += 12; /* strlen("crashkernel=") */
+
+	/*
+	 * if the commandline contains a ':', then that's the extended
+	 * syntax -- if not, it must be the classic syntax
+	 */
+	first_colon = strchr(ck_cmdline, ':');
+	first_space = strchr(ck_cmdline, ' ');
+	if (first_colon && (!first_space || first_colon < first_space))
+		return parse_crashkernel_mem(ck_cmdline, system_ram,
+				crash_size, crash_base);
+	else
+		return parse_crashkernel_simple(ck_cmdline, crash_size,
+				crash_base);
+
+	return 0;
+}
+
+
+
 void crash_save_vmcoreinfo(void)
 {
 	u32 *buf;

-- 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
