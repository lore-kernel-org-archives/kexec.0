Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFpNB-0005Fr-Qn
 for kexec@lists.infradead.org; Wed, 13 Mar 2013 17:21:54 +0000
Received: by mail-pd0-f173.google.com with SMTP id v10so2993pde.4
 for <kexec@lists.infradead.org>; Wed, 13 Mar 2013 10:21:52 -0700 (PDT)
Message-ID: <5140B5A7.9010402@gmail.com>
Date: Thu, 14 Mar 2013 01:21:43 +0800
From: Zhang Yanfei <zhangyanfei.yes@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 02/13] kexec: use _ALIGN() instead of align()
References: <5140B511.7020109@gmail.com>
In-Reply-To: <5140B511.7020109@gmail.com>
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
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Since we have imported macro _ALIGN() for global use, replace the call
of function align() with _ALIGN() and remove align().

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/kexec-elf-boot.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/kexec/kexec-elf-boot.c b/kexec/kexec-elf-boot.c
index 9a160bb..f082f8b 100644
--- a/kexec/kexec-elf-boot.c
+++ b/kexec/kexec-elf-boot.c
@@ -67,12 +67,6 @@ static struct boot_notes {
 	},
 };
 
-static inline unsigned long align(unsigned long val, unsigned long align)
-{
-	return (val + align - 1) & ~(align - 1);
-
-}
-
 unsigned long elf_boot_notes(
 	struct kexec_info *info, unsigned long max_addr,
 	const char *cmdline, int cmdline_len)
@@ -80,7 +74,7 @@ unsigned long elf_boot_notes(
 	unsigned long note_bytes;
 	unsigned long note_base;
 	struct boot_notes *notes;
-	note_bytes = sizeof(*notes) + align(cmdline_len, 4);
+	note_bytes = sizeof(*notes) + _ALIGN(cmdline_len, 4);
 	notes = xmalloc(note_bytes);
 	memcpy(notes, &boot_notes, sizeof(boot_notes));
 	memcpy(notes->command_line, cmdline, cmdline_len);
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
