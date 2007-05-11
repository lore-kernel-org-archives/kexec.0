Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=spitz.ucw.cz)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HmaL1-0001rg-Ds
	for kexec@lists.infradead.org; Fri, 11 May 2007 14:59:45 -0400
Date: Fri, 11 May 2007 18:23:30 +0000
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Fastboot] restoring x86 BIOS state before reboot
Message-ID: <20070511182329.GJ4052@ucw.cz>
References: <20070406154628.GG12005@jukie.net>
	<m1zm4rd676.fsf@ebiederm.dsl.xmission.com>
	<20070429094135.GA10948@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070429094135.GA10948@suse.de>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>

Hi!

> > It may also be worth investigating if it is possible to bypass
> > the part of windows that uses BIOS calls.  I really don't have
> > a clue how a modern windows systems boots.
> 
> I think ReactOS has a bootlader that can also boot Windows, or at
> least they are close to booting the Windows kernel. That bootloader
> could be then used for booting Windows without BIOS calls.
> 
> I also heard that the 100-$-Laptop should now be able to use Windows.
> As it's using LinuxBIOS, this could also be interesting. However,
> maybe Microsoft simply modifies a special Windows for this, or they
> integrate a ClosedSource part in that LinuxBIOS, I don't know ... :-(

I do not think OLPC is using linuxBIOS these days. What they have
certainly looks like Sun's ROM monitor.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
