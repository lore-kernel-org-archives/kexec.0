Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1KBc-0007wS-I9
 for kexec@lists.infradead.org; Tue, 24 Nov 2015 20:27:38 +0000
Received: by wmuu63 with SMTP id u63so112310605wmu.0
 for <kexec@lists.infradead.org>; Tue, 24 Nov 2015 12:27:14 -0800 (PST)
Date: Tue, 24 Nov 2015 21:27:13 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [V5 PATCH 1/4] panic/x86: Fix re-entrance problem due to panic
 on NMI
Message-ID: <20151124202712.GA23063@dhcp22.suse.cz>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093644.4285.9349.stgit@softrs>
 <20151124150510.GA6100@home.goodmis.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151124150510.GA6100@home.goodmis.org>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: x86@kernel.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Tue 24-11-15 10:05:10, Steven Rostedt wrote:
> On Fri, Nov 20, 2015 at 06:36:44PM +0900, Hidehiro Kawai wrote:
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index 350dfb0..480a4fd 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -445,6 +445,19 @@ extern int sysctl_panic_on_stackoverflow;
> >  
> >  extern bool crash_kexec_post_notifiers;
> >  
> > +extern atomic_t panic_cpu;
> > +
> > +/*
> > + * A variant of panic() called from NMI context.
> > + * If we've already panicked on this cpu, return from here.
> > + */
> > +#define nmi_panic(fmt, ...)						\
> > +	do {								\
> > +		int this_cpu = raw_smp_processor_id();			\
> > +		if (atomic_cmpxchg(&panic_cpu, -1, this_cpu) != this_cpu) \
> > +			panic(fmt, ##__VA_ARGS__);			\
> 
> Hmm,
> 
> What happens if:
> 
> 	CPU 0:				CPU 1:
> 	------				------
> 	nmi_panic();
> 
> 					nmi_panic();
> 					<external nmi>
> 					nmi_panic();

I thought that nmi_panic is called only from the nmi context. If so how
can we get a nested NMI like that?
-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
