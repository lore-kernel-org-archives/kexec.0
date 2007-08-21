Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=amd.ucw.cz)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1INU7r-000095-B5
	for kexec@lists.infradead.org; Tue, 21 Aug 2007 09:50:36 -0400
Date: Tue, 21 Aug 2007 12:14:04 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] Re: [PATH 1/1] Kexec jump - v2 - kexec jump
Message-ID: <20070821101404.GA1704@elf.ucw.cz>
References: <1184483639.1898.99.camel@caritas-dev.intel.com>
	<20070731095101.GA1774@elf.ucw.cz>
	<1185954978.1363.23.camel@caritas-dev.intel.com>
	<20070816102635.GA2039@elf.ucw.cz>
	<1187331349.28497.9.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1187331349.28497.9.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

Hi!

> On Thu, 2007-08-16 at 12:26 +0200, Pavel Machek wrote:
> > Ping... is there some next version?
> > 
> > I'm stuck at the tools side currently. kexec-1.101 just won't load the
> > kernel properly, and kexec-testing from git does not know -j option. I
> > tried hand-patching it, but got lots of scary rejects.
> > 
> > Is there chance for a patch against kexec-testing?
> 
> I have some other work to do recently. So the next version will delay
> for some while. :(

Ok, I got it to work -- thanks a lot.

Yes, acpi=off is mandatory. Unfortunately, thinkpad x60 does not boot
with acpi=off (should we add another test to linux firmware kit?
Machines should still boot in acpi=off mode...). acpi=off noapic
nolapic nosmp makes it boot, and that in turn makes kjump work.

Screen is not refreshed on kjump back to original kernel, but I guess
that's to be expected. I did not play with framebuffer, yet.

Maybe it is time to move kjump functionality into -mm and
kexec-testing?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
