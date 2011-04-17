Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QBNMK-00030k-7q
	for kexec@lists.infradead.org; Sun, 17 Apr 2011 08:29:33 +0000
From: Amerigo Wang <amwang@redhat.com>
Subject: [Patch] kexec: fix the missing i386 part in commit 1100580b05e
Date: Sun, 17 Apr 2011 16:29:05 +0800
Message-Id: <1303028945-15298-1-git-send-email-amwang@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>, Amerigo Wang <amwang@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Vivek pointed out that I missed the i386 part in this commit,

	commit 1100580b05e3fdfe648d9be8617d962b11f4b88b
	Author: Amerigo Wang <amwang@redhat.com>
	Date:   Thu Mar 3 00:10:43 2011 +0800

	    get the backup area dynamically

Yes. The customer who reported that bug definitely only
tested it on x86_64. Now make it complete.

Signed-off-by: Amerigo Wang <amwang@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Simon Horman <horms@verge.net.au>

---
diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
index 5c701aa..014ecd5 100644
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -184,6 +184,10 @@ void arch_update_purgatory(struct kexec_info *info)
 		&arch_options.console_vga, sizeof(arch_options.console_vga));
 	elf_rel_set_symbol(&info->rhdr, "console_serial",
 		&arch_options.console_serial, sizeof(arch_options.console_serial));
+	elf_rel_set_symbol(&info->rhdr, "backup_src_start",
+		&info->backup_src_start, sizeof(info->backup_src_start));
+	elf_rel_set_symbol(&info->rhdr, "backup_src_size",
+		&info->backup_src_size, sizeof(info->backup_src_size));
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		panic_kernel = 1;
 		elf_rel_set_symbol(&info->rhdr, "backup_start",

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
