Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDwJF-0002HU-Re
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 12:22:02 +0000
Date: Fri, 8 Mar 2013 13:21:49 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 5/8] kexec: extend hypercall with improved load/unload ops
Message-ID: <20130308122149.GH10740@debian70-amd64.local.net-space.pl>
References: <1361468894-18655-1-git-send-email-david.vrabel@citrix.com>
 <1361468894-18655-6-git-send-email-david.vrabel@citrix.com>
 <20130308112301.GE10740@debian70-amd64.local.net-space.pl>
 <5139CE3C.8070801@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5139CE3C.8070801@citrix.com>
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

On Fri, Mar 08, 2013 at 11:40:44AM +0000, David Vrabel wrote:
> On 08/03/13 11:23, Daniel Kiper wrote:
> > On Thu, Feb 21, 2013 at 05:48:11PM +0000, David Vrabel wrote:
> >>
> >> +        /* Need to switch to 32-bit mode? */
> >> +        testq $KEXEC_RELOC_FLAG_COMPAT, %r8
> >> +        jnz call_32_bit
> >
> > Why do you need that? This is not needed because purgatory code
> > from kexec-tools always switches to 32-bit mode. Please check
> > kexec-tools/purgatory/arch/x86_64/entry64.S.
>
> The sub-architecture is a property of the image.  Why should the tool
> know or care about the sub-architecture of the hypervisor?
>
> The ABI isn't designed only for kexec-tools.

OK, but I think it is much easier to assume that machine state
is not changed by kexec syscall/hypercall and move out this
task to separate module (in this case purgatory code) which does
all needed things (in this case sets it to "native" mode which is
close to machine state after BIOS initialization; as I know this
assumption is common for other architectures too). This way you
could get what you need (e.g. 64-bit -> 64-bit, 64-bit -> 32-bit, ...)
without changing a single instruction in hypervisor or kernel.
Just do changes in purgatory (it could be called differently in
your private kexec-tool) and voila.

Additionally, you duplicate code which exists and works well.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
