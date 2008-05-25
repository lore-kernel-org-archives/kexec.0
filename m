Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K0CTo-0007kP-Gw
	for kexec@lists.infradead.org; Sun, 25 May 2008 09:25:29 +0000
Date: Sun, 25 May 2008 11:25:23 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [RFC] Win32 port of the userspace tools using MinGW.
Message-ID: <20080525112523.06c71d05@kopernikus.site>
In-Reply-To: <e2ed954f0805231513i28cb788bt856d91afcab4e227@mail.gmail.com>
References: <20080516054813.GA21670@oh.minilop.net>
	<20080522153403.1e6e714a@kopernikus.site>
	<e2ed954f0805231513i28cb788bt856d91afcab4e227@mail.gmail.com>
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
To: kexec@lists.infradead.org
Cc: Jamey Sharp <jamey@thetovacompany.com>

* "Jamey Sharp" <jamey@thetovacompany.com> [2008-05-23 15:13]:
>
> On Thu, May 22, 2008 at 6:34 AM, Bernhard Walle <bwalle@suse.de> wrote:
> > * Jamey Sharp <jamey@thetovacompany.com> [2008-05-15 22:48]:
> >> OK, I haven't quite gotten around to posting the Windows kernel driver
> >> source that goes with this.
> >
> > Do you plan to release the driver sources?
> 
> Yes, and I've finally done so. The code I wrote is licensed under GPLv2
> or later; some Linux kernel source is included verbatim or with
> modifications, and is licensed accordingly.
>     http://source.thetovacompany.com/kexec-win/
> 
> I've only tried cross-compiling this code from Linux. In principle it
> should build with MinGW on Windows as well, if anyone cares. :-)

That was my first approach, because I _thought_ it might be easier than
cross-compiling. However, compiling kexec-tools on Windows did not work
here because of several reasons. I fixed up everything, but I ended in
a problem that I was not able to create a ET_REL binary of
purgatory/purgatory.ro. The problem is that -Wl,--oformat didn't work
(ld: cannot perform PE operations on non PE output file). Google
advised me to use 'objcopy' -- however, that produced a ET_EXEC
binary instead of ET_REL. The manual page of objcopy mentions

  However, copying a relocatable object file between any two formats
  may not work as expected.

At that point, I gave up and gave the cross-compiler a try. That worked
flawlessly. However, if somebody has an idea how to create a working
ELF ET_REL file on Windows with Mingw, I can post the other fixups, so
that we have a "clean" Windows port.

I'm also able to _compile_ the driver (also on Windows), but I don't
know how to _load_ the driver. Running kexec -l on Windows gave me an
error message that loading fails, and it seems that the driver device
file is just not there.

Can you please advise me here?



	Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
