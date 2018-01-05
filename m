Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eXHu9-0008JF-ME
 for kexec@lists.infradead.org; Fri, 05 Jan 2018 02:38:47 +0000
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8AEB5C058ECF
 for <kexec@lists.infradead.org>; Fri,  5 Jan 2018 02:38:34 +0000 (UTC)
Date: Fri, 5 Jan 2018 10:38:28 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: makedumpfile saving vmcore fails with dynamically allocated
 mem_section (was: Re: [PATCH] handle renamed init_level4_pgt ->
 init_top_pgt)
Message-ID: <20180105023828.GA11054@dhcp-128-65.nay.redhat.com>
References: <mailman.7.1515009607.12089.kexec@lists.infradead.org>
 <727199273.2520585.1515010910495.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <727199273.2520585.1515010910495.JavaMail.zimbra@redhat.com>
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
To: Dave Anderson <anderson@redhat.com>
Cc: kexec@lists.infradead.org

On 01/03/18 at 03:21pm, Dave Anderson wrote:
> 
> 
> ----- Original Message -----
> 
> > On 01/02/18 at 05:08pm, Baoquan He wrote:
> > > On 01/02/18 at 04:57pm, Dave Young wrote:
> > > > The root cause is this commit makes mem_section as a pointer instead of
> > > > the static array.
> > > > 
> > > > VMCOREINFO_SYMBOL() expand it as &mem_section, this is not correct in
> > > > the test case any more.
> > > > 
> > > > This hack code works for me:
> > > > 
> > > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > > index b3663896278e..f5fe6068ae39 100644
> > > > --- a/kernel/crash_core.c
> > > > +++ b/kernel/crash_core.c
> > > > @@ -376,6 +376,8 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
> > > >  {
> > > >  	return __pa(vmcoreinfo_note);
> > > >  }
> > > > +#define VMCOREINFO_SYMBOL_HACK(name) \
> > > > +	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)name)
> > > 
> > > Oh, you made a new one. We may use vmcoreinfo_append_str directly since
> > > there's an existing one in crash_save_vmcoreinfo():
> > 
> > Yes, it should be something like this instead, this should ensure
> > makedumpfile maybe crash tool works without any modifications,
> > waiting for feedback from Atsushi, also ccing Dave for crash utility
> > potential issue.
> 
> Yeah, I ran into that issue when testing 4.15, and fixed it upstream:
> 
>   https://github.com/crash-utility/crash/commit/264f22dafe9f37780c4113fd08e8d5b2138edbce
> 
>   commit 264f22dafe9f37780c4113fd08e8d5b2138edbce
>   Author: Dave Anderson <anderson@redhat.com>
>   Date:   Wed Nov 29 15:28:41 2017 -0500
> 
>     Fix for Linux 4.15 and later kernels that are configured with
>     CONFIG_SPARSEMEM_EXTREME, and that contain kernel commit
>     83e3c48729d9ebb7af5a31a504f3fd6aff0348c4, titled "mm/sparsemem:
>     Allocate mem_section at runtime for CONFIG_SPARSEMEM_EXTREME=y".
>     Without the patch, kernels configured with SPARSEMEM_EXTREME
>     have changed the data type of "mem_section" from an array to
>     a pointer, leading to errors in commands such as "kmem -p",
>     "kmem -n", "kmem -s", and any other command that translates a
>     physical address to its page struct address.
>     (anderson@redhat.com)
> 

Hi Dave,

I tried latest crash tool, but segment fault happened, I put the
vmlinux/vmcore in below url, could you have a look?:
http://people.redhat.com/ruyang/rhbz1528542/127.0.0.1-2018-01-05-10:29:23/

---
crash 7.2.0++
Copyright (C) 2002-2017  Red Hat, Inc.
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
 
GNU gdb (GDB) 7.6
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-unknown-linux-gnu"...

WARNING: could not find MAGIC_START!
WARNING: kernel version inconsistency between vmlinux and dumpfile

please wait... (gathering task table data)      
WARNING: duplicate idle tasks?

WARNING: duplicate idle tasks?
please wait... (determining panic task)    
WARNING: active task ffffffff81e90536 on cpu 0 not found in PID hash

[ 1156.567444] crash[2964]: segfault at 7175228 ip 00000000004bf39e sp 00007ffd5dce3f30 error 6 in crash[400000+6da000]
Segmentation fault (core dumped)

The tested kernel applied below patch (a tuned patch according to bhe's
suggestion):

---
 kernel/crash_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux.orig/kernel/crash_core.c
+++ linux/kernel/crash_core.c
@@ -410,7 +410,8 @@ static int __init crash_save_vmcoreinfo_
 	VMCOREINFO_SYMBOL(contig_page_data);
 #endif
 #ifdef CONFIG_SPARSEMEM
-	VMCOREINFO_SYMBOL(mem_section);
+	vmcoreinfo_append_str("SYMBOL(mem_section)=%lx\n",
+			      (unsigned long)mem_section);
 	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
 	VMCOREINFO_STRUCT_SIZE(mem_section);
 	VMCOREINFO_OFFSET(mem_section, section_mem_map);


Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
