Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ix0VG-0006rM-T2
	for kexec@lists.infradead.org; Tue, 27 Nov 2007 13:29:31 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on boot
	cpu
References: <20071127014740.GA28622@hmsreliant.think-freely.org>
	<m1d4twmimu.fsf@ebiederm.dsl.xmission.com>
	<20071127131355.GA14887@hmsendeavour.rdu.redhat.com>
Date: Tue, 27 Nov 2007 06:28:13 -0700
In-Reply-To: <20071127131355.GA14887@hmsendeavour.rdu.redhat.com> (Neil
	Horman's message of "Tue, 27 Nov 2007 08:13:55 -0500")
Message-ID: <m1y7cjkec2.fsf@ebiederm.dsl.xmission.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@redhat.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, ak@suse.de, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com

Neil Horman <nhorman@redhat.com> writes:

> What makes you say this?  I don't see any need for interrupts prior to
> calibrate_delay()

Yes.  calibrate_delay() is the first place we send interrupts over
hypertransport.  However I/O still works.  Thus hypertransport from
the first cpu is working, and hypertransport itself is working.

This is an interrupt specific problem not some generic hypertransport
problem.

>> I agree that there is a problem.
>> 
>> The reliable fix is to totally skip the PIC interrupt mode and go directly
>> to apic mode.
>> 
>> To make the code kexec on panic code path reliable we need to remove code
>> not add it.
>> 
>> Frankly I think switching cpus is one of the least reliable things that
>> we can do in general.
>> 
> I understand the sentiment here, but its not like we're adding additional
> functionality with this patch.  We're already sending an IPI to all the
> processors to halt them

And we don't care if they halt.  If they don't get the IPI we timeout.
Making the IPI mandatory is a _singificant_ change.

The only reason that code is on the kexec on panic code path is that
there is no other possible place we could put it.

> , we're just adding logic here so that we can detect the
> boot cpu and use it to jump to the kexec image instead of halting.  I don't
> think this is any less reliable that what we have currently.

It doesn't make things more reliable, and it adds code to a code path
that already has to much code to be solid reliable (thus your
problem). 

Putting the system back in PIC legacy mode on the kexec on panic path
was supposed to be a short term hack until we could remove the need
by always deliver interrupts in apic mode.

If you can't root cause your problem and figure out how the apics
are misconfigured for legacy mode let's remove the need for going into
to legacy PIC mode and do what we should be able to do reliably.  The
reward is much higher, as we kill all possibility of restoring PIC
mode wrong because we don't need to bother.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
