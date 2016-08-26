Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gibson.whatever-company.com ([87.98.251.113])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bdGXZ-0006Un-8s
 for kexec@lists.infradead.org; Fri, 26 Aug 2016 12:47:22 +0000
From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: [PATCH 1/3] kexec elf: Sanity check on the note header before
 accessing it
Date: Fri, 26 Aug 2016 12:46:14 +0000
Message-Id: <1472215576-7466-1-git-send-email-s.munaut@whatever-company.com>
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
To: kexec@lists.infradead.org
Cc: Sylvain Munaut <s.munaut@whatever-company.com>

The name[hdr.n_namesz -1] check below can segfault if the header
is garbage. So we check the computed header side fits within
the expected area before going further.

Signed-off-by: Sylvain Munaut <s.munaut@whatever-company.com>
---
 kexec/kexec-elf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kexec/kexec-elf.c b/kexec/kexec-elf.c
index 3515203..1d6320a 100644
--- a/kexec/kexec-elf.c
+++ b/kexec/kexec-elf.c
@@ -720,6 +720,14 @@ static int build_mem_notes(struct mem_ehdr *ehdr)
 		desc       = note + note_size;
 		note_size += _ALIGN(hdr.n_descsz, 4);
 
+		if (((note+note_size) > note_end) ||
+		    ((note+note_size) < note_start)) {
+			/* Something is very wrong here ! Most likely the note
+			 * header is invalid */
+			fprintf(stderr, "ELF Note corrupted !\n");
+			return -1;
+		}
+
 		if ((hdr.n_namesz != 0) && (name[hdr.n_namesz -1] != '\0')) {
 			/* If note name string is not null terminated, just
 			 * warn user about it and continue processing. This
-- 
2.1.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
