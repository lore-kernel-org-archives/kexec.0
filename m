Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KON08-0007Uo-HN
	for kexec@lists.infradead.org; Thu, 31 Jul 2008 01:30:45 +0000
Message-Id: <20080731012208.115225969@vergenet.net>
Date: Thu, 31 Jul 2008 11:22:08 +1000
From: Simon Horman <horms@verge.net.au>
Subject: [patch 0/6] is_kdump_kernel() cleanup and related patches
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Hi,

this patch series contains all the patches (that I am aware of)
that have recently been posted regarding kdump and in particular
is_kdump_kernel()

For Andrew Morton's benefit I have annotated each patch as to whether it
needs to be included in 2.6.27 or not. My conclusion is that while
I would like to see all of the patches included in 2.6.27, none
of them are particularly dire, and thus they could all wait until
post-2.6.27.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
