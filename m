Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TmfqI-00017T-OM
 for kexec@lists.infradead.org; Sun, 23 Dec 2012 07:19:28 +0000
Received: from joe.kanocho.kobe.vergenet.net (124-149-116-59.dyn.iinet.net.au
 [124.149.116.59])
 by kirsty.vergenet.net (Postfix) with ESMTP id A6364266CE0
 for <kexec@lists.infradead.org>; Sun, 23 Dec 2012 18:19:23 +1100 (EST)
From: Simon Horman <horms@verge.net.au>
Subject: Build Cleanup and Fixes
Date: Sun, 23 Dec 2012 16:19:15 +0900
Message-Id: <1356247158-9671-1-git-send-email-horms@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
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

Hi,

I have applied this small series of patches to clean up the
build system a little.

----------------------------------------------------------------
The following changes since commit c30e0bbd021b5744532fb8555bd4d4bbf8a00a04:

  kexec-zImage-arm: simply cmdline-related DTB resizing (2012-12-23 13:20:39 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git master

for you to fetch changes up to 3af8bee323bfb7894e760ac32f18e3ef082b2c5b:

  build: Restrict scope of per-arch compiler flags (2012-12-23 16:10:00 +0900)

----------------------------------------------------------------
Simon Horman (3):
      die: Use const for fmt
      build: Use cross compiler's strip if available
      build: Restrict scope of per-arch compiler flags

 Makefile.in             |    5 +++--
 configure.ac            |    2 +-
 kexec/arch/arm/Makefile |    2 +-
 kexec/arch/ppc/Makefile |    4 ++--
 kexec/kexec.c           |    2 +-
 kexec/kexec.h           |    2 +-
 6 files changed, 9 insertions(+), 8 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
