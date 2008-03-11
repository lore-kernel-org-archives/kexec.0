Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JZENb-0002Pz-7Z
	for kexec@lists.infradead.org; Tue, 11 Mar 2008 23:59:36 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH -mm] kexec jump -v9
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com>
	<1205272758.7990.37.camel@nigel-laptop>
Date: Tue, 11 Mar 2008 17:55:03 -0600
In-Reply-To: <1205272758.7990.37.camel@nigel-laptop> (Nigel Cunningham's
	message of "Wed, 12 Mar 2008 08:59:18 +1100")
Message-ID: <m1iqzszui0.fsf@ebiederm.dsl.xmission.com>
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
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Nigel Cunningham <ncunningham@crca.org.au> writes:

> Hi all.
>
> I hope kexec turns out to be a good, usable solution. Unfortunately,
> however, I still have some areas where I'm not convinced that kexec is
> going to work or work well:
>
> 1. Reliability.
>
> It's being sold as a replacement for freezing processes, yet AFAICS it's
> still going to require the freezer in order to be reliable. In the
> normal case, there isn't much of an issue with freeing memory or
> allocating swap, and so these steps can be expected to progress without
> pain. Imagine, however, the situation where another process or processes
> are trying to allocate large amounts of memory at the same time, or the
> system is swapping heavily. Although such situations will not be common,
> they are entirely conceivable, and any implementation ought to be able
> to handle such a situation efficiently. If the freezer is removed, any
> hibernation implementation - not just kexec - is going to have a much
> harder job of being reliable in all circumstances. AFAICS, the only way
> a kexec based solution is going to be able to get around this will be to
> not have to allocate memory, but that will require permanent allocation
> of memory for the kexec kernel and it's work area as well as the
> permanent, exclusive allocation of storage for the kexec hibernation
> implementation that's currently in place (making the LCA complaint about
> not being able to hibernate to swap on NTFS on fuse equally relevant). 
>
> While this might be feasible on machines with larger amounts of memory
> (you might validly be able to argue that a user won't miss 10MB of RAM),
> it does make hibernation less viable or unviable for systems with less
> memory (embedded!). It also means that there are 10MB of RAM (or
> whatever amount) that the user has paid good money for, but which are
> probably only used for 30s at a time a couple of times a day.

Right.  I can address the memory concerns with a kexec based approach
as they are core to kexec and completely orthogonal to the rest.

A kexec in done in two passes.  The first to load the target kernel
and do whatever memory allocation is needed.  The second to actually
switch which kernel is running.

Using a linux kernel to save off the image or in any other way be the
target is not required it is simply the sane thing to do in a general
implementation.  An embedded developer could likely implement a save
to disk routing in a couple of hundred lines of C and a couple of K
RAM if it was an important feature.

> Any attempt to start to use storage available to the hibernating kernel
> is also going to have these race issues.

Yep.  Although disk storage is frequently less expensive, and more
readily available, so this is less of an issue.  Still it does suggest
that a dedicated partition likely will be required.

> 2. Lack of ACPI support.
>
> At the moment, noone is going to want to use kexec based hibernation if
> they have an ACPI system. This needs to be addressed before it can be
> considered a serious contender.

Yes.

> 3. Usability.
>
> Right now, kexec based hibernation looks quite complicated to configure,
> and the user is apparently going to have to remember to boot a different
> kernel or at least a different bootloader entry in order to resume. Not
> a plus. It would be good if you could find a way to use one bootloader
> entry, resuming if there's an image, booting normally if there's
> not.

I completely agree here.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
