Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=spitz.ucw.cz)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IPeSB-0005Hp-2e
	for kexec@lists.infradead.org; Mon, 27 Aug 2007 09:16:31 -0400
Date: Mon, 27 Aug 2007 13:15:49 +0000
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 0/2 -mm] kexec based hibernation
Message-ID: <20070827131549.GA4104@ucw.cz>
References: <1188177245.3247.36.camel@caritas-dev.intel.com>
	<20070827050027.GB9809@in.ibm.com>
	<1188195529.3247.82.camel@caritas-dev.intel.com>
	<20070827075317.GB2060@elf.ucw.cz>
	<m1d4x95dqy.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1d4x95dqy.fsf@ebiederm.dsl.xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, Alan Stern <stern@rowland.harvard.edu>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

Hi!

> >> > Does this make sense?
> >> 
> >> Yes, this is a sensible optimization. But I think it may be better to
> >> make bootloader load kernel D directly into a specified memory location.
> >> For example, we can add a option to "kernel" command of grub. 
> >> 
> >> And, I think we can do more in bootloader. Such as we can prepare
> >> two
> >
> > Yes, that would be nice.
> >
> > It will mean quite a bit of work, but I guess it should be the long
> > term goal. Loading restore kernel directly from bootloader means:
> >
> > 1) it is fast -- no need to boot another kernel
> >
> > 2) it is "classical" way of doing things
> >
> > On the other hand, we loose flexibility that way:
> >
> > 1) it locks you onto one bootloader
> >
> > 2) you no longer have userland there to do uncompression, decryption,
> > etc..
> 
> True although for the uncompression and decryption those aren't exactly foreign
> requirements for bootloaders.

Well, uncompression yes, but crypto? What is that, some kind of
trusted computing thingie?

We do RSA for uswsusp, that may be a bit of problem for a bootloader,
but I'm glad bootloaders are bloated already :-).

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
