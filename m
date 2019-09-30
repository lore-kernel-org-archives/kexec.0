Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iEsiB-00013K-SQ
 for kexec@lists.infradead.org; Mon, 30 Sep 2019 10:15:25 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20190920035326.27212-1-lijiang@redhat.com>
 <20190927051518.GA13023@dhcp-128-65.nay.redhat.com>
 <87r241piqg.fsf@x220.int.ebiederm.org>
 <20190928000505.GJ31919@MiWiFi-R3L-srv>
 <875zldp2vj.fsf@x220.int.ebiederm.org>
 <20190928030910.GA5774@MiWiFi-R3L-srv>
Date: Mon, 30 Sep 2019 05:14:16 -0500
In-Reply-To: <20190928030910.GA5774@MiWiFi-R3L-srv> (Baoquan He's message of
 "Sat, 28 Sep 2019 11:09:10 +0800")
Message-ID: <87zhimks5j.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] x86/kdump: Fix 'kmem -s' reported an invalid freepointer
 when SME was active
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
To: Baoquan He <bhe@redhat.com>
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, Lianbo Jiang <lijiang@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Baoquan He <bhe@redhat.com> writes:

> On 09/27/19 at 09:32pm, Eric W. Biederman wrote:
>> Baoquan He <bhe@redhat.com> writes:
>> 
>> > On 09/27/19 at 03:49pm, Eric W. Biederman wrote:
>> >> Dave Young <dyoung@redhat.com> writes:
>> >> >> In order to avoid such problem, lets occupy the first 640k region when
>> >> >> SME is active, which will ensure that the allocated memory does not fall
>> >> >> into the first 640k area. So, no need to worry about whether kernel can
>> >> >> correctly copy the contents of the first 640K area to a backup region in
>> >> >> purgatory().
>> >> 
>> >> We must occupy part of the first 640k so that we can start up secondary
>> >> cpus unless someone has added another way to do that in recent years on
>> >> SME capable cpus.
>> >> 
>> >> Further there is Fimware/BIOS interaction that happens within those
>> >> first 640K.
>> >> 
>> >> Furthermore the kdump kernel needs to be able to read all of the memory
>> >> that the previous kernel could read.  Otherwise we can't get a crash
>> >> dump.
>> >> 
>> >> So I do not think ignoring the first 640K is the correct resolution
>> >> here.
>> >> 
>> >> > The log is too simple,  I know you did some other tries to fix this, but
>> >> > the patch log does not show why you can not correctly copy the 640k in
>> >> > current kdump code, in purgatory here.
>> >> >
>> >> > Also this patch seems works in your test, but still to see if other
>> >> > people can comment and see if it is safe or not, if any other risks
>> >> > other than waste the small chunk of memory.  If it is safe then kdump
>> >> > can just drop the backup logic and use this in common code instead of
>> >> > only do it for SME.
>> >> 
>> >> Exactly.
>> >> 
>> >> I think at best this avoids the symptoms, but does not give a reliable
>> >> crash dump.
>> >
>> > Sorry, didn't notice this comment at bottom.
>> >
>> > From code, currently the first 640K area is needed in two places.
>> > One is for 5-level trampoline during boot compressing stage, in
>> > find_trampoline_placement(). 
>> >
>> > The other is in reserve_real_mode(), as you mentioned, for application
>> > CPU booting.
>> >
>> > Only allow these two put data inside first 640K, then lock it done. It
>> > should not impact crash dump and parsing. And these two's content
>> > doesn't matter.
>> 
>> Do I understand correctly that the idea is that the kernel
>> that may crash will never touch these pages?  And that the reservation
>
> Thanks a lot for your comments, Eric.
>
> And yes. Except of the reserved real mode trampoline for secondary cpu if
> the trampoline is allocated in this area, it will be reused. We search area
> for real mode under 1M. Otherwise, the kernel that may crash will never
> touch these pages.
>
>> is not in the kernel that recovers from the crash?  That definitely
>
> You mean kdump kernel? Only the e820 reserved regions which are inserted
> into io_resource will be passed to kdump kernel, memblock reserved
> region is only seen by the present kernel.
>
> But for the content in first 640K, it's not erased, kdump kernel will
> ignore it and take it as a available memory resource into memory
> allocator.
>
>
>> needs a little better description.  I know it is not a lot on modern
>> systems but reserving an extra 1M of memory to avoid having to special
>> case it later seems in need of calling out.
>> 
>> I have an old system around that I think that 640K is about 25% of
>> memory.
>
> Understood. Basically 640K is wasted in this case. But we only do like
> this in SME case, a condition checking is added. And system with SME is
> pretty new model, it may not impact the old system.

The conditional really should be based on if we are reserving memory
for a kdump kernel.  AKA if crash_kernel=XXX is specified on the kernel
command line.

At which point I think it would be very reasonable to unconditionally
reserve the low 640k, and make the whole thing a non-issue.  This would
allow the kdump code to just not do anything special for any of the
weird special case.

It isn't perfect because we need a page or so used in the first kernel
for bootstrapping the secondary cpus, but that seems like the least of
evils.  Especially as no one will DMA to that memory.

So please let's just change what memory we reserve when crash_kernel is
specified.

>> How we interact with BIOS tables in the first 640k needs some
>> explanation.  Both in the first kernel and in the crash kernel.
>
> Yes, totally agree.
>
> Those BIOS tables have been reserved as e820 reserved regions and will
> be passed to kdump kernel for reusing. Memblock reserved 640K doesn't
> mean it will cover the whole [0, 640K) region, it only searches for
> available system RAM from memblock allocator.

Careful with that assumption.  My memory is that the e820 memory map
frequently fails to cover areas like the real mode interrupt descriptor
table at address 0.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
