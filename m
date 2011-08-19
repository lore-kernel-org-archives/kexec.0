Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QuIE1-0006C4-Oe
	for kexec@lists.infradead.org; Fri, 19 Aug 2011 06:06:39 +0000
Date: Fri, 19 Aug 2011 14:39:30 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 7/8] makedumpfile: Add erased information in
	compressed kdump file
Message-Id: <20110819143930.b025fb1d.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <4E4CC9D4.7040306@linux.vnet.ibm.com>
References: <20110517200608.12740.68790.stgit@mars.in.ibm.com>
	<20110812171013.7545b3df.oomichi@mxs.nes.nec.co.jp>
	<4E4CC9D4.7040306@linux.vnet.ibm.com>
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
Cc: Dave Anderson <anderson@redhat.com>, Reinhard <BUENDGEN@de.ibm.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, V Srivatsa <vsrivatsa@in.ibm.com>


Hi Mahesh,

On Thu, 18 Aug 2011 13:44:12 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> >> --- a/makedumpfile.c
> >> +++ b/makedumpfile.c
> >> @@ -29,6 +29,8 @@ struct DumpInfo		*info = NULL;
> >>  struct module_sym_table	mod_st = { 0 };
> >>  struct filter_info	*filter_info = NULL;
> >>  struct filter_config	filter_config;
> >> +struct erase_info	*erase_info = NULL;
> >> +unsigned long		num_erase_info = 1; /* Node 0 is unused. */
> > 
> > I cannot understand erase_info[0] is unused.
> 
> I did this to avoid the explicit need of initializing erase_info_idx
> member from struct config_entry and struct filter_info with some other
> invalid value, instead I thought I will use '0' as invalid index.

Thank you for the explanation. I can understand your thought.
I think current code is right and we don't need to change the code.
Sorry about my noise.


> >> @@ -6000,10 +6007,17 @@ write_kdump_header(void)
> >>  			kh.size_vmcoreinfo = info->size_vmcoreinfo;
> >>  		}
> >>  	}
> >> -	if (!write_buffer(info->fd_dumpfile, dh->block_size, &kh,
> >> -	    size, info->name_dumpfile))
> >> -		goto out;
> >> +	/*
> >> +	 * While writing dump data to STDOUT, delay the writing of sub header
> >> +	 * untill we gather erase info offset and size.
> >> +	 */
> >> +	if (!info->flag_flatten) {
> >> +		if (!write_buffer(info->fd_dumpfile, dh->block_size, &kh,
> >> +		    size, info->name_dumpfile))
> >> +			goto out;
> >> +	}
> > 
> > Does makedumpfile work wrong if removing the above change ?
> > 
> 
> Hmm.. while implementing this patch I thought we may run into issues if
> we write sub_header data twice for flattened case. But it seems the '-R'
> option rearranges the data properly.
> 
> I agree that we dont need above change. Thanks for catching this.

OK, I will revert the above change.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
