Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MJQQm-0007CL-Na
	for kexec@lists.infradead.org; Wed, 24 Jun 2009 11:14:27 +0000
Date: Wed, 24 Jun 2009 06:14:15 -0500
From: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH 1/7] ia64, kdump: Mask MCA/INIT on freezing cpus
Message-ID: <20090624111415.GA6878@sgi.com>
References: <4A39E247.4030908@jp.fujitsu.com> <4A39E2CF.80901@jp.fujitsu.com>
	<20090622134557.GC7084@sgi.com> <4A4022EA.1020506@jp.fujitsu.com>
	<20090623055536.GE6865@sgi.com> <4A408D32.9010500@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4A408D32.9010500@jp.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-ia64@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>, Robin Holt <holt@sgi.com>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Jun 23, 2009 at 05:07:14PM +0900, Hidetoshi Seto wrote:
> Robin Holt wrote:
> > On Tue, Jun 23, 2009 at 09:33:46AM +0900, Hidetoshi Seto wrote:
> >> Robin Holt wrote:
> > ...
> >> Do you mean that the 2nd kernel should be able to handle MCA/INIT from its
> >> boot up?  I guess the word PROM is nearly equal to PAL/SAL firmware, if so
> >> then I don't think there are good generic interface/procedure could be
> >> useful here.  Do you have any concrete idea?
> > 
> > No concrete ideas.  Just a really uneasy feeling whenever the INIT
> > is disabled.
> 
> Don't worry, don't be afraid.
> Again, my patches don't disable INIT until kdump is invoked.
> (And if kdump is invoked via INIT, it have already masked at the begging
>  of INIT handlers.)

The concern is that any time we prevent SAL from receiving control during
an MCA/INIT, we reduce the maintainability of the machine.  Having them
masked at any time results in the NMI/INIT not recording the PROM record
which we use to diagnose where the hang is.

In other patches, you implemented a do-nothing handler.  Could that
be used?

Alternatively, when the machine is first booted, the handler is defined
by SAL as a SAL routine.  Could you record that during kernel boot and
then just set the handler back to the SAL provided one prior to starting
the kexec kernel boot?  At that point, the machine is more like the
first boot.  Now that I think about this, this alternative seems fairly
attractive.

Thanks,
Robin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
