Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga05.intel.com ([192.55.52.89] helo=fmsmga101.fm.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jt7kR-0002Ea-F1
	for kexec@lists.infradead.org; Mon, 05 May 2008 20:57:23 +0000
Received: from nlxdcldnl2.cl.intel.com (localhost.localdomain [127.0.0.1])
	by nlxdcldnl2.cl.intel.com (8.14.1/8.14.1) with ESMTP id m45KrSPM004448
	for <kexec@lists.infradead.org>; Mon, 5 May 2008 13:53:28 -0700
Received: (from dnlombar@localhost)
	by nlxdcldnl2.cl.intel.com (8.14.1/8.14.1/Submit) id m45KrSoT004447
	for kexec@lists.infradead.org; Mon, 5 May 2008 13:53:28 -0700
Date: Mon, 5 May 2008 13:53:28 -0700
From: "Lombard, David N" <dnlombar@ichips.intel.com>
Subject: [PATCH] Cross compile?
Message-ID: <20080505205328.GA29182@nlxdcldnl2.cl.intel.com>
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

In util/Makefile, the bin-to-hex utility was being built with the
cross-compiler, not the host compiler.  This patch fixes that.

Signed-off-by: David N. Lombard, <david.n.lombard@intel.com>


--- kexec-tools-testing-20080324/util/Makefile.orig	2008-03-24 01:30:57.000000000 -0700
+++ kexec-tools-testing-20080324/util/Makefile	2008-05-05 13:10:09.000000000 -0700
@@ -2,10 +2,7 @@ BIN_TO_HEX:= bin/bin-to-hex
 
 $(BIN_TO_HEX): $(srcdir)/util/bin-to-hex.c
 	@$(MKDIR) -p $(@D)
-	$(LINK.o) -o $@ $^
+	$(BUILD_CC) $(BUILD_CFLAGS) -o $@ $<
-
-$(BIN_TO_HEX): CC=$(BUILD_CC)
-$(BIN_TO_HEX): CFLAGS=$(BUILD_CFLAGS)
 
 dist += util/Makefile util/bin-to-hex.c
 clean += util/bin-to-hex.o $(BIN_TO_HEX)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
