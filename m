Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]
	helo=TX2EHSOBE008.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OlpN0-0006cI-5I
	for kexec@lists.infradead.org; Wed, 18 Aug 2010 20:36:22 +0000
From: Matthew McClintock <msm@freescale.com>
Subject: [PATCH 0/3] Misc. bug fixes for ppc32
Date: Wed, 18 Aug 2010 15:35:23 -0500
Message-ID: <1282163726-21186-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: muvarov@gmail.com, Matthew McClintock <msm@freescale.com>, Kumar Gala <kumar.gala@freescale.com>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

This patch series fixes a few issues I have discovered with my previous
patch series. Nothing new has been added.

Matthew McClintock (3):
  Ramdisk address was not copied correctly on kexec'ed kernel
  Prevent multiple reservations for cpu-release-addr
  Prevent initrd-start and initrd-end from appearing multiple times

 kexec/arch/ppc/fixup_dtb.c |   51 +++++++++++++++++++++++++-------------------
 kexec/arch/ppc/kexec-ppc.c |    2 +-
 2 files changed, 30 insertions(+), 23 deletions(-)



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
