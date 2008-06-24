Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ik-out-1112.google.com ([66.249.90.176])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KB62f-0001h0-8Z
	for kexec@lists.infradead.org; Tue, 24 Jun 2008 10:46:29 +0000
Received: by ik-out-1112.google.com with SMTP id c21so1429609ika.2
	for <kexec@lists.infradead.org>; Tue, 24 Jun 2008 03:46:27 -0700 (PDT)
Date: Tue, 24 Jun 2008 11:43:38 +0100
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: [Patch] 'make dist-clean' should clean more files
Message-ID: <20080624104338.GA6324@hack.voiplan.pt>
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


Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---
diff --git a/Makefile.in b/Makefile.in
index b51c3a1..341e170 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -233,6 +233,8 @@ distclean: dist-clean
 
 dist-clean: clean
 	$(RM) -f config.log config.status config.cache Makefile include/config.h
+	$(RM) -f include/config.h.in configure
+	$(RM) -rf autom4te.cache
 
 install: $(TARGETS)
 	for file in $(TARGETS) ; do \

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
