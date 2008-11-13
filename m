Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L0aAI-0000uz-BZ
	for kexec@lists.infradead.org; Thu, 13 Nov 2008 11:15:10 +0000
Date: Thu, 13 Nov 2008 12:15:06 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] makedumpfile: Claim to support 2.6.27
Message-ID: <20081113121506.3a3b72b1@hale.suse.de>
In-Reply-To: <491BEE34.6070501@mxs.nes.nec.co.jp>
References: <109842e145d381000c4c.1226482968@hale.suse.de>
	<491BEE34.6070501@mxs.nes.nec.co.jp>
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
Cc: kexec@lists.infradead.org

* Ken'ichi Ohmichi [2008-11-13 18:07]:
> Bernhard Walle wrote:
> > According to the changelog and my tests, 2.6.27 kernel is supported. Express
> > that in the LATEST_VERSION check.
> 
> Thank your for your tests and your patch.
> I also tested makedumpfile on linux-2.6.27 of both i386 and x86_64,
> but I have not tested on ia64 yet.
> So I want to know the CPU architecture of your machine to fill the
> supporting table of makedumpfile's "README" file.

I tested on ia64 in that case.



Regards,
Bernhard
-- 
Bernhard Walle, SUSE Linux Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
