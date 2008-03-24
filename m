Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wr-out-0506.google.com ([64.233.184.229])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JdnVC-00009l-Ge
	for kexec@lists.infradead.org; Mon, 24 Mar 2008 14:18:18 +0000
Received: by wr-out-0506.google.com with SMTP id c46so2536149wra.18
	for <kexec@lists.infradead.org>; Mon, 24 Mar 2008 07:18:16 -0700 (PDT)
Message-ID: <170fa0d20803240718p3b0d20cbga6c0d4f34af63125@mail.gmail.com>
Date: Mon, 24 Mar 2008 10:18:15 -0400
From: "Mike Snitzer" <snitzer@gmail.com>
Subject: Re: kexec won't --load-panic a 2.6.22 relocatable kernel?
In-Reply-To: <20080324082924.GA26733@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
References: <170fa0d20803182305x3b16f7bt198d767a53553c8e@mail.gmail.com>
	<20080321053236.GA29330@verge.net.au>
	<20080324082924.GA26733@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On Mon, Mar 24, 2008 at 4:29 AM, Simon Horman <horms@verge.net.au> wrote:
>
> On Fri, Mar 21, 2008 at 02:32:36PM +0900, Simon Horman wrote:
>  > On Wed, Mar 19, 2008 at 02:05:46AM -0400, Mike Snitzer wrote:
>  > > I'm building a x86_64 2.6.22 kernel with the following options set:
>  > >
>  > > CONFIG_KEXEC=y
>  > > CONFIG_CRASH_DUMP=y
>  > > CONFIG_RELOCATABLE=y
>  > > CONFIG_PHYSICAL_START=0x200000
>  > >
>  > > If I try to load the kernel with the following I get:
>  > >
>  > > ./kexec --args-linux -p '--command-line=ro root=LABEL=/1 rhgb quiet
>  > > irqpoll maxcpus=1' --initrd=/boot/initrd-2.6.22.19.img
>  > > /boot/vmlinuz-2.6.22.19
>  > >
>  > > ./kexec: unrecognized option `--args-linux'
>  > > kexec-tools-testing 20080318-rc released 18th March 2008
>  > > Usage: kexec [OPTION]... [kernel]
>  > > ...
>  > > Cannot load /boot/vmlinuz-2.6.22.19
>  >
>  > Hi Mike,
>  >
>  > that looks a lot like a problem with kexec-tools parsing command line
>  > arguments to me. However I'm not having much luck reproducing it here.
>  > I'll poke a bit more.
>  >
>  > Did you get kexec-tools-testing 20080318-rc as a tarball from
>  > kernel.org? I just want to make sure we are looking at the same code.
>
>  Sorry for being a bit slow, I have managed to reproduce the problem,
>  which is that --args-linux can't be used if the image is a bzImage.
>  Could you try with a vmlinux image instead?

Interesting, makes sense.

Sure enough RedHat's image is a "ELF 64-bit LSB shared object" and a
vmlinux is "ELF 64-bit LSB executable".

I wonder how RedHat gets their kernel image to be an ELF image?

Mike

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
