Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eYDn7-0007Gx-Sr
 for kexec@lists.infradead.org; Sun, 07 Jan 2018 16:27:23 +0000
Received: by mail-qk0-x22e.google.com with SMTP id o126so11527765qke.12
 for <kexec@lists.infradead.org>; Sun, 07 Jan 2018 08:27:10 -0800 (PST)
From: David Michael <david.michael@coreos.com>
Subject: [PATCH] arm64: Set -fno-PIC along with -mcmodel=large
Date: Sun, 07 Jan 2018 11:26:57 -0500
Message-ID: <87608dprce.fsf@coreos.com>
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org

As seen in GCC's gcc/config/aarch64/aarch64.c, -fPIC with large
code model is unsupported.  This fixes the "sorry, unimplemented"
errors when building with compilers defaulting to -fPIC.
---

Hi,

I'm hitting this error with 2.0.16 on Gentoo:

purgatory/arch/arm64/entry.S:1:0: sorry, unimplemented: code model 'large' with -fPIC

This change fixes it.  Can something like this be applied?

Thanks.

David


 purgatory/arch/arm64/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/purgatory/arch/arm64/Makefile b/purgatory/arch/arm64/Makefile
index 636abea..80068ca 100644
--- a/purgatory/arch/arm64/Makefile
+++ b/purgatory/arch/arm64/Makefile
@@ -1,6 +1,7 @@
 
 arm64_PURGATORY_EXTRA_CFLAGS = \
 	-mcmodel=large \
+	-fno-PIC \
 	-fno-stack-protector \
 	-fno-asynchronous-unwind-tables \
 	-Wundef \
-- 
2.14.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
