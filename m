Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JbrnR-0006nj-CP
	for kexec@lists.infradead.org; Wed, 19 Mar 2008 06:29:09 +0000
MIME-Version: 1.0
Subject: [PATCH 1/3] Use separate CPPFLAGS and LDFLAGS for purgatory
Message-Id: <1205908147.931964.895312651655.1.gpush@pokey>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 19 Mar 2008 17:29:07 +1100
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Currently, CPPFLAGS and LDFLAGS can 'leak' into the purgatory build
from the main kexec/kexec object. Because of this, the purgatory
is build with -lz, but we may not have a zlib present for the
architecture of the purgatory object.

This change uses fresh CPPFLAGS and LDFLAGS for the purgatory object.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 purgatory/Makefile |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/purgatory/Makefile b/purgatory/Makefile
index 6c747b1..ac58719 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -49,11 +49,12 @@ $(PURGATORY): CFLAGS+=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
 		      -Os -fno-builtin -ffreestanding \
 		      -fno-zero-initialized-in-bss
 
-$(PURGATORY): CPPFLAGS+=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
+$(PURGATORY): CPPFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
 			-I$(srcdir)/purgatory/include \
 			-I$(srcdir)/purgatory/arch/$(ARCH)/include \
+			-I$(srcdir)/util_lib/include \
 			-I$(shell $(CC) -print-file-name=include)
-$(PURGATORY): LDFLAGS+=$($(ARCH)_PURGATORY_EXTRA_CFLAGS)\
+$(PURGATORY): LDFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS)\
 			--no-undefined -nostartfiles -nostdlib -nodefaultlibs \
 			-e purgatory_start -r
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
