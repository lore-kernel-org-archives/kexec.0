Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QjdJw-0001JK-79
	for kexec@lists.infradead.org; Wed, 20 Jul 2011 20:24:40 +0000
Date: Wed, 20 Jul 2011 16:24:29 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
Message-ID: <20110720202429.GE10079@redhat.com>
References: <20110715143820.GG3428@redhat.com>
	<1310744603.10789.79.camel@br98xy6r>
	<20110718123140.GB31986@redhat.com>
	<1310997641.4427.10.camel@br98xy6r>
	<20110718141943.GE31986@redhat.com>
	<1311000253.4427.23.camel@br98xy6r>
	<20110718152532.GF31986@redhat.com>
	<1311012188.4427.58.camel@br98xy6r>
	<20110719150423.GA7001@redhat.com>
	<1311154115.3829.17.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1311154115.3829.17.camel@br98xy6r>
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, kexec@lists.infradead.org

On Wed, Jul 20, 2011 at 11:28:35AM +0200, Michael Holzheu wrote:

[..]
> > > What you as kdump framework maintainer would have to accept with this
> > > solution is that it is allowed now to start kdump directly via purgatory
> > > without using code from the old kernel (e.g. crash_kexec). This has as
> > > implication that all things that the old kernel has to initialize for
> > > kdump has to be done before the system crashes. Currently this is only
> > > the initialization of vmcoreinfo.
> > 
> > when would you save vmcoreinfo? I guess I shall have to look at the
> > patches.
> 
> patch #4: We have to save vmcoreinfo at startup time of the production
> kernel.
> 
> Perhaps it would be best to send you a new patch series with our latest
> proposal.

This patch 4 looks reasonable. So you will prepare notes after boot and
refresh it after adding CRASHTIME if crash_kexec() is executed.

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
