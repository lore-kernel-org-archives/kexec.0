Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RsMIZ-0002jC-Kb
 for kexec@lists.infradead.org; Tue, 31 Jan 2012 22:35:36 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] x86, kdump, ioapic: Fix kdump race with migrating irq
References: <1328045114-4489-1-git-send-email-dzickus@redhat.com>
 <m1ipjr4jaa.fsf@fess.ebiederm.org> <20120131222751.GE5650@redhat.com>
Date: Tue, 31 Jan 2012 14:38:15 -0800
In-Reply-To: <20120131222751.GE5650@redhat.com> (Don Zickus's message of "Tue, 
 31 Jan 2012 17:27:51 -0500")
Message-ID: <m1vcnr33c8.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
To: Don Zickus <dzickus@redhat.com>
Cc: x86@kernel.org, kexec-list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, vgoyal@redhat.com

Don Zickus <dzickus@redhat.com> writes:

> On Tue, Jan 31, 2012 at 02:08:29PM -0800, Eric W. Biederman wrote:
>> > The problem is that although kdump tries to shutdown minimal hardware,
>> > it still needs to disable the IO APIC.  This requires spinlocks which
>> > may be held by another cpu.  This other cpu is being held infinitely in
>> > an NMI context by kdump in order to serialize the crashing path.  Instant
>> > deadlock.
>> 
>> Can you test to see if kexec on panic still needs to disable the IO
>> APIC.  Last I looked we were close if not all of the way there to not
>> needing to boot the kernel in pic mode?
>
> Ok, so you just blindly remove disable_IO_APIC from
> native_machine_crash_shutdown and re-run some panic tests on various
> machines?  What about the disable_IO_APIC path in native_machine_shutdown?
>

Yes.  Just native_machine_crash_shutdown.

native_machine_shutdown is the case when all is good and we attempt to
put the hardware back the way we found it.

Any normal x86 machine that the kernel runs in ioapic mode should be
enough to get a first approximation.

> Also, where could I look to see if that work was done?  Is that in the
> ioapic setup code?

The primary question is do we call the ioapic setup code without calling
the pic setup code first.  On some embedded x86 platforms we certainly
do.  I don't know if that code has been generalized.

Historically the problem is that we started the pit timer in pic mode
and used that to calibrate the delay loop.

So what we are looking to verify is that the linux kernel boot skip
pic mode entirely.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
