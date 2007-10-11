Return-path: <kexec-bounces@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=spitz.ucw.cz)
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Ikixa-0007y6-8y
	for kexec@lists.infradead.org; Wed, 24 Oct 2007 17:20:04 +0100
Date: Thu, 11 Oct 2007 20:54:45 +0000
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Message-ID: <20071011205445.GA3975@ucw.cz>
References: <Pine.LNX.4.44L0.0709211540100.5816-100000@iolanthe.rowland.org>
	<BF08447B-234F-4851-89BF-92A57EA801C6@mac.com>
	<200709220947.58872.nigel@nigel.suspend2.net>
	<200709221240.25614.rjw@sisk.pl>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200709221240.25614.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, huang ying <huang.ying.caritas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>

Hi!

> > That's certainly possible. We already pass a very small amount of data between 
> > the boot and resuming kernels at the moment, and it's done quite simply - by 
> > putting the variables we want to 'transfer' in a nosave page/section.
> 
> Well, if the boot and image kernels are different, which is now possible on
> x86_64 with some recent patches (currently in -mm), the nosave trick won't
> work.

I guess we should remove the nosave.... at least from x86-64. If
someone tries to use it, he'll get a nasty surprise.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
