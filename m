Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]
	helo=TX2EHSOBE001.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OlxBh-00020U-NF
	for kexec@lists.infradead.org; Thu, 19 Aug 2010 04:57:14 +0000
From: Matthew McClintock <msm@freescale.com>
Subject: [PATCH v2 0/3] Misc. bug fixes for ppc32
Date: Wed, 18 Aug 2010 23:56:48 -0500
Message-ID: <1282193811-23098-1-git-send-email-msm@freescale.com>
In-Reply-To: <20100819042023.GC13965@verge.net.au>
References: <20100819042023.GC13965@verge.net.au>
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
Cc: muvarov@gmail.com, linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, Matthew McClintock <msm@freescale.com>

This patch series fixes a few issues I have discovered with my previous
patch series. Nothing new has been added.

v2: Missed signoff, removed initializing variable twice

Matthew McClintock (3):
  Ramdisk address was not copied correctly on kexec'ed kernel
  Prevent multiple reservations for cpu-release-addr
  Prevent initrd-start and initrd-end from appearing multiple times

 kexec/arch/ppc/fixup_dtb.c |   50 ++++++++++++++++++++++++-------------------
 kexec/arch/ppc/kexec-ppc.c |    2 +-
 2 files changed, 29 insertions(+), 23 deletions(-)



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
