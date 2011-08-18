Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qtxks-0003iw-Rj
	for kexec@lists.infradead.org; Thu, 18 Aug 2011 08:15:12 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp02.in.ibm.com (8.14.4/8.13.1) with ESMTP id p7I8EF0W003863
	for <kexec@lists.infradead.org>; Thu, 18 Aug 2011 13:44:15 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7I8EEfj4505764
	for <kexec@lists.infradead.org>; Thu, 18 Aug 2011 13:44:14 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7I8EDLk020109
	for <kexec@lists.infradead.org>; Thu, 18 Aug 2011 13:44:14 +0530
Message-ID: <4E4CC9D4.7040306@linux.vnet.ibm.com>
Date: Thu, 18 Aug 2011 13:44:12 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 7/8] makedumpfile: Add erased information in compressed
	kdump file
References: <20110517200608.12740.68790.stgit@mars.in.ibm.com>
	<20110812171013.7545b3df.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110812171013.7545b3df.oomichi@mxs.nes.nec.co.jp>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Dave Anderson <anderson@redhat.com>, Reinhard <BUENDGEN@de.ibm.com>, kexec@lists.infradead.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, V Srivatsa <vsrivatsa@in.ibm.com>

Hi Ken'ichi,

On 08/12/2011 01:40 PM, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> On Wed, 18 May 2011 01:36:17 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -29,6 +29,8 @@ struct DumpInfo		*info = NULL;
>>  struct module_sym_table	mod_st = { 0 };
>>  struct filter_info	*filter_info = NULL;
>>  struct filter_config	filter_config;
>> +struct erase_info	*erase_info = NULL;
>> +unsigned long		num_erase_info = 1; /* Node 0 is unused. */
> 
> I cannot understand erase_info[0] is unused.

I did this to avoid the explicit need of initializing erase_info_idx
member from struct config_entry and struct filter_info with some other
invalid value, instead I thought I will use '0' as invalid index.

Do you think I should change this patch to use '-1' as invalid index?

> 
> 
>> @@ -6000,10 +6007,17 @@ write_kdump_header(void)
>>  			kh.size_vmcoreinfo = info->size_vmcoreinfo;
>>  		}
>>  	}
>> -	if (!write_buffer(info->fd_dumpfile, dh->block_size, &kh,
>> -	    size, info->name_dumpfile))
>> -		goto out;
>> +	/*
>> +	 * While writing dump data to STDOUT, delay the writing of sub header
>> +	 * untill we gather erase info offset and size.
>> +	 */
>> +	if (!info->flag_flatten) {
>> +		if (!write_buffer(info->fd_dumpfile, dh->block_size, &kh,
>> +		    size, info->name_dumpfile))
>> +			goto out;
>> +	}
> 
> Does makedumpfile work wrong if removing the above change ?
> 

Hmm.. while implementing this patch I thought we may run into issues if
we write sub_header data twice for flattened case. But it seems the '-R'
option rearranges the data properly.

I agree that we dont need above change. Thanks for catching this.

Thanks,
-Mahesh.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
