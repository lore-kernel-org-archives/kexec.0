Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R1SxF-0003PF-Gm
	for kexec@lists.infradead.org; Thu, 08 Sep 2011 00:58:58 +0000
Date: Thu, 8 Sep 2011 08:35:44 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 6/8] makedumpfile: Read and process 'for' command
	from config file.
Message-Id: <20110908083544.64d7f949.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <4E6751FE.5070605@linux.vnet.ibm.com>
References: <20110517200514.12740.86690.stgit@mars.in.ibm.com>
	<20110811170621.2f931dbe.oomichi@mxs.nes.nec.co.jp>
	<20110830181642.GA21808@in.ibm.com>
	<20110901170658.67f830df.oomichi@mxs.nes.nec.co.jp>
	<20110905144033.GA26767@in.ibm.com>
	<20110907154115.02b47998.oomichi@mxs.nes.nec.co.jp>
	<4E6751FE.5070605@linux.vnet.ibm.com>
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

On Wed, 07 Sep 2011 16:44:06 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> >>>>
> >>>> This patch fixes following BUGs:
> >>>
> >>> [..]
> >>>
> >>>> - The loop construct used for array of char* (pointer) silently fails and
> >>>> does not filter the strings.
> >>>
> >>> Did the silent failure happen at the following code of list_entry_empty() ?
> >>>
> >>>    7373         addr = get_config_symbol_addr(le, 0, NULL);
> >>>    7374         if (!addr)
> >>>    7375                 return TRUE;
> >>>
> >>
> >> Nope. It use to fail in resolve_list_entry()->resolve_config_entry()
> >> and following hunk from the patch fixes it:
> >>We dont allow no-array 
> >> @@ -6866,7 +6882,7 @@ resolve_config_entry(struct config_entry *ce, unsigned long long base_addr,
> >>  		 * If this is a struct or list_head data type then
> >>  		 * create a leaf node entry with 'next' member.
> >>  		 */
> >> -		if ((ce->type_flag & TYPE_BASE)
> >> +		if (((ce->type_flag & (TYPE_BASE | TYPE_ARRAY)) == TYPE_BASE)
> >>  					&& (strcmp(ce->type_name, "void")))
> >>  			return FALSE;
> >>  
> >> The old code use to check only TYPE_BASE flag ignoring TYPE_ARRAY flag.
> > 
> > Thank you for the explanation.
> > I feel I see it.
> > Is the below understanding right ?
> > 
> > At the part of earlier resolve_config_entry(), necessary information
> > (sym_addr, type_name, and array_length) can be gotten in the case
> > of pointer array.
> 
> Yes, including the size information for type of element (type_name) in
> the LIST entry.
> 
> > However, the old resolve_config_entry() returned FALSE because of
> > the check lack you said.
> 
> Yes. The old resolve_config_entry() use to return FALSE only for array
> of base type elements (e.g. array of char, int, long etc.). However, it
> was working well for array of structures (pointer/non-pointer).
> 
> The LIST entry can be of one of the following kind:
> 1. Array of base types (pointer/non-pointer).
> 2. Array of structures (pointer/non-pointer).
> 3. Link list.
> 4. list_head link list.
> 
> The old code was working for all of the above except (1).

Thank you.
I can see.


> [PATCH] makedumpfile: Fix array traversal for array of structure and char type.
> 
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> Introduce new function get_next_list_entry() that returns config entry
> for each element in the LIST entry. This approach improves the handling
> of LIST entry. With this change the function get_config_symbol_addr()
> no longer required to handle LIST entry separately.
> 
> This patch fixes following BUGs:
> 
> - If the loop construct is used for array of structures (non-pointer), then
> the array index value is not incremented resulting in an infinite loop. This
> patch fixes this BUG.
> - The loop construct used for array of char* (pointer) silently fails and
> does not filter the strings.
> - Corrected 2nd argument while calling get_structure_size().
> - Fixed dwarf_info.c:get_data_array_length() to handle array of const data
> type.
>   e.g.
> 	<1><1a49df3>: Abbrev Number: 90 (DW_TAG_variable)
> 	   <1a49df4>   DW_AT_name        : policycap_names
> 	   <1a49df8>   DW_AT_decl_file   : 1
> 	   <1a49df9>   DW_AT_decl_line   : 43
> 	   <1a49dfa>   DW_AT_type        : <0x1a49e08>
> 	<1><1a49e08>: Abbrev Number: 7 (DW_TAG_const_type)
> 	   <1a49e09>   DW_AT_type        : <0x1a49de3>
> 	<1><1a49de3>: Abbrev Number: 4 (DW_TAG_array_type)
> 	   <1a49de4>   DW_AT_type        : <0x1a3b276>
> 	   <1a49de8>   DW_AT_sibling     : <0x1a49df3>
> 
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Acked-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
