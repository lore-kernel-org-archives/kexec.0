Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KONFa-0000jI-L2
	for kexec@lists.infradead.org; Thu, 31 Jul 2008 01:46:43 +0000
Message-Id: <4891197D.10400@mxs.nes.nec.co.jp>
Date: Thu, 31 Jul 2008 10:46:37 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: makedumpfile fails on SGI machine
References: <20080730161416.47605c30@halley.suse.de>
In-Reply-To: <20080730161416.47605c30@halley.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0483496299=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: Jay Lan <jlan@sgi.com>, kexec@lists.infradead.org

--===============0483496299==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Thank you for the report.

Bernhard Walle wrote:
> After debugging that, I didn't find an error code. That address is in
> fact the beginning of the mem_map of that node, and is in fact not
> mapped (I verified that in crash).
> 
> With an older kernel and an older makedumpfile it succeeds.

I'd like to know whether this problem is due to the makedumpfile
regression or either the unsupported kernel. Could you please
fill the following items ?

* Problematic condition
  kernel version: ?
  makedumpfile version: 1.2.7

* Successful condition
  kernel version: ?
  makedumpfile version: ?

And could you please test the combination of successful kernel
and problematic makedumpfile(1.2.7) ?


Thanks
Ken'ichi Ohmichi


--===============0483496299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0483496299==--
