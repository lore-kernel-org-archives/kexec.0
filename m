Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dsl022.labridge.com ([206.117.136.22] helo=perches.com)
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IKTSA-0005Px-LL
	for kexec@lists.infradead.org; Mon, 13 Aug 2007 07:31:03 +0100
Date: Sun, 12 Aug 2007 23:30:38 -0700
From: joe@perches.com
Subject: [PATCH] [275/2many] MAINTAINERS - KDUMP
Message-ID: <46bffa8e.NHuk7h7puR+3eDXo%joe@perches.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@in.ibm.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, hbabu@us.ibm.com, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ea2c63..d61676a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2634,6 +2634,7 @@ L:	kexec@lists.infradead.org
 L:	linux-kernel@vger.kernel.org
 W:	http://lse.sourceforge.net/kdump/
 S:	Maintained
+F:	Documentation/kdump
 
 KERNEL AUTOMOUNTER (AUTOFS)
 P:	H. Peter Anvin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
