Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eqKWC-0000xK-Pw
 for kexec@lists.infradead.org; Mon, 26 Feb 2018 15:16:56 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1QF8jPX127103
 for <kexec@lists.infradead.org>; Mon, 26 Feb 2018 10:16:32 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gckm7br5q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 26 Feb 2018 10:16:31 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.vnet.ibm.com>;
 Mon, 26 Feb 2018 15:16:29 -0000
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 02/11] kexec_file: Remove checks in kexec_purgatory_load
Date: Mon, 26 Feb 2018 16:16:11 +0100
In-Reply-To: <20180226151620.20970-1-prudo@linux.vnet.ibm.com>
References: <20180226151620.20970-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180226151620.20970-3-prudo@linux.vnet.ibm.com>
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

Before the purgatory is loaded several checks are done whether the ELF file
in kexec_purgatory is valid or not. These checks are incomplete. For
example they don't check for the total size of the sections defined in the
section header table or if the entry point actually points into the
purgatory.

On the other hand the purgatory, although an ELF file on its own, is part
of the kernel. Thus not trusting the purgatory means not trusting the
kernel build itself.

So remove all validity checks on the purgatory and just trust the kernel
build.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 kernel/kexec_file.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index e5bcd94c1efb..0f044457b40c 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -880,22 +880,8 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
 	if (kexec_purgatory_size <= 0)
 		return -EINVAL;
 
-	if (kexec_purgatory_size < sizeof(Elf_Ehdr))
-		return -ENOEXEC;
-
 	pi->ehdr = (Elf_Ehdr *)kexec_purgatory;
 
-	if (memcmp(pi->ehdr->e_ident, ELFMAG, SELFMAG) != 0
-	    || pi->ehdr->e_type != ET_REL
-	    || !elf_check_arch(pi->ehdr)
-	    || pi->ehdr->e_shentsize != sizeof(Elf_Shdr))
-		return -ENOEXEC;
-
-	if (pi->ehdr->e_shoff >= kexec_purgatory_size
-	    || (pi->ehdr->e_shnum * sizeof(Elf_Shdr) >
-	    kexec_purgatory_size - pi->ehdr->e_shoff))
-		return -ENOEXEC;
-
 	ret = __kexec_load_purgatory(image, min, max, top_down);
 	if (ret)
 		return ret;
-- 
2.13.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
