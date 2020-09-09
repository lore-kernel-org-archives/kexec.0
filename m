Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kG0ig-0008Ic-V9
 for kexec@lists.infradead.org; Wed, 09 Sep 2020 14:05:08 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20200909075016.104407-1-kasong@redhat.com>
Date: Wed, 09 Sep 2020 09:04:16 -0500
In-Reply-To: <20200909075016.104407-1-kasong@redhat.com> (Kairui Song's
 message of "Wed, 9 Sep 2020 15:50:13 +0800")
Message-ID: <87ft7r82sf.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/3] Add writing support to vmcore for reusing oldmem
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kairui Song <kasong@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, Vivek Goyal <vgoyal@redhat.com>

Kairui Song <kasong@redhat.com> writes:

> Currently vmcore only supports reading, this patch series is an RFC
> to add writing support to vmcore. It's x86_64 only yet, I'll add other
> architecture later if there is no problem with this idea.
>
> My purpose of adding writing support is to reuse the crashed kernel's
> old memory in kdump kernel, reduce kdump memory pressure, and
> allow kdump to run with a smaller crashkernel reservation.
>
> This is doable because in most cases, after kernel panic, user only
> interested in the crashed kernel itself, and userspace/cache/free
> memory pages are not dumped. `makedumpfile` is widely used to skip
> these pages. Kernel pages usually only take a small part of
> the whole old memory. So there will be many reusable pages.
>
> By adding writing support, userspace then can use these pages as a fast
> and temporary storage. This helps reduce memory pressure in many ways.
>
> For example, I've written a POC program based on this, it will find
> the reusable pages, and creates an NBD device which maps to these pages.
> The NBD device can then be used as swap, or to hold some temp files
> which previouly live in RAM.
>
> The link of the POC tool: https://github.com/ryncsn/kdumpd

A couple of thoughts.
1) Unless I am completely mistaken treating this as a exercise in
   memory hotplug would be much simpler.

   AKA just plug in the memory that is not needed as part of the kdump.

   I see below that you have problems doing this because
   of fragmentation.  I still think hotplug is doable using some
   kind of fragmented memory zone.
   
2) The purpose of the memory reservation is because hardware is
   still potentially running agains the memory of the old kernel.

   By the time we have brought up a new kernel enough of the hardware
   may have been reinitialized that we don't have to worry about
   hardware randomly dma'ing into the memory used by the old kernel.

   With IOMMUs and care we may be able to guarantee for some machine
   configurations it is impossible for DMA to come from some piece of
   hardware that is present but the kernel does not have a driver
   loaded for.


I really do not like this approach because it is fundamentlly doing the
wrong thing.  Adding write support to read-only drivers.  I do not see
anywhere that you even mentioned the hard problem and the reason we
reserve memory in the first place.  Hardware spontaneously DMA'ing onto
it.

> It's have been a long time issue that kdump suffers from OOM issue
> with limited crashkernel memory. So reusing old memory could be very
> helpful.

There is a very fine line here between reusing existing code (aka
drivers and userspace) and doing something that should work.

It might make sense to figure out what is using so much memory
that an OOM is triggered.

Ages ago I did something that was essentially dumping the kernels printk
buffer to the serial console in case of a crash and I had things down to
something comparatively miniscule like 8M or less.

My memory is that historically it has been high performance scsi raid
drivers or something like that, that are behind the need to have such
large memory reservations.

Now that I think about it, you aren't by any chance doing something
silly like running systemd in your initrd are you?  Are these OOMs by
any chance a userspace problem rather than a problem with inefficient
drivers?


In summary you either need to show that it is safe to reuse the
memory of the old kernel, or do some work to reduce the memory footprint
of the crashdump kernel, and the crashdump userspace. 

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
