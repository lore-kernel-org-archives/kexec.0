Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hr7Rf-0005ZZ-D3
	for kexec@lists.infradead.org; Thu, 24 May 2007 03:09:13 -0400
Date: Thu, 24 May 2007 09:09:08 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] [makedumpfile] Follow debuginfo link of vmlinux file
Message-ID: <20070524070908.GC15395@suse.de>
References: <20070501133912.GA8247@suse.de>
	<20070524093556oomichi@mail.jp.nec.com>
	<20070524065459.GB15395@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070524065459.GB15395@suse.de>
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
To: kexec@lists.infradead.org
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>

* Bernhard Walle <bwalle@suse.de> [2007-05-24 08:54]:
> * Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-05-24 02:35]:
> > 2007/05/01 15:39:12 +0200, Bernhard Walle <bwalle@suse.de> wrote:
> > >This patch implements support for following the debug information link in the
> > >.gnu_debuginfo section if the specified binary contains one. That makes it
> > >possible to call makedumpfile with -x /boot/vmlinux-<version> on distributions
> > >that ship extra -debuginfo packages for the kernel.
> > 
> > Isn't it good to specify the debuginfo file directly instead of your patch ?
> > I confirmed that makedumpfile without your patch can run by specifying the
> > debuginfo file directly.
> 
> But it needs program headers, right?

After reading the source code again I don't think so.

While I like the idea of following the .gnu_debuglink more I can also
accept your decision that the user has to specify the debug info file
manually.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
