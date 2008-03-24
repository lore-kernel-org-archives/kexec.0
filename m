Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jdi3j-0003EO-QN
	for kexec@lists.infradead.org; Mon, 24 Mar 2008 08:29:36 +0000
Date: Mon, 24 Mar 2008 17:29:25 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec won't --load-panic a 2.6.22 relocatable kernel?
Message-ID: <20080324082924.GA26733@verge.net.au>
References: <170fa0d20803182305x3b16f7bt198d767a53553c8e@mail.gmail.com>
	<20080321053236.GA29330@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080321053236.GA29330@verge.net.au>
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
To: Mike Snitzer <snitzer@gmail.com>
Cc: kexec@lists.infradead.org

On Fri, Mar 21, 2008 at 02:32:36PM +0900, Simon Horman wrote:
> On Wed, Mar 19, 2008 at 02:05:46AM -0400, Mike Snitzer wrote:
> > I'm building a x86_64 2.6.22 kernel with the following options set:
> > 
> > CONFIG_KEXEC=y
> > CONFIG_CRASH_DUMP=y
> > CONFIG_RELOCATABLE=y
> > CONFIG_PHYSICAL_START=0x200000
> > 
> > If I try to load the kernel with the following I get:
> > 
> > ./kexec --args-linux -p '--command-line=ro root=LABEL=/1 rhgb quiet
> > irqpoll maxcpus=1' --initrd=/boot/initrd-2.6.22.19.img
> > /boot/vmlinuz-2.6.22.19
> > 
> > ./kexec: unrecognized option `--args-linux'
> > kexec-tools-testing 20080318-rc released 18th March 2008
> > Usage: kexec [OPTION]... [kernel]
> > ...
> > Cannot load /boot/vmlinuz-2.6.22.19
> 
> Hi Mike,
> 
> that looks a lot like a problem with kexec-tools parsing command line
> arguments to me. However I'm not having much luck reproducing it here.
> I'll poke a bit more.
> 
> Did you get kexec-tools-testing 20080318-rc as a tarball from
> kernel.org? I just want to make sure we are looking at the same code.

Sorry for being a bit slow, I have managed to reproduce the problem,
which is that --args-linux can't be used if the image is a bzImage.
Could you try with a vmlinux image instead?

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
