Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Jc3y6-0001g8-1o
	for kexec@lists.infradead.org; Wed, 19 Mar 2008 19:28:59 +0000
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [PATCH -mm] kexec jump -v9
Date: Wed, 19 Mar 2008 20:28:26 +0100
References: <Pine.LNX.4.44L0.0803191057270.4958-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0803191057270.4958-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200803192028.27383.rjw@sisk.pl>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>, Len Brown <lenb@kernel.org>

On Wednesday, 19 of March 2008, Alan Stern wrote:
> On Tue, 18 Mar 2008, Eric W. Biederman wrote:
> 
> > Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > > Could it be connected with the way the boot kernel hands control over
> > > to the image kernel?  Presumably ACPI isn't prepared to deal with that
> > > sort of thing during a boot from S5.  It would have to be fooled into
> > > thinking the two kernels were one and the same.
> > 
> > It should be easy to test if it is a hand over problem, by turning off
> > the laptop by placing it in S5 (shutdown -h now) and then booting same
> > kernel again.
> 
> ?  Doesn't this happen every time Rafael turns the computer off and 
> then turns it back on?
> 
> Do you mean that Rafael should do an S5-type hibernate, but then reboot 
> in such a way that the image isn't loaded and resumed?

That will work.

The problem happens when the control goes back to the hibernated kernel.

I _think_ it has to do with the suspend(PRETHAW) thing we do before that,
but frankly I'm not too inclined to verify it as the problem is generally
dangerous to the hardware (not working thermal management on a notebook is
never fun).

Thanks,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
