Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=amd.ucw.cz)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1ILepd-0007Tb-HZ
	for kexec@lists.infradead.org; Thu, 16 Aug 2007 08:52:13 -0400
Date: Thu, 16 Aug 2007 12:24:18 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATH 1/1] Kexec jump - v2 - kexec jump
Message-ID: <20070816102418.GA2012@elf.ucw.cz>
References: <1184483639.1898.99.camel@caritas-dev.intel.com>
	<20070731095101.GA1774@elf.ucw.cz>
	<20070815184441.GA14161@nlxdcldnl2.cl.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070815184441.GA14161@nlxdcldnl2.cl.intel.com>
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
To: kexec@lists.infradead.org

Hi!
> 
> Are you still having problem w/ kexec and the Intel NIC?  What kernel

I'm afraid I have problem w/ kexec. I tried to get kjump to run, but
thinkpad x60 will not boot with acpi=off. (And there are still some
problems with tools).

> We see work was done in later kernels to properly handle the D3hot to D0
> transition that's so problematic to 2.6.9.  And ugly hack that works

I'm using 2.6.23-rc2 here.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
