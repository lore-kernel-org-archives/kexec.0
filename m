Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PBROl-0007ZC-LN
	for kexec@lists.infradead.org; Thu, 28 Oct 2010 12:16:05 +0000
Date: Thu, 28 Oct 2010 21:16:27 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH,RFC] - make /proc/vmcore accesable on x86_64
Message-ID: <20101028121627.GE16206@verge.net.au>
References: <20101019150630.GA1870@jolsa.brq.redhat.com>
	<20101022085412.GA8267@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20101022085412.GA8267@verge.net.au>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: kexec@lists.infradead.org

On Fri, Oct 22, 2010 at 10:54:12AM +0200, Simon Horman wrote:
> On Tue, Oct 19, 2010 at 05:06:30PM +0200, Jiri Olsa wrote:
> > hi,
> > 
> > I was playing around with preserve context feature on x86_64
> > and was not able to get the /proc/vmcore in the kexec-ed
> > kernel until I aplied attached patch.
> > 
> > I'm not at all sure this is right fix ;) but it seems
> > that /proc/vmcore is not loaded since the machine field in the
> > elf header is wrong.
> > 
> > 
> > If the x86_64 arch returns 0 (KEXEC_ARCH_DEFAULT) then following
> > condition in load_crashdump_segments function will fill 386 as the
> > machine for the vmcore elf header..
> > 
> > ...
> > 
> >         if ((info->kexec_flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_X86_64)
> >         {
> >                 elf_info.machine = EM_X86_64;
> >         } else {
> >                 elf_info.machine       = EM_386;
> >                 elf_info.lowmem_limit  = X86_MAXMEM;
> >                 elf_info.get_note_info = get_crash_notes;
> >         }
> > ...
> > 
> > ending with kexec-ed kernel failing check for the machine,
> > and disabling vmcore interface...
> > 
> > 
> > I'm guessing that the reason is the load_crashdump_segments function
> > being shared among 32 and 64 bits.. but again, not sure ;)
> > 
> > 
> > My goal is to share data within the host and kexec-ed kernel,
> > so I'd like to use the /proc/vmcore for that.. any other
> > ideas are welcome :)
> 
> This approach seems reasonable to me.
> I'll push it if a I don't hear any objections
> in the near future.

Hi Jiru,

could you please submit this as a formal patch with a signed-off-by line?

> > thanks,
> > jirka
> > ---
> > diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> > index 06e5ae9..40f989a 100644
> > --- a/kexec/arch/i386/crashdump-x86.c
> > +++ b/kexec/arch/i386/crashdump-x86.c
> > @@ -691,6 +691,8 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> >  	struct memory_range *mem_range, *memmap_p;
> >  	struct crash_elf_info elf_info;
> >  
> > +	memset(&elf_info, 0x0, sizeof(elf_info));
> > +
> >  	/* Constant parts of the elf_info */
> >  	elf_info.data             = ELFDATA2LSB;
> >  	elf_info.backup_src_start = BACKUP_SRC_START;
> > diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
> > index 3092643..c34fd92 100644
> > --- a/kexec/arch/x86_64/kexec-x86_64.c
> > +++ b/kexec/arch/x86_64/kexec-x86_64.c
> > @@ -134,10 +134,7 @@ int arch_process_options(int argc, char **argv)
> >  }
> >  
> >  const struct arch_map_entry arches[] = {
> > -	/* For compatibility with older patches
> > -	 * use KEXEC_ARCH_DEFAULT instead of KEXEC_ARCH_X86_64 here.
> > -	 */
> > -	{ "x86_64", KEXEC_ARCH_DEFAULT },
> > +	{ "x86_64", KEXEC_ARCH_X86_64 },
> >  	{ NULL, 0 },
> >  };
> >  
> > 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
