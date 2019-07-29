Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hs4Y4-0008RX-DC
 for kexec@lists.infradead.org; Mon, 29 Jul 2019 12:14:41 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6TC9GhJ023382
 for <kexec@lists.infradead.org>; Mon, 29 Jul 2019 08:14:39 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u208c1832-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 29 Jul 2019 08:14:39 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <gor@linux.ibm.com>;
 Mon, 29 Jul 2019 13:14:36 +0100
Date: Mon, 29 Jul 2019 14:14:30 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH] kexec: restore arch_kexec_kernel_image_probe declaration
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <patch.git-ff1c9045ebdc.your-ad-here.call-01564402297-ext-5690@work.hours>
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
To: Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

arch_kexec_kernel_image_probe function declaration has been removed by
commit 9ec4ecef0af7 ("kexec_file,x86,powerpc: factor out kexec_file_ops
functions"). Still this function is overridden by couple of architectures
and proper prototype declaration is therefore important, so bring it
back. This fixes the following sparse warning on s390:
arch/s390/kernel/machine_kexec_file.c:333:5: warning: symbol 'arch_kexec_kernel_image_probe' was not declared. Should it be static?

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 include/linux/kexec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 1740fe36b5b7..f7529d120920 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -183,6 +183,8 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
 				   bool get_value);
 void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
 
+int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
+					 unsigned long buf_len);
 void * __weak arch_kexec_kernel_image_load(struct kimage *image);
 int __weak arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 					    Elf_Shdr *section,
-- 
2.21.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
