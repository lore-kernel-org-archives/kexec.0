Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QoKXP-0000oI-Ak
	for kexec@lists.infradead.org; Tue, 02 Aug 2011 19:22:00 +0000
Date: Tue, 2 Aug 2011 15:21:47 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch v2 04/10] kdump: Trigger kdump via panic notifier chain
	on s390
Message-ID: <20110802192147.GJ6399@redhat.com>
References: <20110727125504.491183728@linux.vnet.ibm.com>
	<20110727125808.028895659@linux.vnet.ibm.com>
	<20110801204114.GJ3805@redhat.com>
	<1312274279.4881.18.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1312274279.4881.18.camel@br98xy6r>
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

On Tue, Aug 02, 2011 at 10:37:59AM +0200, Michael Holzheu wrote:
> Hello Vivek,
> 
> On Mon, 2011-08-01 at 16:41 -0400, Vivek Goyal wrote:
> > On Wed, Jul 27, 2011 at 02:55:08PM +0200, Michael Holzheu wrote:
> > > From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > > 
> > > On s390 we have the possibility to configure actions that are executed in
> > > case of a kernel panic. E.g. it is possible to automatically trigger an s390
> > > stand-alone dump. The actions are called via a panic notifier.  We also want
> > > to trigger kdump via the notifier call chain. Therefore this patch disables
> > > for s390 the direct kdump invocation in the panic() function.
> > 
> > Doesn't this reduce the reliability of the operation as you are assuming
> > that panic notifier list is fine and not corrupted.
> 
> Yes, this is correct. We have to rely that the notifier list is fine.
> Probably there is still room for improvement here.
> 
> > There might be other generic notifiers registerd on panic notifier list
> > too. So in your case, are there multiple subsystem registering for panic
> > notifiers? If not, why not call crash_kexec() directly. Are there any
> > other actions you want to take on panic then calling crash_kexec()?
> 
> We have added the panic notifier in the past in order to be able to
> configure the action that should be done in case of panic using our
> shutdown actions infrastructure. We can configure the action using sysfs
> and we are able to configure that a stand-alone dump should be started
> as action for panic.
> 
> Now with the two stage dump approach we would like to keep the
> possibility to trigger a stand-alone dump even if kdump is installed.
> The stand-alone dumper will be started in case of a kernel panic and
> then the procedure we discussed will happen: Jump into kdump and if
> program check occurs do stand-alone dump as backup.

Frankly speaking this jumping to stand alone kernel by default is not
making any sense to me. Once you have already determined from /sys that
in case of crash a user has set the action to kdump, then we should
simply call crash_kexec() like other architectures and jump to stand
alone kernel only if some piece of code is corrupted and that action
failed.

What's the point of jumping to stand alone kenrel in case of panic()
and then re-enter it back to original kernel using crash_kexec(). Sound
like a very odd design choice to me.

I am now I am repeating this question umpteen time simply because
I never got a good answer except "we have to do it this way".

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
