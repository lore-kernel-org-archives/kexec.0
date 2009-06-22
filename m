Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MIYAV-0008TK-8u
	for kexec@lists.infradead.org; Mon, 22 Jun 2009 01:18:01 +0000
Date: Sun, 21 Jun 2009 21:17:59 -0400
From: Neil Horman <nhorman@redhat.com>
Subject: Re: Need for KEXEC_PRESERVE_CONTEXT flag ?
Message-ID: <20090622011759.GA23205@localhost.localdomain>
References: <48e37220906182330w6a6e83bctb3b3a27f7bfc6afb@mail.gmail.com>
	<20090621171709.GA3358@localhost.localdomain>
	<48e37220906211154s4f1c3812o8f3ba1307a7e06d@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48e37220906211154s4f1c3812o8f3ba1307a7e06d@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: Indraneel Mukherjee <indro.ml@gmail.com>
Cc: kexec@lists.infradead.org

On Mon, Jun 22, 2009 at 12:24:05AM +0530, Indraneel Mukherjee wrote:
> On Sun, Jun 21, 2009 at 10:47 PM, Neil Horman <nhorman@redhat.com> wrote:
> 
> > On Fri, Jun 19, 2009 at 12:00:44PM +0530, Indraneel Mukherjee wrote:
> > > Hi,
> > >
> > > The file kernel/kexec.c (~ line 1001 in linux-2.6.30) has this code
> > >
> > > ------snip----
> > >
> > >  if (flags & KEXEC_PRESERVE_CONTEXT)
> > >             image->preserve_context = 1;
> > >
> > > ------snip----
> > >
> > > Will this ever be true? The flag KEXEC_PRESERVE_CONTEXT is not even
> > defined
> > > in kexec-tools-2.0.0.
> > >
> > > Consequently, all the code inside the condition
> >  if(image->preserve_context)
> > >   is also useless?
> > >
> > > Am i missing something here?
> > >
> > Yes, the code you're looking at in the first definition is part of the
> > kernel,
> > while you're looking for the definition of KEXEC_PRESERVE_CONTEXT in the
> > kexec-tools userspace code.  You need to look for the definition of
> > KEXEC_PRESERVE_CONTEXT in the kernel code (you'll find it in
> > include/linux/kexec.h).
> 
> 
> I've seen that bit.  I was only trying to understand that code & figure out
> when does it ever gets executed. My guess is that kexec-tools is the only
> user of all the code in kernel/kexec.c. So, i started wondering if
> kexec-tools never sets the flag KEXEC_PRESERVE_CONTEXT, then why was that
> code even written?
> Ans that means we've got some untested code in the kernel :) ?
> 
Technically, you're correct, the code doesn't ever get used because the very
limited set of tools that make use of the kexec infrastructure doesn't make use
of it (yet).  That said, just because nothing uses it in user space, doesn't
mean that it won't.  And if its not in the kernel first, userspace won't ever
get to use it :)

I guess the bottom line is, yeah its not used right now, but thats more of an
impetus for kexec-tools to write code to take advantage of it, rather than for
the kernel to remove it :)

Neil

> Regards,
> Indro
> 
> 
> 
>  kexec-tools might use it one day, but not using it
> > doesn't mean we should remove it from the kernel.
> >
> 
> >
> > Neil
> >
> > > Regards,
> > > Indro
> >
> > > _______________________________________________
> > > kexec mailing list
> > > kexec@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> >
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
