Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IAlbF-0001iM-B6
	for kexec@lists.infradead.org; Tue, 17 Jul 2007 07:52:21 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec
	=?iso-8859-1?q?base=09hibernation?=
Date: Tue, 17 Jul 2007 13:59:31 +0200
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<1184491804.1898.121.camel@caritas-dev.intel.com>
	<Pine.LNX.4.64.0707170101010.19248@asgard.lang.hm>
In-Reply-To: <Pine.LNX.4.64.0707170101010.19248@asgard.lang.hm>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200707171359.33317.rjw@sisk.pl>
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
To: david@lang.hm
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Tuesday, 17 July 2007 10:13, david@lang.hm wrote:
> Ying, as the kexec guru in this thread I have a question for you about how 
> kexec works (and possibly where you are going with this)
> 
> for the power-off hibernate with ACPI disabled the hibernation seems 
> fairly straightforward (although there are still some missing pieces)
> 
> however, since the resume designed for ACPI won't work would the following 
> approach work
> 
> 1. boot one kernel
> 2. setup a kexec the same way you would for hibernate
> 3. kexec to the new kernel
> 4. overwrite the memory of the first kernel
> 5. kexec 'back' to the main kernel that has now been overwritten by what was saved?
> 
> as part of this question, when you do a kexec, how does the kernel that 
> you are doing the kexec to know what to run next?
> 
> it needs to do some initialization first before it starts running normal 
> things, and at that point it the move back doesn't look for init like a 
> normal kernel boot (or the system would effectivly boot instead of picking 
> up where it left off)
> 
> is this 'restart point' flexible enough that either the pre-hibernate 
> kerenl or the small hibernate kernel could tell the pre-hibernate kernel 
> to go into suspend-to-ram mode before doing anything else?
> 
> Rafael,
>    if ACPI is disabled and not used, is there any memory in the origional 
> kernel that _must not_ be saved in the hibernate image? I recognise that 
> for efficancy it would save time to not save free memory, but if I'm 
> willing to waste some resources would it hurt to save everything?

On some systems there are valid 'struct page' structures that correspond to
memory holes and the kernel will oops if you try to save the contents of
these pages.  Unfortunately, only the early initialization platform code can
tell you which they are.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
