Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vymwv-0001Os-9r
 for kexec@lists.infradead.org; Thu, 02 Jan 2014 18:24:56 +0000
Date: Thu, 2 Jan 2014 12:24:30 -0600
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: [PATCH 2/2] makedumpfile: exclude unused vmemmap pages > (Cliff
 Wickman)
Message-ID: <20140102182430.GA23662@sgi.com>
References: <mailman.18142.1388532985.1059.kexec@lists.infradead.org>
 <1324606289.23678103.1388681414693.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1324606289.23678103.1388681414693.JavaMail.root@redhat.com>
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
To: Dave Anderson <anderson@redhat.com>
Cc: kexec@lists.infradead.org

On Thu, Jan 02, 2014 at 11:50:14AM -0500, Dave Anderson wrote:
> 
> 
> ----- Original Message -----
> > Date: Tue, 31 Dec 2013 17:36:02 -0600
> > From: Cliff Wickman <cpw@sgi.com>
> > To: kexec@lists.infradead.org, d.hatayama@jp.fujitsu.com,
> > 	kumagai-atsushi@mxc.nes.nec.co.jp
> > Subject: [PATCH 2/2] makedumpfile: exclude unused vmemmap pages
> > Message-ID: <20131231233602.GB18522@sgi.com>
> > Content-Type: text/plain; charset=us-ascii
> > 
> > On Tue, Dec 31, 2013 at 05:30:01PM -0600, cpw wrote:
> > 
> > Exclude kernel pages that contain nothing but page structures for pages
> > that are not being included in the dump.
> > These can amount to 3.67 million pages per terabyte of system memory!
> > 
> > The kernel's page table, starting at virtual address 0xffffea0000000000, is
> > searched to find the actual pages containing the vmemmap page structures.
> > 
> > Bitmap1 is a map of dumpable (i.e existing) pages. Bitmap2 is a map
> > of pages not to be excluded.
> > To speed the search of bitmaps only whole 64-bit words of 1's in
> > bitmap1 and 0's in bitmap2 are tested to see if they are vmemmap pages.
> > 
> > The list of vmemmap pfn's to be excluded is written to a small file in order
> > to conserve crash kernel memory.
> > 
> > In practice, this whole procedure only takes about 10 seconds on a
> > 16TB machine.
> > 
> > The effect of omitting unused page structures from the dump has only
> > one, minimal side effect that I can find: the crash command "kmem -f" will
> > fail when attempting to walk through free pages. This seems to me to be
> > a trivial negative when weighed against the enabling and acceleration
> > of dumps on large systems.
> > 
> > This patch includes -e and -N options to exclude or include unneeded
> > vmemmap pages regardless of system size (see flag_includevm and
> > flag_excludvm).  By default the exclusion of such pages is only
> > done on a system of a terabyte or more.
> 
> Hi Cliff,
> 
> I understand the reason behind this, but the default exclusion
> (even @ 1TB) makes me a little nervous.  
> 
> Although I'm sure you tested this, I find it amazing that
> only the "kmem -[fF]" option is the only command option 
> that is affected?

Hi Dave,

Maybe I missed some kmem options that walk free page lists.
If a crash command is walking a page freelist it would use the
list_head named 'lru' would it not?  I only find lru references
in crash's memory.c unwind.c gdb-7.6/sim/frv/cache.c gdb-7.6/bfd/cache.c
I didn't do extensive tests of crash, but the kmem command was
all I found.

> 
> If I'm not mistaken, this would be the first time that legitimate
> kernel data would be excluded from the dump, and the user would 
> have no obvious way of knowing that it had been done, correct?  
> If it were encoded in the in the header somewhere, at least a 
> warning message could be printed during crash initialization.  

Agreed, it is legitimate kernel data.  But it is data that represents
memory that we are not capturing.  So it would seem to me to be of
little use.  And on the other hand if we do capture that data the time
to take the dump would be so long as to make the whole notion of doing
a dump prohibitive.
(Even with this patch it took 40 minutes to dump a system of 16TB. 
 Without the patch that might be 5 hours.  And soon there will be
 64TB systems.)

When kmem -f fails it does say that a needed page has been excluded
from the dump.
But an up-front message would be reasonable.
> 
> In any case, given that this can change traditional behavior, 
> I would prefer that the full set of pages be copied by default,
> and only be excluded if the user configures it to do so.

That could be easily done.  It's not unreasonable to make the very large
system require the special option.  I just thought that the check of system
size would be doing the system administrator a favor.
> 
> Thanks,
>   Dave
> 
> 
> 
> > 
> > ---
> >  makedumpfile.c |  686
> >  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  makedumpfile.h |   62 +++++
> >  print_info.c   |    9
> >  3 files changed, 753 insertions(+), 4 deletions(-)
> > 
> > Index: makedumpfile-1.5.5/makedumpfile.c
> > ===================================================================
> > --- makedumpfile-1.5.5.orig/makedumpfile.c
> > +++ makedumpfile-1.5.5/makedumpfile.c
> > @@ -31,9 +31,12 @@ struct offset_table	offset_table;
> >  struct array_table	array_table;
> >  struct number_table	number_table;
> >  struct srcfile_table	srcfile_table;
> > +struct save_control	sc;
> >  
> >  struct vm_table		vt = { 0 };
> >  struct DumpInfo		*info = NULL;
> > +struct vmap_pfns	*gvmem_pfns;
> > +int nr_gvmem_pfns;
> >  
> >  char filename_stdout[] = FILENAME_STDOUT;
> >  
> > @@ -3111,6 +3114,21 @@ out:
> >  	if (!get_max_mapnr())
> >  		return FALSE;
> >  
> > +	/*
> > +	 * Do not capture unused pages of vmemmap (page structures) for memories
> > +	 * of a terabyte or more, unless -N was specified to explicitly capture
> > them.
> > +	 *   max. memory pfn is in info->max_mapnr; a terabyte is pfn 0x10000000
> > +	 */
> > +	if (!info->flag_includevm && info->max_mapnr >= 0x10000000UL) {
> > +		info->flag_excludevm = 1;
> > +		PROGRESS_MSG(
> > +			"Large memory, excluding unused vmemmap page structures.\n");
> > +	}
> > +	if (info->flag_includevm) {
> > +		info->flag_excludevm = 0;
> > +		PROGRESS_MSG("Capturing all vmemmap page structures.\n");
> > +	}
> > +
> >  	if (info->flag_cyclic) {
> >  		if (info->bufsize_cyclic == 0) {
> >  			if (!calculate_cyclic_buffer_size())
> > @@ -4945,6 +4963,340 @@ copy_bitmap(void)
> >  	return TRUE;
> >  }
> >  
> > +/*
> > + * Given a range of unused pfn's, check whether we can drop the vmemmap
> > pages
> > + * that represent them.
> > + *  (pfn ranges are literally start and end, not start and end+1)
> > + *   see the array of vmemmap pfns and the pfns then represent: gvmem_pfns
> > + * Return 1 for delete, 0 for not to delete.
> > + */
> > +int
> > +find_vmemmap_pages(unsigned long startpfn, unsigned long endpfn, unsigned
> > long *vmappfn,
> > +									unsigned long *nmapnpfns)
> > +{
> > +	int i;
> > +	long npfns_offset, vmemmap_offset, vmemmap_pfns, start_vmemmap_pfn;
> > +	long npages, end_vmemmap_pfn;
> > +	struct vmap_pfns *vmapp;
> > +	int pagesize = info->page_size;
> > +
> > +	for (i = 0; i < nr_gvmem_pfns; i++) {
> > +		vmapp = gvmem_pfns + i;
> > +		if ((startpfn >= vmapp->rep_pfn_start) &&
> > +		    (endpfn <= vmapp->rep_pfn_end)) {
> > +			npfns_offset = startpfn - vmapp->rep_pfn_start;
> > +			vmemmap_offset = npfns_offset * size_table.page;
> > +			// round up to a page boundary
> > +			if (vmemmap_offset % pagesize)
> > +				vmemmap_offset += (pagesize - (vmemmap_offset % pagesize));
> > +			vmemmap_pfns = vmemmap_offset / pagesize;
> > +			start_vmemmap_pfn = vmapp->vmap_pfn_start + vmemmap_pfns;
> > +			*vmappfn = start_vmemmap_pfn;
> > +
> > +			npfns_offset = endpfn - vmapp->rep_pfn_start;
> > +			vmemmap_offset = npfns_offset * size_table.page;
> > +			// round down to page boundary
> > +			vmemmap_offset -= (vmemmap_offset % pagesize);
> > +			vmemmap_pfns = vmemmap_offset / pagesize;
> > +			end_vmemmap_pfn = vmapp->vmap_pfn_start + vmemmap_pfns;
> > +			npages = end_vmemmap_pfn - start_vmemmap_pfn;
> > +			if (npages == 0)
> > +				return 0;
> > +			*nmapnpfns = npages;
> > +			return 1;
> > +		}
> > +	}
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Finalize the structure for saving pfn's to be deleted.
> > + */
> > +void
> > +finalize_save_control()
> > +{
> > +	free(sc.sc_buf_malloced);
> > +	close(sc.sc_fd);
> > +	return;
> > +}
> > +
> > +/*
> > + * Reset the structure for saving pfn's to be deleted so that it can be read
> > + */
> > +void
> > +reset_save_control()
> > +{
> > +	int i;
> > +	if (sc.sc_bufposition == 0)
> > +		return;
> > +
> > +	/* direct i/o, so have to write the whole buffer */
> > +	i = write(sc.sc_fd, sc.sc_buf, sc.sc_buflen);
> > +	if (i != sc.sc_buflen) {
> > +		fprintf(stderr, "reset: Can't write a page to %s\n",
> > +			sc.sc_filename);
> > +		exit(1);
> > +	}
> > +	sc.sc_filelen += sc.sc_bufposition;
> > +
> > +	if (lseek(sc.sc_fd, 0, SEEK_SET) < 0) {
> > +		fprintf(stderr, "Can't seek the pfn file %s).", sc.sc_filename);
> > +		exit(1);
> > +	}
> > +	sc.sc_fileposition = 0;
> > +	sc.sc_bufposition = sc.sc_buflen; /* trigger 1st read */
> > +	return;
> > +}
> > +
> > +/*
> > + * Initialize the structure for saving pfn's to be deleted.
> > + */
> > +void
> > +init_save_control()
> > +{
> > +	int flags, len;
> > +	char *filename, *cp;
> > +
> > +	filename = malloc(50);
> > +	*filename = '\0';
> > +	/* use the prefix of the dump name   e.g. /mnt//var/.... */
> > +	if (!strchr(info->name_dumpfile,'v')) {
> > +		printf("no /var found in name_dumpfile %s\n", info->name_dumpfile);
> > +		exit(1);
> > +	} else {
> > +		cp = strchr(info->name_dumpfile,'v');
> > +		if (strncmp(cp-1, "/var", 4)) {
> > +			printf("no /var found in name_dumpfile %s\n",
> > +				info->name_dumpfile);
> > +			exit(1);
> > +		}
> > +	}
> > +	len = cp - info->name_dumpfile - 1;
> > +	strncpy(filename, info->name_dumpfile, len);
> > +	if (*(filename + len - 1) == '/')
> > +		len -= 1;
> > +	*(filename + len) = '\0';
> > +
> > +	strcat(filename, "/makedumpfilepfns");
> > +	sc.sc_filename = filename;
> > +	flags = O_RDWR|O_CREAT|O_TRUNC|O_DIRECT;
> > +	if ((sc.sc_fd = open(sc.sc_filename, flags,
> > +							S_IRUSR|S_IWUSR)) < 0) {
> > +		fprintf(stderr, "Can't open the pfn file %s.\n",
> > +			sc.sc_filename);
> > +		exit(1);
> > +	}
> > +	unlink(sc.sc_filename);
> > +
> > +	sc.sc_buf_malloced = malloc(blocksize + DIRECT_ALIGN);
> > +	if (!sc.sc_buf_malloced) {
> > +		fprintf(stderr, "Can't allocate a page for pfn buf.\n");
> > +		exit(1);
> > +	}
> > +	/* round down to a block boundary */
> > +	sc.sc_buf = sc.sc_buf_malloced -
> > +	   ((unsigned long)sc.sc_buf_malloced % DIRECT_ALIGN) + DIRECT_ALIGN;
> > +	sc.sc_buflen = blocksize;
> > +	sc.sc_bufposition = 0;
> > +	sc.sc_fileposition = 0;
> > +	sc.sc_filelen = 0;
> > +}
> > +
> > +/*
> > + * Save a starting pfn and number of pfns for later delete from bitmap.
> > + */
> > +void
> > +save_deletes(unsigned long startpfn, unsigned long numpfns)
> > +{
> > +	int i;
> > +	struct sc_entry *scp;
> > +
> > +	if (sc.sc_bufposition == sc.sc_buflen) {
> > +		i = write(sc.sc_fd, sc.sc_buf, sc.sc_buflen);
> > +		if (i != sc.sc_buflen) {
> > +			fprintf(stderr, "save: Can't write a page to %s\n",
> > +				sc.sc_filename);
> > +			exit(1);
> > +		}
> > +		sc.sc_filelen += sc.sc_buflen;
> > +		sc.sc_bufposition = 0;
> > +	}
> > +	scp = (struct sc_entry *)(sc.sc_buf + sc.sc_bufposition);
> > +	scp->startpfn = startpfn;
> > +	scp->numpfns = numpfns;
> > +	sc.sc_bufposition += sizeof(struct sc_entry);
> > +}
> > +
> > +/*
> > + * Get a starting pfn and number of pfns for delete from bitmap.
> > + * Return 0 for success, 1 for 'no more'
> > + */
> > +int
> > +get_deletes(unsigned long *startpfn, unsigned long *numpfns)
> > +{
> > +	int i;
> > +	struct sc_entry *scp;
> > +
> > +	if (sc.sc_fileposition >= sc.sc_filelen) {
> > +		return 1;
> > +	}
> > +
> > +	if (sc.sc_bufposition == sc.sc_buflen) {
> > +		i = read(sc.sc_fd, sc.sc_buf, sc.sc_buflen);
> > +		if (i <= 0) {
> > +			fprintf(stderr, "Can't read a page from %s.\n", sc.sc_filename);
> > +			exit(1);
> > +		}
> > +		sc.sc_bufposition = 0;
> > +	}
> > +	scp = (struct sc_entry *)(sc.sc_buf + sc.sc_bufposition);
> > +	*startpfn = scp->startpfn;
> > +	*numpfns = scp->numpfns;
> > +	sc.sc_bufposition += sizeof(struct sc_entry);
> > +	sc.sc_fileposition += sizeof(struct sc_entry);
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Find the big holes in bitmap2; they represent ranges for which
> > + * we do not need page structures.
> > + * Bitmap1 is a map of dumpable (i.e existing) pages.
> > + * They must only be pages that exist, so they will be 0 bits
> > + * in the 2nd bitmap but 1 bits in the 1st bitmap.
> > + * For speed, only worry about whole word full of bits.
> > + */
> > +void
> > +find_unused_vmemmap_pages(void)
> > +{
> > +	struct dump_bitmap *bitmap1 = info->bitmap1;
> > +	struct dump_bitmap *bitmap2 = info->bitmap2;
> > +	unsigned long long pfn;
> > +	unsigned long *lp1, *lp2, startpfn, endpfn;
> > +	unsigned long vmapstartpfn, vmapnumpfns;
> > +	int i, sz, numpages=0, did_deletes;
> > +	int startword, numwords, do_break=0;
> > +	long deleted_pages = 0;
> > +	off_t new_offset1, new_offset2;
> > +
> > +	/* read each block of both bitmaps */
> > +	for (pfn = 0; pfn < info->max_mapnr; pfn += PFN_BUFBITMAP) { /* size in
> > bits */
> > +		numpages++;
> > +		did_deletes = 0;
> > +		new_offset1 = bitmap1->offset + BUFSIZE_BITMAP * (pfn / PFN_BUFBITMAP);
> > +		if (lseek(bitmap1->fd, new_offset1, SEEK_SET) < 0 ) {
> > +			ERRMSG("Can't seek the bitmap(%s). %s\n",
> > +				bitmap1->file_name, strerror(errno));
> > +			return;
> > +		}
> > +		if (read(bitmap1->fd, bitmap1->buf, BUFSIZE_BITMAP) != BUFSIZE_BITMAP) {
> > +			ERRMSG("Can't read the bitmap(%s). %s\n",
> > +				bitmap1->file_name, strerror(errno));
> > +			return;
> > +		}
> > +		bitmap1->no_block = pfn / PFN_BUFBITMAP;
> > +
> > +		new_offset2 = bitmap2->offset + BUFSIZE_BITMAP * (pfn / PFN_BUFBITMAP);
> > +		if (lseek(bitmap2->fd, new_offset2, SEEK_SET) < 0 ) {
> > +			ERRMSG("Can't seek the bitmap(%s). %s\n",
> > +				bitmap2->file_name, strerror(errno));
> > +			return;
> > +		}
> > +		if (read(bitmap2->fd, bitmap2->buf, BUFSIZE_BITMAP) != BUFSIZE_BITMAP) {
> > +			ERRMSG("Can't read the bitmap(%s). %s\n",
> > +				bitmap2->file_name, strerror(errno));
> > +			return;
> > +		}
> > +		bitmap2->no_block = pfn / PFN_BUFBITMAP;
> > +
> > +		/* process this one page of both bitmaps at a time */
> > +		lp1 = (unsigned long *)bitmap1->buf;
> > +		lp2 = (unsigned long *)bitmap2->buf;
> > +		/* sz is words in the block */
> > +		sz = BUFSIZE_BITMAP / sizeof(unsigned long);
> > +		startword = -1;
> > +		for (i = 0; i < sz; i++, lp1++, lp2++) {
> > +			/* for each whole word in the block */
> > +			/* deal in full 64-page chunks only */
> > +			if (*lp1 == 0xffffffffffffffffUL) {
> > +				if (*lp2 == 0) {
> > +					/* we are in a series we want */
> > +					if (startword == -1) {
> > +						/* starting a new group */
> > +						startword = i;
> > +					}
> > +				} else {
> > +					/* we hit a used page */
> > +					if (startword >= 0)
> > +						do_break = 1;
> > +				}
> > +			} else {
> > +				/* we hit a hole in real memory, or part of one */
> > +				if (startword >= 0)
> > +					do_break = 1;
> > +			}
> > +			if (do_break) {
> > +				do_break = 0;
> > +				if (startword >= 0) {
> > +					numwords = i - startword;
> > +					/* 64 bits represents 64 page structs, which
> > + 					   are not even one page of them (takes
> > +					   at least 73) */
> > +					if (numwords > 1) {
> > +						startpfn = pfn +
> > +							(startword * BITS_PER_WORD);
> > +						/* pfn ranges are literally start and end,
> > +						   not start and end + 1 */
> > +						endpfn = startpfn +
> > +							(numwords * BITS_PER_WORD) - 1;
> > +						if (find_vmemmap_pages(startpfn, endpfn,
> > +							&vmapstartpfn, &vmapnumpfns)) {
> > +							save_deletes(vmapstartpfn,
> > +								vmapnumpfns);
> > +							deleted_pages += vmapnumpfns;
> > +							did_deletes = 1;
> > +						}
> > +					}
> > +				}
> > +				startword = -1;
> > +			}
> > +		}
> > +		if (startword >= 0) {
> > +			numwords = i - startword;
> > +			if (numwords > 1) {
> > +				startpfn = pfn + (startword * BITS_PER_WORD);
> > +				/* pfn ranges are literally start and end,
> > +				   not start and end + 1 */
> > +				endpfn = startpfn + (numwords * BITS_PER_WORD) - 1;
> > +				if (find_vmemmap_pages(startpfn, endpfn,
> > +							&vmapstartpfn, &vmapnumpfns)) {
> > +					save_deletes(vmapstartpfn, vmapnumpfns);
> > +					deleted_pages += vmapnumpfns;
> > +					did_deletes = 1;
> > +				}
> > +			}
> > +		}
> > +	}
> > +	PROGRESS_MSG("\nExcluded %ld unused vmemmap pages\n", deleted_pages);
> > +
> > +	return;
> > +}
> > +
> > +/*
> > + * Retrieve the list of pfn's and delete them from bitmap2;
> > + */
> > +void
> > +delete_unused_vmemmap_pages(void)
> > +{
> > +	unsigned long startpfn, numpfns, pfn, i;
> > +
> > +	while (!get_deletes(&startpfn, &numpfns)) {
> > +		for (i = 0, pfn = startpfn; i < numpfns; i++, pfn++) {
> > +			clear_bit_on_2nd_bitmap_for_kernel(pfn);
> > +		}
> > +	}
> > +	return;
> > +}
> > +
> >  int
> >  create_2nd_bitmap(void)
> >  {
> > @@ -5016,6 +5368,15 @@ create_2nd_bitmap(void)
> >  	if (!sync_2nd_bitmap())
> >  		return FALSE;
> >  
> > +	/* -e means exclude vmemmap page structures for unused pages */
> > +	if (info->flag_excludevm) {
> > +		init_save_control();
> > +		find_unused_vmemmap_pages();
> > +		reset_save_control();
> > +		delete_unused_vmemmap_pages();
> > +		finalize_save_control();
> > +	}
> > +
> >  	return TRUE;
> >  }
> >  
> > @@ -5222,7 +5583,7 @@ get_loads_dumpfile(void)
> >  			continue;
> >  
> >  		pfn_start = paddr_to_pfn(load.p_paddr);
> > -		pfn_end   = paddr_to_pfn(load.p_paddr + load.p_memsz);
> > +		pfn_end = paddr_to_pfn(load.p_paddr + load.p_memsz);
> >  		frac_head = page_size - (load.p_paddr % page_size);
> >  		frac_tail = (load.p_paddr + load.p_memsz) % page_size;
> >  
> > @@ -8248,6 +8609,315 @@ writeout_multiple_dumpfiles(void)
> >  	return ret;
> >  }
> >  
> > +/*
> > + * Scan the kernel page table for the pfn's of the page structs
> > + * Place them in array gvmem_pfns[nr_gvmem_pfns]
> > + */
> > +void
> > +find_vmemmap()
> > +{
> > +	int i, verbose = 0;
> > +	int pgd_index, pud_index;
> > +	int start_range = 1;
> > +	int num_pmds=0, num_pmds_valid=0;
> > +	int break_in_valids, break_after_invalids;
> > +	int do_break, done = 0;
> > +	int last_valid=0, last_invalid=0;
> > +	int pagestructsize, structsperhpage, hugepagesize;
> > +	long page_structs_per_pud;
> > +	long num_puds, groups = 0;
> > +	long pgdindex, pudindex, pmdindex;
> > +	long vaddr, vaddr_base;
> > +	long rep_pfn_start = 0, rep_pfn_end = 0;
> > +	unsigned long init_level4_pgt;
> > +	unsigned long max_paddr, high_pfn;
> > +	unsigned long pgd_addr, pud_addr, pmd_addr;
> > +	unsigned long *pgdp, *pudp, *pmdp;
> > +	unsigned long pud_page[PTRS_PER_PUD];
> > +	unsigned long pmd_page[PTRS_PER_PMD];
> > +	unsigned long vmap_offset_start = 0, vmap_offset_end = 0;
> > +	unsigned long pmd, tpfn;
> > +	unsigned long pvaddr = 0;
> > +	unsigned long data_addr = 0, last_data_addr = 0, start_data_addr = 0;
> > +	/*
> > +	 * data_addr is the paddr of the page holding the page structs.
> > +	 * We keep lists of contiguous pages and the pfn's that their
> > +	 * page structs represent.
> > +	 *  start_data_addr and last_data_addr mark start/end of those
> > +	 *  contiguous areas.
> > +	 * An area descriptor is vmap start/end pfn and rep start/end
> > +	 *  of the pfn's represented by the vmap start/end.
> > +	 */
> > +	struct vmap_pfns *vmapp, *vmaphead = NULL, *cur, *tail;
> > +
> > +	init_level4_pgt = SYMBOL(init_level4_pgt);
> > +	if (init_level4_pgt == NOT_FOUND_SYMBOL) {
> > +		fprintf(stderr, "init_level4_pgt not found\n");
> > +		return;
> > +	}
> > +	pagestructsize = size_table.page;
> > +	hugepagesize = PTRS_PER_PMD * info->page_size;
> > +	vaddr_base = info->vmemmap_start;
> > +	vaddr = vaddr_base;
> > +	max_paddr = get_max_paddr();
> > +	/*
> > +	 * the page structures are mapped at VMEMMAP_START (info->vmemmap_start)
> > +	 * for max_paddr >> 12 page structures
> > +	 */
> > +	high_pfn = max_paddr >> 12;
> > +	pgd_index = pgd4_index(vaddr_base);
> > +	pud_index = pud_index(vaddr_base);
> > +	pgd_addr = vaddr_to_paddr(init_level4_pgt); /* address of pgd */
> > +	pgd_addr += pgd_index * sizeof(unsigned long);
> > +	page_structs_per_pud = (PTRS_PER_PUD * PTRS_PER_PMD * info->page_size) /
> > +									pagestructsize;
> > +	num_puds = (high_pfn + page_structs_per_pud - 1) / page_structs_per_pud;
> > +	pvaddr = VMEMMAP_START;
> > +	structsperhpage = hugepagesize / pagestructsize;
> > +
> > +	/* outer loop is for pud entries in the pgd */
> > +	for (pgdindex = 0, pgdp = (unsigned long *)pgd_addr; pgdindex < num_puds;
> > +								pgdindex++, pgdp++) {
> > +		/* read the pgd one word at a time, into pud_addr */
> > +		if (!readmem(PADDR, (unsigned long long)pgdp, (void *)&pud_addr,
> > +								sizeof(unsigned long))) {
> > +			ERRMSG("Can't get pgd entry for slot %d.\n", pgd_index);
> > +			return;
> > +		}
> > +		/* mask the pgd entry for the address of the pud page */
> > +		pud_addr &= PMASK;
> > +		/* read the entire pud page */
> > +		if (!readmem(PADDR, (unsigned long long)pud_addr, (void *)pud_page,
> > +					PTRS_PER_PUD * sizeof(unsigned long))) {
> > +			ERRMSG("Can't get pud entry for pgd slot %ld.\n", pgdindex);
> > +			return;
> > +		}
> > +		/* step thru each pmd address in the pud page */
> > +		/* pudp points to an entry in the pud page */
> > +		for (pudp = (unsigned long *)pud_page, pudindex = 0;
> > +					pudindex < PTRS_PER_PUD; pudindex++, pudp++) {
> > +			pmd_addr = *pudp & PMASK;
> > +			/* read the entire pmd page */
> > +			if (!readmem(PADDR, pmd_addr, (void *)pmd_page,
> > +					PTRS_PER_PMD * sizeof(unsigned long))) {
> > +				ERRMSG("Can't get pud entry for slot %ld.\n", pudindex);
> > +				return;
> > +			}
> > +			/* pmdp points to an entry in the pmd */
> > +			for (pmdp = (unsigned long *)pmd_page, pmdindex = 0;
> > +					pmdindex < PTRS_PER_PMD; pmdindex++, pmdp++) {
> > +				/* linear page position in this page table: */
> > +				pmd = *pmdp;
> > +				num_pmds++;
> > +				tpfn = (pvaddr - VMEMMAP_START) /
> > +							pagestructsize;
> > +				if (tpfn >= high_pfn) {
> > +					done = 1;
> > +					break;
> > +				}
> > +				/*
> > +				 * vmap_offset_start:
> > +				 * Starting logical position in the
> > +				 * vmemmap array for the group stays
> > +				 * constant until a hole in the table
> > +				 * or a break in contiguousness.
> > +				 */
> > +
> > +				/*
> > +				 * Ending logical position in the
> > +				 * vmemmap array:
> > +				 */
> > +				vmap_offset_end += hugepagesize;
> > +				do_break = 0;
> > +				break_in_valids = 0;
> > +				break_after_invalids = 0;
> > +				/*
> > +				 * We want breaks either when:
> > +				 * - we hit a hole (invalid)
> > +				 * - we discontiguous page is a string of valids
> > +				 */
> > +				if (pmd) {
> > +					data_addr = (pmd & PMASK);
> > +					if (start_range) {
> > +						/* first-time kludge */
> > +						start_data_addr = data_addr;
> > +						last_data_addr = start_data_addr
> > +							 - hugepagesize;
> > +						start_range = 0;
> > +					}
> > +					if (last_invalid) {
> > +						/* end of a hole */
> > +						start_data_addr = data_addr;
> > +						last_data_addr = start_data_addr
> > +							 - hugepagesize;
> > +						/* trigger update of offset */
> > +						do_break = 1;
> > +					}
> > +					last_valid = 1;
> > +					last_invalid = 0;
> > +					/*
> > +					 * we have it a gap in physical
> > +					 * contiguousness in the table.
> > +					 */
> > +					/* ?? consecutive holes will have
> > +					   same data_addr */
> > +					if (data_addr !=
> > +						last_data_addr + hugepagesize) {
> > +						do_break = 1;
> > +						break_in_valids = 1;
> > +					}
> > +					if (verbose)
> > +						printf("valid: pud %ld pmd %ld pfn %#lx"
> > +							" pvaddr %#lx pfns %#lx-%lx"
> > +							" start %#lx end %#lx\n",
> > +							pudindex, pmdindex,
> > +							data_addr >> 12,
> > +							pvaddr, tpfn,
> > +					tpfn + structsperhpage - 1,
> > +					vmap_offset_start,
> > +					vmap_offset_end);
> > +					num_pmds_valid++;
> > +					if (!(pmd & PSE)) {
> > +						printf("vmemmap pmd not huge, abort\n");
> > +						exit(1);
> > +					}
> > +				} else {
> > +					if (last_valid) {
> > +						/* this a hole after some valids */
> > +						do_break = 1;
> > +						break_in_valids = 1;
> > +						break_after_invalids = 0;
> > +					}
> > +					last_valid = 0;
> > +					last_invalid = 1;
> > +					/*
> > +					 * There are holes in this sparsely
> > +					 * populated table; they are 2MB gaps
> > +					 * represented by null pmd entries.
> > +					 */
> > +					if (verbose)
> > +						printf("invalid: pud %ld pmd %ld %#lx"
> > +							" pfns %#lx-%lx start %#lx end"
> > +							" %#lx\n", pudindex, pmdindex,
> > +							pvaddr, tpfn,
> > +							tpfn + structsperhpage - 1,
> > +							vmap_offset_start,
> > +							vmap_offset_end);
> > +				}
> > +				if (do_break) {
> > +					/* The end of a hole is not summarized.
> > +					 * It must be the start of a hole or
> > +					 * hitting a discontiguous series.
> > +					 */
> > +					if (break_in_valids || break_after_invalids) {
> > +						/*
> > +						 * calculate that pfns
> > +						 * represented by the current
> > +						 * offset in the vmemmap.
> > +						 */
> > +						/* page struct even partly on this page */
> > +						rep_pfn_start = vmap_offset_start /
> > +							pagestructsize;
> > +						/* ending page struct entirely on
> > + 						   this page */
> > +						rep_pfn_end = ((vmap_offset_end -
> > +							hugepagesize) / pagestructsize);
> > + 						if (verbose)
> > +							printf("vmap pfns %#lx-%lx "
> > +							"represent pfns %#lx-%lx\n\n",
> > +							start_data_addr >> PAGESHFT,
> > +							last_data_addr >> PAGESHFT,
> > +							rep_pfn_start, rep_pfn_end);
> > +						groups++;
> > +						vmapp = (struct vmap_pfns *)malloc(
> > +								sizeof(struct vmap_pfns));
> > +						/* pfn of this 2MB page of page structs */
> > +						vmapp->vmap_pfn_start = start_data_addr
> > +									>> PTE_SHIFT;
> > +						vmapp->vmap_pfn_end = last_data_addr
> > +									>> PTE_SHIFT;
> > +						/* these (start/end) are literal pfns
> > + 						 * on this page, not start and end+1 */
> > +						vmapp->rep_pfn_start = rep_pfn_start;
> > +						vmapp->rep_pfn_end = rep_pfn_end;
> > +
> > +						if (!vmaphead) {
> > +							vmaphead = vmapp;
> > +							vmapp->next = vmapp;
> > +							vmapp->prev = vmapp;
> > +						} else {
> > +							tail = vmaphead->prev;
> > +							vmaphead->prev = vmapp;
> > +							tail->next = vmapp;
> > +							vmapp->next = vmaphead;
> > +							vmapp->prev = tail;
> > +						}
> > +					}
> > +
> > +					/* update logical position at every break */
> > +					vmap_offset_start =
> > +						vmap_offset_end - hugepagesize;
> > +					start_data_addr = data_addr;
> > +				}
> > +
> > +				last_data_addr = data_addr;
> > +				pvaddr += hugepagesize;
> > +				/*
> > +				 * pvaddr is current virtual address
> > +				 *   eg 0xffffea0004200000 if
> > +				 *    vmap_offset_start is 4200000
> > +				 */
> > +			}
> > +		}
> > +		tpfn = (pvaddr - VMEMMAP_START) / pagestructsize;
> > +		if (tpfn >= high_pfn) {
> > +			done = 1;
> > +			break;
> > +		}
> > +	}
> > +	rep_pfn_start = vmap_offset_start / pagestructsize;
> > +	rep_pfn_end = (vmap_offset_end - hugepagesize) / pagestructsize;
> > + 	if (verbose)
> > +		printf("vmap pfns %#lx-%lx represent pfns %#lx-%lx\n\n",
> > +			start_data_addr >> PAGESHFT, last_data_addr >> PAGESHFT,
> > +			rep_pfn_start, rep_pfn_end);
> > +	groups++;
> > +	vmapp = (struct vmap_pfns *)malloc(sizeof(struct vmap_pfns));
> > +	vmapp->vmap_pfn_start = start_data_addr >> PTE_SHIFT;
> > +	vmapp->vmap_pfn_end = last_data_addr >> PTE_SHIFT;
> > +	vmapp->rep_pfn_start = rep_pfn_start;
> > +	vmapp->rep_pfn_end = rep_pfn_end;
> > +	if (!vmaphead) {
> > +		vmaphead = vmapp;
> > +		vmapp->next = vmapp;
> > +		vmapp->prev = vmapp;
> > +	} else {
> > +		tail = vmaphead->prev;
> > +		vmaphead->prev = vmapp;
> > +		tail->next = vmapp;
> > +		vmapp->next = vmaphead;
> > +		vmapp->prev = tail;
> > +	}
> > +	if (verbose)
> > +		printf("num_pmds: %d num_pmds_valid %d\n", num_pmds, num_pmds_valid);
> > +
> > +	/* transfer the linked list to an array */
> > +	cur = vmaphead;
> > +	gvmem_pfns = (struct vmap_pfns *)malloc(sizeof(struct vmap_pfns) * groups);
> > +	i = 0;
> > +	do {
> > +		vmapp = gvmem_pfns + i;
> > +		vmapp->vmap_pfn_start = cur->vmap_pfn_start;
> > +		vmapp->vmap_pfn_end = cur->vmap_pfn_end;
> > +		vmapp->rep_pfn_start = cur->rep_pfn_start;
> > +		vmapp->rep_pfn_end = cur->rep_pfn_end;
> > +		cur = cur->next;
> > +		free(cur->prev);
> > +		i++;
> > +	} while (cur != vmaphead);
> > +	nr_gvmem_pfns = i;
> > +}
> > +
> >  int
> >  create_dumpfile(void)
> >  {
> > @@ -8268,6 +8938,10 @@ create_dumpfile(void)
> >  
> >  	print_vtop();
> >  
> > +	/* create an array of translations from pfn to vmemmap pages */
> > +	if (info->flag_excludevm)
> > +		find_vmemmap();
> > +
> >  	if (info->flag_rawdump)
> >  		PROGRESS_MSG("Using O_DIRECT i/o for dump.\n");
> >  	if (info->flag_rawbitmaps)
> > @@ -9300,7 +9974,7 @@ main(int argc, char *argv[])
> >  
> >  	info->block_order = DEFAULT_ORDER;
> >  	message_level = DEFAULT_MSG_LEVEL;
> > -	while ((opt = getopt_long(argc, argv, "b:cDd:EFfg:hi:lpRvXx:", longopts,
> > +	while ((opt = getopt_long(argc, argv, "b:cDd:eEFfg:hi:lNpRvXx:", longopts,
> >  	    NULL)) != -1) {
> >  		switch (opt) {
> >  		case OPT_BLOCK_ORDER:
> > @@ -9315,6 +9989,14 @@ main(int argc, char *argv[])
> >  		case OPT_DEBUG:
> >  			flag_debug = TRUE;
> >  			break;
> > +		case OPT_EXCLUDEVM:
> > +			info->flag_excludevm = 1;
> > +			/* exclude unused vmemmap pages */
> > +			break;
> > +		case OPT_INCLUDEVM:
> > +			info->flag_includevm = 1;
> > +			/* include unused vmemmap pages */
> > +			break;
> >  		case OPT_DUMP_LEVEL:
> >  			if (!parse_dump_level(optarg))
> >  				goto out;
> > Index: makedumpfile-1.5.5/makedumpfile.h
> > ===================================================================
> > --- makedumpfile-1.5.5.orig/makedumpfile.h
> > +++ makedumpfile-1.5.5/makedumpfile.h
> > @@ -44,6 +44,9 @@
> >  #include "diskdump_mod.h"
> >  #include "sadump_mod.h"
> >  
> > +#define VMEMMAPSTART 0xffffea0000000000UL
> > +#define BITS_PER_WORD 64
> > +
> >  /*
> >   * Result of command
> >   */
> > @@ -477,6 +480,7 @@ do { \
> >  #define VMALLOC_END		(info->vmalloc_end)
> >  #define VMEMMAP_START		(info->vmemmap_start)
> >  #define VMEMMAP_END		(info->vmemmap_end)
> > +#define PMASK			(0x7ffffffffffff000UL)
> >  
> >  #ifdef __arm__
> >  #define KVBASE_MASK		(0xffff)
> > @@ -561,15 +565,20 @@ do { \
> >  #define PGDIR_SIZE		(1UL << PGDIR_SHIFT)
> >  #define PGDIR_MASK		(~(PGDIR_SIZE - 1))
> >  #define PTRS_PER_PGD		(512)
> > +#define PGD_SHIFT		(39)
> > +#define PUD_SHIFT		(30)
> >  #define PMD_SHIFT		(21)
> >  #define PMD_SIZE		(1UL << PMD_SHIFT)
> >  #define PMD_MASK		(~(PMD_SIZE - 1))
> > +#define PTRS_PER_PUD		(512)
> >  #define PTRS_PER_PMD		(512)
> >  #define PTRS_PER_PTE		(512)
> >  #define PTE_SHIFT		(12)
> >  
> >  #define pml4_index(address) (((address) >> PML4_SHIFT) & (PTRS_PER_PML4 -
> >  1))
> >  #define pgd_index(address)  (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD -
> >  1))
> > +#define pgd4_index(address)  (((address) >> PGD_SHIFT) & (PTRS_PER_PGD - 1))
> > +#define pud_index(address)  (((address) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
> >  #define pmd_index(address)  (((address) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
> >  #define pte_index(address)  (((address) >> PTE_SHIFT) & (PTRS_PER_PTE - 1))
> >  
> > @@ -683,7 +692,6 @@ do { \
> >  /*
> >   * 4 Levels paging
> >   */
> > -#define PUD_SHIFT		(PMD_SHIFT + PTRS_PER_PTD_SHIFT)
> >  #define PGDIR_SHIFT_4L		(PUD_SHIFT + PTRS_PER_PTD_SHIFT)
> >  
> >  #define MASK_PUD   	((1UL << REGION_SHIFT) - 1) & (~((1UL << PUD_SHIFT) -
> >  1))
> > @@ -917,6 +925,8 @@ struct DumpInfo {
> >  	int		flag_vmemmap;        /* kernel supports vmemmap address space */
> >  	int		flag_rawdump;        /* use raw i/o for the dump file */
> >  	int		flag_rawbitmaps;     /* use raw i/o for the bitmaps file */
> > +	int		flag_excludevm;      /* exclude unused vmemmap pages */
> > +	int		flag_includevm;      /* include unused vmemmap pages */
> >  	unsigned long	vaddr_for_vtop;      /* virtual address for debugging */
> >  	long		page_size;           /* size of page */
> >  	long		page_shift;
> > @@ -1449,6 +1459,52 @@ struct srcfile_table {
> >  	char	pud_t[LEN_SRCFILE];
> >  };
> >  
> > +/*
> > + * This structure records where the vmemmap page structures reside, and
> > which
> > + * pfn's are represented by those page structures.
> > + * The actual pages containing the page structures are 2MB pages, so their
> > pfn's
> > + * will all be multiples of 0x200.
> > + * The page structures are 7 64-bit words in length (0x38) so they overlap
> > the
> > + * 2MB boundaries. Each page structure represents a 4k page.
> > + * A 4k page is here defined to be represented on a 2MB page if its page
> > structure
> > + * 'ends' on that page (even if it began on the page before).
> > + */
> > +struct vmap_pfns {
> > +	struct vmap_pfns *next;
> > +	struct vmap_pfns *prev;
> > +	/*
> > +	 * These (start/end) are literal pfns of 2MB pages on which the page
> > +	 * structures reside, not start and end+1.
> > +	 */
> > +	unsigned long vmap_pfn_start;
> > +	unsigned long vmap_pfn_end;
> > +	/*
> > +	 * These (start/end) are literal pfns represented on these pages, not
> > +	 * start and end+1.
> > +	 * The starting page struct is at least partly on the first page; the
> > + 	 * ending page struct is entirely on the last page.
> > + 	 */
> > +	unsigned long rep_pfn_start;
> > +	unsigned long rep_pfn_end;
> > +};
> > +
> > +/* for saving a list of pfns to a buffer, and then to a file if necessary */
> > +struct save_control {
> > +	int sc_fd;
> > +	char *sc_filename;
> > +	char *sc_buf_malloced;
> > +	char *sc_buf;
> > +	long sc_buflen; /* length of buffer never changes */
> > +	long sc_bufposition; /* offset of next slot for write, or next to be read
> > */
> > +	long sc_filelen; /* length of valid data written */
> > +	long sc_fileposition; /* offset in file of next entry to be read */
> > +};
> > +/* one entry in the buffer and file */
> > +struct sc_entry {
> > +	unsigned long startpfn;
> > +	unsigned long numpfns;
> > +};
> > +
> >  extern struct symbol_table	symbol_table;
> >  extern struct size_table	size_table;
> >  extern struct offset_table	offset_table;
> > @@ -1595,6 +1651,8 @@ int get_xen_info_ia64(void);
> >  #define get_xen_basic_info_arch(X) FALSE
> >  #define get_xen_info_arch(X) FALSE
> >  #endif	/* s390x */
> > +#define PAGESHFT	12 /* assuming a 4k page */
> > +#define PSE		128 /* bit 7 */
> >  
> >  static inline int
> >  is_on(char *bitmap, int i)
> > @@ -1729,6 +1787,7 @@ struct elf_prstatus {
> >  #define OPT_COMPRESS_ZLIB       'c'
> >  #define OPT_DEBUG               'D'
> >  #define OPT_DUMP_LEVEL          'd'
> > +#define OPT_EXCLUDEVM           'e'
> >  #define OPT_ELF_DUMPFILE        'E'
> >  #define OPT_FLATTEN             'F'
> >  #define OPT_FORCE               'f'
> > @@ -1738,6 +1797,7 @@ struct elf_prstatus {
> >  #define OPT_RAWDUMP             'j'
> >  #define OPT_RAWBITMAPS          'J'
> >  #define OPT_COMPRESS_LZO        'l'
> > +#define OPT_INCLUDEVM           'N'
> >  #define OPT_COMPRESS_SNAPPY     'p'
> >  #define OPT_REARRANGE           'R'
> >  #define OPT_VERSION             'v'
> > Index: makedumpfile-1.5.5/print_info.c
> > ===================================================================
> > --- makedumpfile-1.5.5.orig/print_info.c
> > +++ makedumpfile-1.5.5/print_info.c
> > @@ -48,7 +48,7 @@ print_usage(void)
> >  	MSG("\n");
> >  	MSG("Usage:\n");
> >  	MSG("  Creating DUMPFILE:\n");
> > -	MSG("  # makedumpfile    [-c|-l|-E] [-d DL] [-j] [-J] [-x VMLINUX|-i
> > VMCOREINFO] VMCORE\n");
> > +	MSG("  # makedumpfile    [-c|-l|-E|-j|-J|-e|-N] [-d DL] [-x VMLINUX|-i
> > VMCOREINFO] VMCORE\n");
> >  	MSG("    DUMPFILE\n");
> >  	MSG("\n");
> >  	MSG("  Creating DUMPFILE with filtered kernel data specified through filter
> >  	config\n");
> > @@ -101,6 +101,13 @@ print_usage(void)
> >  	MSG("  [-J]:\n");
> >  	MSG("      Use raw (O_DIRECT) i/o on bitmap file to avoid expanding kernel
> >  	pagecache.\n");
> >  	MSG("\n");
> > +	MSG("  [-e]:\n");
> > +	MSG("      Exclude page structures (vmemmap) for unused pages.\n");
> > +	MSG("      (this will be the default for memories over 1 terabyte)\n");
> > +	MSG("\n");
> > +	MSG("  [-N]:\n");
> > +	MSG("      Explicitly include all page structures (vmemmap).\n");
> > +	MSG("\n");
> >  	MSG("  [-d DL]:\n");
> >  	MSG("      Specify the type of unnecessary page for analysis.\n");
> >  	MSG("      Pages of the specified type are not copied to DUMPFILE. The page
> >  	type\n");
> > --
> > Cliff Wickman
> > SGI
> > cpw@sgi.com
> > (651) 683-3824
> > 
> > 
> > 
> > ------------------------------
> > 
> > Subject: Digest Footer
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> > 
> > ------------------------------
> > 
> > End of kexec Digest, Vol 81, Issue 69
> > *************************************
> > 

-- 
Cliff Wickman
SGI
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
