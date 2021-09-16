Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQpva-00B2U8-1X
 for kexec@lists.infradead.org; Thu, 16 Sep 2021 11:51:43 +0000
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 4/8] powerpc/pseries/svm: Add a powerpc version of
 cc_platform_has()
In-Reply-To: <YULztMRLJ55YLVU9@infradead.org>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
 <YUCOTIPPsJJpLO/d@zn.tnic> <87lf3yk7g4.fsf@mpe.ellerman.id.au>
 <YUHGDbtiGrDz5+NS@zn.tnic>
 <f8388f18-5e90-5d0f-d681-0b17f8307dd4@csgroup.eu>
 <YULztMRLJ55YLVU9@infradead.org>
Date: Thu, 16 Sep 2021 21:51:30 +1000
Message-ID: <87czp8kabh.fsf@mpe.ellerman.id.au>
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
To: Christoph Hellwig <hch@infradead.org>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Borislav Petkov <bp@alien8.de>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, linux-graphics-maintainer@vmware.com, Tom Lendacky <thomas.lendacky@amd.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Christoph Hellwig <hch@infradead.org> writes:
> On Wed, Sep 15, 2021 at 07:18:34PM +0200, Christophe Leroy wrote:
>> Could you please provide more explicit explanation why inlining such an
>> helper is considered as bad practice and messy ?
>
> Because now we get architectures to all subly differ.  Look at the mess
> for ioremap and the ioremap* variant.
>
> The only good reason to allow for inlines if if they are used in a hot
> path.  Which cc_platform_has is not, especially not on powerpc.

Yes I agree, it's not a hot path so it doesn't really matter, which is
why I Acked it.

I think it is possible to do both, share the declaration across arches
but also give arches flexibility to use an inline if they prefer, see
patch below.

I'm not suggesting we actually do that for this series now, but I think
it would solve the problem if we ever needed to in future.

cheers


diff --git a/arch/powerpc/platforms/pseries/cc_platform.c b/arch/powerpc/include/asm/cc_platform.h
similarity index 74%
rename from arch/powerpc/platforms/pseries/cc_platform.c
rename to arch/powerpc/include/asm/cc_platform.h
index e8021af83a19..6285c3c385a6 100644
--- a/arch/powerpc/platforms/pseries/cc_platform.c
+++ b/arch/powerpc/include/asm/cc_platform.h
@@ -7,13 +7,10 @@
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
  */
 
-#include <linux/export.h>
 #include <linux/cc_platform.h>
-
-#include <asm/machdep.h>
 #include <asm/svm.h>
 
-bool cc_platform_has(enum cc_attr attr)
+static inline bool arch_cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_MEM_ENCRYPT:
@@ -23,4 +20,3 @@ bool cc_platform_has(enum cc_attr attr)
 		return false;
 	}
 }
-EXPORT_SYMBOL_GPL(cc_platform_has);
diff --git a/arch/x86/include/asm/cc_platform.h b/arch/x86/include/asm/cc_platform.h
new file mode 100644
index 000000000000..0a4220697043
--- /dev/null
+++ b/arch/x86/include/asm/cc_platform.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CC_PLATFORM_H_
+#define _ASM_X86_CC_PLATFORM_H_
+
+bool arch_cc_platform_has(enum cc_attr attr);
+
+#endif // _ASM_X86_CC_PLATFORM_H_
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 3c9bacd3c3f3..77e8c3465979 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -11,11 +11,11 @@
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
 
-bool cc_platform_has(enum cc_attr attr)
+bool arch_cc_platform_has(enum cc_attr attr)
 {
 	if (sme_me_mask)
 		return amd_cc_platform_has(attr);
 
 	return false;
 }
-EXPORT_SYMBOL_GPL(cc_platform_has);
+EXPORT_SYMBOL_GPL(arch_cc_platform_has);
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index 253f3ea66cd8..f3306647c5d9 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -65,6 +65,8 @@ enum cc_attr {
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
 
+#include <asm/cc_platform.h>
+
 /**
  * cc_platform_has() - Checks if the specified cc_attr attribute is active
  * @attr: Confidential computing attribute to check
@@ -77,7 +79,10 @@ enum cc_attr {
  * * TRUE  - Specified Confidential Computing attribute is active
  * * FALSE - Specified Confidential Computing attribute is not active
  */
-bool cc_platform_has(enum cc_attr attr);
+static inline bool cc_platform_has(enum cc_attr attr)
+{
+	return arch_cc_platform_has(attr);
+}
 
 #else	/* !CONFIG_ARCH_HAS_CC_PLATFORM */
 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
