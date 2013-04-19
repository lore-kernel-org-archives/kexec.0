Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UT6NS-0007pG-Pg
 for kexec@lists.infradead.org; Fri, 19 Apr 2013 08:09:03 +0000
Date: Fri, 19 Apr 2013 10:08:41 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH 5/8] kexec: extend hypercall with improved load/unload ops
Message-ID: <20130419080841.GA3823@debian70-amd64.local.net-space.pl>
References: <1366132390-5269-1-git-send-email-david.vrabel@citrix.com>
 <1366132390-5269-6-git-send-email-david.vrabel@citrix.com>
 <20130417125106.GB906@debian70-amd64.local.net-space.pl>
 <51701F6D.6050608@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51701F6D.6050608@citrix.com>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Keir (Xen.org)" <keir@xen.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>

On Thu, Apr 18, 2013 at 05:29:33PM +0100, David Vrabel wrote:
> On 17/04/13 13:51, Daniel Kiper wrote:
> > On Tue, Apr 16, 2013 at 06:13:07PM +0100, David Vrabel wrote:
> >>
> >>      }
> >>
> >> +    code_page = __map_domain_page(image->control_code_page);
> >> +    memcpy(code_page, kexec_reloc, PAGE_SIZE);
> >
> > memcpy(code_page, kexec_reloc, kexec_reloc_size);
>
> kexec_reloc_size is absolute symbol and doing this give linker errors.

Yes, it should be changed to something like that:

kexec_reloc_size:
  .long . - xen_relocate_kernel

Somwhere in xen/include/asm-x86/machine_kexec.h:

extern unsigned int kexec_reloc_size;

> FWIW, Linux also uses a #define'd value for its similar memcpy.

I saw that sometime ago and I think this is a bug.
We should copy only kexec_reloc() code and nothing else.
Otherwise we ask for problems.

I am going to post relevant patches for this and
others kexec issues found in Linux Kernel.

> I have added a link time check that kexec_reloc_size <= PAGE_SIZE.

Good idea but it should be kexec_reloc_size <= KEXEC_CONTROL_PAGE_SIZE.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
