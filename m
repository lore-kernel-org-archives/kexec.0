Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IDMBB-0004yW-Pf
	for kexec@lists.infradead.org; Tue, 24 Jul 2007 11:20:07 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base hibernation
Date: Tue, 24 Jul 2007 17:27:34 +0200
References: <9D7649D18729DE4BB2BD7B494F7FEDC236CF66@pdsmsx415.ccr.corp.intel.com>
In-Reply-To: <9D7649D18729DE4BB2BD7B494F7FEDC236CF66@pdsmsx415.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200707241727.35589.rjw@sisk.pl>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Tuesday, 24 July 2007 16:00, Huang, Ying wrote:
> >From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> >This is not the point.  There are memory regions that you should not
> _restore_,
> >because that will cause harm.
> >
> >> On x86_64, there is another usage of nosave during processing E820
> >> memory map. But I don't know why the memory region other than
> E820_RAM
> >> are marked as nosave. I think only the memory region of type E820_RAM
> >> will be thought of normal memory, others will be thought as reserved.
> Is
> >> it sufficient just to check whether the page is reserved?
> >
> >No, it's not.
> 
> The "/proc/iomem" records information of all memory regions including
> "normal RAM" and all kinds of reserved regions, which is backed by
> iomem_resource. On x86_64, it is initialized in the exact same way as
> nosave region initialization.
> 
> I think maybe we can replace the "nosave region" concepts with
> "iomem_resource" (maybe need some enhancement).

Yes, I think that might be done.

Geetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
