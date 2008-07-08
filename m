Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KGJqQ-0004cT-7K
	for kexec@lists.infradead.org; Tue, 08 Jul 2008 20:31:29 +0000
Date: Tue, 8 Jul 2008 12:40:45 +0200
From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm 1/2] kexec jump -v12: kexec jump
Message-ID: <20080708104044.GA15327@elf.ucw.cz>
References: <1215401122.4660.4.camel@caritas-dev.intel.com>
	<20080707125010.GA21254@elf.ucw.cz>
	<1215508209.29894.8.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1215508209.29894.8.camel@caritas-dev.intel.com>
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
To: Huang Ying <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Hi!

> > > @@ -1411,3 +1421,50 @@ static int __init crash_save_vmcoreinfo_
> > >  }
> > > 
> > >  module_init(crash_save_vmcoreinfo_init)
> > > +
> > > +/**
> > > + *   kernel_kexec - reboot the system
> 
> > Really?
> 
> I will change the comments to reflect the changes to kernel_kexec.
> 
> > > + *   Move into place and start executing a preloaded standalone
> > > + *   executable.  If nothing was preloaded return an error.
> > > + */
> > > +int kernel_kexec(void)
> > > +{
> > > +     int error = 0;
> > > +
> > > +     if (xchg(&kexec_lock, 1))
> > > +             return -EBUSY;
> > 
> > That's quite a strange way to provide a lock. mutex_trylock?
> 
> I think this is because kexec_lock is used by crash_kexec() too, which
> may be called in some extreme environment, such as during panic().
> 
> > > +     if (!kexec_image) {
> > > +             error = -EINVAL;
> > > +             goto Unlock;
> > > +     }
> > > +
> > > +     if (kexec_image->preserve_context) {
> > > +#ifdef CONFIG_KEXEC_JUMP
> > > +             local_irq_disable();
> > > +             save_processor_state();
> > 
> > #else
> >         BUG()
> > 
> > ...because otherwise you silently do nothing?
> > 
> > > +#endif
> 
> If CONFIG_KEXEC_JUMP is defined, kexec_image->preserve_context will
> always be 0. So current code is safe. Here, #ifdef is used to resolve
> the dependency issue. For example, save_processor_state() may be
> undefined if CONFIG_KEXEC_JUMP is not defined.

Move the #ifdef outside the if (), then, so this is clear?

Actually, if preserve_context is always zero in !KEXEC_JUMP case, it
might make sense to remove whole variable...
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
