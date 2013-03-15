Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UGRQr-0002os-QT
 for kexec@lists.infradead.org; Fri, 15 Mar 2013 10:00:16 +0000
Message-ID: <5142EDFB.80601@cn.fujitsu.com>
Date: Fri, 15 Mar 2013 17:46:35 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v3 04/13] kexec: use _ALIGN* to make the logic clear
References: <5140B511.7020109@gmail.com> <5140B6E0.1080202@gmail.com>
 <20130314090805.GH11196@verge.net.au> <20130314094950.GR11196@verge.net.au>
 <20130314095852.GY11196@verge.net.au> <5141B3DA.2030004@gmail.com>
 <20130315083544.GE1846@verge.net.au>
In-Reply-To: <20130315083544.GE1846@verge.net.au>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

By replacing all the explicit align opertion with marco _ALIGN*,
the code logic could more clear.

Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 kexec/crashdump-elf.c  |    3 +--
 kexec/fs2dt.c          |    5 ++---
 kexec/kexec-elf-boot.c |    2 +-
 kexec/kexec-elf-rel.c  |    8 ++++----
 kexec/kexec-elf.c      |    8 ++++----
 kexec/kexec.c          |   15 +++++++--------
 6 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
index ec66548..2baa357 100644
--- a/kexec/crashdump-elf.c
+++ b/kexec/crashdump-elf.c
@@ -96,8 +96,7 @@ int FUNC(struct kexec_info *info,
 		return -1;
 	}
 
-	sz += align - 1;
-	sz &= ~(align - 1);
+	sz = _ALIGN(sz, align);
 
 	bufp = xmalloc(sz);
 	memset(bufp, 0, sz);
diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
index 5d933c8..1f5b0cf 100644
--- a/kexec/fs2dt.c
+++ b/kexec/fs2dt.c
@@ -697,8 +697,7 @@ static void add_boot_block(char **bufp, off_t *sizep)
 	unsigned long tlen, toff;
 	char *buf;
 
-	len = sizeof(bb[0]);
-	len += 7; len &= ~7;
+	len = _ALIGN(sizeof(bb[0]), 8);
 
 	bb->off_mem_rsvmap = cpu_to_be32(len);
 
@@ -721,7 +720,7 @@ static void add_boot_block(char **bufp, off_t *sizep)
 
 	len = propnum("");
 	bb->dt_strings_size = cpu_to_be32(len);
-	len +=  3; len &= ~3;
+	len = _ALIGN(len, 4);
 	bb->totalsize = cpu_to_be32(be32_to_cpu(bb->off_dt_strings) + len);
 
 	bb->magic = cpu_to_be32(0xd00dfeed);
diff --git a/kexec/kexec-elf-boot.c b/kexec/kexec-elf-boot.c
index f082f8b..38f9056 100644
--- a/kexec/kexec-elf-boot.c
+++ b/kexec/kexec-elf-boot.c
@@ -31,7 +31,7 @@
 #include "kexec-elf-boot.h"
 
 
-#define UPSZ(X) ((sizeof(X) + 3) &~3)
+#define UPSZ(X) _ALIGN_UP(sizeof(X), 4)
 
 static struct boot_notes {
 	Elf_Bhdr hdr;
diff --git a/kexec/kexec-elf-rel.c b/kexec/kexec-elf-rel.c
index 8880c8b..38e34ec 100644
--- a/kexec/kexec-elf-rel.c
+++ b/kexec/kexec-elf-rel.c
@@ -225,7 +225,7 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
 				buf_align = align;
 			}
 			/* Now align bufsz */
-			bufsz = (bufsz + (align - 1)) & ~(align - 1);
+			bufsz = _ALIGN(bufsz, align);
 			/* And now add our buffer */
 			bufsz += shdr->sh_size;
 		}
@@ -237,7 +237,7 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
 				bss_align = align;
 			}
 			/* Now align bsssz */
-			bsssz = (bsssz + (align - 1)) & ~(align -1);
+			bsssz = _ALIGN(bsssz, align);
 			/* And now add our buffer */
 			bsssz += shdr->sh_size;
 		}
@@ -269,7 +269,7 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
 		if (shdr->sh_type != SHT_NOBITS) {
 			unsigned long off;
 			/* Adjust the address */
-			data_addr = (data_addr + (align - 1)) & ~(align -1);
+			data_addr = _ALIGN(data_addr, align);
 
 			/* Update the section */
 			off = data_addr - buf_addr;
@@ -281,7 +281,7 @@ int elf_rel_load(struct mem_ehdr *ehdr, struct kexec_info *info,
 			data_addr += shdr->sh_size;
 		} else {
 			/* Adjust the address */
-			bss_addr = (bss_addr + (align - 1)) & ~(align -1);
+			bss_addr = _ALIGN(bss_addr, align);
 
 			/* Update the section */
 			shdr->sh_addr = bss_addr;
diff --git a/kexec/kexec-elf.c b/kexec/kexec-elf.c
index b88aced..3515203 100644
--- a/kexec/kexec-elf.c
+++ b/kexec/kexec-elf.c
@@ -704,8 +704,8 @@ static int build_mem_notes(struct mem_ehdr *ehdr)
 		ElfNN_Nhdr hdr;
 		read_nhdr(ehdr, &hdr, note);
 		note_size  = sizeof(hdr);
-		note_size += (hdr.n_namesz + 3) & ~3;
-		note_size += (hdr.n_descsz + 3) & ~3;
+		note_size += _ALIGN(hdr.n_namesz, 4);
+		note_size += _ALIGN(hdr.n_descsz, 4);
 		ehdr->e_notenum += 1;
 	}
 	/* Now walk and normalize the notes */
@@ -716,9 +716,9 @@ static int build_mem_notes(struct mem_ehdr *ehdr)
 		read_nhdr(ehdr, &hdr, note);
 		note_size  = sizeof(hdr);
 		name       = note + note_size;
-		note_size += (hdr.n_namesz + 3) & ~3;
+		note_size += _ALIGN(hdr.n_namesz, 4);
 		desc       = note + note_size;
-		note_size += (hdr.n_descsz + 3) & ~3;
+		note_size += _ALIGN(hdr.n_descsz, 4);
 
 		if ((hdr.n_namesz != 0) && (name[hdr.n_namesz -1] != '\0')) {
 			/* If note name string is not null terminated, just
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 494c5b3..f3928af 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -257,8 +257,7 @@ unsigned long locate_hole(struct kexec_info *info,
 		if (start < hole_min) {
 			start = hole_min;
 		}
-		start = (start + hole_align - 1) &
-			~((unsigned long long)hole_align - 1);
+		start = _ALIGN(start, hole_align);
 		if (end > mem_max) {
 			end = mem_max;
 		}
@@ -276,8 +275,8 @@ unsigned long locate_hole(struct kexec_info *info,
 				hole_base = start;
 				break;
 			} else {
-				hole_base = (end - hole_size) &
-					~((unsigned long long)hole_align - 1);
+				hole_base = _ALIGN_DOWN(end - hole_size,
+					hole_align);
 			}
 		}
 	}
@@ -313,7 +312,7 @@ void add_segment_phys_virt(struct kexec_info *info,
 
 	/* Round memsz up to a multiple of pagesize */
 	pagesize = getpagesize();
-	memsz = (memsz + (pagesize - 1)) & ~(pagesize - 1);
+	memsz = _ALIGN(memsz, pagesize);
 
 	/* Verify base is pagesize aligned.
 	 * Finding a way to cope with this problem
@@ -363,7 +362,7 @@ unsigned long add_buffer_phys_virt(struct kexec_info *info,
 
 	/* Round memsz up to a multiple of pagesize */
 	pagesize = getpagesize();
-	memsz = (memsz + (pagesize - 1)) & ~(pagesize - 1);
+	memsz = _ALIGN(memsz, pagesize);
 
 	base = locate_hole(info, memsz, buf_align, buf_min, buf_max, buf_end);
 	if (base == ULONG_MAX) {
@@ -457,8 +456,8 @@ int add_backup_segments(struct kexec_info *info, unsigned long backup_base,
 				return -1;
 			if (!find_segment_hole(info, &bkseg_base, &bkseg_size))
 				break;
-			start = (bkseg_base + pagesize - 1) & ~(pagesize - 1);
-			end = (bkseg_base + bkseg_size) & ~(pagesize - 1);
+			start = _ALIGN(bkseg_base, pagesize);
+			end = _ALIGN_DOWN(bkseg_base + bkseg_size, pagesize);
 			add_segment_phys_virt(info, NULL, 0,
 					      start, end-start, 0);
 			mem_size = mem_base + mem_size - \
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
