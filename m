Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from chamillionaire.breakpoint.cc ([85.10.199.196])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NwtDw-0002uN-Ep
	for kexec@lists.infradead.org; Wed, 31 Mar 2010 08:24:29 +0000
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: PPC32 kexec v3
Date: Wed, 31 Mar 2010 10:24:11 +0200
Message-Id: <1270023858-26947-1-git-send-email-sebastian@breakpoint.cc>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

Hi Simon,

sorry for the delay. I broke something and wanted to make sure that
whatever I sent is working.
I'm sending the whole series which should be bisectable and care about
HAVE_LIBZ.
Patch 6 splits my uImage handling and 7 reuses it for SH and ARM. This is
only compile tested for ARM. The only benefit is that with libz it will
be crc32 tested.

The whole series is also at
  git://git.breakpoint.cc/bigeasy/kexec-tools.git ppc32

Sebastian


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
