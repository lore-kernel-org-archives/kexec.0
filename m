Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.243]
	helo=rv-out-0506.google.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JoRzC-0006vd-M4
	for kexec@lists.infradead.org; Tue, 22 Apr 2008 23:33:19 +0000
Received: by rv-out-0506.google.com with SMTP id b17so1263444rvf.42
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2008 16:33:18 -0700 (PDT)
From: Jamey Sharp <jamey@thetovacompany.com>
Subject: [PATCH 3/9] Conform more closely to Documentation/i386/boot.txt for
	bzImages.
Date: Tue, 22 Apr 2008 16:21:06 -0700
Message-Id: <1208906472-18465-4-git-send-email-jamey@thetovacompany.com>
In-Reply-To: <1208906472-18465-1-git-send-email-jamey@thetovacompany.com>
References: <1208906472-18465-1-git-send-email-jamey@thetovacompany.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

DS, ES, FS, and GS were all initialized to 0, but according to boot.txt
they need to point to setup_base. Recent kernel versions apparently rely
on this point of the spec, though earlier versions didn't.

Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
---
This patch is arguably incomplete, since SS and SP are also not being
set as specified by boot.txt. However, it seems that nobody cares at
present, and I had other issues I wanted to address.

 kexec/arch/i386/kexec-bzImage.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/i386/kexec-bzImage.c b/kexec/arch/i386/kexec-bzImage.c
index 93e37a4..abb094c 100644
--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -284,9 +284,12 @@ int do_bzImage_load(struct kexec_info *info,
 	/*
 	 * Initialize the 16bit start information.
 	 */
-	regs16.cs = (setup_base>>4) + 0x20;
+	regs16.ds = regs16.es = regs16.fs = regs16.gs = setup_base >> 4;
+	regs16.cs = regs16.ds + 0x20;
 	regs16.ip = 0;
+	/* XXX: Documentation/i386/boot.txt says 'ss' must equal 'ds' */
 	regs16.ss = (elf_rel_get_addr(&info->rhdr, "stack_end") - 64*1024) >> 4;
+	/* XXX: Documentation/i386/boot.txt says 'sp' must equal heap_end */
 	regs16.esp = 0xFFFC;
 	if (real_mode_entry) {
 		printf("Starting the kernel in real mode\n");
-- 
1.5.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
