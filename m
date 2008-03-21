Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wf-out-1314.google.com ([209.85.200.173])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jcr4C-0000tJ-Au
	for kexec@lists.infradead.org; Fri, 21 Mar 2008 23:54:32 +0000
Received: by wf-out-1314.google.com with SMTP id 29so1809860wff.24
	for <kexec@lists.infradead.org>; Fri, 21 Mar 2008 16:54:30 -0700 (PDT)
Message-ID: <170fa0d20803211654t77b988f3p94868b870c827a1a@mail.gmail.com>
Date: Fri, 21 Mar 2008 19:54:30 -0400
From: "Mike Snitzer" <snitzer@gmail.com>
Subject: Re: kexec won't --load-panic a 2.6.22 relocatable kernel?
In-Reply-To: <20080321053236.GA29330@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
References: <170fa0d20803182305x3b16f7bt198d767a53553c8e@mail.gmail.com>
	<20080321053236.GA29330@verge.net.au>
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

On Fri, Mar 21, 2008 at 1:32 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Mar 19, 2008 at 02:05:46AM -0400, Mike Snitzer wrote:
>  > I'm building a x86_64 2.6.22 kernel with the following options set:
>  >
>  > CONFIG_KEXEC=y
>  > CONFIG_CRASH_DUMP=y
>  > CONFIG_RELOCATABLE=y
>  > CONFIG_PHYSICAL_START=0x200000
>  >
>  > If I try to load the kernel with the following I get:
>  >
>  > ./kexec --args-linux -p '--command-line=ro root=LABEL=/1 rhgb quiet
>  > irqpoll maxcpus=1' --initrd=/boot/initrd-2.6.22.19.img
>  > /boot/vmlinuz-2.6.22.19
>  >
>  > ./kexec: unrecognized option `--args-linux'
>  > kexec-tools-testing 20080318-rc released 18th March 2008
>  > Usage: kexec [OPTION]... [kernel]
>  > ...
>  > Cannot load /boot/vmlinuz-2.6.22.19
>
>  Hi Mike,
>
>  that looks a lot like a problem with kexec-tools parsing command line
>  arguments to me. However I'm not having much luck reproducing it here.
>  I'll poke a bit more.

I agree it does look like a parsing bug but if I use the same
commandline with a different kernel (e.g. RHEL5's kernel) kexec
doesn't error out.

>  Did you get kexec-tools-testing 20080318-rc as a tarball from
>  kernel.org? I just want to make sure we are looking at the same code.

Yes, I got 20080318-rc from kernel.org.

I can provide the problematic vmlinuz offlist if you'd like.  I've not
yet had a chance to trace kexec with gdb and really dig into this
issue.

Mike

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
