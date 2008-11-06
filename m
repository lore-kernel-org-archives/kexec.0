Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=UNKNOWN)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ky9Kv-0008RT-Nr
	for kexec@lists.infradead.org; Thu, 06 Nov 2008 18:12:06 +0000
Date: Thu, 6 Nov 2008 19:11:59 +0100
From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 09/15] x86: Emergency virtualization disable function
Message-ID: <20081106181159.GB1642@ucw.cz>
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
	<1225915018-6548-10-git-send-email-ehabkost@redhat.com>
	<20081105222731.GA14202@elf.ucw.cz>
	<20081106153405.GS5247@blackpad>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081106153405.GS5247@blackpad>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

Hi!

> > > --- /dev/null
> > > +++ b/arch/x86/kernel/virtext.c
> > > @@ -0,0 +1,89 @@
> > > +/* Core CPU virtualization extensions handling
> > > + *
> > > + * This should carry the code for handling CPU virtualization extensions
> > > + * that needs to live in the kernel core.
> > > + *
> > > + * Author: Eduardo Habkost <ehabkost@redhat.com>
> > > + *
> > > + * Copyright (C) 2008, Red Hat Inc.
> > > + */
> > 
> > GPL?
> 
> Yes, of course.
> 
> As IANAL, I used a similar .c file as reference for the author/copyright
> info header, and used arch/x86/kernel/crash.c, that doesn't refer to
> the GPL also. I think I chose a bad example as reference.
> 
> arch/x86/kernel/crash.c even has "All rights reserved". Ouch.

Yep, that should be fixed.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
