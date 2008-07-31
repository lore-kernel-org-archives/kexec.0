Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KOTo7-00075F-KQ
	for kexec@lists.infradead.org; Thu, 31 Jul 2008 08:46:48 +0000
Date: Thu, 31 Jul 2008 10:47:26 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: makedumpfile fails on SGI machine
Message-ID: <20080731104726.035850be@halley.suse.de>
In-Reply-To: <4891197D.10400@mxs.nes.nec.co.jp>
References: <20080730161416.47605c30@halley.suse.de>
	<4891197D.10400@mxs.nes.nec.co.jp>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Jay Lan <jlan@sgi.com>, kexec@lists.infradead.org

* Ken'ichi Ohmichi [2008-07-31 10:46]:
> Bernhard Walle wrote:
> > After debugging that, I didn't find an error code. That address is in
> > fact the beginning of the mem_map of that node, and is in fact not
> > mapped (I verified that in crash).
> > 
> > With an older kernel and an older makedumpfile it succeeds.
> 
> I'd like to know whether this problem is due to the makedumpfile
> regression or either the unsupported kernel. Could you please
> fill the following items ?
 
* Problematic condition
  kernel version: 2.6.26
  makedumpfile version: 1.2.7

* Successful condition
  kernel version: 2.6.16.60 (SLES kernel)
  makedumpfile version: 1.1.4 (SLES 10 SP2 version, but in fact that is
                               1.1.4 although -v displays something
                               different ;-))

> And could you please test the combination of successful kernel
> and problematic makedumpfile(1.2.7) ?

That works. Seems to be some kernel change.



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
