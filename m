Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eWpY2-0005ol-26
 for kexec@lists.infradead.org; Wed, 03 Jan 2018 20:22:19 +0000
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A3824900C
 for <kexec@lists.infradead.org>; Wed,  3 Jan 2018 20:21:50 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93AC46C435
 for <kexec@lists.infradead.org>; Wed,  3 Jan 2018 20:21:50 +0000 (UTC)
Received: from zmail24.collab.prod.int.phx2.redhat.com
 (zmail24.collab.prod.int.phx2.redhat.com [10.5.83.30])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 8C978180884F
 for <kexec@lists.infradead.org>; Wed,  3 Jan 2018 20:21:50 +0000 (UTC)
Date: Wed, 3 Jan 2018 15:21:50 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <727199273.2520585.1515010910495.JavaMail.zimbra@redhat.com>
In-Reply-To: <mailman.7.1515009607.12089.kexec@lists.infradead.org>
References: <mailman.7.1515009607.12089.kexec@lists.infradead.org>
Subject: Re: makedumpfile saving vmcore fails with dynamically allocated
 mem_section (was: Re: [PATCH] handle renamed init_level4_pgt ->
 init_top_pgt)
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org



----- Original Message -----

> On 01/02/18 at 05:08pm, Baoquan He wrote:
> > On 01/02/18 at 04:57pm, Dave Young wrote:
> > > The root cause is this commit makes mem_section as a pointer instead of
> > > the static array.
> > > 
> > > VMCOREINFO_SYMBOL() expand it as &mem_section, this is not correct in
> > > the test case any more.
> > > 
> > > This hack code works for me:
> > > 
> > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > index b3663896278e..f5fe6068ae39 100644
> > > --- a/kernel/crash_core.c
> > > +++ b/kernel/crash_core.c
> > > @@ -376,6 +376,8 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
> > >  {
> > >  	return __pa(vmcoreinfo_note);
> > >  }
> > > +#define VMCOREINFO_SYMBOL_HACK(name) \
> > > +	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)name)
> > 
> > Oh, you made a new one. We may use vmcoreinfo_append_str directly since
> > there's an existing one in crash_save_vmcoreinfo():
> 
> Yes, it should be something like this instead, this should ensure
> makedumpfile maybe crash tool works without any modifications,
> waiting for feedback from Atsushi, also ccing Dave for crash utility
> potential issue.

Yeah, I ran into that issue when testing 4.15, and fixed it upstream:

  https://github.com/crash-utility/crash/commit/264f22dafe9f37780c4113fd08e8d5b2138edbce

  commit 264f22dafe9f37780c4113fd08e8d5b2138edbce
  Author: Dave Anderson <anderson@redhat.com>
  Date:   Wed Nov 29 15:28:41 2017 -0500

    Fix for Linux 4.15 and later kernels that are configured with
    CONFIG_SPARSEMEM_EXTREME, and that contain kernel commit
    83e3c48729d9ebb7af5a31a504f3fd6aff0348c4, titled "mm/sparsemem:
    Allocate mem_section at runtime for CONFIG_SPARSEMEM_EXTREME=y".
    Without the patch, kernels configured with SPARSEMEM_EXTREME
    have changed the data type of "mem_section" from an array to
    a pointer, leading to errors in commands such as "kmem -p",
    "kmem -n", "kmem -s", and any other command that translates a
    physical address to its page struct address.
    (anderson@redhat.com)

Thanks,
  Dave



> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index b3663896278e..122494364179 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -410,10 +410,16 @@ static int __init crash_save_vmcoreinfo_init(void)
>  	VMCOREINFO_SYMBOL(contig_page_data);
>  #endif
>  #ifdef CONFIG_SPARSEMEM
> +#ifdef CONFIG_SPARSEMEM_EXTREME
> +	vmcoreinfo_append_str("SYMBOL(mem_section)=%lx\n",
> +			      (unsigned long)mem_section);
> +#else
>  	VMCOREINFO_SYMBOL(mem_section);
> +#endif
>  	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
>  	VMCOREINFO_STRUCT_SIZE(mem_section);
>  	VMCOREINFO_OFFSET(mem_section, section_mem_map);
> +
>  #endif
>  	VMCOREINFO_STRUCT_SIZE(page);
>  	VMCOREINFO_STRUCT_SIZE(pglist_data);
> 
> > 
> > vmcoreinfo_append_str("CRASHTIME=%ld\n", get_seconds());
> > 
> > The thing is that VMCOREINFO_SYMBOL will reference symbol. While
> > checking all exported symbol, all of them are array names. So here
> > the value of &array_name is equal to the address of the first element of
> > array. Now the first exception appeared, mem_section, which could be not
> > an array name, but a pointer pointing at the allocated memory.
> > 
> > For this issue, we either change as Dave mentioned two options, or can
> > we adjust VMCOREINFO_SYMBOL(name)?
> > 
> > >  
> > >  static int __init crash_save_vmcoreinfo_init(void)
> > >  {
> > > @@ -410,10 +412,11 @@ static int __init crash_save_vmcoreinfo_init(void)
> > >  	VMCOREINFO_SYMBOL(contig_page_data);
> > >  #endif
> > >  #ifdef CONFIG_SPARSEMEM
> > > -	VMCOREINFO_SYMBOL(mem_section);
> > > +	VMCOREINFO_SYMBOL_HACK(mem_section);
> > >  	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> > >  	VMCOREINFO_STRUCT_SIZE(mem_section);
> > >  	VMCOREINFO_OFFSET(mem_section, section_mem_map);
> > > +
> > >  #endif
> > >  	VMCOREINFO_STRUCT_SIZE(page);
> > >  	VMCOREINFO_STRUCT_SIZE(pglist_data);
> > > 
> > > 
> > > But probably we need this instead, but I can not test it because I do
> > > not know how to fix makedumpfile to use a _NUMBER instead of a SYMBOL.
> > > Thus bring up the issue, seeking for thoughts and discussion.
> > > 
> > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > index b3663896278e..dfa2238e2c28 100644
> > > --- a/kernel/crash_core.c
> > > +++ b/kernel/crash_core.c
> > > @@ -410,10 +410,17 @@ static int __init crash_save_vmcoreinfo_init(void)
> > > 	VMCOREINFO_SYMBOL(contig_page_data);
> > >  #endif
> > >  #ifdef CONFIG_SPARSEMEM
> > > +#ifdef CONFIG_SPARSEMEM_EXTREME
> > > +	VMCOREINFO_NUMBER(mem_section);
> > > +#else
> > > 	VMCOREINFO_SYMBOL(mem_section);
> > > +#endif
> > > 	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> > > 	VMCOREINFO_STRUCT_SIZE(mem_section);
> > > 	VMCOREINFO_OFFSET(mem_section, section_mem_map);
> > > 
> > > [snip]
> > > 
> > > Thanks
> > > Dave
> 
> 
> 
> ------------------------------
> 
> Message: 2
> Date: Wed, 3 Jan 2018 10:38:35 +0800
> From: Baoquan He <bhe@redhat.com>
> To: Dave Young <dyoung@redhat.com>
> Cc: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Keiichirou Suzuki
> 	<kei-suzuki@xr.jp.nec.com>, Jeff Mahoney <jeffm@suse.com>,
> 	"anderson@redhat.com kexec@lists.infradead.org"
> 	<kexec@lists.infradead.org>
> Subject: Re: makedumpfile saving vmcore fails with dynamically
> 	allocated mem_section (was: Re: [PATCH] handle renamed init_level4_pgt
> 	-> init_top_pgt)
> Message-ID: <20180103023835.GB2338@x1>
> Content-Type: text/plain; charset=us-ascii
> 
> On 01/03/18 at 10:30am, Dave Young wrote:
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
> > 
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index b3663896278e..122494364179 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -410,10 +410,16 @@ static int __init crash_save_vmcoreinfo_init(void)
> >  	VMCOREINFO_SYMBOL(contig_page_data);
> >  #endif
> >  #ifdef CONFIG_SPARSEMEM
> > +#ifdef CONFIG_SPARSEMEM_EXTREME
> > +	vmcoreinfo_append_str("SYMBOL(mem_section)=%lx\n",
> > +			      (unsigned long)mem_section);
> > +#else
> >  	VMCOREINFO_SYMBOL(mem_section);
> > +#endif
> 
> 	vmcoreinfo_append_str("SYMBOL(mem_section)=%lx\n",
> 				(unsigned long)mem_section);
> 
> This is enough to cover both cases. mem_section is array name in non
> SPARSEMEM_EXTREME case, so value of &mem_section == value of
> mem_section.
> 
> >  	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> >  	VMCOREINFO_STRUCT_SIZE(mem_section);
> >  	VMCOREINFO_OFFSET(mem_section, section_mem_map);
> > +
> >  #endif
> >  	VMCOREINFO_STRUCT_SIZE(page);
> >  	VMCOREINFO_STRUCT_SIZE(pglist_data);
> > 
> > > 
> > > vmcoreinfo_append_str("CRASHTIME=%ld\n", get_seconds());
> > > 
> > > The thing is that VMCOREINFO_SYMBOL will reference symbol. While
> > > checking all exported symbol, all of them are array names. So here
> > > the value of &array_name is equal to the address of the first element of
> > > array. Now the first exception appeared, mem_section, which could be not
> > > an array name, but a pointer pointing at the allocated memory.
> > > 
> > > For this issue, we either change as Dave mentioned two options, or can
> > > we adjust VMCOREINFO_SYMBOL(name)?
> > > 
> > > >  
> > > >  static int __init crash_save_vmcoreinfo_init(void)
> > > >  {
> > > > @@ -410,10 +412,11 @@ static int __init
> > > > crash_save_vmcoreinfo_init(void)
> > > >  	VMCOREINFO_SYMBOL(contig_page_data);
> > > >  #endif
> > > >  #ifdef CONFIG_SPARSEMEM
> > > > -	VMCOREINFO_SYMBOL(mem_section);
> > > > +	VMCOREINFO_SYMBOL_HACK(mem_section);
> > > >  	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> > > >  	VMCOREINFO_STRUCT_SIZE(mem_section);
> > > >  	VMCOREINFO_OFFSET(mem_section, section_mem_map);
> > > > +
> > > >  #endif
> > > >  	VMCOREINFO_STRUCT_SIZE(page);
> > > >  	VMCOREINFO_STRUCT_SIZE(pglist_data);
> > > > 
> > > > 
> > > > But probably we need this instead, but I can not test it because I do
> > > > not know how to fix makedumpfile to use a _NUMBER instead of a SYMBOL.
> > > > Thus bring up the issue, seeking for thoughts and discussion.
> > > > 
> > > > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > > > index b3663896278e..dfa2238e2c28 100644
> > > > --- a/kernel/crash_core.c
> > > > +++ b/kernel/crash_core.c
> > > > @@ -410,10 +410,17 @@ static int __init
> > > > crash_save_vmcoreinfo_init(void)
> > > > 	VMCOREINFO_SYMBOL(contig_page_data);
> > > >  #endif
> > > >  #ifdef CONFIG_SPARSEMEM
> > > > +#ifdef CONFIG_SPARSEMEM_EXTREME
> > > > +	VMCOREINFO_NUMBER(mem_section);
> > > > +#else
> > > > 	VMCOREINFO_SYMBOL(mem_section);
> > > > +#endif
> > > > 	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> > > > 	VMCOREINFO_STRUCT_SIZE(mem_section);
> > > > 	VMCOREINFO_OFFSET(mem_section, section_mem_map);
> > > > 
> > > > [snip]
> > > > 
> > > > Thanks
> > > > Dave
> 
> 
> 
> ------------------------------
> 
> Subject: Digest Footer
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
> 
> ------------------------------
> 
> End of kexec Digest, Vol 130, Issue 2
> *************************************
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
