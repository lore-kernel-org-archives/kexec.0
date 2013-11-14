Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vgm8a-0002eM-JP
 for kexec@lists.infradead.org; Thu, 14 Nov 2013 01:54:29 +0000
Date: Thu, 14 Nov 2013 09:53:46 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 7/7 v2] x86: add xloadflags bit for efi runtime support
 on kexec
Message-ID: <20131114015346.GF4081@dhcp-16-126.nay.redhat.com>
References: <20131105082007.872550445@dhcp-16-126.nay.redhat.com>
 <20131105082719.416282009@dhcp-16-126.nay.redhat.com>
 <20131113155037.GE17248@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131113155037.GE17248@console-pimps.org>
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
To: Matt Fleming <matt@console-pimps.org>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 11/13/13 at 03:50pm, Matt Fleming wrote:
> On Tue, 05 Nov, at 04:20:14PM, dyoung@redhat.com wrote:
> > Old kexec-tools can not load new kernel. The reason is previously kexec-tools
> > do not fill efi_info in x86 setup header thus efi init fail and switch
> > to noefi boot. In new kexec-tools it will by default fill efi_info and
> > pass other efi required infomation to 2nd kernel so kexec kernel efi
> > initialization will success finally.
> > 
> > To prevent from breaking userspace, add a new xloadflags bit so kexec-tools
> > will check the flag and switch to old logic.
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  arch/x86/boot/header.S                |    9 ++++++++-
> >  arch/x86/include/uapi/asm/bootparam.h |    1 +
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > --- linux-2.6.orig/arch/x86/boot/header.S
> > +++ linux-2.6/arch/x86/boot/header.S
> > @@ -391,7 +391,14 @@ xloadflags:
> >  #else
> >  # define XLF23 0
> >  #endif
> > -			.word XLF0 | XLF1 | XLF23
> > +
> > +#if defined(CONFIG_X86_64) && defined(CONFIG_EFI)
> 
> && defined(CONFIG_KEXEC) ?

Will add above.

> 
> > +# define XLF4 XLF_EFI_KEXEC
> > +#else
> > +# define XLF4 0
> > +#endif
> > +
> 
> -- 
> Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
