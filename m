Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RB6Ol-0003M4-CT
	for kexec@lists.infradead.org; Tue, 04 Oct 2011 14:55:12 +0000
Date: Tue, 4 Oct 2011 10:55:08 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec: load-preserve-context option on s390
Message-ID: <20111004145508.GC28306@redhat.com>
References: <1317042549.3157.9.camel@br98xy6r>
	<20110928235101.GB13684@verge.net.au>
	<20110929133209.GA25760@redhat.com>
	<1317303511.3494.2.camel@br98xy6r>
	<20110930160655.GD25891@redhat.com>
	<1317737226.15474.16.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1317737226.15474.16.camel@br98xy6r>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, ying.huang@intel.com

On Tue, Oct 04, 2011 at 04:07:06PM +0200, Michael Holzheu wrote:

[..]
> > Not sure why it is not working.
> 
> Hmmm, actually it is working. I somehow must have overlooked that
> before.
> 
> When I call kexec with --load-preserve-context - while not really
> knowing what I am doing here - I get the following:
> 
> # kexec -p /boot/vmlinuz --load-preserve-context --mem-min=0x10000
> --mem-max=0x100000000 
> 
> kexec_load failed: Invalid argument
> entry       = 0x10000 flags = 160002
> nr_segments = 2
> segment[0].buf   = 0x3fffc989010
> segment[0].bufsz = 330600
> segment[0].mem   = 0x10000
> segment[0].memsz = 331000
> segment[1].buf   = (nil)
> segment[1].bufsz = 0
> segment[1].mem   = 0x341000
> segment[1].memsz = 334be000
> 
> Perhaps a better error message could help here. But there are several
> possible reasons for getting EINVAL from kexec_load(). So probably we
> can't say "--load-preserve-context not supported by current kernel"
> every time we get EINVAL from kexec_load().
> 
> Not sure what to do here. Perhaps we just leave it as it is.

I am also not sure what can we do here. There are many cases where -EINVAL
can happen.

> 
> BTW: Is there any good documentation on KEXEC_PRESERVE_CONTEXT?

I am not aware of any and really wished there was one

Huang, is there any? Also is anybody using KEXEC_PRESERVE_CONTEXT? I have
not encountered any users yet.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
