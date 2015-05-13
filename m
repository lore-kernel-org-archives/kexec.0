Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YsRHQ-0007jh-3W
 for kexec@lists.infradead.org; Wed, 13 May 2015 07:40:37 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20150509152159.6b391c2b@hananiah.suse.cz>
 <20150509152159.6b391c2b@hananiah.suse.cz>
 <87y4ktjbe8.fsf@x220.int.ebiederm.org>
 <5553116A0200007800079D2D@mail.emea.novell.com>
Date: Wed, 13 May 2015 02:35:36 -0500
In-Reply-To: <5553116A0200007800079D2D@mail.emea.novell.com> (Jan Beulich's
 message of "Wed, 13 May 2015 07:55:06 +0100")
Message-ID: <87vbfxhquv.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: More on kexec/purgatory handover
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
To: Jan Beulich <JBeulich@suse.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>, Petr Tesarik <ptesarik@suse.cz>, xen-devel@lists.xen.org

"Jan Beulich" <JBeulich@suse.com> writes:

>>>> On 13.05.15 at 07:26, <ebiederm@xmission.com> wrote:
>> The low 640k was weird.   We copied it off in purgatory so that it could
>> be capture in a dump.  The linux kernel itself winds up using that
>> memory fundamentally because to fire up subsequent processors you have
>> to have memory in the low 640k as processors start in real-mode and
>> the startup IPI only takes an address in the low 1M.  I also remember
>> things with interrupt descriptor tables.
>
> Right, but the point to clarify is whether it is reasonable for the
> purgatory and/or new kernel to expect the old kernel to set up
> mappings for special regions like this one. As said before - I don't
> think this should be done; the old (possibly half broken) kernel
> shouldn't be forced to do any more than the absolute minimum
> amount of work to be able to transfer control.

When transfering control in 64bit mode on x86_64.  A one-to-one virtual
to physical identity mapping must be set up.  That identity map must be
set up before transfering control to the kexec destination.  That
mapping must cover all pages in the destination image.  

Those page tables should be created before the old kernel gets into a
broken state.

Fundamentally if you are transfering control in long mode you have to
set up some page table.  I giant identity mapped page table that can use
1G or 2M pages takes up very little memory, and can be very simply
and easily before the transfer of control takes place.

All you have to do when you are in a half broken state is load cr3.
Possible after verifying a checksum.

640k in this case I don't think is particularly special, and certainly
not worth a special case.  The in-kernel implementation on x86_64 sets
up a page table for all of memory which because of the availability of
huge pages winds up being simple and trivial.

Weird things like copying off the 640k region for the kexec-on-panic
case can be done in the adapter/purgatory piece that lives between the
two kernels.

So at a very practical level I think we shouldn't have mappings for
special regions we should just have mappings for all of memory.
KISS.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
