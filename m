Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SjZxz-0003EA-Pv
 for kexec@lists.infradead.org; Tue, 26 Jun 2012 17:54:20 +0000
Received: by lbbgg6 with SMTP id gg6so387862lbb.36
 for <kexec@lists.infradead.org>; Tue, 26 Jun 2012 10:54:17 -0700 (PDT)
From: Aleksey Makarov <aleksey.makarov@gmail.com>
Subject: [PATCH 2/2] Fix format strings of die()
Date: Wed, 27 Jun 2012 00:53:43 +0700
Message-Id: <1340733223-25382-2-git-send-email-aleksey.makarov@gmail.com>
In-Reply-To: <1340733223-25382-1-git-send-email-aleksey.makarov@gmail.com>
References: <1340733223-25382-1-git-send-email-aleksey.makarov@gmail.com>
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
Cc: Aleksey Makarov <aleksey.makarov@gmail.com>

One of them caused crash when user specifies a file that does not
exist.

Signed-off-by: Aleksey Makarov <aleksey.makarov@gmail.com>
---
 kexec/arch/x86_64/kexec-elf-rel-x86_64.c |    2 +-
 kexec/kexec-elf-rel.c                    |    6 +++---
 kexec/kexec.c                            |    2 +-
 kexec/lzma.c                             |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
index a1291a6..1c2faa3 100644
--- a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
+++ b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
@@ -86,6 +86,6 @@ void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr), unsigned long r_type,
 	}
 	return;
  overflow:
-	die("overflow in relocation type %s val %Lx\n", 
+	die("overflow in relocation type %s val %lx\n", 
 		reloc_name(r_type), value);
 }
diff --git a/kexec/kexec-elf-rel.c b/kexec/kexec-elf-rel.c
index c04c972..fc90e42 100644
--- a/kexec/kexec-elf-rel.c
+++ b/kexec/kexec-elf-rel.c
@@ -513,7 +513,7 @@ void elf_rel_set_symbol(struct mem_ehdr *ehdr,
 			name);
 	}
 	if (sym.st_size != size) {
-		die("Symbol: %s has size: %ld not %ld\n",
+		die("Symbol: %s has size: %lld not %ld\n",
 			name, sym.st_size, size);
 	}
 	shdr = &ehdr->e_shdr[sym.st_shndx];
@@ -534,10 +534,10 @@ void elf_rel_get_symbol(struct mem_ehdr *ehdr,
 
 	result = elf_rel_find_symbol(ehdr, name, &sym);
 	if (result < 0) {
-		die("Symbol: %s not found cannot get\n");
+		die("Symbol: %s not found cannot get\n", name);
 	}
 	if (sym.st_size != size) {
-		die("Symbol: %s has size: %ld not %ld\n",
+		die("Symbol: %s has size: %lld not %ld\n",
 			name, sym.st_size, size);
 	}
 	shdr = &ehdr->e_shdr[sym.st_shndx];
diff --git a/kexec/kexec.c b/kexec/kexec.c
index d2d05a8..5ab0196 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -321,7 +321,7 @@ void add_segment_phys_virt(struct kexec_info *info,
 	 * thing.
 	 */
 	if (base & (pagesize -1)) {
-		die("Base address: %x is not page aligned\n", base);
+		die("Base address: %lx is not page aligned\n", base);
 	}
 
 	if (phys)
diff --git a/kexec/lzma.c b/kexec/lzma.c
index 2490de6..939aeb3 100644
--- a/kexec/lzma.c
+++ b/kexec/lzma.c
@@ -168,7 +168,7 @@ char *lzma_decompress_file(const char *filename, off_t *r_size)
 	}
 	fp = lzopen(filename, "rb");
 	if (fp == 0) {
-		die("Cannot open `%s': %s\n", filename);
+		die("Cannot open `%s'\n", filename);
 	}
 	size = 0;
 	allocated = 65536;
-- 
1.7.7.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
