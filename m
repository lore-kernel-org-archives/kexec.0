Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OneOY-0003Eu-TJ
	for kexec@lists.infradead.org; Mon, 23 Aug 2010 21:17:32 +0000
Subject: [PATCH] kexec: extend KCORE_ELF_HEADERS_SIZE for large memory
Message-Id: <E1OneP7-0008Vq-K8@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Mon, 23 Aug 2010 16:18:05 -0500
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
Cc: horms@verge.net.au


A customer has seen the kexec command exhaust its buffer for the ELF headers
from /proc/kcore.  It found 147 program headers, which requires a buffer of
over 8k.
(This overflow was on an SGI UV with an extremely large memory, hence
 many ram ranges.)
The default buffer size of 4k is configured in KCORE_ELF_HEADERS_SIZE.

The easy solution would probably be to increase the buffer to 16k.
That is room for 291 entries, on x86_64.

You might want to make the command dynamically enlarge the buffer when
it is found to be too small, but I don't think this command's use of a
little more memory is of concern.  So there is probably no reason to
change the program logic in this area.

Diffed against kexec-tools-2.0.2

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 kexec/crashdump.h |    4 ++--
 kexec/kexec-elf.c |    4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

Index: kexec-tools-2.0.2/kexec/crashdump.h
===================================================================
--- kexec-tools-2.0.2.orig/kexec/crashdump.h
+++ kexec-tools-2.0.2/kexec/crashdump.h
@@ -7,8 +7,8 @@ extern int get_xen_vmcoreinfo(uint64_t *
 
 /* Need to find a better way to determine per cpu notes section size. */
 #define MAX_NOTE_BYTES		1024
-/* Expecting ELF headers to fit in 4K. Increase it if you need more. */
-#define KCORE_ELF_HEADERS_SIZE  4096
+/* Expecting ELF headers to fit in 16K. Increase it if you need more. */
+#define KCORE_ELF_HEADERS_SIZE  16384
 /* The address of the ELF header is passed to the secondary kernel
  * using the kernel command line option memmap=nnn.
  * The smallest unit the kernel accepts is in kilobytes,
Index: kexec-tools-2.0.2/kexec/kexec-elf.c
===================================================================
--- kexec-tools-2.0.2.orig/kexec/kexec-elf.c
+++ kexec-tools-2.0.2/kexec/kexec-elf.c
@@ -8,6 +8,7 @@
 #include <boot/elf_boot.h>
 #include "kexec.h"
 #include "kexec-elf.h"
+#include "crashdump.h"
 
 static const int probe_debug = 0;
 
@@ -389,6 +390,9 @@ static int build_mem_phdrs(const char *b
 	phdr_size *= ehdr->e_phnum;
 	if ((uintmax_t)(ehdr->e_phoff + phdr_size) > (uintmax_t)len) {
 		/* The program header did not fit in the file buffer */
+		fprintf(stderr, "%d segments require a %ld-byte buffer\n",
+			ehdr->e_phnum, ehdr->e_phoff + phdr_size);
+		fprintf(stderr, "KCORE_ELF_HEADERS_SIZE %d too small\n",				KCORE_ELF_HEADERS_SIZE);
 		if (probe_debug) {
 			fprintf(stderr, "ELF program segment truncated\n");
 		}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
