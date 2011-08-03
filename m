Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QoY6A-0007Wg-AU
	for kexec@lists.infradead.org; Wed, 03 Aug 2011 09:50:47 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p739ofI2013995
	for <kexec@lists.infradead.org>; Wed, 3 Aug 2011 09:50:41 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p739offP2347030
	for <kexec@lists.infradead.org>; Wed, 3 Aug 2011 10:50:41 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p739oeTt030723
	for <kexec@lists.infradead.org>; Wed, 3 Aug 2011 03:50:40 -0600
Subject: Re: [patch v2 04/10] kdump: Trigger kdump via panic notifier chain
	on s390
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110802192147.GJ6399@redhat.com>
References: <20110727125504.491183728@linux.vnet.ibm.com>
	<20110727125808.028895659@linux.vnet.ibm.com>
	<20110801204114.GJ3805@redhat.com> <1312274279.4881.18.camel@br98xy6r>
	<20110802192147.GJ6399@redhat.com>
Date: Wed, 03 Aug 2011 11:50:39 +0200
Message-ID: <1312365039.3783.36.camel@br98xy6r>
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

Hello Vivek,

On Tue, 2011-08-02 at 15:21 -0400, Vivek Goyal wrote:
> > We have added the panic notifier in the past in order to be able to
> > configure the action that should be done in case of panic using our
> > shutdown actions infrastructure. We can configure the action using sysfs
> > and we are able to configure that a stand-alone dump should be started
> > as action for panic.
> > 
> > Now with the two stage dump approach we would like to keep the
> > possibility to trigger a stand-alone dump even if kdump is installed.
> > The stand-alone dumper will be started in case of a kernel panic and
> > then the procedure we discussed will happen: Jump into kdump and if
> > program check occurs do stand-alone dump as backup.
> 
> Frankly speaking this jumping to stand alone kernel by default is not
> making any sense to me. Once you have already determined from /sys that
> in case of crash a user has set the action to kdump, then we should
> simply call crash_kexec()

If the user has set the panic action to kdump, we jump directly to
crash_kexec(). This then works like on all other architectures.

Only if the user has specified panic action stand-alone dump, we do the
detour via the stand-alone dump tools.

> like other architectures and jump to stand
> alone kernel only if some piece of code is corrupted and that action
> failed.
> 
> What's the point of jumping to stand alone kenrel in case of panic()
> and then re-enter it back to original kernel using crash_kexec(). Sound
> like a very odd design choice to me.
> 
> I am now I am repeating this question umpteen time simply because
> I never got a good answer except "we have to do it this way".

Sometimes communication is really hard and frustrating.
... but at least we are still communicating.

Ok very last try:

* We can use the same mechanism for manual dump and automatic dump on
panic: IPL the stand-alone dump tools. kdump check and backup
stand-alone dump is implemented only in the stand-alone dump code. If we
would do it like you suggested, we would have to do it twice - in the
kernel and in the stand-alone dump tools:
- kernel: Try kdump and if kdump fails trigger standalone dump tool
- Stand-alone dump tool: Try kdump and if kdump fails do full dump

* Still the panic action is configured via sysfs as the user is already
used to on s390.

* It fits much better into our whole s390 infrastructure. Believe me, we
have discussed that here a long time. I think you do not have a full
overview here. Perhaps you just have to believe that.

Michael



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
