Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netrider.rowland.org ([192.131.102.5])
	by bombadil.infradead.org with smtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KHVPw-0007Xj-AT
	for kexec@lists.infradead.org; Sat, 12 Jul 2008 03:05:00 +0000
Date: Fri, 11 Jul 2008 23:04:57 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH -mm 1/2] kexec jump -v12: kexec jump
In-Reply-To: <m1lk076dtj.fsf@frodo.ebiederm.org>
Message-ID: <Pine.LNX.4.44L0.0807112255450.9023-100000@netrider.rowland.org>
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

> I just realized with a little care the block layer does have support for this,
> or something very close.
> 
> You setup a software raid mirror with one disk device.    The physical
> device can come in and out while the filesystems depend on the real device.

Do you mean "the filesystems depend on the logical RAID device"?  

What's to prevent userspace from accessing the physical device 
directly?

What this amounts to, in the end, is having a way to distinguish the
set of I/O requests coming from the hibernation code (reading or
writing the memory image) from the set of all other I/O requests.  The
driver or the block layer has to be set up to allow the first set
through while blocking the second set.  (And don't forget about the 
complications caused by error-recovery I/O during the hibernation 
activity!)

Forcing the second set of requests to filter through an extra software 
layer is a clumsy way of accomplishing this.  There ought to be a 
better approach.

Alan Stern


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
