Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fAuxc-0005l7-Rd
 for kexec@lists.infradead.org; Tue, 24 Apr 2018 10:14:10 +0000
Date: Tue, 24 Apr 2018 12:13:49 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] RFC Xen signature verification for kexec
Message-ID: <20180424101349.GJ6312@olila.local.net-space.pl>
References: <81714431-9776-7247-86db-c035fa3d2ce6@oracle.com>
 <5ADD837102000078001BD675@prv1-mh.provo.novell.com>
 <20180423102500.GI6312@olila.local.net-space.pl>
 <5ADDB67002000078001BD805@prv1-mh.provo.novell.com>
 <CAFLBxZZPkJU-iifT7037AQzLEd9_uHm8S6FWhP_U1WypMwexyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFLBxZZPkJU-iifT7037AQzLEd9_uHm8S6FWhP_U1WypMwexyQ@mail.gmail.com>
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
To: George Dunlap <dunlapg@umich.edu>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, Eric DeVolder <eric.devolder@oracle.com>, kexec@lists.infradead.org, Jan Beulich <JBeulich@suse.com>, Xen-devel <xen-devel@lists.xen.org>

On Tue, Apr 24, 2018 at 10:46:38AM +0100, George Dunlap wrote:
> On Mon, Apr 23, 2018 at 11:33 AM, Jan Beulich <JBeulich@suse.com> wrote:
> >>>> On 23.04.18 at 12:25, <daniel.kiper@oracle.com> wrote:
> >> On Mon, Apr 23, 2018 at 12:55:45AM -0600, Jan Beulich wrote:
> >>> >>> On 20.04.18 at 21:12, <eric.devolder@oracle.com> wrote:
> >>> > Two options for signature verification in Xen
> >>> >
> >>> > This proposal outlines two options under consideration for enhancing
> >>> > Xen to support signature verification of kexec loaded images. The
> >>> > first option is essentially to mirror Linux signature verification
> >>> > code into Xen. The second option utilizes components from sources
> >>> > other than Linux (for example, libgcrypt rather than linux/crypto).
> >>> >
> >>> > NOTE: An option to utilize dom0 kernel signature verification does not
> >>> > prevent the exploit as user space can invoke the hypercall directly,
> >>> > bypassing dom0.
> >>>
> >>> Not exactly - this option nevertheless exists, albeit is perhaps
> >>> unattractive: No user space component can issue hypercalls
> >>> directly, they always go through the privcmd driver. Hence the
> >>> driver cold snoop the kexec hypercall.
> >>
> >> Hmmm... Is not it a problem from security point of view for us in this
> >> case? It should not if dom0 kernel is signed. It have to be signed here.
> >> Just thinking a loud...
> >
> > I'm afraid I don't understand: If the Dom0 kernel isn't signed (or hasn't
> > been verified), the system is insecure in the first place. No reason to
> > bother measuring the kexec kernel then.
>
> I think you're both saying the same thing.
>
> FWIW I wouldn't mind coming up with a hypercall that the privcmd
> driver refuses to pass-through as-is, and having some way for the
> tools to ask the kernel to check the signature.

I have a feeling that I should reformulate the question: How far the Xen
hypervisor trusts the privcmd driver? If the privcmd driver is signed
then at first sight there should not be a problem. However, we can be
more strict and require that (every? Daniel is running away...) hypercall
from privcmd to Xen should be verified somehow. Maybe I am overzealous but
I think that it make sense to discuss this now than later have problems.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
