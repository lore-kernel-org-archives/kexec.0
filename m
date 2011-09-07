Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([202.32.8.215])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R1FuO-0006eH-OL
	for kexec@lists.infradead.org; Wed, 07 Sep 2011 11:03:09 +0000
Received: from tyo201.gate.nec.co.jp ([10.7.69.201])
	by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id p87830xZ027390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <kexec@lists.infradead.org>; Wed, 7 Sep 2011 17:03:02 +0900 (JST)
Date: Wed, 7 Sep 2011 15:41:15 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 6/8] makedumpfile: Read and process 'for' command
	from config file.
Message-Id: <20110907154115.02b47998.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110905144033.GA26767@in.ibm.com>
References: <20110517200514.12740.86690.stgit@mars.in.ibm.com>
	<20110811170621.2f931dbe.oomichi@mxs.nes.nec.co.jp>
	<20110830181642.GA21808@in.ibm.com>
	<20110901170658.67f830df.oomichi@mxs.nes.nec.co.jp>
	<20110905144033.GA26767@in.ibm.com>
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
To: mahesh@linux.vnet.ibm.com
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>


Hi Mahesh,

On Mon, 5 Sep 2011 20:10:33 +0530
Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> > > 
> > > This patch fixes following BUGs:
> > 
> > [..]
> > 
> > > - The loop construct used for array of char* (pointer) silently fails and
> > > does not filter the strings.
> > 
> > Did the silent failure happen at the following code of list_entry_empty() ?
> > 
> >    7373         addr = get_config_symbol_addr(le, 0, NULL);
> >    7374         if (!addr)
> >    7375                 return TRUE;
> > 
> 
> Nope. It use to fail in resolve_list_entry()->resolve_config_entry()
> and following hunk from the patch fixes it:
> 
> @@ -6866,7 +6882,7 @@ resolve_config_entry(struct config_entry *ce, unsigned long long base_addr,
>  		 * If this is a struct or list_head data type then
>  		 * create a leaf node entry with 'next' member.
>  		 */
> -		if ((ce->type_flag & TYPE_BASE)
> +		if (((ce->type_flag & (TYPE_BASE | TYPE_ARRAY)) == TYPE_BASE)
>  					&& (strcmp(ce->type_name, "void")))
>  			return FALSE;
>  
> The old code use to check only TYPE_BASE flag ignoring TYPE_ARRAY flag.

Thank you for the explanation.
I feel I see it.
Is the below understanding right ?

At the part of earlier resolve_config_entry(), necessary information
(sym_addr, type_name, and array_length) can be gotten in the case
of pointer array.
However, the old resolve_config_entry() returned FALSE because of
the check lack you said.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
