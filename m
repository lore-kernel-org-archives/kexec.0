Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OeYbB-0005qZ-As
	for kexec@lists.infradead.org; Thu, 29 Jul 2010 19:16:57 +0000
Date: Thu, 29 Jul 2010 15:16:54 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: In place kexec
Message-ID: <20100729191654.GB28704@redhat.com>
References: <4C50A7AD.8040902@zytor.com> <m1y6cvtgd0.fsf@fess.ebiederm.org>
	<20100729134343.GA31490@shamino.rdu.redhat.com>
	<4C519853.2040206@zytor.com>
	<20100729150640.GF31490@shamino.rdu.redhat.com>
	<4C51BFA5.60507@zytor.com> <m1k4oe88n9.fsf@fess.ebiederm.org>
	<4C51C878.2090102@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4C51C878.2090102@zytor.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Neil Horman <nhorman@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-driver@qlogic.com, Andrew Vasquez <andrew.vasquez@qlogic.com>

On Thu, Jul 29, 2010 at 11:29:12AM -0700, H. Peter Anvin wrote:
> On 07/29/2010 11:06 AM, Eric W. Biederman wrote:
> > 
> > Thinking about this I am a bit surprised that you would find
> > DMA left on from a disk driver.  Historically disks have been
> > pretty good about shutting off in this scenario.
> > 
> > Added to that typically we unmount all filesystems.
> > 
> > Calling rmmod on the driver before the final kexec --exec
> > could be interesting, and drivers much more reliably implement
> > .remove than .shutdown.
> > 
> > Network drivers are more likely to be a problem, but we should be
> > downing all of the network interfaces before something happens.
> > 
> > All of which is to say kexec-in-place has generally been a lot
> > less hassle, because it is so similar to the normal case.
> > 
> 
> In particular, the supposed corruption comes from the "firmware logging"
> feature in the qla2xxx driver.  I'd really like to understand if this is
> a kexec problem or a qla2xxx problem.
> 	

kernel_kexec()
   kernel_restart_prepare()
	device_shutdown()

I would suspect it to be a qla2xxx driver problem that it did not shut
down the device properly.

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
