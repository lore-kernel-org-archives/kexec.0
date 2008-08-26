Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KXuSo-0001p4-0B
	for kexec@lists.infradead.org; Tue, 26 Aug 2008 09:03:46 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id D40A841B96
	for <kexec@lists.infradead.org>; Tue, 26 Aug 2008 11:03:43 +0200 (CEST)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Add INSTALL to tarball
Date: Tue, 26 Aug 2008 11:03:43 +0200
Message-Id: <1219741423-8317-1-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
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
Cc: Bernhard Walle <bwalle@suse.de>

This patch just adds the installation file to the tarball.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 Makefile.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index 341e170..f0621e1 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -125,7 +125,7 @@ all: $(TARGETS)
 clean =
 
 # collect objects to be removed in 'make clean'
-dist =	AUTHORS COPYING News TODO Makefile.in configure.ac configure	\
+dist =	AUTHORS COPYING INSTALL News TODO Makefile.in configure.ac configure \
 	kexec-tools.spec.in config/
 
 # utility function for converting a list of files (with extension) to
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
