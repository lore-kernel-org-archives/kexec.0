Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QoAUJ-0000Z5-8Q
	for kexec@lists.infradead.org; Tue, 02 Aug 2011 08:38:08 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p728c0HZ008210
	for <kexec@lists.infradead.org>; Tue, 2 Aug 2011 08:38:00 GMT
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
	[9.149.37.251])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p728c0Vw2121834
	for <kexec@lists.infradead.org>; Tue, 2 Aug 2011 09:38:00 +0100
Received: from d06av10.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av10.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p728bxVu001798
	for <kexec@lists.infradead.org>; Tue, 2 Aug 2011 02:38:00 -0600
Subject: Re: [patch v2 04/10] kdump: Trigger kdump via panic notifier chain
	on s390
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110801204114.GJ3805@redhat.com>
References: <20110727125504.491183728@linux.vnet.ibm.com>
	<20110727125808.028895659@linux.vnet.ibm.com>
	<20110801204114.GJ3805@redhat.com>
Date: Tue, 02 Aug 2011 10:37:59 +0200
Message-ID: <1312274279.4881.18.camel@br98xy6r>
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

On Mon, 2011-08-01 at 16:41 -0400, Vivek Goyal wrote:
> On Wed, Jul 27, 2011 at 02:55:08PM +0200, Michael Holzheu wrote:
> > From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > 
> > On s390 we have the possibility to configure actions that are executed in
> > case of a kernel panic. E.g. it is possible to automatically trigger an s390
> > stand-alone dump. The actions are called via a panic notifier.  We also want
> > to trigger kdump via the notifier call chain. Therefore this patch disables
> > for s390 the direct kdump invocation in the panic() function.
> 
> Doesn't this reduce the reliability of the operation as you are assuming
> that panic notifier list is fine and not corrupted.

Yes, this is correct. We have to rely that the notifier list is fine.
Probably there is still room for improvement here.

> There might be other generic notifiers registerd on panic notifier list
> too. So in your case, are there multiple subsystem registering for panic
> notifiers? If not, why not call crash_kexec() directly. Are there any
> other actions you want to take on panic then calling crash_kexec()?

We have added the panic notifier in the past in order to be able to
configure the action that should be done in case of panic using our
shutdown actions infrastructure. We can configure the action using sysfs
and we are able to configure that a stand-alone dump should be started
as action for panic.

Now with the two stage dump approach we would like to keep the
possibility to trigger a stand-alone dump even if kdump is installed.
The stand-alone dumper will be started in case of a kernel panic and
then the procedure we discussed will happen: Jump into kdump and if
program check occurs do stand-alone dump as backup.

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
