Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ew0-f49.google.com ([209.85.215.49])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OqmHx-0000Ni-B2
	for kexec@lists.infradead.org; Wed, 01 Sep 2010 12:19:38 +0000
Received: by ewy9 with SMTP id 9so4882017ewy.36
	for <kexec@lists.infradead.org>; Wed, 01 Sep 2010 05:19:35 -0700 (PDT)
From: Maxim Uvarov <muvarov@gmail.com>
Subject: [PATCH] Add CFLAGS to compile mips purgatory
Date: Wed, 01 Sep 2010 16:19:32 +0400
Message-ID: <20100901121932.16599.8572.stgit@muvarov>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Required in case if "-mabi=64" option was specified to build 64 bit mips
application, if not compiler tries to link 64 bit binaries with 32 bit
system libraries.
Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
---

 kexec/Makefile     |    2 +-
 purgatory/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kexec/Makefile b/kexec/Makefile
index 77f37ae..23385fc 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -77,7 +77,7 @@ KEXEC_MANPAGE = $(MANDIR)/man8/kexec.8
 
 $(KEXEC): $(KEXEC_OBJS) $(UTIL_LIB)
 	@$(MKDIR) -p $(@D)
-	$(LINK.o) -o $@ $^ $(LIBS)
+	$(LINK.o) -o $@ $^ $(CFLAGS) $(LIBS)
 
 $(KEXEC): CPPFLAGS+=-I$(srcdir)/kexec/arch/$(ARCH)/include
 
diff --git a/purgatory/Makefile b/purgatory/Makefile
index aa3a788..ea0c19a 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -61,7 +61,7 @@ $(PURGATORY): LDFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS)\
 
 $(PURGATORY): $(PURGATORY_OBJS)
 	$(MKDIR) -p $(@D)
-	$(CC) $(LDFLAGS) -o $@ $^
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^
 
 #	$(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) --no-undefined -e purgatory_start -r -o $@ $(PURGATORY_OBJS) $(UTIL_LIB)
 


Best regards,
Maxim Uvarov.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
