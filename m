Return-path: <kexec-bounces@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IkmkM-0004HD-Nw
	for kexec@lists.infradead.org; Wed, 24 Oct 2007 21:22:38 +0100
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Wed, 24 Oct 2007 22:38:02 +0200
References: <Pine.LNX.4.44L0.0709211540100.5816-100000@iolanthe.rowland.org>
	<200709221240.25614.rjw@sisk.pl> <20071011205445.GA3975@ucw.cz>
In-Reply-To: <20071011205445.GA3975@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200710242238.02978.rjw@sisk.pl>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, huang ying <huang.ying.caritas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Thursday, 11 October 2007 22:54, Pavel Machek wrote:
> Hi!
> 
> > > That's certainly possible. We already pass a very small amount of data between 
> > > the boot and resuming kernels at the moment, and it's done quite simply - by 
> > > putting the variables we want to 'transfer' in a nosave page/section.
> > 
> > Well, if the boot and image kernels are different, which is now possible on
> > x86_64 with some recent patches (currently in -mm), the nosave trick won't
> > work.
> 
> I guess we should remove the nosave.... at least from x86-64. If
> someone tries to use it, he'll get a nasty surprise.

Agreed.

I'll try to prepare a patch for that when I have a bit of time.

Greetings,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
