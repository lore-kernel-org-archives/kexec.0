Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QolKi-0007nP-4F
	for kexec@lists.infradead.org; Wed, 03 Aug 2011 23:58:41 +0000
Date: Thu, 4 Aug 2011 08:54:08 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 3/8] makedumpfile: Load the module symbol data from
	vmcore.
Message-Id: <20110804085408.927a7e7a.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <4E39247A.1070303@linux.vnet.ibm.com>
References: <20110517200143.12740.52724.stgit@mars.in.ibm.com>
	<20110729184208.236c4e1f.oomichi@mxs.nes.nec.co.jp>
	<4E39247A.1070303@linux.vnet.ibm.com>
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


Hi Mehesh,

On Wed, 03 Aug 2011 16:05:38 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> > 
> >> +static int
> >> +load_module_symbols(void)
> >> +{
> >> +	unsigned long head, cur, cur_module;
> >> +	unsigned long symtab, strtab;
> >> +	unsigned long mod_base, mod_init;
> >> +	unsigned int mod_size, mod_init_size;
> >> +	unsigned char *module_struct_mem, *module_core_mem;
> >> +	unsigned char *module_init_mem = NULL;
> >> +	unsigned char *symtab_mem;
> >> +	char *module_name, *strtab_mem, *nameptr;
> >> +	struct module_info *modules = NULL;
> >> +	struct symbol_info *sym_info;
> >> +	unsigned int num_symtab;
> >> +	unsigned int i = 0, nsym;
> >> +
> >> +	head = SYMBOL(modules);
> >> +	if (!get_num_modules(head, &mod_st.num_modules)) {
> >> +		ERRMSG("Can't get module count\n");
> >> +		return FALSE;
> >> +	}
> >> +	if (!mod_st.num_modules) {
> >> +		return FALSE;
> > 
> > If the above num_modules is 0, makedumpfile fails without any hint
> > message. How about the below change ?
> 
> Agree.

[..]

> >> +		if (mod_init_size > 0) {
> >> +			module_init_mem = calloc(1, mod_init_size);
> >> +			if (module_init_mem == NULL) {
> >> +				ERRMSG("Can't allocate memory for module "
> >> +								"init\n");
> >> +				return FALSE;
> >> +			}
> >> +			if (!readmem(VADDR, mod_init, module_init_mem,
> >> +							mod_init_size)) {
> >> +				ERRMSG("Can't access module init in memory.\n");
> >> +				return FALSE;
> > 
> > In the above error case, module_init_mem should be freed.
> > There are the same lacks of free, and I feel it is due to
> > a large load_module_symbols() function.
> > Hence I created the attached patch for making the function
> > small and fixing the lacks of free.
> > Can you review it ?
> 
> The attached patch looks good to me. Thanks for splitting the function.

Thank you for your review of two patches.
I have merged them into filter-out-devel branch.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
