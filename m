Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate2.uk.ibm.com ([194.196.100.162])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RB5eR-0002yY-CX
	for kexec@lists.infradead.org; Tue, 04 Oct 2011 14:07:20 +0000
Received: from d06nrmr1806.portsmouth.uk.ibm.com
	(d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p94E7BRt010356
	for <kexec@lists.infradead.org>; Tue, 4 Oct 2011 14:07:11 GMT
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p94E7B3c2564142
	for <kexec@lists.infradead.org>; Tue, 4 Oct 2011 15:07:11 +0100
Received: from d06av09.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p94E76XR019623
	for <kexec@lists.infradead.org>; Tue, 4 Oct 2011 08:07:07 -0600
Subject: Re: kexec: load-preserve-context option on s390
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110930160655.GD25891@redhat.com>
References: <1317042549.3157.9.camel@br98xy6r>
	<20110928235101.GB13684@verge.net.au>
	<20110929133209.GA25760@redhat.com>
	<1317303511.3494.2.camel@br98xy6r> <20110930160655.GD25891@redhat.com>
Date: Tue, 04 Oct 2011 16:07:06 +0200
Message-ID: <1317737226.15474.16.camel@br98xy6r>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, ying.huang@intel.com

Hello Vivek,

On Fri, 2011-09-30 at 12:06 -0400, Vivek Goyal wrote:
> On Thu, Sep 29, 2011 at 03:38:31PM +0200, Michael Holzheu wrote:
> > Hello Vivec,
> 
> Right spelling is "Vivek" and not "Vivec" :-)

I know... and I really wanted to avoid that error. But somehow the "c"
is always coming automatically :-)

> [..]
> > > Shouldn't kexec system call return error if KEXEC_JUMP is not supported
> > > and user asked for it?
> > 
> > I think currently not. I assume that we should check the
> > KEXEC_PRESERVE_CONTEXT flag in the kexec_load system call.
> > 
> 
> Shouldn't following existing code take care of this already?
> 
>         /*
>          * Verify we have a legal set of flags
>          * This leaves us room for future extensions.
>          */
>         if ((flags & KEXEC_FLAGS) != (flags & ~KEXEC_ARCH_MASK))
>                 return -EINVAL;
> 
> In include/linux/kexec.h, we have following.
> 
> /* List of defined/legal kexec flags */
> #ifndef CONFIG_KEXEC_JUMP
> #define KEXEC_FLAGS    KEXEC_ON_CRASH
> #else
> #define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)
> #endif
> 
> Not sure why it is not working.

Hmmm, actually it is working. I somehow must have overlooked that
before.

When I call kexec with --load-preserve-context - while not really
knowing what I am doing here - I get the following:

# kexec -p /boot/vmlinuz --load-preserve-context --mem-min=0x10000
--mem-max=0x100000000 

kexec_load failed: Invalid argument
entry       = 0x10000 flags = 160002
nr_segments = 2
segment[0].buf   = 0x3fffc989010
segment[0].bufsz = 330600
segment[0].mem   = 0x10000
segment[0].memsz = 331000
segment[1].buf   = (nil)
segment[1].bufsz = 0
segment[1].mem   = 0x341000
segment[1].memsz = 334be000

Perhaps a better error message could help here. But there are several
possible reasons for getting EINVAL from kexec_load(). So probably we
can't say "--load-preserve-context not supported by current kernel"
every time we get EINVAL from kexec_load().

Not sure what to do here. Perhaps we just leave it as it is.

BTW: Is there any good documentation on KEXEC_PRESERVE_CONTEXT?

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
