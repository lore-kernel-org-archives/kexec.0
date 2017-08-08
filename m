Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1deuF2-0003eO-EC
 for kexec@lists.infradead.org; Tue, 08 Aug 2017 02:27:34 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [makedumpfile PATCH v2] Wipe excluded pages that are written
 into ELF dump file
Date: Tue, 8 Aug 2017 02:25:08 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EF7308@BPXM01GP.gisp.nec.co.jp>
References: <1501848839-10518-1-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1501848839-10518-1-git-send-email-eric.devolder@oracle.com>
Content-Language: ja-JP
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
To: Eric DeVolder <eric.devolder@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "daniel.kiper@oracle.com" <daniel.kiper@oracle.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>

Hello Eric,

>When a page is excluded by any of the existing dump levels,
>that page may still be written to the ELF dump file, depending
>upon the PFN_EXCLUDED mechanism.
>
>The PFN_EXCLUDED mechanism looks for N consecutive "not
>dumpable" pages, and if found, the current ELF segment is
>closed out and a new ELF segment started, at the next dumpable
>page. Otherwise, if the PFN_EXCLUDED criteria is not meet (that
>is, there is a mix of dumpable and not dumpable pages, but not
>N consecutive not dumpable pages) all pages are written to the
>dump file.
>
>This patch implements a mechanism for those "not dumpable" pages
>that are written to the ELF dump file to fill those pages with
>constant data, rather than the original data. In other words,
>the dump file still contains the page, but its data is wiped.
>The data is wiped with the value 0xDEAD9A6EDEAD9A6EUL (an
>attempt at DEADPAGE in hex, which works for 32-bit targets as
>well).
>
>The motivation for doing this is to protect real user (customer)
>data from "leaking" through to a dump file when that data was
>intended to be omitted.
>
>Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>---
>v2: posted 04aug2017 to mailing list
> - Incorporate feedback from Daniel Kiper (wipe value)
> - Incorporate feedback from Atsushi Kumagai (eliminate the
>   option and make as default/builtin behavior)

Thanks for your work, this version looks good to me.
I'll merge this into v1.6.3.

Regards,
Atsushi Kumagai

>v1: posted 31jul2017 to mailing list
>---
> makedumpfile.c | 27 ++++++++++++++++++++-------
> makedumpfile.h |  1 +
> 2 files changed, 21 insertions(+), 7 deletions(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index f85003a..66c3105 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -7139,7 +7139,7 @@ out:
>
> int
> write_elf_load_segment(struct cache_data *cd_page, unsigned long long paddr,
>-		       off_t off_memory, long long size)
>+		       off_t off_memory, long long size, struct cycle *cycle)
> {
> 	long page_size = info->page_size;
> 	long long bufsz_write;
>@@ -7163,10 +7163,23 @@ write_elf_load_segment(struct cache_data *cd_page, unsigned long long paddr,
> 		else
> 			bufsz_write = size;
>
>-		if (read(info->fd_memory, buf, bufsz_write) != bufsz_write) {
>-			ERRMSG("Can't read the dump memory(%s). %s\n",
>-			    info->name_memory, strerror(errno));
>-			return FALSE;
>+		if (!is_dumpable(info->bitmap2, paddr_to_pfn(paddr), cycle)) {
>+			unsigned k;
>+			unsigned long *p = (unsigned long *)buf;
>+			for (k = 0; k < info->page_size; k += sizeof(unsigned long)) {
>+				*p++ = FILL_EXCLUDED_PAGES_VALUE;
>+			}
>+			if (lseek(info->fd_memory, bufsz_write, SEEK_CUR) < 0) {
>+				ERRMSG("Can't seek the dump memory(%s). %s\n",
>+				    info->name_memory, strerror(errno));
>+				return FALSE;
>+			}
>+		} else {
>+			if (read(info->fd_memory, buf, bufsz_write) != bufsz_write) {
>+				ERRMSG("Can't read the dump memory(%s). %s\n",
>+				    info->name_memory, strerror(errno));
>+				return FALSE;
>+			}
> 		}
> 		filter_data_buffer((unsigned char *)buf, paddr, bufsz_write);
> 		paddr += bufsz_write;
>@@ -7431,7 +7444,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
> 				 */
> 				if (load.p_filesz)
> 					if (!write_elf_load_segment(cd_page, paddr,
>-								    off_memory, load.p_filesz))
>+								    off_memory, load.p_filesz, &cycle))
> 						return FALSE;
>
> 				load.p_paddr += load.p_memsz;
>@@ -7473,7 +7486,7 @@ write_elf_pages_cyclic(struct cache_data *cd_header, struct cache_data *cd_page)
> 		 */
> 		if (load.p_filesz)
> 			if (!write_elf_load_segment(cd_page, paddr,
>-						    off_memory, load.p_filesz))
>+						    off_memory, load.p_filesz, &cycle))
> 				return FALSE;
>
> 		off_seg_load += load.p_filesz;
>diff --git a/makedumpfile.h b/makedumpfile.h
>index 8a05794..e043cf2 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -223,6 +223,7 @@ isAnon(unsigned long mapping)
> #define FILENAME_BITMAP		"kdump_bitmapXXXXXX"
> #define FILENAME_STDOUT		"STDOUT"
> #define MAP_REGION		(4096*1024)
>+#define FILL_EXCLUDED_PAGES_VALUE   (0xDEAD9A6EDEAD9A6EUL)
>
> /*
>  * Minimam vmcore has 2 ProgramHeaderTables(PT_NOTE and PT_LOAD).
>--
>2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
