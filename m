Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([203.10.76.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J4Y7b-0008Do-Ok
	for kexec@lists.infradead.org; Tue, 18 Dec 2007 08:48:30 +0000
MIME-Version: 1.0
Subject: [PATCH 0/8] kexec build system updates, to allow cross-kexec()ing
Message-Id: <1197967675.854275.930419561848.0.gpush@pokey>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 18 Dec 2007 17:47:55 +0900
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
To: kexec@lists.infradead.org

Hi all,

This series of patches is aimed at simplifying the kexec build system,
mainly in order to make cross-compilation much easier.

As well as cross-compiling, this makes it possible to separate the
'host' architecture (ie, the arch of the kexec binary built), and the
'target' architecture (ie, the arch of the kernel that we're kexecing).
We can specify these with the standard --host and --target arguments
to configure.

This allows us to kexec a powerpc64 kernel from a powerpc userspace.
x86{,_64} users might find this handy too, but I don't have hardware
to test.

Any comments are most welcome - if you're able to test on your
arch, that would be great too.

Cheers,


Jeremy

---
David Woodhouse (1):
      Enable building a 32 bit binary for ppc64 platforms.

Jeremy Kerr (6):
      Use --target for target architecture specification
      Consolidate BOOTLOADER defines
      Use config.h for defines
      Add gamecube to config.h defines
      Build system simplification/standardisation
      Don't assume we can re-make Makefile

Simon Horman (1):
      removed partially duplicated system headers


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
