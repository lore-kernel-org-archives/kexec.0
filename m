Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jw7j7-0004LA-C3
	for kexec@lists.infradead.org; Wed, 14 May 2008 03:32:25 +0000
Subject: Re: [PATCH] kexec based hibernation: a prototype of kexec
	multi-stage load
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <20080514025607.GA19944@redhat.com>
References: <1210574441.30365.8.camel@caritas-dev.intel.com>
	<20080513053408.GA5870@redhat.com>
	<1210730266.23707.50.camel@caritas-dev.intel.com>
	<20080514025607.GA19944@redhat.com>
Date: Wed, 14 May 2008 11:37:55 +0800
Message-ID: <1210736275.23707.62.camel@caritas-dev.intel.com>
MIME-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>

On Tue, 2008-05-13 at 22:56 -0400, Vivek Goyal wrote:
[...]
> > 
> > > Last time I tried the patches (V9) and kexec jump did not work for me. I
> > > was not getting timer interrupts in second kernel. Then I had to put 
> > > LAPIC and IOAPIC in legacy mode and then at one way jump started working.
> > > I am not sure how the next kernel boots for you without putting APICs
> > > in legacy mode. (Yet to make returning back to original kernel work
> > > using V9). 
> > 
> > Can normal kexec (without kexec jump) works without putting LAPIC and
> > IOAPIC in legacy mode? Does this mean we should put LAPIC and IOAPIC
> > into legacy mode before kexec and restore them after?
> > 
> 
> We do put LAPIC and IOAPIC in legacy mode in normal kexec. Look at 
> disable_IO_APIC() in native_machine_shutdown(). So I think we shall
> have to do the same thing in kexec jump code too.

OK. I will look at this.

> I went through above mail thread again where we were discussing what all
> information need to be passed between kernels.
> 
> Last time we enumerated three things.
> 
> - kernel entry/re-entry point for switch between kernels.
> - backup pages map for core filtering
> - Probably ELF core notes for saving hibernated image.
> 
> I think if we just implement the functionality so that one can switch
> back and forth between kernels (no hibernated image saving),then we probably
> need to pass around only kernel entry/re-entry point and nothing else and in
> your patches I think you are already doing using %edi.

Yes.

> So, IMHO, for first simple implementation, we don't have to pass around
> any data between kernels except entry point. (Please correct me if I am 
> wrong). Lets get that implementation in first and then we can get rest
> of the pieces in place.

Yes. Kernel entry/re-entry point is the only information need to be
communicated between kernels for just switching between them. So we can
focus on kexec jump patch firstly.

Best Regards,
Huang Ying


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
