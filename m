Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WkPsE-0004yz-Rr
 for kexec@lists.infradead.org; Wed, 14 May 2014 03:28:55 +0000
Date: Wed, 14 May 2014 11:28:30 +0800
From: WANG Chao <chaowang@redhat.com>
Subject: Re: [PATCH] x86, cleanup: remove cmdline_add_memmap_acpi
Message-ID: <20140514032830.GG15396@dhcp-17-89.nay.redhat.com>
References: <1399956694-24353-1-git-send-email-chaowang@redhat.com>
 <20140513070901.GA3279@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140513070901.GA3279@darkstar.nay.redhat.com>
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
Cc: horms@verge.net.au, kexec@lists.infradead.org

On 05/13/14 at 03:09pm, Dave Young wrote:
> Thanks for the cleanup..
> 
> On 05/13/14 at 12:51pm, WANG Chao wrote:
> > In kdump path, now we store all the 2nd kernel memory ranges in
> > memmap_p. We could use just cmdline_add_memmap() to add all types of
> > memory ranges to 2nd kernel cmdline.
> > 
> > So clean up here, merge cmdline_add_memmap_acpi() into
> > cmdline_add_memmap().
> > 
> > Signed-off-by: WANG Chao <chaowang@redhat.com>
> > ---
> >  kexec/arch/i386/crashdump-x86.c | 41 ++++++++++++-----------------------------
> >  1 file changed, 12 insertions(+), 29 deletions(-)
> > 
> > diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> > index 15ac4b5..207b031 100644
> > --- a/kexec/arch/i386/crashdump-x86.c
> > +++ b/kexec/arch/i386/crashdump-x86.c
> > @@ -667,18 +667,22 @@ static int cmdline_add_memmap(char *cmdline, struct memory_range *memmap_p)
> >  	strcat(cmdline, str_mmap);
> >  
> >  	for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
> > -		unsigned long startk, endk;
> > +		unsigned long startk, endk, type;
> >  		startk = (memmap_p[i].start/1024);
> >  		endk = ((memmap_p[i].end + 1)/1024);
> > +		type = memmap_p[i].type;
> >  		if (!startk && !endk)
> >  			/* All regions traversed. */
> >  			break;
> >  
> > -		/* A region is not worth adding if region size < 100K. It eats
> > -		 * up precious command line length. */
> > -		if ((endk - startk) < min_sizek)
> > +		/* A RAM region is not worth adding if region size < 100K.
> > +		 * It eats up precious command line length. */
> > +		if (type == RANGE_RAM && (endk - startk) < min_sizek)
> >  			continue;
> > -		cmdline_add_memmap_internal(cmdline, startk, endk, RANGE_RAM);
> > +		/* And do not add e820 reserved region either */
> > +		if (type == RANGE_RESERVED)
> > +			continue;
> 
> How about move above 2 lines to the begining of the loop, such as
> 
> if (type != RANGE_RAM && (type != RANGE_ACPI) && (type != RANGE_ACPI_NVS))
> 	continue;
> 
> Because for cmdline mode we only take care of these types, it will still work
> if there's more types in the future.

Sure. Will do.

> 
> > +		cmdline_add_memmap_internal(cmdline, startk, endk, type);
> >  	}
> >  
> >  	dbgprintf("Command line after adding memmap\n");
> > @@ -767,26 +771,6 @@ static enum coretype get_core_type(struct crash_elf_info *elf_info,
> >  	}
> >  }
> >  
> > -/* Appends memmap=X#Y commandline for ACPI to command line*/
> > -static int cmdline_add_memmap_acpi(char *cmdline, unsigned long start,
> > -					unsigned long end)
> > -{
> > -	int align = 1024;
> > -	unsigned long startk, endk;
> > -
> > -	if (!(end - start))
> > -		return 0;
> > -
> > -	startk = start/1024;
> > -	endk = (end + align - 1)/1024;
> 
> The endk here is different from the one in cmdline_add_memmap?

Good catch. Seems we need take care of these accordingly.

> 
> > -	cmdline_add_memmap_internal(cmdline, startk, endk, RANGE_ACPI);
> > -
> > -	dbgprintf("Command line after adding acpi memmap\n");
> > -	dbgprintf("%s\n", cmdline);
> > -
> > -	return 0;
> > -}
> > -
> >  /* Appends 'acpi_rsdp=' commandline for efi boot crash dump */
> >  static void cmdline_add_efi(char *cmdline)
> >  {
> > @@ -981,8 +965,6 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> >  	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
> >  	if (delete_memmap(memmap_p, &nr_memmap, elfcorehdr, memsz) < 0)
> >  		return -1;
> > -	if (arch_options.pass_memmap_cmdline)
> > -		cmdline_add_memmap(mod_cmdline, memmap_p);
> >  	if (!bzImage_support_efi_boot)
> >  		cmdline_add_efi(mod_cmdline);
> >  	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
> > @@ -999,10 +981,11 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
> >  		type = mem_range[i].type;
> >  		size = end - start + 1;
> >  		add_memmap(memmap_p, &nr_memmap, start, size, type);
> > -		if (arch_options.pass_memmap_cmdline && type != RANGE_RESERVED)
> > -			cmdline_add_memmap_acpi(mod_cmdline, start, end);
> >  	}
> >  
> > +	if (arch_options.pass_memmap_cmdline)
> > +		cmdline_add_memmap(mod_cmdline, memmap_p);
> > +
> >  	/* Store 2nd kernel boot memory ranges for later reference in
> >  	 * x86-setup-linux.c: setup_linux_system_parameters() */
> >  	info->crash_range = memmap_p;
> > -- 
> > 1.9.0
> > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
