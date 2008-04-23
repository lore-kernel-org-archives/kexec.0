Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JoaQD-0000G8-6Q
	for kexec@lists.infradead.org; Wed, 23 Apr 2008 08:33:45 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JoaQ8-0001fU-6Z
	for kexec@lists.infradead.org; Wed, 23 Apr 2008 08:33:40 +0000
Received: from charybdis-ext.suse.de ([195.135.221.2])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Wed, 23 Apr 2008 08:33:40 +0000
Received: from bwalle by charybdis-ext.suse.de with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Wed, 23 Apr 2008 08:33:40 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: kexec --real-mode
Date: Wed, 23 Apr 2008 10:34:00 +0200
Message-ID: <20080423103400.6e3d9d90@strauss.suse.de>
References: <20080422151622.43c85a00@strauss.suse.de>
	<e2ed954f0804221644y436bd6cdoeb1fed2fd5d04ccb@mail.gmail.com>
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
To: kexec@lists.infradead.org

* Jamey Sharp [2008-04-22 16:44]:
>
> On Tue, Apr 22, 2008 at 6:16 AM, Bernhard Walle <bwalle@suse.de> wrote:
> > did anybody try the --real-mode option with current release? I tried
> > it on two machines, and on one machine it just reboots, on the other
> > machine it hangs.
> 
> I think you're experiencing a bug that I just proposed a patch for. :-)
> You can confirm that: try adding the "--debug" option to your kexec
> call. If that works correctly, then I think you'll find that the patch
> in "[PATCH 2/9] Fix copy-paste bug: entry16 does not start at
> entry16_debug" will solve your problem. That's archived here:
> 
> http://lists.infradead.org/pipermail/kexec/2008-April/001581.html

No, I used --debug already.


	Bernhard



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
