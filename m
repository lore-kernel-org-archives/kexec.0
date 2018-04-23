Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fAYes-0002su-7J
 for kexec@lists.infradead.org; Mon, 23 Apr 2018 10:25:21 +0000
Date: Mon, 23 Apr 2018 12:25:00 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] RFC Xen signature verification for kexec
Message-ID: <20180423102500.GI6312@olila.local.net-space.pl>
References: <81714431-9776-7247-86db-c035fa3d2ce6@oracle.com>
 <5ADD837102000078001BD675@prv1-mh.provo.novell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5ADD837102000078001BD675@prv1-mh.provo.novell.com>
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
To: jbeulich@suse.com, eric.devolder@oracle.com
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>, kexec@lists.infradead.org, xen-devel@lists.xen.org

On Mon, Apr 23, 2018 at 12:55:45AM -0600, Jan Beulich wrote:
> >>> On 20.04.18 at 21:12, <eric.devolder@oracle.com> wrote:
> > Two options for signature verification in Xen
> >
> > This proposal outlines two options under consideration for enhancing
> > Xen to support signature verification of kexec loaded images. The
> > first option is essentially to mirror Linux signature verification
> > code into Xen. The second option utilizes components from sources
> > other than Linux (for example, libgcrypt rather than linux/crypto).
> >
> > NOTE: An option to utilize dom0 kernel signature verification does not
> > prevent the exploit as user space can invoke the hypercall directly,
> > bypassing dom0.
>
> Not exactly - this option nevertheless exists, albeit is perhaps
> unattractive: No user space component can issue hypercalls
> directly, they always go through the privcmd driver. Hence the
> driver cold snoop the kexec hypercall.

Hmmm... Is not it a problem from security point of view for us in this
case? It should not if dom0 kernel is signed. It have to be signed here.
Just thinking a loud...

> > #####
> > Option 2: Enable signature verification in Xen utilizing libgcrypt
> >
> > This option is similar to Option 1, but utilizes libgcrypt
> > crytpo library rather than linux/crypto files.
> >
> > Pros:
> > - Libgcrypt is LGPLv2.1+ license.
> > - Eliminates problematic scenario of tracking changes to
> >    linux/crypto sources in Xen, and vice versa in Linux.
>
> As an initial reaction, of the two options presented I'd prefer this
> 2nd one, for this specific reason.
>
> > Cons:
> > - Introduces a dependency on libgcrypt
> > - Still relying on lifting many Linux kernel sources for PE file
> >    handling, certificate handling, etc. However, an alternative
> >    source for PE file handling is shim.
>
> That's under the assumption that PE files are the only containers usable
> to carry certificates, which I consider odd, not the least because Linux
> kernel modules aren't PE either. If the kernel was carrying its certificate

I do not think that we care about kernel modules format here...

> in a way (also) accessible without parsing PE structures, this dependency
> could be dropped.

IIRC kexec-tools feeds one file with signature attached into Linux
kernel via syscall. It does not support detached signatures. Does it?
Eric, could you check it? If it does not then we have to add some
code into kexec-tools too. However, I do not think that gain in Xen
code will be significant. PE file parsing in this case should be simple.
The largest part still would be PKCS#7 and/or PEM parser. Hmmm...
There is a chance that there is a lib floating around which does that.
Eric, please double check it.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
