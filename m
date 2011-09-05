Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1R0hqP-0000nr-MA
	for kexec@lists.infradead.org; Mon, 05 Sep 2011 22:40:46 +0000
Date: Tue, 6 Sep 2011 07:40:06 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch 0/2] s390: Patch series for s390 kdump support
Message-ID: <20110905224006.GC29637@verge.net.au>
References: <20110819130949.289522258@linux.vnet.ibm.com>
	<20110820092157.GA24619@verge.net.au>
	<1315216114.15703.5.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1315216114.15703.5.camel@br98xy6r>
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
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, hbabu@us.ibm.com, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org, vgoyal@redhat.com

On Mon, Sep 05, 2011 at 11:48:34AM +0200, Michael Holzheu wrote:
> Hello Simon,
> 
> On Sat, 2011-08-20 at 18:21 +0900, Simon Horman wrote:
> > On Fri, Aug 19, 2011 at 03:09:49PM +0200, Michael Holzheu wrote:
> > > Hello Simon,
> > > 
> > > The following two patches add s390 kdump support (64 bit only) to the
> > > kexec-tools:
> > > [0] Add s390 kdump support
> > > [1] Allow to call verify_sha256_digest() from kernel
> > 
> > Thanks, applied.
> 
> I checked out kexec-tools git head. Everything worked as expected.

Great. If you have any further patches to kexec-tools please let me know.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
