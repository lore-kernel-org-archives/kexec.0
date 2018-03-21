Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1eybuf-0003L7-1M
 for kexec@lists.infradead.org; Wed, 21 Mar 2018 11:28:33 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LBQ4Xg017700
 for <kexec@lists.infradead.org>; Wed, 21 Mar 2018 07:28:04 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gunbxjsh4-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 21 Mar 2018 07:28:04 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 11:28:01 -0000
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH v2 03/11] kexec_file: Make purgatory_info->ehdr const
Date: Wed, 21 Mar 2018 12:27:43 +0100
In-Reply-To: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
References: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180321112751.22196-4-prudo@linux.vnet.ibm.com>
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
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

The kexec_purgatory buffer is read-only. Thus all pointers into
kexec_purgatory are read-only, too. Point this out by explicitly marking
purgatory_info->ehdr as 'const' and update the comments in purgatory_info.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 include/linux/kexec.h | 17 +++++++++++------
 kernel/kexec_file.c   |  4 ++--
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 7bae5e87bf0d..10842eece180 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -99,14 +99,19 @@ struct compat_kexec_segment {
 
 #ifdef CONFIG_KEXEC_FILE
 struct purgatory_info {
-	/* Pointer to elf header of read only purgatory */
-	Elf_Ehdr *ehdr;
-
-	/* Pointer to purgatory sechdrs which are modifiable */
+	/*
+	 * Pointer to elf header at the beginning of kexec_purgatory.
+	 * Note: kexec_purgatory is read only
+	 */
+	const Elf_Ehdr *ehdr;
+	/*
+	 * Temporary, modifiable buffer for sechdrs used for relocation.
+	 * This memory can be freed post image load.
+	 */
 	Elf_Shdr *sechdrs;
 	/*
-	 * Temporary buffer location where purgatory is loaded and relocated
-	 * This memory can be freed post image load
+	 * Temporary, modifiable buffer for stripped purgatory used for
+	 * relocation. This memory can be freed post image load.
 	 */
 	void *purgatory_buf;
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 0f044457b40c..06fc9fdd2474 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -880,7 +880,7 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 	if (kexec_purgatory_size <= 0)
 		return -EINVAL;
 
-	pi->ehdr = (Elf_Ehdr *)kexec_purgatory;
+	pi->ehdr = (const Elf_Ehdr *)kexec_purgatory;
 
 	ret = __kexec_load_purgatory(image, min, max, top_down);
 	if (ret)
@@ -904,9 +904,9 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 static Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
 					    const char *name)
 {
+	const Elf_Ehdr *ehdr;
 	Elf_Sym *syms;
 	Elf_Shdr *sechdrs;
-	Elf_Ehdr *ehdr;
 	int i, k;
 	const char *strtab;
 
-- 
2.13.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
