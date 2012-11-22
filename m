Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TbXR0-0003Vo-Bd
 for kexec@lists.infradead.org; Thu, 22 Nov 2012 14:07:19 +0000
Received: by mail-pa0-f49.google.com with SMTP id bi1so2780194pad.36
 for <kexec@lists.infradead.org>; Thu, 22 Nov 2012 06:07:16 -0800 (PST)
Date: Thu, 22 Nov 2012 23:07:01 +0900 (JST)
Message-Id: <20121122.230701.1753430694449315493.d.hatayama@gmail.com>
Subject: Re: [PATCH v2] makedumpfile: request the kernel do page scans
From: HATAYAMA Daisuke <d.hatayama@gmail.com>
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E20AB0B43E@G01JPEXMBYT03>
References: <E1TbGZV-0008DR-Tb@eag09.americas.sgi.com>
 <33710E6CAA200E4583255F4FB666C4E20AB0B43E@G01JPEXMBYT03>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: cpw@sgi.com
Cc: kexec@lists.infradead.org, d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp

From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH v2] makedumpfile: request the kernel do page scans
Date: Thu, 22 Nov 2012 01:43:39 +0000

[...]

>> +/*
>> + * limit the size of the pfn list to this many pfn_element structures
>> + */
>> +#define MAX_PFN_LIST 10000
>> +
>> +/*
>> + * one element in the pfn_list
>> + */
>> +struct pfn_element {
>> +	unsigned long pfn;
>> +	unsigned long order;
>> +};
>> +
>> +/*
>> + * a request for finding pfn's that can be excluded from the dump
>> + * they may be pages of particular types or free pages
>> + */
>> +struct pfn_list_request {
>> +	int request;		/* PL_REQUEST_FREE PL_REQUEST_EXCLUDE or
>> */
>> +				/* PL_REQUEST_MEMMAP */
>> +	int debug;
>> +	unsigned long paddr;	/* mem_map address for
>> PL_REQUEST_EXCLUDE */
>> +	unsigned long pfn_start;/* pfn represented by paddr */
>> +	unsigned long pgdat_paddr; /* for PL_REQUEST_FREE */
>> +	unsigned long pgdat_vaddr; /* for PL_REQUEST_FREE */
>> +	int node;		/* for PL_REQUEST_FREE */
>> +	int exclude_bits;	/* for PL_REQUEST_EXCLUDE */
>> +	int count;		/* for PL_REQUEST_EXCLUDE */
>> +	void *reply_ptr;	/* address of user's pfn_reply, for reply
>> */
> 
> How about passing bitmap instead of lists and making kernel side unset bits
> corresponding to unnecessary pages? It's less coping and constant.
> 

Again, there's also small memory issue. makedumpfile v1.5.1 calculates
cyclic buffer size automatically from MemFree in /proc/meminfo. It's
40% of MemFree. There are two bitmaps so 80% is used in total.

Now, if passing bitmap as usual, copy_from_user() would be used. But
then, kernel space needs to prepare buffer of the cyclic buffer
size. It's 120% in total.

Alternatively, my idea is to export bitmap from kernel-space, and from
makedumpfile, mmap it, read it and then updates it each time one cycle
ends.

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
