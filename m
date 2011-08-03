Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QoYtI-0008Ff-0e
	for kexec@lists.infradead.org; Wed, 03 Aug 2011 10:41:32 +0000
Received: from d06nrmr1307.portsmouth.uk.ibm.com
	(d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p73AfTSq025332
	for <kexec@lists.infradead.org>; Wed, 3 Aug 2011 10:41:29 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p73AfTKO2379786
	for <kexec@lists.infradead.org>; Wed, 3 Aug 2011 11:41:29 +0100
Received: from d06av03.portsmouth.uk.ibm.com (localhost.localdomain
	[127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p73AfT3v008908
	for <kexec@lists.infradead.org>; Wed, 3 Aug 2011 04:41:29 -0600
Subject: Re: [patch v2 02/10] kdump: Make kimage_load_crash_segment() weak
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
In-Reply-To: <20110802185530.GH6399@redhat.com>
References: <20110727125504.491183728@linux.vnet.ibm.com>
	<20110727125807.695225427@linux.vnet.ibm.com>
	<20110801203143.GH3805@redhat.com> <1312277403.4881.26.camel@br98xy6r>
	<20110802185530.GH6399@redhat.com>
Date: Wed, 03 Aug 2011 12:41:28 +0200
Message-ID: <1312368088.3783.40.camel@br98xy6r>
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

On Tue, 2011-08-02 at 14:55 -0400, Vivek Goyal wrote:
> On Tue, Aug 02, 2011 at 11:30:03AM +0200, Michael Holzheu wrote:
> > Hello Vivek,
> > 
> > On Mon, 2011-08-01 at 16:31 -0400, Vivek Goyal wrote:
> > > On Wed, Jul 27, 2011 at 02:55:06PM +0200, Michael Holzheu wrote:
> > 
> > [snip]
> > 
> > > > --- a/kernel/kexec.c
> > > > +++ b/kernel/kexec.c
> > > > @@ -842,8 +842,8 @@ out:
> > > >  	return result;
> > > >  }
> > > >  
> > > > -static int kimage_load_crash_segment(struct kimage *image,
> > > > -					struct kexec_segment *segment)
> > > > +int __weak kimage_load_crash_segment(struct kimage *image,
> > > > +				     struct kexec_segment *segment)
> > > 
> > > A comment here why we are making it weak should help in increasing
> > > the code readability.
> > 
> > What about the following:
> > 
> > /*
> >  * Load crash segment into memory. Architecture code can override this
> >  * function. E.g. this is necessary for architectures that do not
> >  * create page tables for crashkernel memory.
> >  */
> > int __weak kimage_load_crash_segment(struct kimage *image,
> 
> This looks better.

With that comment change: Do I get an "Acked-by" for this patch from
you?

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
