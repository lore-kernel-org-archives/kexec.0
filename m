Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netrider.rowland.org ([192.131.102.5])
	by bombadil.infradead.org with smtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JcVVD-0006o4-Og
	for kexec@lists.infradead.org; Fri, 21 Mar 2008 00:53:00 +0000
Date: Thu, 20 Mar 2008 20:52:59 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH -mm] kexec jump -v9
In-Reply-To: <200803210040.33982.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.0803202049550.11234-100000@netrider.rowland.org>
MIME-Version: 1.0
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Fri, 21 Mar 2008, Rafael J. Wysocki wrote:

> > > > Well, in fact ACPI has something called the NVS memory, which we're supposed
> > > > to restore during the resume and which we're not doing.  The problem may be
> > > > related to this.
> > > 
> > > No, it can't be.  ACPI won't expect the NVS memory to be restored 
> > > following an S5-shutdown.  In fact, as far as ACPI is concerned, 
> > > resuming from an S5-type hibernation should not be considered a resume 
> > > at all but just an ordinary reboot.
> 
> I agree here.
> 
> > > All ACPI-related memory areas in the boot kernel should be passed directly
> > > through to the image kernel.
> 
> However, the image kernel is supposed to restore the NVS area (from the
> image) before executing _WAK.

It's supposed to do that when resuming from an S4 hibernation, not 
when resuming from an S5 hibernation.

> > How can we pass interpretter state? I do not think we do this kind of
> > passing.
> 
> The interpreter state is passed withing the image.  The platform state is not.

For an S5 hibernation, the interpreter state within the image is wrong.  
The image kernel needs to have the interpreter state from the boot 
kernel -- I don't know if this is possible.

Alan Stern


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
