Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KXtjY-0001Uy-0a
	for kexec@lists.infradead.org; Tue, 26 Aug 2008 08:17:00 +0000
MIME-Version: 1.0
Subject: [PATCH] [PATCH] Move $(LIBS) on the end
Message-Id: <669d49e549978c2cd9bb.1219738609@halley.suse.de>
Date: Tue, 26 Aug 2008 10:16:49 +0200
From: Bernhard Walle <bwalle@suse.de>
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
Cc: yhlu.kernel@gmail.com

1 file changed, 1 insertion(+), 2 deletions(-)
kexec/Makefile |    3 +--


To make static compilation work with

    LDFLAGS=-static ./configure
    make

we have to move $(LIBS) on the end of the compiler line. Static compilation has
been requested by "Yinghai Lu" <yhlu.kernel@gmail.com>. Although I don't see the
practical benefit in most cases, I don't think we should not support it. Since
kexec does not use name resolution functions of libc, it's valid to use static
linking.

Tested on x86_64-suse-linux.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

diff --git a/kexec/Makefile b/kexec/Makefile
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -67,10 +67,9 @@
 
 -include $(KEXEC_DEPS)
 
-$(KEXEC): LDFLAGS+=$(LIBS)
 $(KEXEC): $(KEXEC_OBJS) $(UTIL_LIB)
 	@$(MKDIR) -p $(@D)
-	$(LINK.o) -o $@ $^
+	$(LINK.o) -o $@ $^ $(LIBS)
 
 $(KEXEC): CPPFLAGS+=-I$(srcdir)/kexec/arch/$(ARCH)/include
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
