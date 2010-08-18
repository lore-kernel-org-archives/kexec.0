Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Oli42-0001iQ-38
	for kexec@lists.infradead.org; Wed, 18 Aug 2010 12:48:19 +0000
Date: Wed, 18 Aug 2010 21:48:13 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch] MAINTAINERS: kexec-tools has moved
Message-ID: <20100818124813.GK9073@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>

Kexec tools has been moved to http://kernel.org/pub/linux/utils/kernel/kexec/
as user-space code shouldn't be in /pub/linux/kernel

Signed-off-by: Simon Horman <horms@verge.net.au>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

--- 

Andrew, can you push this?

Index: linux-2.6/MAINTAINERS
===================================================================
--- linux-2.6.orig/MAINTAINERS	2010-07-29 13:10:04.000000000 +0900
+++ linux-2.6/MAINTAINERS	2010-07-29 13:11:40.000000000 +0900
@@ -3334,7 +3334,7 @@ F:	drivers/s390/kvm/
 
 KEXEC
 M:	Eric Biederman <ebiederm@xmission.com>
-W:	http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/
+W:	http://kernel.org/pub/linux/utils/kernel/kexec/
 L:	kexec@lists.infradead.org
 S:	Maintained
 F:	include/linux/kexec.h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
