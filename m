Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KHW9W-0003UA-F4
	for kexec@lists.infradead.org; Sat, 12 Jul 2008 03:52:06 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <Pine.LNX.4.44L0.0807112255450.9023-100000@netrider.rowland.org>
Date: Fri, 11 Jul 2008 20:50:12 -0700
In-Reply-To: <Pine.LNX.4.44L0.0807112255450.9023-100000@netrider.rowland.org>
	(Alan Stern's message of "Fri, 11 Jul 2008 23:04:57 -0400 (EDT)")
Message-ID: <m1ej5z4v7v.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [linux-pm] [PATCH -mm 1/2] kexec jump -v12: kexec jump
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Alan Stern <stern@rowland.harvard.edu> writes:

> On Fri, 11 Jul 2008, Eric W. Biederman wrote:
>
>> I just realized with a little care the block layer does have support for this,
>> or something very close.
>> 
>> You setup a software raid mirror with one disk device.    The physical
>> device can come in and out while the filesystems depend on the real device.
>
> Do you mean "the filesystems depend on the logical RAID device"?  

Oh yes. Thinko.

> What's to prevent userspace from accessing the physical device 
> directly?

Nothing.

> What this amounts to, in the end, is having a way to distinguish the
> set of I/O requests coming from the hibernation code (reading or
> writing the memory image) from the set of all other I/O requests.  The
> driver or the block layer has to be set up to allow the first set
> through while blocking the second set.  (And don't forget about the 
> complications caused by error-recovery I/O during the hibernation 
> activity!)

I guess this problem exists but it is not at all the problem I was
thinking of.

> Forcing the second set of requests to filter through an extra software 
> layer is a clumsy way of accomplishing this.  There ought to be a 
> better approach.

The point was something different.  The reasons we can not store the
state of the system with the hardware devices logically hot unplugged
(and thus reuse all of the find device hotplug methods) is because
things like the filesystem layer don't know how to cope with their
block devices going away an coming back.

That is the problem inserting an virtual software device in the middle
can solve.  If that works should there be a better way?  Certainly but
to prove it out starting with a block device wrapper is a trivial way to
go.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
