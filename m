Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aR6JD-0007pA-Dr
 for kexec@lists.infradead.org; Wed, 03 Feb 2016 22:54:01 +0000
Received: by mail-wm0-x22e.google.com with SMTP id p63so92535491wmp.1
 for <kexec@lists.infradead.org>; Wed, 03 Feb 2016 14:53:36 -0800 (PST)
Date: Wed, 3 Feb 2016 22:53:33 +0000
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH] x86/efi: skip bgrt init for kexec reboot
Message-ID: <20160203225333.GA31246@codeblueprint.co.uk>
References: <20160127112044.GA2961@dhcp-128-65.nay.redhat.com>
 <20160203214200.GA15110@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160203214200.GA15110@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, 04 Feb, at 05:42:00AM, Dave Young wrote:
> 
> On 01/27/16 at 07:20pm, Dave Young wrote:
> > For kexec reboot the bgrt image address could contains random data because
> > we have freed boot service areas in 1st kernel boot phase. One possible
> > result is kmalloc fail in efi_bgrt_init due to large random image size.
> > 
> > So change efi_late_init to avoid efi_bgrt_init in case kexec boot.
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  arch/x86/platform/efi/efi.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > --- linux-x86.orig/arch/x86/platform/efi/efi.c
> > +++ linux-x86/arch/x86/platform/efi/efi.c
> > @@ -531,7 +531,8 @@ void __init efi_init(void)
> >  
> >  void __init efi_late_init(void)
> >  {
> > -	efi_bgrt_init();
> > +	if (!efi_setup)
> > +		efi_bgrt_init();
> >  }
> >  
> >  void __init efi_set_executable(efi_memory_desc_t *md, bool executable)
> 
> Matt, opinions about this patch?

Yeah, I'm not happy seeing efi_setup escaping into even more places,
nor am I happy to see more code paths introduced where kexec boot is
special-cased.

I'll reply with more details tomorrow.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
