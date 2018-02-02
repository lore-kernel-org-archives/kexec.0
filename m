Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ehb4E-0007rh-Q2
 for kexec@lists.infradead.org; Fri, 02 Feb 2018 13:07:54 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w12D6bLI036273
 for <kexec@lists.infradead.org>; Fri, 2 Feb 2018 08:07:35 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fvppwn6ng-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 02 Feb 2018 08:07:34 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.vnet.ibm.com>;
 Fri, 2 Feb 2018 13:07:32 -0000
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 07/17] kexec_file: Simplify kexec_purgatory_setup_sechdrs 1
Date: Fri,  2 Feb 2018 14:07:08 +0100
In-Reply-To: <20180202130718.35509-1-prudo@linux.vnet.ibm.com>
References: <20180202130718.35509-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180202130718.35509-8-prudo@linux.vnet.ibm.com>
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
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: prudo@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

To update the entry point there is an extra loop over all section headers
although this can be done in the main loop. So move it there and eliminate
the extra loop and variable to store the 'entry section index'.

Also, in the main loop, move the usual case, i.e. non-bss section, out of
the extra if-block.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 kernel/kexec_file.c | 76 +++++++++++++++++++++--------------------------------
 1 file changed, 30 insertions(+), 46 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index d1c3ec8dc6b1..bb31a3b627c2 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -731,7 +731,6 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	unsigned char *buf_addr;
 	unsigned char *src;
 	Elf_Shdr *sechdrs;
-	int entry_sidx = -1;
 	int i;
 
 	sechdrs = vzalloc(pi->ehdr->e_shnum * sizeof(Elf_Shdr));
@@ -763,32 +762,11 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 						sechdrs[i].sh_offset;
 	}
 
-	/*
-	 * Identify entry point section and make entry relative to section
-	 * start.
-	 */
-	kbuf->image->start = pi->ehdr->e_entry;
-	for (i = 0; i < pi->ehdr->e_shnum; i++) {
-		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
-			continue;
-
-		if (!(sechdrs[i].sh_flags & SHF_EXECINSTR))
-			continue;
-
-		/* Make entry section relative */
-		if (sechdrs[i].sh_addr <= pi->ehdr->e_entry &&
-		    ((sechdrs[i].sh_addr + sechdrs[i].sh_size) >
-		     pi->ehdr->e_entry)) {
-			entry_sidx = i;
-			kbuf->image->start -= sechdrs[i].sh_addr;
-			break;
-		}
-	}
-
 	/* Load SHF_ALLOC sections */
 	buf_addr = kbuf->buffer;
 	load_addr = curr_load_addr = kbuf->mem;
 	bss_addr = load_addr + kbuf->bufsz;
+	kbuf->image->start = pi->ehdr->e_entry;
 
 	for (i = 0; i < pi->ehdr->e_shnum; i++) {
 		unsigned long align;
@@ -797,34 +775,40 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 			continue;
 
 		align = sechdrs[i].sh_addralign;
-		if (sechdrs[i].sh_type != SHT_NOBITS) {
-			curr_load_addr = ALIGN(curr_load_addr, align);
-			offset = curr_load_addr - load_addr;
-			/* We already modifed ->sh_offset to keep src addr */
-			src = (char *) sechdrs[i].sh_offset;
-			memcpy(buf_addr + offset, src, sechdrs[i].sh_size);
-
-			/* Store load address and source address of section */
-			sechdrs[i].sh_addr = curr_load_addr;
-
-			/*
-			 * This section got copied to temporary buffer. Update
-			 * ->sh_offset accordingly.
-			 */
-			sechdrs[i].sh_offset = (unsigned long)(buf_addr + offset);
-
-			/* Advance to the next address */
-			curr_load_addr += sechdrs[i].sh_size;
-		} else {
+
+		if (sechdrs[i].sh_type == SHT_NOBITS) {
 			bss_addr = ALIGN(bss_addr, align);
 			sechdrs[i].sh_addr = bss_addr;
 			bss_addr += sechdrs[i].sh_size;
+			continue;
+		}
+
+		curr_load_addr = ALIGN(curr_load_addr, align);
+		offset = curr_load_addr - load_addr;
+		/* We already modifed ->sh_offset to keep src addr */
+		src = (char *)sechdrs[i].sh_offset;
+		memcpy(buf_addr + offset, src, sechdrs[i].sh_size);
+
+		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
+		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
+		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
+					 + sechdrs[i].sh_size)) {
+			kbuf->image->start -= sechdrs[i].sh_addr;
+			kbuf->image->start += curr_load_addr
 		}
-	}
 
-	/* Update entry point based on load address of text section */
-	if (entry_sidx >= 0)
-		kbuf->image->start += sechdrs[entry_sidx].sh_addr;
+		/* Store load address and source address of section */
+		sechdrs[i].sh_addr = curr_load_addr;
+
+		/*
+		 * This section got copied to temporary buffer. Update
+		 * ->sh_offset accordingly.
+		 */
+		sechdrs[i].sh_offset = (unsigned long)(buf_addr + offset);
+
+		/* Advance to the next address */
+		curr_load_addr += sechdrs[i].sh_size;
+	}
 
 	return 0;
 }
-- 
2.13.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
