Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ey0-f177.google.com ([209.85.215.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RQfFW-0008TS-Qz
 for kexec@lists.infradead.org; Wed, 16 Nov 2011 13:09:59 +0000
Received: by eye3 with SMTP id 3so451951eye.36
 for <kexec@lists.infradead.org>; Wed, 16 Nov 2011 05:09:55 -0800 (PST)
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: [Patch] kexec: fix several issues in get_crash_notes()
Date: Wed, 16 Nov 2011 21:09:26 +0800
Message-Id: <1321448966-25163-1-git-send-email-xiyou.wangcong@gmail.com>
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
To: kexec@lists.infradead.org
Cc: WANG Cong <xiyou.wangcong@gmail.com>, horms@verge.net.au

a) We don't need 'crash_notes' array at all, save some bytes on stack.
b) We forgot to fclose 'fp' before return.

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---
diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 98cda72..333f6ba 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -589,20 +589,18 @@ static int cmdline_add_elfcorehdr(char *cmdline, unsigned long addr)
  */
 static int get_crash_notes(int cpu, uint64_t *addr, uint64_t *len)
 {
-	char crash_notes[PATH_MAX];
 	char line[MAX_LINE];
 	FILE *fp;
 	unsigned long vaddr;
 	int count;
 
-	sprintf(crash_notes, "/sys/kernel/crash_notes");
-	fp = fopen(crash_notes, "r");
+	fp = fopen("/sys/kernel/crash_notes", "r");
 	if (fp) {
 		if (fgets(line, sizeof(line), fp) != 0) {
 			count = sscanf(line, "%lx", &vaddr);
 			if (count != 1)
-				die("Cannot parse %s: %s\n", crash_notes,
-						strerror(errno));
+				die("Cannot parse /sys/kernel/crash_notes:"
+					" %s\n", strerror(errno));
 		}
 
 		*addr = x86__pa(vaddr + (cpu * MAX_NOTE_BYTES));
@@ -610,6 +608,7 @@ static int get_crash_notes(int cpu, uint64_t *addr, uint64_t *len)
 #ifdef DEBUG
 		printf("crash_notes addr = %Lx\n", *addr);
 #endif
+		fclose(fp);
 		return 0;
 	} else
 		return get_crash_notes_per_cpu(cpu, addr, len);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
