Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlK1f-0006gz-HU
 for kexec@lists.infradead.org; Tue, 16 Jun 2020 22:25:52 +0000
Received: by mail-qk1-f195.google.com with SMTP id q2so258808qkb.2
 for <kexec@lists.infradead.org>; Tue, 16 Jun 2020 15:25:50 -0700 (PDT)
From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH] x86/purgatory: Add -fno-stack-protector
Date: Tue, 16 Jun 2020 18:25:47 -0400
Message-Id: <20200616222547.1979233-1-nivedita@alum.mit.edu>
In-Reply-To: <CAEJqkggDJEC4W9V6ijmPoE0-soKE7zBUWUiDLdCZArEsDo9vrQ@mail.gmail.com>
References: <CAEJqkggDJEC4W9V6ijmPoE0-soKE7zBUWUiDLdCZArEsDo9vrQ@mail.gmail.com>
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
To: x86@kernel.org, kexec@lists.infradead.org
Cc: Borislav Petkov <bp@alien8.de>, Hans de Goede <hdegoede@redhat.com>, Gabriel C <nix.or.die@googlemail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org

The purgatory Makefile removes -fstack-protector options if they were
configured in, but does not currently add -fno-stack-protector.

If gcc was configured with the --enable-default-ssp configure option,
this results in the stack protector still being enabled for the
purgatory (absent distro-specific specs files that might disable it
again for freestanding compilations), if the main kernel is being
compiled with stack protection enabled (if it's disabled for the main
kernel, the top-level Makefile will add -fno-stack-protector).

This will break the build since commit
  e4160b2e4b02 ("x86/purgatory: Fail the build if purgatory.ro has missing symbols")
and prior to that would have caused runtime failure when trying to use
kexec.

Explicitly add -fno-stack-protector to avoid this, as done in other
Makefiles that need to disable the stack protector.

Reported-by: Gabriel C <nix.or.die@googlemail.com>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/purgatory/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index b04e6e72a592..088bd764e0b7 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -34,6 +34,7 @@ KCOV_INSTRUMENT := n
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
+PURGATORY_CFLAGS += $(call cc-option,-fno-stack-protector)
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
-- 
2.26.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
