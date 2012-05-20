Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SVtgH-0003UH-Br
 for kexec@lists.infradead.org; Sun, 20 May 2012 00:07:30 +0000
Received: by obqv19 with SMTP id v19so7690225obq.36
 for <kexec@lists.infradead.org>; Sat, 19 May 2012 17:07:27 -0700 (PDT)
MIME-Version: 1.0
From: Baruch Even <baruch@ev-en.org>
Date: Sun, 20 May 2012 03:00:05 +0300
Message-ID: <CAC9+anKZv5=nQhW9MWjPiWaH3hvoqgRc__XNOP+tG50Qjc7NzA@mail.gmail.com>
Subject: [PATCH] Use HOSTCC for build utilities
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Subject: [PATCH] Use HOSTCC for build utilities

bin-to-hex is used during the build and needs to be compiled with the host
compiler to be able to run during the build.

Signed-off-by: Baruch Even <baruch@ev-en.org>
---
 util/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/Makefile b/util/Makefile
index 948ee63..82c7407 100644
--- a/util/Makefile
+++ b/util/Makefile
@@ -4,8 +4,8 @@ $(BIN_TO_HEX): $(srcdir)/util/bin-to-hex.c
 	@$(MKDIR) -p $(@D)
 	$(LINK.o) $(CFLAGS) -o $@ $^

-$(BIN_TO_HEX): CC=$(BUILD_CC)
-$(BIN_TO_HEX): CFLAGS=$(BUILD_CFLAGS)
+$(BIN_TO_HEX): CC=$(HOSTCC)
+$(BIN_TO_HEX): CFLAGS=$(HOST_CFLAGS)
 $(BIN_TO_HEX): LDFLAGS=

 dist += util/Makefile util/bin-to-hex.c
-- 
1.7.10

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
