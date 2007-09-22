Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IZ26o-0005fv-Gj
	for kexec@lists.infradead.org; Sat, 22 Sep 2007 06:21:14 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Sat, 22 Sep 2007 12:34:17 +0200
References: <Pine.LNX.4.44L0.0709211540100.5816-100000@iolanthe.rowland.org>
	<878x6z67n8.fsf@jbms.ath.cx>
	<BF08447B-234F-4851-89BF-92A57EA801C6@mac.com>
In-Reply-To: <BF08447B-234F-4851-89BF-92A57EA801C6@mac.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200709221234.18426.rjw@sisk.pl>
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
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, huang ying <huang.ying.caritas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Saturday, 22 September 2007 01:19, Kyle Moffett wrote:
> On Sep 21, 2007, at 17:16:59, Jeremy Maitin-Shepard wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> >> The ACPI platform firmware is allowed to preserve information  
> >> accross the hibernation-resume cycle, so this need not be the same.
> >
> > All of my comments related to the case where S4 is not being used  
> > (instead the system is just powered off normally), and a boot  
> > kernel that does not initialize ACPI is used.  In that case, the  
> > ACPI platform firmware should not be able to distinguish a normal  
> > boot from a resume from hibernation.
> 
> I think that in order for this to work, there would need to be some  
> ABI whereby the resume-ing kernel can pass its entire ACPI state and  
> a bunch of other ACPI-related device details to the resume-ed kernel,  
> which I believe it does not do at the moment.

In fact we don't need to do this.

The solution is not to touch ACPI in the boot kernel (ie. the one that loads
the image) and pass control to the image kernel.  This is how it's supposed
to work according to the spec, more or less (well, there are some ugly details
that need handling, like the restoration of the NVS area).

> I believe that what causes problems is the ACPI state data that the kernel
> stores is *different* between identical sequential boots, especially when
> you add/remove/replace batteries, AC, etc.

Rather the ACPI state data that the platform firmware stores may be different,
depending on whether you enter S4 or S5 during "power off" and that determines
the interactions between the kernel and the firmware after the next boot.

Greetings,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
