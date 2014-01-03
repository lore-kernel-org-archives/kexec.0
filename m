Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vyvqx-0006tf-BB
 for kexec@lists.infradead.org; Fri, 03 Jan 2014 03:55:20 +0000
Date: Fri, 3 Jan 2014 11:54:31 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH tip/efi-kexec] x86: ksysfs.c build fix
Message-ID: <20140103035431.GA5259@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: matt@console-pimps.org, hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org

kbuild test robot report below error for randconfig:

   arch/x86/kernel/ksysfs.c: In function 'get_setup_data_paddr':
>> arch/x86/kernel/ksysfs.c:81:3: error: implicit declaration of function 'ioremap_cache' [-Werror=implicit-function-declaration]
      data = ioremap_cache(pa_data, sizeof(*data));
      ^
>> arch/x86/kernel/ksysfs.c:86:3: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
      iounmap(data);
      ^
Fix it by including <asm/io.h> in ksysfs.c

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/kernel/ksysfs.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux/arch/x86/kernel/ksysfs.c
===================================================================
--- linux.orig/arch/x86/kernel/ksysfs.c
+++ linux/arch/x86/kernel/ksysfs.c
@@ -16,6 +16,7 @@
 #include <linux/stat.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <asm/io.h>
 
 #include <asm/setup.h>
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
