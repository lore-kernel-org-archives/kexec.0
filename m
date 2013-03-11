Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UF2oR-000314-UJ
 for kexec@lists.infradead.org; Mon, 11 Mar 2013 13:30:48 +0000
Date: Mon, 11 Mar 2013 14:30:37 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] [PATCH 5/8] kexec: extend hypercall with improved
 load/unload ops
Message-ID: <20130311133037.GB13175@debian70-amd64.local.net-space.pl>
References: <20130308112301.GE10740@debian70-amd64.local.net-space.pl>
 <5139CE3C.8070801@citrix.com>
 <20130308122149.GH10740@debian70-amd64.local.net-space.pl>
 <5139EF2F.2060107@citrix.com>
 <20130308152334.GA11057@debian70-amd64.local.net-space.pl>
 <513A1FE1.9040407@citrix.com>
 <20130308214547.GC11057@debian70-amd64.local.net-space.pl>
 <513A765B.8000709@citrix.com>
 <20130311111720.GA13175@debian70-amd64.local.net-space.pl>
 <513DDA5A.7090409@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <513DDA5A.7090409@citrix.com>
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
Cc: Andrew Cooper <Andrew.Cooper3@citrix.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On Mon, Mar 11, 2013 at 01:21:30PM +0000, David Vrabel wrote:
> On 11/03/13 11:17, Daniel Kiper wrote:
> >
> > Heh... It looks that there is a misunderstanding. At first I thought
> > that David was going to replace purgatory functionality by switching
> > from 64-bit to 32-bit in kexec_reloc. But later I realized that
> > I missed Xen 64-bit/dom 32-bit case. Now I agree that this switch
> > must stay as is. However, now I think that there is another
> > small mistake which should be fixed. Please look above.
>
> Which mistake?  I'm not sure what you're referring to.

I thought about that:

if ( image->arch == EM_386 )
  reloc_flags |= KEXEC_RELOC_FLAG_COMPAT;

It should be change to:

if ( is_pv_32on64_domain(dom0) )
  reloc_flags |= KEXEC_RELOC_FLAG_COMPAT;

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
