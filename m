Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YsSe4-0004LG-IZ
 for kexec@lists.infradead.org; Wed, 13 May 2015 09:08:05 +0000
Date: Wed, 13 May 2015 11:07:37 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: More on kexec/purgatory handover
Message-ID: <20150513110737.74a72429@hananiah.suse.cz>
In-Reply-To: <5553239F0200007800079DEE@mail.emea.novell.com>
References: <20150509152159.6b391c2b@hananiah.suse.cz>
 <20150509152159.6b391c2b@hananiah.suse.cz>
 <87y4ktjbe8.fsf@x220.int.ebiederm.org>
 <5553116A0200007800079D2D@mail.emea.novell.com>
 <5553116A0200007800079D2D@mail.emea.novell.com>
 <87vbfxhquv.fsf@x220.int.ebiederm.org>
 <5553239F0200007800079DEE@mail.emea.novell.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jan Beulich <JBeulich@suse.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, xen-devel@lists.xen.org, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, David Vrabel <david.vrabel@citrix.com>

On Wed, 13 May 2015 09:12:47 +0100
"Jan Beulich" <JBeulich@suse.com> wrote:

> >>> On 13.05.15 at 09:35, <ebiederm@xmission.com> wrote:
> > Fundamentally if you are transfering control in long mode you have to
> > set up some page table.  I giant identity mapped page table that can use
> > 1G or 2M pages takes up very little memory, and can be very simply
> > and easily before the transfer of control takes place.
> > 
> > All you have to do when you are in a half broken state is load cr3.
> > Possible after verifying a checksum.
> > 
> > 640k in this case I don't think is particularly special, and certainly
> > not worth a special case.  The in-kernel implementation on x86_64 sets
> > up a page table for all of memory which because of the availability of
> > huge pages winds up being simple and trivial.
> > 
> > Weird things like copying off the 640k region for the kexec-on-panic
> > case can be done in the adapter/purgatory piece that lives between the
> > two kernels.
> > 
> > So at a very practical level I think we shouldn't have mappings for
> > special regions we should just have mappings for all of memory.
> 
> But in all of the above you (a) forget that setting up 1:1
> mappings for all memory isn't as simple as putting in place a
> couple of 1G pages - holes need to be accounted for and must
> at best be mapped UC (that's especially an issue with the low
> 640k) and (b) imply that whatever Linux behavior there is, Xen
> should mimic it (ignoring for example the fact that with the non-
> kernel based kexec which newer Xen and tools support such 1:1
> mapping setup doesn't appear to be required, i.e. [supposed]
> requirements change).

IIUC the problem here is that the Xen hypervisor has reused part of
kexec infrastructure without providing full compatibility.

In other words, what prevents you from using your own bootloader glue
code (aka purgatory in Linux kexec)?

OTOH I agree that the pagetables could be constructed by the 64-bit
purgatory code itself to make it less dependent on the old kernel.
Especially if Eric considers the task trivial...

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
