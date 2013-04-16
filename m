Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1US4eI-0004Ni-Nz
 for kexec@lists.infradead.org; Tue, 16 Apr 2013 12:06:11 +0000
Date: Tue, 16 Apr 2013 14:05:41 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 5/8] kexec: extend hypercall with improved load/unload ops
Message-ID: <20130416120541.GA4286@debian70-amd64.local.net-space.pl>
References: <1365447593-11988-1-git-send-email-david.vrabel@citrix.com>
 <1365447593-11988-6-git-send-email-david.vrabel@citrix.com>
 <20130409210241.GB31533@debian70-amd64.local.net-space.pl>
 <516C4DD6.4020805@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <516C4DD6.4020805@citrix.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Ian Jackson <Ian.Jackson@eu.citrix.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Ian Campbell <Ian.Campbell@citrix.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On Mon, Apr 15, 2013 at 07:58:30PM +0100, David Vrabel wrote:
> On 09/04/13 22:02, Daniel Kiper wrote:
> > On Mon, Apr 08, 2013 at 07:59:50PM +0100, David Vrabel wrote:
> >>
> >> +
> >> +        /* Jump to identity mapped code. */
> >> +        movq %rdi, %r9
> >> +        addq $(identity_mapped - kexec_reloc), %r9
> >> +
> >> +        jmp *%r9
> >
> > jmpq *(identity_mapped - kexec_reloc)(%rdi)
>
> This isn't equivalent.  It loads the value at the specified memory
> location and jumps to that address.
>
>         leaq (identity_mapped - kexec_reloc)(%rdi), %rax
>         jmpq *%rax
>
> Does the right thing.

You are right. Sorry for confusion.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
