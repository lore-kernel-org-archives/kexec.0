Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KQLJj-0006oT-8n
	for kexec@lists.infradead.org; Tue, 05 Aug 2008 12:07:08 +0000
Message-Id: <48984275.5070409@mxs.nes.nec.co.jp>
Date: Tue, 05 Aug 2008 21:07:17 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: makedumpfile fails on SGI machine
References: <20080730161416.47605c30@halley.suse.de>	<4891197D.10400@mxs.nes.nec.co.jp>	<20080731104726.035850be@halley.suse.de>	<48919306.80103@mxs.nes.nec.co.jp>	<20080731131823.3c7c97b2@halley.suse.de>
	<4891A3CB.9040805@mxs.nes.nec.co.jp>
In-Reply-To: <4891A3CB.9040805@mxs.nes.nec.co.jp>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0428892228=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: Jay Lan <jlan@sgi.com>, kexec@lists.infradead.org

--===============0428892228==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Ken'ichi Ohmichi wrote:
>> * Ken'ichi Ohmichi [2008-07-31 19:25]:
>>> I tried to reproduce this problem on my machine by using an ia64 linux-2.6.26
>>> discontigmem kernel, but it could not do it. makeudmpifle did not fail.
>>> I want to know whether this problem depends on the kernel or either the machine.
>>> Could you send me the kernel .config file ?
>> I think that problem is machine specific. However, here is the .config.
> 
> Thank you for config file.
> 
> I'm starting the kernel compiling.
> I'll investigate this problem the next week.

Unfortunately, the compiled kernel got panic when booting.
So I cannot reproduce this problem on my machine yet.
I'm trying it again.

BTW, I'd like to know some conditions of this problem.
So please let me know the makedumpfile commandline which you run.
 Ex. # makedumpfile -d 31 -x vmlinux /proc/vmcore dumpfile


I doubt that makedumpfile cannot distinguish the pgtable correctly.
I created the debugging patch. Please run makedumpfile-1.2.7 applied
with it by '-D' option, and report the output.
According to your kernel .config file, the output should contain
"PAGETABLE_4L : ON".


Thanks
Ken'ichi Ohmichi

---
diff -puN backup/v1.2.7/ia64.c makedumpfile/ia64.c
--- backup/v1.2.7/ia64.c	2008-07-18 11:23:29.000000000 +0900
+++ makedumpfile/ia64.c	2008-08-06 05:40:27.000000000 +0900
@@ -67,21 +67,20 @@ get_machdep_info_ia64(void)
 	else
 		info->vmalloc_start = KERNEL_VMALLOC_BASE;
 
-	if ((vt.mem_flags & MEMORY_PAGETABLE_4L)
-	    || (vt.mem_flags & MEMORY_PAGETABLE_3L))
-		return TRUE;
-
 	/*
 	 * Check the pgtable (3 Levels or 4 Levels).
 	 */
-	if (!strncmp(SRCFILE(pud_t), STR_PUD_T_4L, strlen(STR_PUD_T_4L)))
+	if ((vt.mem_flags & MEMORY_PAGETABLE_4L)
+	    || !strncmp(SRCFILE(pud_t), STR_PUD_T_4L, strlen(STR_PUD_T_4L))) {
 		vt.mem_flags |= MEMORY_PAGETABLE_4L;
-
-	else if (!strncmp(SRCFILE(pud_t), STR_PUD_T_3L, strlen(STR_PUD_T_3L)))
+		DEBUG_MSG("PAGETABLE_4L : ON\n");
+	} else if ((vt.mem_flags & MEMORY_PAGETABLE_3L)
+	    || !strncmp(SRCFILE(pud_t), STR_PUD_T_3L, strlen(STR_PUD_T_3L))) {
 		vt.mem_flags |= MEMORY_PAGETABLE_3L;
-
-	else
+		DEBUG_MSG("PAGETABLE_3L : ON\n");
+	} else {
 		MSG("Can't distinguish the pgtable.\n");
+	}
 
 	return TRUE;
 }


--===============0428892228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0428892228==--
