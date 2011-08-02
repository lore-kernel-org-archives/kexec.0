Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QoK7y-0000T0-II
	for kexec@lists.infradead.org; Tue, 02 Aug 2011 18:55:43 +0000
Date: Tue, 2 Aug 2011 14:55:30 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch v2 02/10] kdump: Make kimage_load_crash_segment() weak
Message-ID: <20110802185530.GH6399@redhat.com>
References: <20110727125504.491183728@linux.vnet.ibm.com>
	<20110727125807.695225427@linux.vnet.ibm.com>
	<20110801203143.GH3805@redhat.com>
	<1312277403.4881.26.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1312277403.4881.26.camel@br98xy6r>
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

On Tue, Aug 02, 2011 at 11:30:03AM +0200, Michael Holzheu wrote:
> Hello Vivek,
> 
> On Mon, 2011-08-01 at 16:31 -0400, Vivek Goyal wrote:
> > On Wed, Jul 27, 2011 at 02:55:06PM +0200, Michael Holzheu wrote:
> 
> [snip]
> 
> > > --- a/kernel/kexec.c
> > > +++ b/kernel/kexec.c
> > > @@ -842,8 +842,8 @@ out:
> > >  	return result;
> > >  }
> > >  
> > > -static int kimage_load_crash_segment(struct kimage *image,
> > > -					struct kexec_segment *segment)
> > > +int __weak kimage_load_crash_segment(struct kimage *image,
> > > +				     struct kexec_segment *segment)
> > 
> > A comment here why we are making it weak should help in increasing
> > the code readability.
> 
> What about the following:
> 
> /*
>  * Load crash segment into memory. Architecture code can override this
>  * function. E.g. this is necessary for architectures that do not
>  * create page tables for crashkernel memory.
>  */
> int __weak kimage_load_crash_segment(struct kimage *image,

This looks better.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
