Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.245])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwnPd-0001wm-Ty
	for kexec@lists.infradead.org; Fri, 16 May 2008 00:03:07 +0000
Received: by rv-out-0708.google.com with SMTP id b17so733150rvf.42
	for <kexec@lists.infradead.org>; Thu, 15 May 2008 17:03:02 -0700 (PDT)
Date: Thu, 15 May 2008 17:03:09 -0700
From: Jamey Sharp <jamey@thetovacompany.com>
Subject: [PATCH] Use target CC and LD to build kdump and kexec_test.
Message-ID: <20080516000309.GA5188@oh.minilop.net>
MIME-Version: 1.0
Content-Disposition: inline
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

Signed-off-by: Jamey Sharp <jamey@thetovacompany.com>
---
Another generic patch extracted from my Windows porting work.

I think this is correct, but review would be appreciated.

 Makefile.in         |    1 +
 configure.ac        |    2 ++
 kdump/Makefile      |    1 +
 kexec_test/Makefile |    4 ++--
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index 037f9a4..b51c3a1 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -37,6 +37,7 @@ AR		= @AR@
 BUILD_CC	= @BUILD_CC@
 BUILD_CFLAGS	= @BUILD_CFLAGS@
 TARGET_CC	= @TARGET_CC@
+TARGET_LD	= @TARGET_LD@
 TARGET_CFLAGS	= @TARGET_CFLAGS@
 
 
diff --git a/configure.ac b/configure.ac
index b2ad226..beb8b3e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -87,6 +87,7 @@ fi
 dnl Find compiler for target
 if test "${target}" != "${host}" ; then
 	AC_CHECK_PROGS(TARGET_CC, [${target_alias}-gcc ${target}-gcc gcc])
+	AC_CHECK_PROGS(TARGET_LD, [${target_alias}-ld ${target}-ld ld])
 else
 	TARGET_CC="$CC"
 fi
@@ -148,6 +149,7 @@ dnl ---Output variables...
 AC_SUBST([BUILD_CC])
 AC_SUBST([BUILD_CFLAGS])
 AC_SUBST([TARGET_CC])
+AC_SUBST([TARGET_LD])
 AC_SUBST([TARGET_CFLAGS])
 AC_SUBST([ASFLAGS])
 
diff --git a/kdump/Makefile b/kdump/Makefile
index 4a788f9..1e2b72c 100644
--- a/kdump/Makefile
+++ b/kdump/Makefile
@@ -15,6 +15,7 @@ clean += $(KDUMP_OBJS) $(KDUMP_DEPS) $(KDUMP) $(KDUMP_MANPAGE)
 
 -include $(KDUMP_DEPS)
 
+$(KDUMP): CC=$(TARGET_CC)
 $(KDUMP): $(KDUMP_OBJS)
 	@$(MKDIR) -p $(@D)
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -o $@ $(KDUMP_OBJS)
diff --git a/kexec_test/Makefile b/kexec_test/Makefile
index 4848fc4..fec6210 100644
--- a/kexec_test/Makefile
+++ b/kexec_test/Makefile
@@ -26,6 +26,7 @@ clean += $(KEXEC_TEST_OBJS) $(KEXEC_TEST_DEPS) $(KEXEC_TEST)
 
 -include $(KEXEC_TEST_DEPS)
 
+$(KEXEC_TEST): CC=$(TARGET_CC)
 $(KEXEC_TEST): CPPFLAGS+=-DRELOC=$(RELOC)
 $(KEXEC_TEST): ASFLAGS+=-m32
 #$(KEXEC_TEST): LDFLAGS=-m32 -Wl,-e -Wl,_start -Wl,-Ttext -Wl,$(RELOC) \
@@ -34,7 +35,6 @@ $(KEXEC_TEST): LDFLAGS=-melf_i386 -e _start -Ttext $(RELOC)
 
 $(KEXEC_TEST): $(KEXEC_TEST_OBJS)
 	mkdir -p $(@D)
-	#$(LINK.o) -o $@ $^
-	$(LD) $(LDFLAGS) -o $@ $^
+	$(TARGET_LD) $(LDFLAGS) -o $@ $^
 
 endif
-- 
1.5.4.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
