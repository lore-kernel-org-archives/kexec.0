Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wt0Ax-0001gQ-1t
 for kexec@lists.infradead.org; Fri, 06 Jun 2014 19:51:43 +0000
Date: Fri, 6 Jun 2014 15:51:04 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 09/13] purgatory: Core purgatory functionality
Message-ID: <20140606195104.GM1526@redhat.com>
References: <1401800822-27425-1-git-send-email-vgoyal@redhat.com>
 <1401800822-27425-10-git-send-email-vgoyal@redhat.com>
 <20140605200523.GB26110@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140605200523.GB26110@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, bhe@redhat.com, jkosina@suse.cz, greg@kroah.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, dyoung@redhat.com, chaowang@redhat.com

On Thu, Jun 05, 2014 at 10:05:23PM +0200, Borislav Petkov wrote:

[..]
> > @@ -249,6 +254,7 @@ archclean:
> >  	$(Q)rm -rf $(objtree)/arch/x86_64
> >  	$(Q)$(MAKE) $(clean)=$(boot)
> >  	$(Q)$(MAKE) $(clean)=arch/x86/tools
> 
> ifeq ($(CONFIG_KEXEC),y)
> 	$(Q)$(MAKE) $(clean)=arch/x86/purgatory
> endif

Hmm.., is it strictly required? I am wondering what happens if I build
a kernel with CONFIG_KEXEC=y, then set CONFIG_KEXEC=n and do "make clean".
I think I will still like any files in arch/x86/purgatory to be cleaned
despite the fact that CONFIG_KEXEC=n. Isn't it?

[..]
> > +ifeq ($(CONFIG_X86_64),y)
> > +KBUILD_CFLAGS	:= -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -mcmodel=large -Os -fno-builtin -ffreestanding -c -MD
> > +else
> > +KBUILD_CFLAGS	:= -fno-strict-aliasing -Wall -Wstrict-prototypes -fno-zero-initialized-in-bss -Os -fno-builtin -ffreestanding -c -MD -m32
> > +endif
> 
> Those variable assignments have a lot of duplication, let's simplify
> (diff ontop):

Thanks. This looks cleaner and also highlights the difference between
x86_64 and x86. Will change.

[..]
> > +	.section ".rodata"
> > +	.balign 4
> > +entry64_regs:
> > +rax:	.quad 0x00000000
> 
> Simply 0x0? Or am I missing something?

I think .quad 0x0 should work. Will use it.

[..]
> > +	sha256_final(&sctx, digest);
> > +
> > +	if (memcmp(digest, sha256_digest, sizeof(digest)) != 0)
> 
> 	if (memcmp(...))
> 		return 1;
> 
> should be a bit cleaner.
> 

Ok. Will do.

[..]
> > +void purgatory(void)
> > +{
> > +	int ret;
> > +
> > +	ret = verify_sha256_digest();
> > +	if (ret) {
> > +		/* loop forever */
> > +		for (;;);
> 
> checkpatch bitches about this:
> 
> ERROR: trailing statements should be on next line
> #303: FILE: arch/x86/purgatory/purgatory.c:68:
> +               for (;;);

Ok, will move semicolon to next line.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
