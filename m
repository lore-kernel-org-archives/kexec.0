Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=spitz.ucw.cz)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JZMmM-00066t-1Y
	for kexec@lists.infradead.org; Wed, 12 Mar 2008 08:57:45 +0000
Date: Wed, 12 Mar 2008 09:57:14 +0100
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] kexec jump -v9
Message-ID: <20080312085714.GB3993@ucw.cz>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com>
	<20080311232415.GA26320@elf.ucw.cz>
	<200803120049.06491.rjw@sisk.pl>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200803120049.06491.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Hi!

> > > > The features of this patch can be used for as follow:
> > > > 
> > > > - A simple hibernation implementation without ACPI support. You can
> > > >   kexec a hibernating kernel, save the memory image of original system
> > > >   and shutdown the system. When resuming, you restore the memory image
> > > >   of original system via ordinary kexec load then jump back.
> > > > 
> > > 
> > > The main usage of this functionality is for hibernation. I am not sure
> > > what has been the conclusion of previous discussions.
> > > 
> > > Rafael/Pavel, does the approach of doing hibernation using a separate
> > > kernel holds promise?
> > 
> > Its certainly "more traditional" method of doing hibernation than
> > tricks swsusp currently plays.
> 
> What exactly are you referring to?

Well, traditionaly it is 'A saves B to disk' (like bootloader saves
kernel&userspace). In swsusp we have 'kernel saves itself'... which
works, too, but is pretty different design.

> > Now, I guess they are some difficulties, like ACPI integration, and
> > some basic drawbacks, like few seconds needed to boot second kernel
> > during suspend.
> > 
> > ...OTOH this is probably only chance to eliminate freezer from
> > swsusp...
> 
> Some facts:
> 
> * There's no reason to think that we can't use this same mechanism for
>   hibernation (the only difficulty seems to be the handling of devices used for
>   saving the image).

Ok, at least kexec makes handling of suspend device easier.

> Moreover, if this had been the _only_ argument for the $subject functionality,
> I'd have been against it.

Fortunately its not the only one :-).

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
