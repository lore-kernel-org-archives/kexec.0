Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDz9L-0001le-K4
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 15:24:06 +0000
Date: Fri, 8 Mar 2013 16:23:34 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 5/8] kexec: extend hypercall with improved load/unload ops
Message-ID: <20130308152334.GA11057@debian70-amd64.local.net-space.pl>
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-6-git-send-email-david.vrabel@citrix.com>
 <20130308112301.GE10740@debian70-amd64.local.net-space.pl>
 <5139CE3C.8070801@citrix.com>
 <20130308122149.GH10740@debian70-amd64.local.net-space.pl>
 <5139EF2F.2060107@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5139EF2F.2060107@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On Fri, Mar 08, 2013 at 02:01:19PM +0000, David Vrabel wrote:
> On 08/03/13 12:21, Daniel Kiper wrote:
> > On Fri, Mar 08, 2013 at 11:40:44AM +0000, David Vrabel wrote:
> >> On 08/03/13 11:23, Daniel Kiper wrote:
> >>> On Thu, Feb 21, 2013 at 05:48:11PM +0000, David Vrabel wrote:
> >>>>
> >>>> +        /* Need to switch to 32-bit mode? */
> >>>> +        testq $KEXEC_RELOC_FLAG_COMPAT, %r8
> >>>> +        jnz call_32_bit
> >>>
> >>> Why do you need that? This is not needed because purgatory code
> >>> from kexec-tools always switches to 32-bit mode. Please check
> >>> kexec-tools/purgatory/arch/x86_64/entry64.S.
> >>
> >> The sub-architecture is a property of the image.  Why should the tool
> >> know or care about the sub-architecture of the hypervisor?
> >>
> >> The ABI isn't designed only for kexec-tools.
> >
> > OK, but I think it is much easier to assume that machine state
> > is not changed by kexec syscall/hypercall
>
> What machine state is that?  The one seen by the tools or the guest
> kernel or by the hypervisor?

State of machine set by hypervisor before purgatory call.

> The tools know what mode the image must be called it and it can tell the
> hypervisor and the hypervisor can trivial setup the correct mode.
>
> I propose:
>
> * Tools say: "here's an image, call it in mode X".
>
> You suggest:
>
> * Hypervisor implicitly says through some unspecified side channel: "I
> only call images in mode Y".

Purgatory is clearly defined. Please look into kexec-tools/purgatory.
It is integral part of kexec infrastructure.

> * Tools says: "here's an image. I set it up for mode Y. I hope that
> works for you."

New kernel is never called directly by old kernel in current kexec
implementations. New system is always started in following way:

old_kernel -> purgatory -> new_kernel

What purgatory does I described earlier more or less.

Why do you want change that? It works on many architectures.
Why do we need something different for Xen (and Xen only)?
If we choose existing solution we do not lose any flexiblity.
Additionally, we could maintain compatibilty at least with
Linux for nothing.

> Finally, the v1 interface will call images loaded by a 32-bit dom0
> kernel in 32-bit mode and we need to do continue to do the same.

Purgatory does it. It is used even with current
Xen kexec implementation.

> > Additionally, you duplicate code which exists and works well.
>
> It's only 17 instructions and 6 bytes of data.

For me it is always worth to optimize code. In this case too.
However, to be precise, if you remove this unneeded code then
you could gain PAGE_SIZE - 1 bytes in worst case. Just remove
.align PAGE_SIZE in xen/xen/arch/x86/x86_64/kexec_reloc.S.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
