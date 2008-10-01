Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kl97T-0003wM-8M
	for kexec@lists.infradead.org; Wed, 01 Oct 2008 21:20:27 +0000
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [RFC] kexec support on Book-e, ppc32
Date: Wed,  1 Oct 2008 23:20:21 +0200
Message-Id: <1222896024-22172-1-git-send-email-sebastian@breakpoint.cc>
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
To: linuxppc-dev@ozlabs.org
Cc: kexec@lists.infradead.org

This is what I am currently using for kexec support on mpc8544 / Book-E.
The userland (patch #3) behaves similar to the ppc64 code. Purgatory is
available and the user can specify new device tree. In v2wrap.S the setup
of the stack is disabled. I'm not sure why but as soon as I enable it,
the kernel does not appear. I think that I'm loading the value from the
wrong address but the same code is working for the kernel entry point.

Patch #1 adds support for the kernel. I've extended the misc32 code
because I did not want to copy the move_page_code.

Patch #2 adds the required callbacks to platform code of 8544ds

Sebastian


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
