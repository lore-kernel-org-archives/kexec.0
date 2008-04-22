Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.243]
	helo=rv-out-0506.google.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JoRyd-0006vd-9I
	for kexec@lists.infradead.org; Tue, 22 Apr 2008 23:32:43 +0000
Received: by rv-out-0506.google.com with SMTP id b17so1263444rvf.42
	for <kexec@lists.infradead.org>; Tue, 22 Apr 2008 16:32:42 -0700 (PDT)
From: Jamey Sharp <jamey@thetovacompany.com>
Subject: [PATCH 1/9] Fix undefined symbol errors on readw/writew: arch/io.h,
	not sys/io.h.
Date: Tue, 22 Apr 2008 16:21:04 -0700
Message-Id: <1208906472-18465-2-git-send-email-jamey@thetovacompany.com>
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

The undefined symbols naturally weren't relocated by kexec's linker, so
each compiled `call` instruction branched into the middle of itself. The
CPU proceeded to interpret the un-relocated address as instructions,
resulting in an undefined opcode fault. Since at this point no IDT is
loaded, that turned into a triple-fault and reboot.

The bug was only visible when running kexec with --console-vga.

Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
---
Although GCC warned about this problem, it would have been easier to
diagnose if the ELF linking code in the kexec userspace tools would
report an error on attempting to link undefined symbols.

 purgatory/arch/i386/console-x86.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/purgatory/arch/i386/console-x86.c b/purgatory/arch/i386/console-x86.c
index 68f5daf..9773573 100644
--- a/purgatory/arch/i386/console-x86.c
+++ b/purgatory/arch/i386/console-x86.c
@@ -1,5 +1,5 @@
 #include <stdint.h>
-#include <sys/io.h>
+#include <arch/io.h>
 #include <purgatory.h>
 
 /*
-- 
1.5.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
