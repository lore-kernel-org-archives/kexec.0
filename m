Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J1tQn-0005l4-T4
	for kexec@lists.infradead.org; Tue, 11 Dec 2007 00:57:13 +0000
Subject: Re: [PATCH 1/4 -mm] kexec based hibernation -v7 : kexec jump
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <20071210223117.GC27124@redhat.com>
References: <1197042810.24045.61.camel@caritas-dev.intel.com>
	<20071210223117.GC27124@redhat.com>
Date: Tue, 11 Dec 2007 08:55:45 +0000
Message-Id: <1197363345.24045.96.camel@caritas-dev.intel.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Mon, 2007-12-10 at 17:31 -0500, Vivek Goyal wrote:
> [..]
> >  
> > -#define KEXEC_ON_CRASH  0x00000001
> > -#define KEXEC_ARCH_MASK 0xffff0000
> > +#define KEXEC_ON_CRASH		0x00000001
> > +#define KEXEC_PRESERVE_CPU	0x00000002
> > +#define KEXEC_PRESERVE_CPU_EXT	0x00000004
> > +#define KEXEC_SINGLE_CPU	0x00000008
> > +#define KEXEC_PRESERVE_DEVICE	0x00000010
> > +#define KEXEC_PRESERVE_CONSOLE	0x00000020
> 
> Hi,
> 
> Why do we need so many different flags for preserving different types
> of state (CPU, CPU_EXT, Device, console) ? To keep things simple,
> can't we can create just one flag KEXEC_PRESERVE_CONTEXT, which will
> indicate any special action required for preserving the previous kernel's
> context so that one can swith back to old kernel?

Yes. There are too many flags, especially when we have no users of these
flags now. It is better to use one flag such as KEXEC_PRESERVE_CONTEXT
now, and create the others required flags when really needed.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
