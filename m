Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i1FZ8-0000JZ-BS
 for kexec@lists.infradead.org; Fri, 23 Aug 2019 19:49:45 +0000
From: Sven Schnelle <svens@stackframe.org>
Subject: [PATCH v5 6/7] kexec_elf: remove unused variable in kexec_elf_load()
Date: Fri, 23 Aug 2019 21:49:18 +0200
Message-Id: <20190823194919.30916-7-svens@stackframe.org>
In-Reply-To: <20190823194919.30916-1-svens@stackframe.org>
References: <20190823194919.30916-1-svens@stackframe.org>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>, linuxppc-dev@lists.ozlabs.org, Thiago Jung Bauermann <bauerman@linux.ibm.com>

base was never assigned, so we can remove it.

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 kernel/kexec_elf.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
index 6c806ce96ac1..85f2bd177d6e 100644
--- a/kernel/kexec_elf.c
+++ b/kernel/kexec_elf.c
@@ -363,7 +363,7 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
 			 struct kexec_buf *kbuf,
 			 unsigned long *lowest_load_addr)
 {
-	unsigned long base = 0, lowest_addr = UINT_MAX;
+	unsigned long lowest_addr = UINT_MAX;
 	int ret;
 	size_t i;
 
@@ -385,7 +385,7 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
 		kbuf->bufsz = size;
 		kbuf->memsz = phdr->p_memsz;
 		kbuf->buf_align = phdr->p_align;
-		kbuf->buf_min = phdr->p_paddr + base;
+		kbuf->buf_min = phdr->p_paddr;
 		kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
 		ret = kexec_add_buffer(kbuf);
 		if (ret)
@@ -396,9 +396,6 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
 			lowest_addr = load_addr;
 	}
 
-	/* Update entry point to reflect new load address. */
-	ehdr->e_entry += base;
-
 	*lowest_load_addr = lowest_addr;
 	ret = 0;
  out:
-- 
2.23.0.rc1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
