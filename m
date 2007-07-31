Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=amd.ucw.cz)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IFpdp-0000R5-Ex
	for kexec@lists.infradead.org; Tue, 31 Jul 2007 07:11:56 -0400
Date: Tue, 31 Jul 2007 13:12:08 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec based
	hibernation
Message-ID: <20070731111208.GA1778@elf.ucw.cz>
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
	<20070731091004.GA2022@elf.ucw.cz>
	<1185873924.23149.86.camel@caritas-dev.intel.com>
	<m17iogrgjw.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m17iogrgjw.fsf@ebiederm.dsl.xmission.com>
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
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

Hi!

> >> >  
> >> > +/* Adds the kexec_backup= command line parameter to command line. */
> >> > +static int cmdline_add_backup(char *cmdline, unsigned long addr)
> >> > +{
> >> > +	int cmdlen, len, align = 1024;
> >> > +	char str[30], *ptr;
> >> > +
> >> > +	/* Passing in kexec_backup=xxxK format. Saves space required
> >> > +	 * in cmdline. Ensure 1K alignment*/
> >> > +	if (addr%align)
> >> > +		return -1;
> >> > +	addr = addr/align;
> >> > +	ptr = str;
> >> > +	strcpy(str, " kexec_backup=");
> >> > +	ptr += strlen(str);
> >> > +	ultoa(addr, ptr);
> >> > +	strcat(str, "K");
> >> > +	len = strlen(str);
> >> > +	cmdlen = strlen(cmdline) + len;
> >> > +	if (cmdlen > (COMMAND_LINE_SIZE - 1))
> >> > +		die("Command line overflow\n");
> >> > +	strcat(cmdline, str);
> >> > +	return 0;
> >> > +}
> >> 
> >> This part did not apply for me -- it seems crashdump related and I did
> >> not have that applied. Is it critical?
> >
> > This is needed for kexec_jump to work properly. Which version of
> > kexec-tools do you use? This patch is against 1.101. The kdump patch
> > must be applied before this patch is applied.
> 
> Please work against the kexec-tools-testing tree, if you can.
> All of the outstanding patches should be there.

So
git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools-testing.git
is the right tree to use?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
