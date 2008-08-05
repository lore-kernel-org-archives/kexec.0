Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KQLsH-0002ey-4y
	for kexec@lists.infradead.org; Tue, 05 Aug 2008 12:42:49 +0000
Date: Tue, 5 Aug 2008 14:43:29 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Kdump compressed format
Message-ID: <20080805144329.559f4203@halley.suse.de>
In-Reply-To: <4897F177.2060106@mxs.nes.nec.co.jp>
References: <20080804135309.4ef6f33b@halley.suse.de>
	<4897F177.2060106@mxs.nes.nec.co.jp>
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
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

* Ken'ichi Ohmichi [2008-08-05 15:21]:
> Bernhard Walle wrote:
> > is there any documentation how the kdump compressed format (or the
> > diskdump format, from what it is derived) looks like? Beside of the
> > source code of the tools that support it. ;-)
> 
> The kdump compressed format is supported by only the crash utility
> and makedumpfile command. gdb does not support it. I think that
> there is not any documentation about the kdump compressed format,
> then I wrote it. Is it enough ?

Thanks a lot! Yes, that gives me the overview I needed.

I grabbed your information and generated a manual page from it where I
also want to describe the other dump formats (when I have some time
left):

   http://www.suse.de/~bwalle/kdump/

That's basically part of the SUSE kdump configuration, maintained in
http://freehg.org/u/bwalle/kdump/.

I just used asciidoc because I hate nroff. I hope it's ok for you to
distribute that manual page.

However, if you wonder, I didn't need that information for documentation
but for page size on PPC64 ... thanks again!



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
