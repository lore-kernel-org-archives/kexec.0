Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YudhH-0002ZU-KZ
 for kexec@lists.infradead.org; Tue, 19 May 2015 09:20:24 +0000
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 19 May 2015 10:19:59 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id AE2382190061
 for <kexec@lists.infradead.org>; Tue, 19 May 2015 10:19:38 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4J9JvWj59769036
 for <kexec@lists.infradead.org>; Tue, 19 May 2015 09:19:57 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4J4DlE5004699
 for <kexec@lists.infradead.org>; Tue, 19 May 2015 00:13:47 -0400
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [PATCH] ppc64: Don't look for the TOC pointer all the time
Date: Tue, 19 May 2015 11:19:57 +0200
Message-Id: <1432027197-19418-1-git-send-email-ldufour@linux.vnet.ibm.com>
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
To: kexec@lists.infradead.org, horms@verge.net.au

When dealing with the purgatory's relocation, the TOC pointer is computed
by looking at the ".toc" section's address.

This should be done only once and the result kept back to avoid scanning
all the ELF section each time a TOC relative relocation is processed.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 kexec/arch/ppc64/kexec-elf-rel-ppc64.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
index 9b191d0025a4..18d9f2f8e000 100644
--- a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
@@ -1,4 +1,4 @@
-#include <stdio.h>
+ #include <stdio.h>
 #include <elf.h>
 #include <string.h>
 #include "../../kexec.h"
@@ -40,13 +40,17 @@ static struct mem_shdr *toc_section(const struct mem_ehdr *ehdr)
 unsigned long my_r2(const struct mem_ehdr *ehdr)
 {
 	struct mem_shdr *shdr;
+	static unsigned long r2 = 0;
 
-	shdr = toc_section(ehdr);
-	if (!shdr) {
-		die("TOC reloc without a toc section?");
+	if (!r2) {
+		shdr = toc_section(ehdr);
+		if (!shdr) {
+			die("TOC reloc without a toc section?");
+		}
+		r2 = shdr->sh_addr + 0x8000;
 	}
 
-	return shdr->sh_addr + 0x8000;
+	return r2;
 }
 
 static void do_relative_toc(unsigned long value, uint16_t *location,
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
