Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ehb4E-0007rd-Q7
 for kexec@lists.infradead.org; Fri, 02 Feb 2018 13:07:48 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w12D5saD067991
 for <kexec@lists.infradead.org>; Fri, 2 Feb 2018 08:07:35 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fvpmnnc4g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 02 Feb 2018 08:07:35 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.vnet.ibm.com>;
 Fri, 2 Feb 2018 13:07:32 -0000
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 08/17] kexec_file: Simplify kexec_purgatory_setup_sechdrs 2
Date: Fri,  2 Feb 2018 14:07:09 +0100
In-Reply-To: <20180202130718.35509-1-prudo@linux.vnet.ibm.com>
References: <20180202130718.35509-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180202130718.35509-9-prudo@linux.vnet.ibm.com>
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

The main loop currently uses quite a lot of variables to update the section
headers. Some of them are unnecessary. So clean them up a little.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 kernel/kexec_file.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index bb31a3b627c2..746b91e46e34 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -724,12 +724,8 @@ static int kexec_purgatory_setup_kbuf(struct purgatory_info *pi,
 static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 					 struct kexec_buf *kbuf)
 {
-	unsigned long curr_load_addr;
-	unsigned long load_addr;
 	unsigned long bss_addr;
 	unsigned long offset;
-	unsigned char *buf_addr;
-	unsigned char *src;
 	Elf_Shdr *sechdrs;
 	int i;
 
@@ -762,20 +758,18 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 						sechdrs[i].sh_offset;
 	}
 
-	/* Load SHF_ALLOC sections */
-	buf_addr = kbuf->buffer;
-	load_addr = curr_load_addr = kbuf->mem;
-	bss_addr = load_addr + kbuf->bufsz;
+	offset = 0;
+	bss_addr = kbuf->mem + kbuf->bufsz;
 	kbuf->image->start = pi->ehdr->e_entry;
 
 	for (i = 0; i < pi->ehdr->e_shnum; i++) {
 		unsigned long align;
+		void *src, *dst;
 
 		if (!(sechdrs[i].sh_flags & SHF_ALLOC))
 			continue;
 
 		align = sechdrs[i].sh_addralign;
-
 		if (sechdrs[i].sh_type == SHT_NOBITS) {
 			bss_addr = ALIGN(bss_addr, align);
 			sechdrs[i].sh_addr = bss_addr;
@@ -783,31 +777,27 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 			continue;
 		}
 
-		curr_load_addr = ALIGN(curr_load_addr, align);
-		offset = curr_load_addr - load_addr;
-		/* We already modifed ->sh_offset to keep src addr */
-		src = (char *)sechdrs[i].sh_offset;
-		memcpy(buf_addr + offset, src, sechdrs[i].sh_size);
-
+		offset = ALIGN(offset, align);
 		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
 		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
 		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
 					 + sechdrs[i].sh_size)) {
 			kbuf->image->start -= sechdrs[i].sh_addr;
-			kbuf->image->start += curr_load_addr
+			kbuf->image->start += kbuf->mem + offset;
 		}
 
-		/* Store load address and source address of section */
-		sechdrs[i].sh_addr = curr_load_addr;
+		src = (void *)sechdrs[i].sh_offset;
+		dst = pi->purgatory_buf + offset;
+		memcpy(dst, src, sechdrs[i].sh_size);
+
+		sechdrs[i].sh_addr = kbuf->mem + offset;
 
 		/*
 		 * This section got copied to temporary buffer. Update
 		 * ->sh_offset accordingly.
 		 */
-		sechdrs[i].sh_offset = (unsigned long)(buf_addr + offset);
-
-		/* Advance to the next address */
-		curr_load_addr += sechdrs[i].sh_size;
+		sechdrs[i].sh_offset = (unsigned long)dst;
+		offset += sechdrs[i].sh_size;
 	}
 
 	return 0;
-- 
2.13.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
