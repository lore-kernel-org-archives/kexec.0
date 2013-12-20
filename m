Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VtwzL-0005hV-Gi
 for kexec@lists.infradead.org; Fri, 20 Dec 2013 10:07:23 +0000
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH v4 1/4] build fix: include x86-linux.h in x86-linux-setup.h
Date: Fri, 20 Dec 2013 18:05:44 +0800
Message-Id: <1387533947-18210-2-git-send-email-dyoung@redhat.com>
In-Reply-To: <1387533947-18210-1-git-send-email-dyoung@redhat.com>
References: <1387533947-18210-1-git-send-email-dyoung@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

There's build warnings about using struct x86_linux_param_header *
in x86-linux-setup.h, it is declared in x86-linux.h

Fix it by include x86-linux.h in x86-linux-setup.h

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/arch/i386/x86-linux-setup.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/arch/i386/x86-linux-setup.h b/kexec/arch/i386/x86-linux-setup.h
index 09aed4d..2afe97c 100644
--- a/kexec/arch/i386/x86-linux-setup.h
+++ b/kexec/arch/i386/x86-linux-setup.h
@@ -1,5 +1,6 @@
 #ifndef X86_LINUX_SETUP_H
 #define X86_LINUX_SETUP_H
+#include <x86/x86-linux.h>
 
 void init_linux_parameters(struct x86_linux_param_header *real_mode);
 void setup_linux_bootloader_parameters_high(
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
