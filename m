Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I1RL7-0005M0-Js
	for kexec@lists.infradead.org; Thu, 21 Jun 2007 14:25:07 -0400
Date: Thu, 21 Jun 2007 20:24:41 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [IA64] [kdump] machveg=dig on hpzx1 platforms
Message-ID: <20070621182441.GA21840@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org, linux-ia64@vger.kernel.org
Cc: Terry Loftin <terry.loftin@hp.com>, Khalid Aziz <khalid_aziz@hp.com>

Hello,

on most HP machines, the 'machveg=dig' parameter is needed for the
kdump kernel to avoid problems with the HP ioc. In the original kdump
patches, a function ioc_iova_disable() was used, which (as I
understand) disabled the IOC before executing the new kernel. However,
that function wasn't added to mainline [2].

However, with a 2.6.22-rc kernel, booting into the kdump kernel works
surprisingly. I haven't found a fix in the git history that could be
responsible. Was there a fix? Or is it just a random result on a
machine I tested that it works?

Are there any plans to bring back ioc_iova_disable(), or would some
automatic kernel code that uses machvec=dig in the kernel without
forcing the user to pass an additional command line work?



Thanks,
   Bernhard

[1] http://article.gmane.org/gmane.linux.ports.ia64/15192
[2] http://article.gmane.org/gmane.linux.ports.ia64/15147


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
