Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JUJmV-0002XR-Al
	for kexec@lists.infradead.org; Wed, 27 Feb 2008 10:44:59 +0000
Message-Id: <20080227103536.406746333@vergenet.net>
Date: Wed, 27 Feb 2008 19:35:36 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 0/7] kexec-tools: mipsel port
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
To: Tomasz Chmielewski <mangoo@wpkg.org>, Francesco Chiechi <francesco.chiechi@colibre.it>
Cc: kexec@lists.infradead.org

Hi,

After some recent questions by Tomasz Chmielewski I have dug up
the mipsel port of kexec-tool and up-ported it to the lastest
release of kexec-tools-testing, v20080227

  ftp://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/
  http://lists.infradead.org/pipermail/kexec/2008-February/001346.html

I have just looked over the code and fixed up trivial errors
to the point where it builds (using a cross-compiler). This
mostly involved rediffing and updating Makefiles for recent
build changes. Along the way I removed some unused variables and
things like that.

I have not tested the code beyond making sure it builds - mainly
because I do not have any mipsel hardware. I will see about using
quemu, but it may take me a while to get a kernel and user-space
up and running as I have not used mipsel before.

On the code itself, the most glaring problem is the use
of "#ifdef __MIPSEL__". That code needs to be moved into
kexec/arch/mips or some similar location.

I would really appreciate it if someone could test this code.
And I would appreciate it even more if someone could help
fix it up to a mergable state. Or alternatively, point me in
the right direction to find people who want to help with this.

I am more than happy to merge the code once it is clean and working.

Have fun

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
