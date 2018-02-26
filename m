Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eqKWM-00012s-MG
 for kexec@lists.infradead.org; Mon, 26 Feb 2018 15:17:12 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1QFGfYj139491
 for <kexec@lists.infradead.org>; Mon, 26 Feb 2018 10:16:44 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gcj97yexv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 26 Feb 2018 10:16:43 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.vnet.ibm.com>;
 Mon, 26 Feb 2018 15:16:39 -0000
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 09/11] kexec_file: Remove mis-use of sh_offset field
Date: Mon, 26 Feb 2018 16:16:18 +0100
In-Reply-To: <20180226151620.20970-1-prudo@linux.vnet.ibm.com>
References: <20180226151620.20970-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180226151620.20970-10-prudo@linux.vnet.ibm.com>
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
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

The current code uses the sh_offset field in purgatory_info->sechdrs to
store a pointer to the current load address of the section. Depending
whether the section will be loaded or not this is either a pointer into
purgatory_info->purgatory_buf or kexec_purgatory. This is not only a
violation of the ELF standard but also makes the code very hard to
understand as you cannot tell if the memory you are using is read-only or
not.

Remove this mis-use and store the offset of the section in
pugaroty_info->purgatory_buf in sh_offset.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 arch/x86/kernel/machine_kexec_64.c | 10 ++++++----
 kernel/kexec_file.c                | 33 +++------------------------------
 2 files changed, 9 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 51667c8b5c9b..41db74bdc88b 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -457,13 +457,15 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		 * rel[i].r_offset contains byte offset from beginning
 		 * of section to the storage unit affected.
 		 *
-		 * This is location to update (->sh_offset). This is temporary
-		 * buffer where section is currently loaded. This will finally
-		 * be loaded to a different address later, pointed to by
+		 * This is location to update. This is temporary buffer
+		 * where section is currently loaded. This will finally be
+		 * loaded to a different address later, pointed to by
 		 * ->sh_addr. kexec takes care of moving it
 		 *  (kexec_load_segment()).
 		 */
-		location = (void *)(section->sh_offset + rel[i].r_offset);
+		location = pi->purgatory_buf;
+		location += section->sh_offset;
+		location += rel[i].r_offset;
 
 		/* Final address of the location */
 		address = section->sh_addr + rel[i].r_offset;
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 746b91e46e34..25b44d1a664a 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -736,28 +736,6 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	       pi->ehdr->e_shnum * sizeof(Elf_Shdr));
 	pi->sechdrs = sechdrs;
 
-	/*
-	 * We seem to have multiple copies of sections. First copy is which
-	 * is embedded in kernel in read only section. Some of these sections
-	 * will be copied to a temporary buffer and relocated. And these
-	 * sections will finally be copied to their final destination at
-	 * segment load time.
-	 *
-	 * Use ->sh_offset to reflect section address in memory. It will
-	 * point to original read only copy if section is not allocatable.
-	 * Otherwise it will point to temporary copy which will be relocated.
-	 *
-	 * Use ->sh_addr to contain final address of the section where it
-	 * will go during execution time.
-	 */
-	for (i = 0; i < pi->ehdr->e_shnum; i++) {
-		if (sechdrs[i].sh_type == SHT_NOBITS)
-			continue;
-
-		sechdrs[i].sh_offset = (unsigned long)pi->ehdr +
-						sechdrs[i].sh_offset;
-	}
-
 	offset = 0;
 	bss_addr = kbuf->mem + kbuf->bufsz;
 	kbuf->image->start = pi->ehdr->e_entry;
@@ -786,17 +764,12 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 			kbuf->image->start += kbuf->mem + offset;
 		}
 
-		src = (void *)sechdrs[i].sh_offset;
+		src = (void *)pi->ehdr + sechdrs[i].sh_offset;
 		dst = pi->purgatory_buf + offset;
 		memcpy(dst, src, sechdrs[i].sh_size);
 
 		sechdrs[i].sh_addr = kbuf->mem + offset;
-
-		/*
-		 * This section got copied to temporary buffer. Update
-		 * ->sh_offset accordingly.
-		 */
-		sechdrs[i].sh_offset = (unsigned long)dst;
+		sechdrs[i].sh_offset = offset;
 		offset += sechdrs[i].sh_size;
 	}
 
@@ -1006,7 +979,7 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 		return -EINVAL;
 	}
 
-	sym_buf = (char *)sec->sh_offset + sym->st_value;
+	sym_buf = (char *)pi->purgatory_buf + sec->sh_offset + sym->st_value;
 
 	if (get_value)
 		memcpy((void *)buf, sym_buf, size);
-- 
2.13.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
