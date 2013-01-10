Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TtNI0-0004Ue-Lk
 for kexec@lists.infradead.org; Thu, 10 Jan 2013 18:55:45 +0000
Date: Thu, 10 Jan 2013 13:55:43 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1906730150.3445569.1357844143086.JavaMail.root@redhat.com>
In-Reply-To: <1276992529.3443656.1357843852315.JavaMail.root@redhat.com>
Subject: makedumpfile bug with ppc64 CONFIG_SPARSEMEM_EXTREME
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Dave Young <dyoung@redhat.com>, CAI Qian <caiqian@redhat.com>


Our QA group recently ran into a makedumpfile problem while
testing kdump/makedumpfile w/upstream 3.7.1 kernels, which
had to do with the filtering of pages on a 12GB ppc64 system. 

The problem can be seen using -d31 on the "vmcore.full" ELF dumpfile:
 
 # makedumpfile -c -d31 -x vmlinux vmcore.full vmcore.out
 The kernel version is not supported.
 The created dumpfile may be incomplete.
 Excluding free pages               : [  0 %] 
 page_to_pfn: Can't convert the address of page descriptor (c0000002ef031c00) to pfn.
 page_to_pfn: Can't convert the address of page descriptor (c0000002ef031c00) to pfn.
 
 makedumpfile Failed.
 #

Other -d flag values yield different results, for example, where
a dumpfile does get created when filtering "user pages" with -d8:

 # makedumpfile -c -d8 -x vmlinux vmcore.full vmcore.out
 The kernel version is not supported.
 The created dumpfile may be incomplete.
 Copying data                       : [100 %] 
 
 The dumpfile is saved to vmcore.out.
 
 makedumpfile Completed.
 #

But the resultant vmcore.out could not be analyzed with crash:

 # crash vmlinux vmcore.out
 
 crash 6.1.1-1.el7
 Copyright (C) 2002-2012  Red Hat, Inc.
 Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
 Copyright (C) 1999-2006  Hewlett-Packard Co
 Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
 Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
 Copyright (C) 2005, 2011  NEC Corporation
 Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
 Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
 This program is free software, covered by the GNU General Public License,
 and you are welcome to change it and/or distribute copies of it under
 certain conditions.  Enter "help copying" to see the conditions.
 This program has absolutely no warranty.  Enter "help warranty" for details.
  
 GNU gdb (GDB) 7.3.1
 Copyright (C) 2011 Free Software Foundation, Inc.
 License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
 This is free software: you are free to change and redistribute it.
 There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
 and "show warranty" for details.
 This GDB was configured as "powerpc64-unknown-linux-gnu"...
 
 crash: page excluded: kernel virtual address: c00000000075edb0  type: "cpu_possible_mask"
 #
  
Clearly the kernel page containing the "cpu_possible_mask" should
never be determined to be a user page.  

So after debugging this, I first noted that makedumpfile did in fact
determine that the 64K physical page at 0x750000 was a user page 
because its associated page.mapping field had the PAGE_MAPPING_ANON bit
set.  But further debugging showed that __exclude_unnecessary_pages()
was being passed invalid mem_map array addresses, and as a result
the page contents being tested were bogus.  And the reason for the 
invalid mem_map addresses is because is_sparsemem_extreme() is 
incorrectly returning FALSE:
 
 int
 is_sparsemem_extreme(void)
 {
         if (ARRAY_LENGTH(mem_section)
              == (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
                 return TRUE;
         else
                 return FALSE;
 }
 
on a kernel which most definitely is CONFIG_SPARSEMEM_EXTREME.
The kernel's declaration of mem_section is this:  
 
 #ifdef CONFIG_SPARSEMEM_EXTREME
 struct mem_section *mem_section[NR_SECTION_ROOTS]
         ____cacheline_internodealigned_in_smp;
 #else
 struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
         ____cacheline_internodealigned_in_smp;
 #endif
 EXPORT_SYMBOL(mem_section);
 
And this ppc64 kernel's mem_section is this:

 crash> whatis mem_section
 struct mem_section *mem_section[2048];
 crash>

The is_sparsemem_extreme() function is similar to that of
the crash utility's, which was modified in 2008 like so:
 
 -		
 -	if (get_array_length("mem_section", NULL, 0) ==
 -	    (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME()))
 +
 +	if ((get_array_length("mem_section", &dimension, 0) ==
 +	    (NR_MEM_SECTIONS() / _SECTIONS_PER_ROOT_EXTREME())) || !dimension)
 		vt->flags |= SPARSEMEM_EX;
 
The patch above simplifies things by also checking whether it's
a two-dimensional array.  It was actually put in place in 
crash-4.0-7.2 for s390/s390x CONFIG_SPARSEMEM support:

  - Implement support for s390/s390x CONFIG_SPARSEMEM kernels.  Without
    the patch, crash sessions would fail during initialization with the
    error message: "crash: CONFIG_SPARSEMEM kernels not supported for
    this architecture".  (holzheu@linux.vnet.ibm.com)

In any case, if I hack makedumpfile so that is_sparsemem_extreme()
returns TRUE, everything works fine.

I haven't checked why the original math fails in the case of the
ppc64 kernel, while it does not fail in a CONFIG_SPARSEMEM_EXTREME
x86_64 kernel, for example. (page size maybe?)  But obviously the
simpler dimemsion-check is a better way to do it.

Of course, within the current constraints of makedumpfile, it's not
that easy.  Ideally the kernel could pass the configuration in
the vmcoreinfo with a VMCOREINFO_CONFIG(name).  But anyway, I'll leave
that up to you.

Thanks,
  Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
