Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K0gyl-0002FO-Iy
	for kexec@lists.infradead.org; Mon, 26 May 2008 17:59:27 +0000
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 169EC412C0
	for <kexec@lists.infradead.org>; Mon, 26 May 2008 19:59:25 +0200 (CEST)
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Don't run libtoolize and automake in bootstrap.
Date: Mon, 26 May 2008 20:00:02 +0200
Message-Id: <1211824802-7205-1-git-send-email-bwalle@suse.de>
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

This patch removes the 'automake' and 'libtoolize' calls from the 'bootstrap'.
The bug has been introduced by commit 6f65cb623cdb82f712144e438d9aa2f097376251
by myself. Automake and Libtool are not used in kexec-tools.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 bootstrap |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/bootstrap b/bootstrap
index 8e289e1..fc9837d 100755
--- a/bootstrap
+++ b/bootstrap
@@ -22,8 +22,6 @@
 set -x
 aclocal -I config
 autoheader
-automake --foreign --add-missing --copy
 autoconf
-libtoolize --copy
 
 ## @end 1
-- 
1.5.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
