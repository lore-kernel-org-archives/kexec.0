Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netrider.rowland.org ([192.131.102.5])
	by bombadil.infradead.org with smtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KHlBU-0007st-B1
	for kexec@lists.infradead.org; Sat, 12 Jul 2008 19:55:08 +0000
Date: Sat, 12 Jul 2008 15:55:02 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH -mm 1/2] kexec jump -v12: kexec jump
In-Reply-To: <m1ej5z4v7v.fsf@frodo.ebiederm.org>
Message-ID: <Pine.LNX.4.44L0.0807121551590.17776-100000@netrider.rowland.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

On Fri, 11 Jul 2008, Eric W. Biederman wrote:

> > Forcing the second set of requests to filter through an extra software 
> > layer is a clumsy way of accomplishing this.  There ought to be a 
> > better approach.
> 
> The point was something different.  The reasons we can not store the
> state of the system with the hardware devices logically hot unplugged
> (and thus reuse all of the find device hotplug methods) is because
> things like the filesystem layer don't know how to cope with their
> block devices going away an coming back.

This is not how the procedure works.  During hibernation, block devices
are not logically hot-unplugged.  (If they were then they couldn't be
used for writing the memory image.)  Instead, they are quiesced or
suspended and their input queues are plugged.

> That is the problem inserting an virtual software device in the middle
> can solve.  If that works should there be a better way?  Certainly but
> to prove it out starting with a block device wrapper is a trivial way to
> go.

This sounds like a solution to a non-existent problem.

Alan Stern


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
