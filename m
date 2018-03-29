Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f1cst-0003av-Um
 for kexec@lists.infradead.org; Thu, 29 Mar 2018 19:06:53 +0000
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2TJ5Qcp074319
 for <kexec@lists.infradead.org>; Thu, 29 Mar 2018 15:06:39 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h15uc0g86-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 29 Mar 2018 15:06:39 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 29 Mar 2018 13:06:38 -0600
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: kexec_file: Fix error code when trying to load kdump
 kernel
Date: Thu, 29 Mar 2018 16:05:43 -0300
Message-Id: <20180329190543.25118-1-bauerman@linux.vnet.ibm.com>
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
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>, Dave Young <dyoung@redhat.com>

kexec_file_load() on powerpc doesn't support kdump kernels yet, so it
returns -ENOTSUPP in that case.

I've recently learned that this errno is internal to the kernel and isn't
supposed to be exposed to userspace. Therefore, change to -EOPNOTSUPP which
is defined in an uapi header.

This does indeed make kexec-tools happier. Before the patch, on ppc64le:

  # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
  kexec_file_load failed: Unknown error 524

After the patch:

  # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
  kexec_file_load failed: Operation not supported

Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
Reported-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/machine_kexec_file_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This is a minor issue, but since it's a simple patch it might be worth
applying it to stable branches.

This is the kexec-tools thread where this problem was brought up:

https://lists.infradead.org/pipermail/kexec/2018-March/020346.html

And this is an instance of a similar fix being applied elsewhere in the
kernel, for the same reasons:

https://patchwork.kernel.org/patch/8490791/

The test shown in the commit log was made using Hari Bathini's patch
adding kexec_file_load() support to kexec-tools in ppc64.

diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
index e4395f937d63..45e0b7d5f200 100644
--- a/arch/powerpc/kernel/machine_kexec_file_64.c
+++ b/arch/powerpc/kernel/machine_kexec_file_64.c
@@ -43,7 +43,7 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
 
 	/* We don't support crash kernels yet. */
 	if (image->type == KEXEC_TYPE_CRASH)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	for (i = 0; i < ARRAY_SIZE(kexec_file_loaders); i++) {
 		fops = kexec_file_loaders[i];


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
