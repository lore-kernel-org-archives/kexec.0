Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XKq5U-0005PW-Jc
 for kexec@lists.infradead.org; Fri, 22 Aug 2014 14:45:09 +0000
Date: Fri, 22 Aug 2014 22:44:41 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
Message-ID: <20140822144441.GA1694@dhcp-17-102.nay.redhat.com>
References: <53F11882.3060803@whissi.de> <20140818145718.GD4745@redhat.com>
 <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
 <20140820143315.GC16303@redhat.com>
 <CAGXu5jLxEoKEy0nw8qj0MW0f2Vpog-DtDi7OwnUrkh7jGSkdWw@mail.gmail.com>
 <20140821181000.GB21891@redhat.com>
 <20140822031941.GB2651@dhcp-17-37.nay.redhat.com>
 <20140822115902.GA12681@dhcp-16-116.nay.redhat.com>
 <20140822131623.GI5954@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140822131623.GI5954@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "Thomas D." <whissi@whissi.de>, Kexec Mailing List <kexec@lists.infradead.org>, Kees Cook <keescook@chromium.org>, WANG Chao <chaowang@redhat.com>

On 08/22/14 at 09:16am, Vivek Goyal wrote:
> On Fri, Aug 22, 2014 at 07:59:02PM +0800, Baoquan He wrote:
> 
> [..]
> > So we have 2 choices for kexec/kdump:
> > 1) kexec/kdump kernel need not randomize the kernel starting point.
> > Since kexec/kdump kernel is only for testing or emergencey, its life is
> > not too long.
> > 
> > 2) makes slots around the kernel input addr. This is only useful for
> > kexec. I can't imagine why kdump need it. 
> > 
> > 
> > 
> > 
> > Hi Thomas,
> > Could you test below patch? 
> > 
> > 
> > This is patch is from Lu Yinghai.
> > ---
> >  arch/x86/boot/compressed/misc.c |   14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > Index: linux-2.6/arch/x86/boot/compressed/misc.c
> > ===================================================================
> > --- linux-2.6.orig/arch/x86/boot/compressed/misc.c
> > +++ linux-2.6/arch/x86/boot/compressed/misc.c
> > @@ -235,8 +235,9 @@ static void error(char *x)
> >  		asm("hlt");
> >  }
> >  
> > -#if CONFIG_X86_NEED_RELOCS
> > -static void handle_relocations(void *output, unsigned long output_len)
> > +#ifdef CONFIG_X86_NEED_RELOCS
> > +static void handle_relocations(void *output_orig, void *output,
> > +			       unsigned long output_len)
> >  {
> >  	int *reloc;
> >  	unsigned long delta, map, ptr;
> > @@ -247,7 +248,7 @@ static void handle_relocations(void *out
> >  	 * Calculate the delta between where vmlinux was linked to load
> >  	 * and where it was actually loaded.
> >  	 */
> > -	delta = min_addr - LOAD_PHYSICAL_ADDR;
> > +	delta = min_addr - (unsigned long)output_orig;
> 
> So what does this patch actuall do? If I try to trace back output_orig,
> it seems to be same as LOAD_PHYSICAL_ADDR. That means there should not
> be any effect of this change? Or did I not understand it.

No, kexec kernel has to be relocatable kernel. so it shoule be the
value calculated by code block surrounded by the MACRO checking.

(startup_32 + %rip + BP_kernel_alignment -1 )& ~(BP_kernel_alignment-1)

#ifdef CONFIG_RELOCATABLE      
        leaq    startup_32(%rip) /* - $startup_32 */, %rbp
        movl    BP_kernel_alignment(%rsi), %eax 
        decl    %eax
        addq    %rax, %rbp     
        notq    %rax           
        andq    %rax, %rbp     
        cmpq    $LOAD_PHYSICAL_ADDR, %rbp
        jge     1f
#endif
        movq    $LOAD_PHYSICAL_ADDR, %rbp
1:        
          
        /* Target address to relocate to for decompression */
        leaq    z_extract_offset(%rbp), %rbx
> 
> Look at head_64.S
> 
> movq    $LOAD_PHYSICAL_ADDR, %rbp
> ...
> ...
> movq    %rbp, %r8               /* output target address */
> call    decompress_kernel       /* returns kernel location in %rax */
> 
> Thanks
> Vivek
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
