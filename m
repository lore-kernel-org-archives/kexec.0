Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KK0mU-0007D7-Fi
	for kexec@lists.infradead.org; Sat, 19 Jul 2008 00:58:38 +0000
Date: Sat, 19 Jul 2008 10:58:37 +1000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH] kdump: Update kdump documentation as kexec-tools-resting
	has been renamed kexec-tools
Message-ID: <20080719005835.GA19032@verge.net.au>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Haren Myneni <hbabu@us.ibm.com>, Vivek Goyal <vgoyal@in.ibm.com>


Signed-off-by: Simon Horman <horms@verge.net.au>

Index: linux-2.6/Documentation/kdump/kdump.txt
===================================================================
--- linux-2.6.orig/Documentation/kdump/kdump.txt	2008-07-19 10:27:50.000000000 +1000
+++ linux-2.6/Documentation/kdump/kdump.txt	2008-07-19 10:51:57.000000000 +1000
@@ -65,26 +65,26 @@ Install kexec-tools
 
 2) Download the kexec-tools user-space package from the following URL:
 
-http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/kexec-tools-testing.tar.gz
+http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/kexec-tools.tar.gz
 
-This is a symlink to the latest version, which at the time of writing is
-20061214, the only release of kexec-tools-testing so far. As other versions
-are released, the older ones will remain available at
-http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/
+This is a symlink to the latest version.
 
-Note: Latest kexec-tools-testing git tree is available at
+The latest kexec-tools git tree is available at:
 
-git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools-testing.git
+git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools.git
 or
-http://www.kernel.org/git/?p=linux/kernel/git/horms/kexec-tools-testing.git;a=summary
+http://www.kernel.org/git/?p=linux/kernel/git/horms/kexec-tools.git
+
+More information about kexec-tools can be found at
+http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/README.html
 
 3) Unpack the tarball with the tar command, as follows:
 
-   tar xvpzf kexec-tools-testing.tar.gz
+   tar xvpzf kexec-tools.tar.gz
 
 4) Change to the kexec-tools directory, as follows:
 
-   cd kexec-tools-testing-VERSION
+   cd kexec-tools-VERSION
 
 5) Configure the package, as follows:
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
