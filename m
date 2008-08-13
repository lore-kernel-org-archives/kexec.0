Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KT5J1-0006np-GC
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 01:37:43 +0000
Subject: Re: [PATCH -v3 6/7] kexec jump: __ftrace_enabled_save/restore
From: Huang Ying <ying.huang@intel.com>
In-Reply-To: <20080812130609.GB3951@redhat.com>
References: <1218510876.24951.45.camel@caritas-dev.intel.com>
	<20080812130609.GB3951@redhat.com>
Date: Wed, 13 Aug 2008 09:37:36 +0800
Message-Id: <1218591456.24951.62.camel@caritas-dev.intel.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu

On Tue, 2008-08-12 at 09:06 -0400, Vivek Goyal wrote:
> On Tue, Aug 12, 2008 at 11:14:36AM +0800, Huang Ying wrote:
> > Add __ftrace_enabled_save/restore, used to disable ftrace for a
> > while. Now, this is used by kexec jump, which need a version without
> > lock, for general situation, a locked version should be used.
> > 
> > Signed-off-by: Huang Ying <ying.huang@intel.com>
> > 
> > ---
> >  include/linux/ftrace.h |   21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -98,6 +98,27 @@ static inline void tracer_disable(void)
> >  #endif
> >  }
> >  
> > +/* Ftrace disable/restore without lock. Some synchronization mechanism
> > + * must be used to prevent ftrace_enabled to be changed between
> > + * disable/restore. */
> > +static inline int __ftrace_enabled_save(void)
> > +{
> > +#ifdef CONFIG_FTRACE
> > +	int saved_ftrace_enabled = ftrace_enabled;
> > +	ftrace_enabled = 0;
> > +	return saved_ftrace_enabled;
> > +#else
> > +	return 0;
> > +#endif
> > +}
> > +
> > +static inline void __ftrace_enabled_restore(int enabled)
> > +{
> > +#ifdef CONFIG_FTRACE
> > +	ftrace_enabled = enabled;
> > +#endif
> > +}
> > +
> >  #ifdef CONFIG_FRAME_POINTER
> >  /* TODO: need to fix this for ARM */
> >  # define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
> 
> I guess steven would like to see a patch which introduces both locked
> and lockless versions and with a very good comment explaining in what
> kind of unusual situation one can use the lockless version.

Have sent a locked version to Steven. And, there are some comments for
non-locked version, __ftrace_enabled_save() in above patch. What do you
think about it?

Best Regards,
Huang Ying



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
