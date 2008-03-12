Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JZGMV-00042d-TW
	for kexec@lists.infradead.org; Wed, 12 Mar 2008 02:06:36 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH -mm] kexec jump -v9
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com> <200803112318.28120.rjw@sisk.pl>
Date: Tue, 11 Mar 2008 20:02:55 -0600
In-Reply-To: <200803112318.28120.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Tue, 11 Mar 2008 23:18:27 +0100")
Message-ID: <m1ejagzokw.fsf@ebiederm.dsl.xmission.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> Well, what can I say?
>
> I haven't been a big fan of doing hibernation this way since the very beginning
> and I still have the same reservations.  Namely, my opinion is that the
> hibernation-related problems we have are not just solvable this way.  For one
> example, in order to stop using the freezer for suspend/hibernation we first
> need to revamp the suspending/resuming of devices (uder way) and the
> kexec-based approach doesn't help us here.  I wouldn't like to start another
> discussion about it though.

Agreed.  At best all this does is moving the policy on how to save the kernel
image from the kernel itself out to user space, and it not a cure all.

> That said, I can imagine some applications of the $subject functionality
> not directly related to hibernation.  For example, one can use it for kernel
> debgging (jump to a new kernel, change something in the old kernel's
> data, jump back and see what happens etc.).  Also, in principle it may be used
> for such things as live migration of VMs.

Also such things as calling BIOS services or EFI services on x86_64.  Where
vm86 is not useful.

So in principle I think a kexec with return is a logical extension to
the current kexec functionality.  

That said it looks like next month before I will have time to do a reasonable
job of reviewing the current patches.  

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
