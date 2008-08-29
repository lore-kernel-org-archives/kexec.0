Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KYyo8-00012u-56
	for kexec@lists.infradead.org; Fri, 29 Aug 2008 07:54:12 +0000
Date: Fri, 29 Aug 2008 09:54:08 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: How do i see printf output from the purgatory code?
Message-ID: <20080829095408.22f50a3f@halley.suse.de>
In-Reply-To: <20080829051907.GA25758@verge.net.au>
References: <48B73F4C.5030206@sgi.com>
	<20080829051907.GA25758@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: Jay Lan <jlan@sgi.com>, kexec@lists.infradead.org

Hi,

* Simon Horman [2008-08-29 15:19]:
>
> On Thu, Aug 28, 2008 at 05:14:04PM -0700, Jay Lan wrote:
> > Specifically, an ia64.
> > 
> > I added printf() to purgatory-ia64.c, compiled, and executed
> > the kexec command from a shell window (ie, not from a script), but
> > i still did not see the printf i put in.
> > 
> > Thanks for help in advance!
> 
> IIRC, the printf output in purgatory only shows on the VGA console.

No, you just have to call kexec with right parameters:

       --console-serial
              Enable the serial console.

       --serial=port
              Specify the serial port for debug output.

       --serial-baud=baud_rate
              Specify the baud rate of the serial port.

However, I don't know if it works on IA64, especially with SGI consoles
I think one would have to patch kexec.

Also, don't use --noio (which is the default on SUSE on IA64 because
we had problems on some machines without that parameter).


Bernhard
-- 
Bernhard Walle, SUSE Linux Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
