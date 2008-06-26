Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBxYH-0006PC-4T
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 19:54:41 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] x86: Fix documentation bug about relocatability
Date: Thu, 26 Jun 2008 21:55:18 +0200
Message-Id: <1214510118-21405-1-git-send-email-bwalle@suse.de>
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
Cc: Bernhard Walle <bwalle@suse.de>, x86@kernel.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

This patch fixes a small bug in documentation: x86_64 also has now
the ability to build a relocatable kernel.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 Documentation/kdump/kdump.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index b8e52c0..9691c7f 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -109,7 +109,7 @@ There are two possible methods of using Kdump.
 2) Or use the system kernel binary itself as dump-capture kernel and there is
    no need to build a separate dump-capture kernel. This is possible
    only with the architecutres which support a relocatable kernel. As
-   of today i386 and ia64 architectures support relocatable kernel.
+   of today, i386, x86_64 and ia64 architectures support relocatable kernel.
 
 Building a relocatable kernel is advantageous from the point of view that
 one does not have to build a second kernel for capturing the dump. But
-- 
1.5.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
