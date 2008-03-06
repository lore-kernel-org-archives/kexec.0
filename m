Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JXCrX-0007aO-M0
	for kexec@lists.infradead.org; Thu, 06 Mar 2008 09:58:07 +0000
Message-Id: <20080306094637.669665743@vergenet.net>
Date: Thu, 06 Mar 2008 18:46:37 +0900
From: Simon Horman <horms@verge.net.au>
Subject: [patch 00/12] Intention to merge mipsel into kexec-tools-testing
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
To: kexec@lists.infradead.org, linux-mips@linux-mips.org
Cc: Tomasz Chmielewski <mangoo@wpkg.org>, Francesco Chiechi <francesco.chiechi@colibre.it>

Hi,

Using qemu I have been able to satisfy myself that Francesco Chiechi's
patch to add mipsel to kexec-tools works.

I have upported this patch and made various cosmetic changes too it, as per
this series of patches. I intend to merge these patches.

One thing that clearly needs further work is the handling of the command
line passed to the second kernel. In preamble to his patch Francesco makes
mention that his patch uses elf boot nodes to pass the command line.
Inspection of the code reflects this.

However in my limited understanding this only supports a subset of mipsel
hardware. In particular, I notice that it does not use qemu. I wonder if
ultimately kexec-tools will need a --machine or --boot-protocol parameter
or something of that nature.

-- 
Horms

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
