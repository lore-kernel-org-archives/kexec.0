Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HihqH-0004XT-Gu
	for kexec@lists.infradead.org; Mon, 30 Apr 2007 22:11:51 -0400
Date: Tue, 1 May 2007 11:11:36 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Update the list information for kexec and kdump
Message-ID: <20070501021135.GC18364@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, fastboot@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Haren Myneni <hbabu@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, Eric Biederman <ebiederm@xmission.com>

There is a new list for kexec/kdump discussion.

Signed-off-by: Simon Horman <horms@verge.net.au>
Acked-by: Eric W. Biederman <ebiederm@xmission.com>

--- 
Update: osdl.org -> linux-foundation.org

Index: linux-2.6/MAINTAINERS
===================================================================
--- linux-2.6.orig/MAINTAINERS	2007-04-23 17:34:30.000000000 +0900
+++ linux-2.6/MAINTAINERS	2007-04-23 17:34:47.000000000 +0900
@@ -1951,7 +1951,7 @@ P:	Vivek Goyal
 M:	vgoyal@in.ibm.com
 P:	Haren Myneni
 M:	hbabu@us.ibm.com
-L:	fastboot@lists.linux-foundation.org
+L:	kexec@lists.infradead.org
 L:	linux-kernel@vger.kernel.org
 W:	http://lse.sourceforge.net/kdump/
 S:	Maintained
@@ -2001,7 +2001,7 @@ P:	Eric Biederman
 M:	ebiederm@xmission.com
 W:	http://www.xmission.com/~ebiederm/files/kexec/
 L:	linux-kernel@vger.kernel.org
-L:	fastboot@lists.linux-foundation.org
+L:	kexec@lists.infradead.org
 S:	Maintained
 
 KPROBES

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
