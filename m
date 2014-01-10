Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W1haj-0001Jr-ET
 for kexec@lists.infradead.org; Fri, 10 Jan 2014 19:18:02 +0000
Received: from zmail15.collab.prod.int.phx2.redhat.com
 (zmail15.collab.prod.int.phx2.redhat.com [10.5.83.17])
 by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id s0AJHdde015939
 for <kexec@lists.infradead.org>; Fri, 10 Jan 2014 14:17:39 -0500
Date: Fri, 10 Jan 2014 14:17:39 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <54378028.659399.1389381459082.JavaMail.root@redhat.com>
In-Reply-To: <mailman.19254.1389376849.1059.kexec@lists.infradead.org>
References: <mailman.19254.1389376849.1059.kexec@lists.infradead.org>
Subject: Re: [PATCH 2/2 V2] exclude unused vmemmap pages
MIME-Version: 1.0
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
To: kexec@lists.infradead.org



----- Original Message -----
>
> provides some requested changes:
> - remove the automatic exclusion of page structures for memories over 1TB; it
>   will only be done by explicit request (-e)
> - remove the -N option; no need to explicitly include unused vmemmap pages
>   as they will be included by default
> - add DUMP_DH_EXCLUDED_VMEMMAP to the dump header; to warn crash users that
>   these page structures are excluded
> - fix the making of the filename for pfn file (in init_save_control())
> but still is only tested on a disk dump of an x86_64 system.
> 
> Exclude kernel pages that contain nothing but page structures for pages
> that are not being included in the dump.
> These can amount to 3.67 million pages per terabyte of system memory!
> 
> The kernel's page table, starting at virtual address 0xffffea0000000000, is
> searched to find the actual pages containing the vmemmap page structures.
> 
> Bitmap1 is a map of dumpable (i.e existing) pages. Bitmap2 is a map
> of pages not to be excluded.
> To speed the search of bitmaps only whole 64-bit words of 1's in
> bitmap1 and 0's in bitmap2 are tested to see if they are vmemmap pages.
> 
> The list of vmemmap pfn's to be excluded is written to a small file in order
> to conserve crash kernel memory.
> 
> In practice, this whole procedure only takes about 10 seconds on a
> 16TB machine.
> 
> Signed-off-by: Cliff Wickman <cpw@sgi.com>

... [ cut ] ...

> +#define OPT_EXCLUDEVM           'e'
>  #define OPT_ELF_DUMPFILE        'E'
>  #define OPT_FLATTEN             'F'
>  #define OPT_FORCE               'f'
> Index: makedumpfile-1.5.5/print_info.c
> ===================================================================
> --- makedumpfile-1.5.5.orig/print_info.c
> +++ makedumpfile-1.5.5/print_info.c
> @@ -48,7 +48,7 @@ print_usage(void)
>  	MSG("\n");
>  	MSG("Usage:\n");
>  	MSG("  Creating DUMPFILE:\n");
> -	MSG("  # makedumpfile    [-c|-l|-E] [-d DL] [-j] [-J] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
> +	MSG("  # makedumpfile    [-c|-l|-E|-j|-J|-e|-N] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
>  	MSG("    DUMPFILE\n");
>  	MSG("\n");
>  	MSG("  Creating DUMPFILE with filtered kernel data specified through filter config\n");
> @@ -101,6 +101,10 @@ print_usage(void)
>  	MSG("  [-J]:\n");
>  	MSG("      Use raw (O_DIRECT) i/o on bitmap file to avoid expanding kernel pagecache.\n");
>  	MSG("\n");
> +	MSG("  [-e]:\n");
> +	MSG("      Exclude page structures (vmemmap) for unused pages.\n");
> +	MSG("      (the default is to capture them all, which amounts to 3.67M pages per terabyte)\n");
> +	MSG("\n");
>  	MSG("  [-d DL]:\n");
>  	MSG("      Specify the type of unnecessary page for analysis.\n");
>  	MSG("      Pages of the specified type are not copied to DUMPFILE. The page
>  	type\n");

Perhaps there should be a warning above concerning the potential for crash analysis
problems?  The description above makes it sound like -e is similar in nature (and
therefore as harmless) as the -d <level> option.

It could be argued that there's no such warning for eppic/erasures, but with eppic
it's far less likely to result in crash analysis failures.  With -e, the user is
virtually guaranteed to have issues.

I realize that this is beating a dead horse, but again, this is an option
that should very rarely be used -- and if applied, the user/administrator should
be well aware of the ramifications. 

Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
