Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qp92l-0007Km-OW
	for kexec@lists.infradead.org; Fri, 05 Aug 2011 01:17:45 +0000
Date: Fri, 5 Aug 2011 09:26:59 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 4/8] makedumpfile: Introduce routines to get type
	name from debuginfo.
Message-Id: <20110805092659.a8a60bea.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <4E3A3F8A.8090204@linux.vnet.ibm.com>
References: <20110517200247.12740.45844.stgit@mars.in.ibm.com>
	<20110801102704.efc244ac.oomichi@mxs.nes.nec.co.jp>
	<4E3A3F8A.8090204@linux.vnet.ibm.com>
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
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

Thank you for your review and test.

On Thu, 04 Aug 2011 12:13:22 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
> On 08/01/2011 06:57 AM, Ken'ichi Ohmichi wrote:
> > 
> > Hi Mahesh,
> > 
> > A pointer size can been gotton by sizeof(void *), and pointer (virtual 
> > address) can been defined as "unsigned long".
> > I think we can make this patch simple. How about the attached patch ?
> > 
> 
> Yup, the patch looks simpler and good.
> 
> > 
> > Thanks
> > Ken'ichi Ohmichi
> > 
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index 3ad2bd5..6955f64 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -34,7 +34,6 @@ struct erase_info	*erase_info = NULL;
> >  unsigned long		num_erase_info = 1; /* Node 0 is unused. */
> > 
> >  char filename_stdout[] = FILENAME_STDOUT;
> > -long pointer_size;
> >  char config_buf[BUFSIZE_FGETS];
> > 
> >  /*
> > @@ -2058,10 +2057,6 @@ get_debug_info(void)
> >  	 */
> >  	while (dwarf_nextcu(dwarfd, off, &next_off, &header_size,
> >  	    &abbrev_offset, &address_size, &offset_size) == 0) {
> > -		if (dwarf_info.cmd == DWARF_INFO_GET_PTR_SIZE) {
> > -			dwarf_info.struct_size = address_size;
> > -			break;
> > -		}
> >  		off += header_size;
> >  		if (dwarf_offdie(dwarfd, off, &cu_die) == NULL) {
> >  			ERRMSG("Can't get CU die.\n");
> 
> [...]
> 
> > @@ -7863,8 +7849,8 @@ print_config_entry(struct config_entry *ce)
> >  		DEBUG_MSG("Type Name: %s, ", ce->type_name);
> >  		DEBUG_MSG("flag: %x, ", ce->flag);
> >  		DEBUG_MSG("Type flag: %lx, ", ce->type_flag);
> > -		DEBUG_MSG("sym_addr: %llx, ", ce->sym_addr);
> > -		DEBUG_MSG("addr: %llx, ", ce->addr);
> > +		DEBUG_MSG("sym_addr: %lx, ", ce->sym_addr);
> 
> Above change throws compilation warning. The sym_addr is unsigned long
> long, %llx still holds good.

Nice catch, I fixed the above.


> > +		DEBUG_MSG("addr: %lx, ", ce->addr);
> >  		DEBUG_MSG("offset: %lx, ", ce->offset);
> >  		DEBUG_MSG("size: %zd\n", ce->size);
> > 
> 
> [...]
> 
> > @@ -1284,7 +1283,7 @@ struct config_entry {
> >  	unsigned short		flag;
> >  	unsigned short		nullify;
> >  	unsigned long long	sym_addr;	/* Symbol address */
> > -	unsigned long long	addr;		/* Symbol address or
> > +	unsigned long		addr;		/* Symbol address or
> >  						   value pointed by sym_addr */
> >  	unsigned long long	cmp_addr;	/* for LIST_ENTRY */
> >  	unsigned long		offset;
> > 
> 
> I tested this patch and works fine.

Thank you.
I have merged this patch.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
