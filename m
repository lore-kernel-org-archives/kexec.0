Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PzNYk-0006Xk-4z
	for kexec@lists.infradead.org; Tue, 15 Mar 2011 06:16:47 +0000
Date: Tue, 15 Mar 2011 15:12:47 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v1 0/6] makedumpfile: makedumpfile enhancement to filter
	out kernel data from vmcore
Message-Id: <20110315151247.23fc84bc.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <4D7EF934.3090008@linux.vnet.ibm.com>
References: <20110311075647.14587.50626.stgit@mars.in.ibm.com>
	<1823425025.382709.1299852470929.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
	<20110314114457.7e252f0d.oomichi@mxs.nes.nec.co.jp>
	<4D7EF934.3090008@linux.vnet.ibm.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Dave Anderson <anderson@redhat.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

On Tue, 15 Mar 2011 10:59:24 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> >>
> >> Is there any notation in the filtered ELF kdump or compressed kdump file
> >> that filtering has been done?  Given that there may be potential ramifications
> >> in crash utility behavior (or outright failure?), the crash utility should
> >> display a warning message early on during invocation.
> > 
> > That is a good point.
> > 
> > How about adding new members (like offset_eraseinfo, size_eraseinfo)
> > into the sub header in compressed kdump file, and setting version 5
> > in the header version (disk_dump_header.header_version) ?
> > These members show the erased information like the following:
> > 
> > struct kdump_sub_header {
> >         unsigned long   phys_base;
> >         int             dump_level;     /* header_version 1 and later */
> >         int             split;          /* header_version 2 and later */
> >         unsigned long   start_pfn;      /* header_version 2 and later */
> >         unsigned long   end_pfn;        /* header_version 2 and later */
> >         off_t           offset_vmcoreinfo;/* header_version 3 and later */
> >         unsigned long   size_vmcoreinfo;  /* header_version 3 and later */
> >         off_t           offset_note;      /* header_version 4 and later */
> >         unsigned long   size_note;        /* header_version 4 and later */
> > +       off_t           offset_eraseinfo; /* header_version 5 and later */
> > +       unsigned long   size_eraseinfo;   /* header_version 5 and later */
> > };
> > 
> > The erased information contains only effective lines in the
> > configuration file.
> 
> Do you mean the info would contain symbol name/expression, resolved
> symbol/vmalloc addresses and its sizes that got filtered out?
> 
> What I mean by symbol expression is, user can ask makedumpfile to erase
> a data referred by a member from the symbol variable of structure type.
> e.g.
> 	struct S1 {
> 		int a;
> 	};
> 	struct S2 {
> 		struct S1 *mystruct1;
> 	};
> 
> 	struct S2 mystruct2;
> 
> 	#Filter command
> 	erase mystruct2.mystruct1.a
> 
> So the erase information in kdump header would contain:
> 
> -----------------------------------
> Symbol Name: mystruct2.mystruct1.a
> Filter Addr: &mystruct2.mystruct1->a
> Filter Size: 4	(sizeof type int)
> -----------------------------------
> 
> For erase commands in loop construct we will have multiple Filter addresses.
> 
> Please let me know your comment on the above format.

In my idea, offset_eraseinfo points the *file offset* of the erased
information and size_eraseinfo is the information size.

The erased information would contain *multiple* erased symbol names.
For example, the following is based on your above example.

 	struct S1 {
 		int a;
 		int b;
 		int c;
 	};
 	struct S2 {
 		struct S1 *mystruct1;
 		struct S1 *mystruct2;
 	};
 
 	struct S2 mystruct2;
 
 	#Filter command
 	erase mystruct2.mystruct1.a
 	erase mystruct2.mystruct1.c
 	erase mystruct2.mystruct2.b

	#The erased information
 	erase mystruct2.mystruct1.a 4
 	erase mystruct2.mystruct1.c 4
 	erase mystruct2.mystruct2.b 4


The dumpfile image :

       header             dump data             the erased information
+------------------+-----------------------+-------------------------------+
| ................ | ..................... | erase mystruct2.mystruct1.a 4 |
| offset_eraseinfo | ..................... | erase mystruct2.mystruct1.c 4 |
|   size_eraseinfo | ..................... | erase mystruct2.mystruct2.b 4 |
+------------------+-------------------------------------------------------+
                                           : offset_eraseinfo (offset in dumpfile)
                                            <------ size_eraseinfo ------->
                                            
Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
