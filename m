From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 31 Mar 2022 13:59:34 +0800
Subject: [PATCH 2/2] kexec/elf: assign one to align if sh_addralign equals zero
In-Reply-To: <20220331055934.13608-1-piliu@redhat.com>
References: <20220331055934.13608-1-piliu@redhat.com>
Message-ID: <20220331055934.13608-3-piliu@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

According to ELF specification, if sh_addralign equals zero or one, then
the section has no alignment requirement on the start address. (I.e. it
can be aligned on 1 byte)

Since modern cpu asks the .text, .data, .bss to be aligned
on the machine word boundary at least, so in elf_rel_load(),
sh_addralign can not be zero, and
  align = shdr->sh_addralign;
  ...
  bufsz = _ALIGN(bufsz, align);

will not render a result of 'bufsz = 0'.

But it had better have a check on the case of 'sh_addralign == 0'
regardless of the assumption of machine word alignment.

This patch has no functional change.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Simon Horman <horms@verge.net.au>
To: kexec@lists.infradead.org
---
 kexec/kexec-elf-rel.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kexec/kexec-elf-rel.c b/kexec/kexec-elf-rel.c
index 9a6e63d..0a8b4d2 100644
--- a/kexec/kexec-elf-rel.c
+++ b/kexec/kexec-elf-rel.c
@@ -168,6 +168,10 @@ int build_elf_rel_info(const char *buf, off_t len, struct mem_ehdr *ehdr,
 	return 0;
 }
 
+static unsigned long get_section_addralign(struct mem_shdr *shdr)
+{
+	return (shdr->sh_addralign == 0) ? 1 : shdr->sh_addralign;
+}
 
 int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
 	unsigned long min, unsigned long max, int end)
@@ -219,7 +223,7 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
 		}
 		if (shdr->sh_type != SHT_NOBITS) {
 			unsigned long align;
-			align = shdr->sh_addralign;
+			align = get_section_addralign(shdr);
 			/* See if I need more alignment */
 			if (buf_align < align) {
 				buf_align = align;
@@ -231,7 +235,7 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
 		}
 		else {
 			unsigned long align;
-			align = shdr->sh_addralign;
+			align = get_section_addralign(shdr);
 			/* See if I need more alignment */
 			if (bss_align < align) {
 				bss_align = align;
@@ -265,7 +269,7 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
 		if (!(shdr->sh_flags & SHF_ALLOC)) {
 			continue;
 		}
-		align = shdr->sh_addralign;
+		align = get_section_addralign(shdr);
 		if (shdr->sh_type != SHT_NOBITS) {
 			unsigned long off;
 			/* Adjust the address */
-- 
2.31.1


