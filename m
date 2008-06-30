Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KDHjB-0001fm-LH
	for kexec@lists.infradead.org; Mon, 30 Jun 2008 11:39:26 +0000
Date: Mon, 30 Jun 2008 13:40:01 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Fix vmcoreinfo generation on 32bit hosts for 64bit kernels
Message-ID: <20080630134001.4c0dfc0c@halley.suse.de>
In-Reply-To: <486837DB.8020405@mxs.nes.nec.co.jp>
References: <20080626124731.GA24365@suse.de>
	<48645B6C.1070608@mxs.nes.nec.co.jp>
	<20080627131701.5ab66b5a@halley.suse.de>
	<486837DB.8020405@mxs.nes.nec.co.jp>
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
Cc: kexec-ml <kexec@lists.infradead.org>

* Ken'ichi Ohmichi [2008-06-30 10:33]:
> > 
> > No, not directly. We still ship the makedumpfile.config. Yes, we plan
> > to switch to /proc/vmcore vmcoreinfo for next release (SLES 11).
> > 
> > I'll test your patch on PPC and give feedback!
> 
> Sounds good to me :-)

Sorry, cannot test because kdump is currently broken in our kernel on
PPC64. Don't know why, we're investigating ...



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
