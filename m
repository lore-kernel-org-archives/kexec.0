Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XigFa-00006y-Gg
 for kexec@lists.infradead.org; Mon, 27 Oct 2014 09:06:07 +0000
Date: Mon, 27 Oct 2014 17:04:02 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: Enable --mem-usage for s390x
Message-ID: <20141027090402.GC1558@dhcp-16-105.nay.redhat.com>
References: <20140929090432.GA9989@dhcp-16-116.nay.redhat.com>
 <20140929151413.4e9bd1ab@holzheu>
 <20140930090201.GB9989@dhcp-16-116.nay.redhat.com>
 <20141001185953.66c6ae9d@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D4D5E4@BPXM01GP.gisp.nec.co.jp>
 <20141010142310.4c488f6a@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D4E4E4@BPXM01GP.gisp.nec.co.jp>
 <20141016143753.726f63c0@holzheu>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D580A9@BPXM01GP.gisp.nec.co.jp>
 <20141027075707.GB1558@dhcp-16-105.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141027075707.GB1558@dhcp-16-105.nay.redhat.com>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "holzheu@linux.vnet.ibm.com" <holzheu@linux.vnet.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 10/27/14 at 03:57pm, Baoquan He wrote:
> On 10/23/14 at 06:56am, Atsushi Kumagai wrote:
> > >On Tue, 14 Oct 2014 07:19:13 +0000
> > >Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
> > >
> > >[snip]
> > >
> > >>
> > >> I understand why your patch works on s390x, so how about this way ?
> > >>
> > >>  1. Define "is_phys_addr()" for --mem-usage.
> > >>  2. Implement is_phys_addr() using is_iomem_phys_addr() for s390x
> > >>     while x86_64 uses is_vmalloc_addr_x86_64().
> > >>  3. Use is_phys_addr() instead of is_vmalloc_addr() in get_kcore_dump_loads().
> > >
> > >Hello Atsushi,
> > >
> > >Great, so let's do that.
> > >
> > >@Baoquan:
> > >If you want to use the is_iomem_phys_addr() function also for x86,
> > >you could perhaps add an additional patch.
> > 
> > I noticed that is_vmalloc_addr_x86_64() can't be used as is_phys_addr()
> > due to the "kaslr issue". I fixed it in the common path as below, but
> > --mem-usage still has the same issue since initial() will be invoked
> > after get_kcore_dump_loads().
> > 
> >   http://lists.infradead.org/pipermail/kexec/2014-October/012743.html
> > 
> > I know it's so late, but I began to think the current implementation
> > that invokes vaddr_to_paddr_XXX() before initial() is bad:
> > 
> > show_mem_usage()
> >   + get_kcore_dump_loads()
> >     + process_dump_load()
> >       + vaddr_to_paddr_XXX()
> >   + initial()
> 
> This is a bug. Seems that get_kcore_dump_loads() has to be called in
> initial(). Since dumped vmcore need contains kernel text segment.
> Without setting correct value for MODULES_VADDR, it will be equal to
> __START_KERNEL_map, then calling is_vmalloc_addr() will filter kernel
> text mapping segment too.
> 
> Now it seems only one way to solve this, that is moving
> get_kcore_dump_loads() into initial() just after
> get_value_for_old_linux() is called.


Hi Atsushi,

Checking code again, I found with kaslr support we need move vmcoreinfo
reading earlier to initialize the MODULES_VADDR, otherwise
get_phys_base_x86_64() will be wrong. Since not initializing
MODULES_VADDR explicitly its value is equal to __START_KERNEL_map,  that
means kernel text mapping segment is filtered by
is_vmalloc_addr_x86_64().

So could we move below code earlier? 


diff --git a/makedumpfile.c b/makedumpfile.c
index b27ea1e..1dac19f 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3092,6 +3092,23 @@ initial(void)
 		return FALSE;
 	}
 
+	/*
+	 * Get the debug information from /proc/vmcore.
+	 * NOTE: Don't move this code to the above, because the debugging
+	 *       information token by -x/-i option is overwritten by vmcoreinfo
+	 *       in /proc/vmcore. vmcoreinfo in /proc/vmcore is more reliable
+	 *       than -x/-i option.
+	 */
+	if (has_vmcoreinfo()) {
+		get_vmcoreinfo(&offset, &size);
+		if (!read_vmcoreinfo_from_vmcore(offset, size, FALSE))
+			return FALSE;
+		debug_info = TRUE;
+	}
+
+	if (!get_value_for_old_linux())
+		return FALSE;
+
 	if (info->flag_refiltering) {
 		if (info->flag_elf_dumpfile) {
 			MSG("'-E' option is disable, ");
@@ -3189,23 +3206,6 @@ initial(void)
 		}
 	}
 
-	/*
-	 * Get the debug information from /proc/vmcore.
-	 * NOTE: Don't move this code to the above, because the debugging
-	 *       information token by -x/-i option is overwritten by vmcoreinfo
-	 *       in /proc/vmcore. vmcoreinfo in /proc/vmcore is more reliable
-	 *       than -x/-i option.
-	 */
-	if (has_vmcoreinfo()) {
-		get_vmcoreinfo(&offset, &size);
-		if (!read_vmcoreinfo_from_vmcore(offset, size, FALSE))
-			return FALSE;
-		debug_info = TRUE;
-	}
-
-	if (!get_value_for_old_linux())
-		return FALSE;
-
 out:
 	if (!info->page_size) {
 		/*

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
