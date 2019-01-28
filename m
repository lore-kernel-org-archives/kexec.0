Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4VP-00070U-Dn
 for kexec@lists.infradead.org; Mon, 28 Jan 2019 10:51:08 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH] purgatory: Use standalond CFLAGS
Date: Mon, 28 Jan 2019 18:50:40 +0800
Message-Id: <20190128105040.30520-1-kasong@redhat.com>
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
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>, Dave Young <dyoung@redhat.com>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>

There has been a lot of workarounds for purgatory disabling many
specified CFLAGS that will break purgatory. It will be better to not
let the CFLAGS used to compile purgatory honor the CFLAGS from
environment variables. So we will have stable CFLAGS for purgatory.

If anyone still wants to change purgatory CFLAGS, PURGATORY_EXTRA_CFLAGS
is still honored.

---
 purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/purgatory/Makefile b/purgatory/Makefile
index 49ce80a..2dd6c47 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -45,7 +45,7 @@ purgatory/sha256.o: $(srcdir)/util_lib/sha256.c
 	$(COMPILE.c) -o $@ $^
 
 $(PURGATORY): CC=$(TARGET_CC)
-$(PURGATORY): CFLAGS+=$(PURGATORY_EXTRA_CFLAGS) \
+$(PURGATORY): CFLAGS=$(PURGATORY_EXTRA_CFLAGS) \
 		      $($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
 		      -Os -fno-builtin -ffreestanding \
 		      -fno-zero-initialized-in-bss \
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
