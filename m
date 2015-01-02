Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-la0-x235.google.com ([2a00:1450:4010:c03::235])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y76T1-00055C-R5
 for kexec@lists.infradead.org; Fri, 02 Jan 2015 17:56:56 +0000
Received: by mail-la0-f53.google.com with SMTP id gm9so15435394lab.40
 for <kexec@lists.infradead.org>; Fri, 02 Jan 2015 09:56:33 -0800 (PST)
From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] kexec: Fix a typo in comment
Date: Fri,  2 Jan 2015 23:56:19 +0600
Message-Id: <1420221379-4553-1-git-send-email-kuleshovmail@gmail.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 kernel/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 9a8a01a..75a8b7e 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -444,7 +444,7 @@ arch_kexec_apply_relocations(const Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 }
 
 /*
- * Free up memory used by kernel, initrd, and comand line. This is temporary
+ * Free up memory used by kernel, initrd, and command line. This is temporary
  * memory allocation which is not needed any more after these buffers have
  * been loaded into separate segments and have been copied elsewhere.
  */
-- 
2.2.1.202.g44ae4ee.dirty


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
