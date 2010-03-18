Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bw0-f215.google.com ([209.85.218.215])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NsLwR-00072x-Br
	for kexec@lists.infradead.org; Thu, 18 Mar 2010 20:03:43 +0000
Received: by bwz7 with SMTP id 7so1841053bwz.4
	for <kexec@lists.infradead.org>; Thu, 18 Mar 2010 13:03:38 -0700 (PDT)
From: Ameya Palande <2ameya@gmail.com>
Subject: [PATCH 5/6] kexec-tools: Add rpm spec file to the dist-clean target
Date: Thu, 18 Mar 2010 22:03:23 +0200
Message-Id: <3e757c668eb8f12fc31480a1e156c64744bc04a6.1268942234.git.ameya.palande@nokia.com>
In-Reply-To: <cover.1268942234.git.ameya.palande@nokia.com>
References: <cover.1268942234.git.ameya.palande@nokia.com>
In-Reply-To: <cover.1268942234.git.ameya.palande@nokia.com>
References: <cover.1268942234.git.ameya.palande@nokia.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

This patch adds rpm spec file to the "make dist-clean" target and also removes
a wrong comment.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 Makefile.in |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index 3532457..256f4de 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -126,7 +126,6 @@ all: $(TARGETS)
 # collect objects to be removed in 'make clean'
 clean =
 
-# collect objects to be removed in 'make clean'
 dist =	AUTHORS COPYING INSTALL News TODO Makefile.in configure.ac configure \
 	kexec-tools.spec.in config/
 
@@ -235,7 +234,7 @@ distclean: dist-clean
 
 dist-clean: clean
 	$(RM) -f config.log config.status config.cache Makefile include/config.h
-	$(RM) -f include/config.h.in configure
+	$(RM) -f include/config.h.in configure $(SPEC)
 	$(RM) -rf autom4te.cache
 
 install: $(TARGETS)
-- 
1.6.3.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
