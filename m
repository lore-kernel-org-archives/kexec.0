Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KYbsi-0005M3-8u
	for kexec@lists.infradead.org; Thu, 28 Aug 2008 07:25:24 +0000
Date: Thu, 28 Aug 2008 09:25:19 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: makedumpfile fails on SGI machine
Message-ID: <20080828092519.5d2d8838@halley.suse.de>
In-Reply-To: <48B602CF.5040809@sgi.com>
References: <20080730161416.47605c30@halley.suse.de>
	<4891197D.10400@mxs.nes.nec.co.jp>
	<20080731104726.035850be@halley.suse.de>
	<48919306.80103@mxs.nes.nec.co.jp>
	<20080731131823.3c7c97b2@halley.suse.de>
	<4891A3CB.9040805@mxs.nes.nec.co.jp>
	<48984275.5070409@mxs.nes.nec.co.jp>
	<20080805171143.773c2465@halley.suse.de>
	<48A9228A.3070005@mxs.nes.nec.co.jp>
	<20080818130025.0282e471@halley.suse.de>
	<48B517A2.5010508@mxs.nes.nec.co.jp> <48B602CF.5040809@sgi.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, kexec@lists.infradead.org

Hi Ken'ichi Ohmichi,

* Jay Lan [2008-08-27 18:43]:
> 
> Thanks for your patch!
> 
> I am wondering if the discontigmem kernel has a legitimate bug,
> we probably should report it?
> 
> I tested your patch on a machine that used to fail in executing
> 'makedumpfile'. It now generated a dump file fine.

thanks for the patch, I can also report that with the patch and with
vmlinux it works now. However, shouldn't we add that vmem_map to
VMCOREINFO of the kernel?

Thanks also Jay for testing!


Bernhard
-- 
Bernhard Walle, SUSE Linux Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
