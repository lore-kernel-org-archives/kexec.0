Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1LIqr8-0000Ie-Sp
	for kexec@lists.infradead.org; Fri, 02 Jan 2009 20:42:55 +0000
From: Milton Miller <miltonm@bga.com>
Message-Id: <kexec-29-1.miltonm@bga.com>
Subject: [PATCH 0/5 + 2] kexec updates
Date: Fri, 02 Jan 2009 14:42:38 -0600
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
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Cc: Michael Ellerman <michael@ellerman.id.au>, "M. Mohan Kumar" <mohan@in.ibm.com>, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>

Follwing this mail are 5 patches for kexec userspace and two for the
kernel.  The first fixes an array overflow and the second updates
userspace to the merged 2.6.28 kdump support.  The remaining are
cleanups and warning fixes, including one for the common code.

The two patchs for the kernel are independent.

milton


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
