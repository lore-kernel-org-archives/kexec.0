Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JZEEH-0001jp-5b
	for kexec@lists.infradead.org; Tue, 11 Mar 2008 23:49:57 +0000
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 12 Mar 2008 00:49:05 +0100
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com>
	<20080311232415.GA26320@elf.ucw.cz>
In-Reply-To: <20080311232415.GA26320@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200803120049.06491.rjw@sisk.pl>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Wednesday, 12 of March 2008, Pavel Machek wrote:
> Hi!

Hi,

> > > This is a minimal patch with only the essential features. All
> > > additional features are split out and can be discussed later. I think
> > > it may be easier to get consensus on this minimal patch.
> > > 
> > 
> > Hi Huang,
> > 
> > This patchset is slowly getting better. True that first we need to come
> > up with minimal infrastructure patch and then think of building more
> > functionality on top of it.
> > 
> ...
> > > The features of this patch can be used for as follow:
> > > 
> > > - A simple hibernation implementation without ACPI support. You can
> > >   kexec a hibernating kernel, save the memory image of original system
> > >   and shutdown the system. When resuming, you restore the memory image
> > >   of original system via ordinary kexec load then jump back.
> > > 
> > 
> > The main usage of this functionality is for hibernation. I am not sure
> > what has been the conclusion of previous discussions.
> > 
> > Rafael/Pavel, does the approach of doing hibernation using a separate
> > kernel holds promise?
> 
> Its certainly "more traditional" method of doing hibernation than
> tricks swsusp currently plays.

What exactly are you referring to?

> Yes, I'd like these patches to go in, being able to switch kernels seems like
> useful tool. 

No objection from me.
 
> Now, I guess they are some difficulties, like ACPI integration, and
> some basic drawbacks, like few seconds needed to boot second kernel
> during suspend.
> 
> ...OTOH this is probably only chance to eliminate freezer from
> swsusp...

Some facts:

* In order to be able to do suspend (STR) without the freezer, we need to make
  device drivers block access to devices from applications during suspend.
* There's no reason to think that we can't use this same mechanism for
  hibernation (the only difficulty seems to be the handling of devices used for
  saving the image).
* We need the drivers to quiesce devices to be able to do the kexec jump in the
  first place (and to avoid races, we'll need them to block applications'
  access to devices just like for STR, which is the sufficient condition for
  removing the freezer).

So, I don't really think that the "freezer removal" argument is valid here.

Moreover, if this had been the _only_ argument for the $subject functionality,
I'd have been against it.

Thanks,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
