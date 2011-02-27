Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PtlQb-0003YK-AP
	for kexec@lists.infradead.org; Sun, 27 Feb 2011 18:33:10 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20110226162008.GA23879@laptop> <4D6972CE.8040401@zytor.com>
	<m14o7q5m6d.fsf@fess.ebiederm.org> <20110227132409.GA4036@laptop>
Date: Sun, 27 Feb 2011 10:32:43 -0800
In-Reply-To: <20110227132409.GA4036@laptop> (Ahmed S. Darwish's message of
	"Sun, 27 Feb 2011 15:24:09 +0200")
Message-ID: <m1vd055nw4.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: Saveoops: Making Kexec purgatory position-independent?
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: X86-ML <x86@kernel.org>, KEXEC-ML <kexec@lists.infradead.org>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Vivek Goyal <vgoyal@redhat.com>

"Ahmed S. Darwish" <darwish.07@gmail.com> writes:

> On Sat, Feb 26, 2011 at 04:57:30PM -0800, Eric W. Biederman wrote:
>> "H. Peter Anvin" <hpa@zytor.com> writes:
>> >
>> > I can't see any sane reason to *not* make kexec purgatory
>> > position-independent.  It is the obvious thing to do.
>> 
>> This isn't a case of the code not being position independent.  This is
>> case of where the relocations are applied.
>> 
>> I can see a couple of handling this with different tradeoffs.
>> 
>> 1) We teach bootloaders how to load two kernels at once.  This
>>    completely avoids the purgatory, as it is replaced by code in the
>>    bootloader that already exists to load the primary kernel and setup
>>    it's arguments.
>> 
>
> This is in fact my plan. Using Syslinux, I loaded 'purgatory.ro' to RAM
> thinking that it will still be needed. Re-checking the purgatory code
> now after reading above note, it seems it does 5 important points:
>
>    a) reset the VGA (if instructed)
>    b) reset the PIC to legacy mode (if instructed)
>    c) check the overall integrity of the second kernel image (SHA-2)
>    d) setup the environment for second kernel entry (switch back to
>       32-bit protected mode in x86-64, reset registers, etc)
>    e) saves the first 640K in a backup region
>
> So (a) and (b) can be done elsewhere if needed; (c) isn't needed cause
> if the bootloader corrupts images, we have bigger problems; (d) can be
> done as a stub; (e), on the contrary of kdump, isn't critical for my
> goals.

(c) Is needed somewhere on the initialization path, because we don't start
    running until after a kernel has crashed.  For a first prototype it
    can probably be skipped.
(e) Is there because the first 640K is the only memory of the original
    kernel that we use.

I suspect the copying of the first 640K to somewhere reserved for it,
and the verifying the sha256 checksum are things we can move into the
kernels boot.

But seriously prototype it and get something that works.  I don't know
of a case where in practice I have gotten a checksum failure.

Saving the first 640K is sort of important but again we don't do much
down there except boot secondary cpus so you can probably deal with that
later.

There is also some magic we do with ELF headers to describe memory
regions and to find elf notes written by the crashed kernel when it goes
down.  Those notes the existing tools use to find all kinds of things.
See vmcore-to-dmesg in the /sbin/kexec source tree.  If you don't want
the full core I expect you want to be able to run that program.

I'm not ready to change how the crash recovery kernel on finds what is
going on.  The elf header and elf notes.  It is already kernel agnostic
etc, but I am totally willing to change how we implement it.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
