Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R1G5A-0007JA-MD
	for kexec@lists.infradead.org; Wed, 07 Sep 2011 11:14:17 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p87BD99J003512
	for <kexec@lists.infradead.org>; Wed, 7 Sep 2011 21:13:09 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p87BCZu31052722
	for <kexec@lists.infradead.org>; Wed, 7 Sep 2011 21:12:35 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p87BE9BV025867
	for <kexec@lists.infradead.org>; Wed, 7 Sep 2011 21:14:09 +1000
Message-ID: <4E6751FE.5070605@linux.vnet.ibm.com>
Date: Wed, 07 Sep 2011 16:44:06 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 6/8] makedumpfile: Read and process 'for' command from
	config file.
References: <20110517200514.12740.86690.stgit@mars.in.ibm.com>
	<20110811170621.2f931dbe.oomichi@mxs.nes.nec.co.jp>
	<20110830181642.GA21808@in.ibm.com>
	<20110901170658.67f830df.oomichi@mxs.nes.nec.co.jp>
	<20110905144033.GA26767@in.ibm.com>
	<20110907154115.02b47998.oomichi@mxs.nes.nec.co.jp>
In-Reply-To: <20110907154115.02b47998.oomichi@mxs.nes.nec.co.jp>
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
Cc: V Srivatsa <vsrivatsa@in.ibm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Dave Anderson <anderson@redhat.com>, Prerna Saxena <prerna@linux.vnet.ibm.com>, Reinhard <BUENDGEN@de.ibm.com>

Hi Ken'ichi,

On 09/07/2011 12:11 PM, Ken'ichi Ohmichi wrote:
> 
> Hi Mahesh,
> 
> On Mon, 5 Sep 2011 20:10:33 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
>>>>
>>>> This patch fixes following BUGs:
>>>
>>> [..]
>>>
>>>> - The loop construct used for array of char* (pointer) silently fails and
>>>> does not filter the strings.
>>>
>>> Did the silent failure happen at the following code of list_entry_empty() ?
>>>
>>>    7373         addr = get_config_symbol_addr(le, 0, NULL);
>>>    7374         if (!addr)
>>>    7375                 return TRUE;
>>>
>>
>> Nope. It use to fail in resolve_list_entry()->resolve_config_entry()
>> and following hunk from the patch fixes it:
>>We dont allow no-array 
>> @@ -6866,7 +6882,7 @@ resolve_config_entry(struct config_entry *ce, unsigned long long base_addr,
>>  		 * If this is a struct or list_head data type then
>>  		 * create a leaf node entry with 'next' member.
>>  		 */
>> -		if ((ce->type_flag & TYPE_BASE)
>> +		if (((ce->type_flag & (TYPE_BASE | TYPE_ARRAY)) == TYPE_BASE)
>>  					&& (strcmp(ce->type_name, "void")))
>>  			return FALSE;
>>  
>> The old code use to check only TYPE_BASE flag ignoring TYPE_ARRAY flag.
> 
> Thank you for the explanation.
> I feel I see it.
> Is the below understanding right ?
> 
> At the part of earlier resolve_config_entry(), necessary information
> (sym_addr, type_name, and array_length) can be gotten in the case
> of pointer array.

Yes, including the size information for type of element (type_name) in
the LIST entry.

> However, the old resolve_config_entry() returned FALSE because of
> the check lack you said.

Yes. The old resolve_config_entry() use to return FALSE only for array
of base type elements (e.g. array of char, int, long etc.). However, it
was working well for array of structures (pointer/non-pointer).

The LIST entry can be of one of the following kind:
1. Array of base types (pointer/non-pointer).
2. Array of structures (pointer/non-pointer).
3. Link list.
4. list_head link list.

The old code was working for all of the above except (1).

Thanks,
-Mahesh.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
