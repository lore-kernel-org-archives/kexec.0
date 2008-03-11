Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JZDpF-0008Hf-7G
	for kexec@lists.infradead.org; Tue, 11 Mar 2008 23:24:06 +0000
Date: Wed, 12 Mar 2008 00:24:15 +0100
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] kexec jump -v9
Message-ID: <20080311232415.GA26320@elf.ucw.cz>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080311211004.GA30164@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

Hi!

> > This is a minimal patch with only the essential features. All
> > additional features are split out and can be discussed later. I think
> > it may be easier to get consensus on this minimal patch.
> > 
> 
> Hi Huang,
> 
> This patchset is slowly getting better. True that first we need to come
> up with minimal infrastructure patch and then think of building more
> functionality on top of it.
> 
...
> > The features of this patch can be used for as follow:
> > 
> > - A simple hibernation implementation without ACPI support. You can
> >   kexec a hibernating kernel, save the memory image of original system
> >   and shutdown the system. When resuming, you restore the memory image
> >   of original system via ordinary kexec load then jump back.
> > 
> 
> The main usage of this functionality is for hibernation. I am not sure
> what has been the conclusion of previous discussions.
> 
> Rafael/Pavel, does the approach of doing hibernation using a separate
> kernel holds promise?

Its certainly "more traditional" method of doing hibernation than
tricks swsusp currently plays. Yes, I'd like these patches to go in,
being able to switch kernels seems like useful tool.

Now, I guess they are some difficulties, like ACPI integration, and
some basic drawbacks, like few seconds needed to boot second kernel
during suspend.

...OTOH this is probably only chance to eliminate freezer from
swsusp...

Yes, I'd like to see this to go ahead.

No, this does not make swsusp obsolete just yet.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
