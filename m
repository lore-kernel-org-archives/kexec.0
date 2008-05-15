Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwTIX-00076c-SK
	for kexec@lists.infradead.org; Thu, 15 May 2008 02:34:26 +0000
Subject: Re: [PATCH] kexec based hibernation: a prototype of kexec
	multi-stage load
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <m1lk2c4l4i.fsf@frodo.ebiederm.org>
References: <1210574441.30365.8.camel@caritas-dev.intel.com>
	<20080513053408.GA5870@redhat.com>
	<1210730266.23707.50.camel@caritas-dev.intel.com>
	<20080514025607.GA19944@redhat.com>
	<1210736275.23707.62.camel@caritas-dev.intel.com>
	<m1lk2c4l4i.fsf@frodo.ebiederm.org>
Date: Thu, 15 May 2008 10:40:07 +0800
Message-ID: <1210819207.23707.107.camel@caritas-dev.intel.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On Wed, 2008-05-14 at 14:43 -0700, Eric W. Biederman wrote:
> "Huang, Ying" <ying.huang@intel.com> writes:
> 
> >> So, IMHO, for first simple implementation, we don't have to pass around
> >> any data between kernels except entry point. (Please correct me if I am 
> >> wrong). Lets get that implementation in first and then we can get rest
> >> of the pieces in place.
> >
> > Yes. Kernel entry/re-entry point is the only information need to be
> > communicated between kernels for just switching between them. So we can
> > focus on kexec jump patch firstly.
> 
> Then as a preliminary design let's plan on this.
> 
> - Pass the rentry point as the return address (using the C ABI).
>   We may want to load the stack pointer etc so we can act as
>   a direct entry point for new code.

OK, I will try to do this.

> - Look at passing a pointer to the mapping of pages that the kexec
>   trampoline uses in arg1 of the C ABI.  Largely the format is defacto
>   fixed anyway because we need to pass the structure from C to
>   assembly.

You mean pass image->head to purgatory of /sbin/kexec using arg1 of C
ABI?

> Using the standard C ABI makes things much it much easier to pick
> a calling convention, and to document it.

Yes.

Best Regards,
Huang Ying


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
