Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dsl022.labridge.com ([206.117.136.22] helo=perches.com)
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IKTSJ-0005Q1-80
	for kexec@lists.infradead.org; Mon, 13 Aug 2007 07:31:13 +0100
Date: Sun, 12 Aug 2007 23:30:49 -0700
From: joe@perches.com
Subject: [PATCH] [281/2many] MAINTAINERS - KEXEC
Message-ID: <46bffa99.nQ27DQOgkKo2uOy+%joe@perches.com>
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
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index d9a53d9..71738bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2694,6 +2694,8 @@ W:	http://www.xmission.com/~ebiederm/files/kexec/
 L:	linux-kernel@vger.kernel.org
 L:	kexec@lists.infradead.org
 S:	Maintained
+F:	include/linux/kexec.h
+F:	kernel/kexec.c
 
 KPROBES
 P:	Prasanna S Panchamukhi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
