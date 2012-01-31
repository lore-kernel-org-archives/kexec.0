Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RsMB8-0002do-QL
 for kexec@lists.infradead.org; Tue, 31 Jan 2012 22:27:55 +0000
Date: Tue, 31 Jan 2012 17:27:51 -0500
From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] x86, kdump, ioapic: Fix kdump race with migrating irq
Message-ID: <20120131222751.GE5650@redhat.com>
References: <1328045114-4489-1-git-send-email-dzickus@redhat.com>
 <m1ipjr4jaa.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1ipjr4jaa.fsf@fess.ebiederm.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: x86@kernel.org, kexec-list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, vgoyal@redhat.com

On Tue, Jan 31, 2012 at 02:08:29PM -0800, Eric W. Biederman wrote:
> > The problem is that although kdump tries to shutdown minimal hardware,
> > it still needs to disable the IO APIC.  This requires spinlocks which
> > may be held by another cpu.  This other cpu is being held infinitely in
> > an NMI context by kdump in order to serialize the crashing path.  Instant
> > deadlock.
> 
> Can you test to see if kexec on panic still needs to disable the IO
> APIC.  Last I looked we were close if not all of the way there to not
> needing to boot the kernel in pic mode?

Ok, so you just blindly remove disable_IO_APIC from
native_machine_crash_shutdown and re-run some panic tests on various
machines?  What about the disable_IO_APIC path in native_machine_shutdown?

Also, where could I look to see if that work was done?  Is that in the
ioapic setup code?

> 
> If we can skip the ioapic disable entirely we should be much more
> robust.

Agreed.

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
