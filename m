Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WBB1S-0004qK-8z
 for kexec@lists.infradead.org; Wed, 05 Feb 2014 22:32:46 +0000
Message-ID: <52F2BBF2.8080907@suse.de>
Date: Wed, 05 Feb 2014 14:32:18 -0800
From: Tony Jones <tonyj@suse.de>
MIME-Version: 1.0
Subject: PATCH: kexec/i386 fix build failure (bzImage_support_efi_boot)
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
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>

Commit 9c200a85de2245a850546fded96a1977b84ad24d referenced 
'bzImage_support_efi_boot' without matching 32-bit definition.

Signed-off-by: Tony Jones <tonyj@suse.de>
---
 kexec/arch/i386/kexec-bzImage.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kexec/arch/i386/kexec-bzImage.c
+++ b/kexec/arch/i386/kexec-bzImage.c
@@ -40,6 +40,7 @@
 #include <arch/options.h>
 
 static const int probe_debug = 0;
+int bzImage_support_efi_boot = 0;
 
 int bzImage_probe(const char *buf, off_t len)
 {

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
