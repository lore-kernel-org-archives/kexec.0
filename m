Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.156.57] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MJfel-0004hp-HA
	for kexec@lists.infradead.org; Thu, 25 Jun 2009 03:29:54 +0000
Date: Wed, 24 Jun 2009 22:29:41 -0500
From: Robin Holt <holt@sgi.com>
Subject: Re: [PATCH 1/7] ia64, kdump: Mask MCA/INIT on freezing cpus
Message-ID: <20090625032941.GS6865@sgi.com>
References: <4A39E247.4030908@jp.fujitsu.com> <4A39E2CF.80901@jp.fujitsu.com>
	<20090622134557.GC7084@sgi.com> <4A4022EA.1020506@jp.fujitsu.com>
	<20090623055536.GE6865@sgi.com> <4A408D32.9010500@jp.fujitsu.com>
	<20090624111415.GA6878@sgi.com> <4A42DDDF.2000403@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4A42DDDF.2000403@jp.fujitsu.com>
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

Let's just leave it at you have an opinion of how things should be done
and I don't agree with that position.  If there are errors occurring
in hardware, disabling the MCA handler will do nothing but make the
kdump crash stall forever as the processor tries to consume bad data.
It also removes the ability to find out why things are broken in the event
that there are any errors in the kexec kernel which prevent the boot.
You have exceeded the amount of time I have to argue against your patches.

Good Luck,
Robin

On Thu, Jun 25, 2009 at 11:15:59AM +0900, Hidetoshi Seto wrote:
> Robin Holt wrote:
> > The concern is that any time we prevent SAL from receiving control during
> > an MCA/INIT, we reduce the maintainability of the machine.  Having them
> > masked at any time results in the NMI/INIT not recording the PROM record
> > which we use to diagnose where the hang is.
> 
> Think about servers which have no such PROM record features... Please?
> 
> The original problem here, which I wrote these patches for, is that the
> INIT can block retrieving crashdump via kdump.  The crashdump is the only
> record which we can use to diagnose where the hang is, if the PROM record
> like SGI servers have is not supported.
> (I guess the even the PROM record is supported, the crashdump is better,
>  more important resource for the trouble shooting.)
> 
> My patches will mask MCA/INIT on all CPUs once kdump is invoked (via
> panic or INIT), and soon unmask one of them who is going to jump in 2nd
> kernel (=kdump kernel) after registering a do-nothing handler.
> 
> If there was a pending INIT, it will be received on the cpu as soon as
> it is unmasked.  Then the PROM will make a record on it, pass the control
> to OS_INIT which does nothing, and return to interrupted context to
> continue processing the kdump.
> 
> What time point are you concerning?
> 
> 
> > In other patches, you implemented a do-nothing handler.  Could that
> > be used?
> 
> ... How?  Maybe I could not catch your point.
> 
> It would be useful, but it is only available from the beginning of 2nd
> kernel (to be exact, from the end of 1st kernel), until new INIT handlers
> for 2nd kernel is registered.
> 
> 
> > Alternatively, when the machine is first booted, the handler is defined
> > by SAL as a SAL routine.  Could you record that during kernel boot and
> > then just set the handler back to the SAL provided one prior to starting
> > the kexec kernel boot?  At that point, the machine is more like the
> > first boot.  Now that I think about this, this alternative seems fairly
> > attractive.
> 
> I think it is definitely wrong thing if SAL provides the initial handler
> as OS_INIT which can be removed/replaced by OS.
> 
> Since INIT event processes PAL_INIT -> SAL_INIT -> OS_INIT(if available),
> SAL should keep the entry point of its initial handler and should use it
> from SAL_INIT when OS_INIT is not registered.  Ditto to OS_MCA.
> 
> 
> Thanks,
> H.Seto

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
