Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xso8Q-0001hm-A4
 for kexec@lists.infradead.org; Mon, 24 Nov 2014 07:32:34 +0000
Message-ID: <5472DE1D.3090608@cn.fujitsu.com>
Date: Mon, 24 Nov 2014 15:28:29 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH V5 4/5] Add module of calculating start_pfn and end_pfn
 in each dumpfile
References: <1415263768-15821-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1415263768-15821-5-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20141124071856.GB3015@dhcp-16-105.nay.redhat.com>
In-Reply-To: <20141124071856.GB3015@dhcp-16-105.nay.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org

On 11/24/2014 03:18 PM, Baoquan He wrote:
> On 11/06/14 at 04:49pm, Zhou Wenjian wrote:
>
>> +#define CURRENT_SPLITBLOCK_PFN_NUM (*cur_splitblock_num * splitblock->page_per_splitblock)
>> +mdf_pfn_t
>> +calculate_end_pfn_by_splitblock(mdf_pfn_t start_pfn,
>> +				 int *cur_splitblock_num)
>> +{
>> +	if (start_pfn>= info->max_mapnr)
>> +		return info->max_mapnr;
>> +
>> +	mdf_pfn_t end_pfn;
>> +	long long pfn_needed, offset;
>> +	char *splitblock_value_offset;
>> +
>> +	pfn_needed = info->num_dumpable / info->num_dumpfile;
>> +	offset = *cur_splitblock_num * splitblock->entry_size;
>> +	splitblock_value_offset = splitblock->table + offset;
>> +	end_pfn = start_pfn;
>> +
>> +	while (*cur_splitblock_num<  splitblock->num&&  pfn_needed>  0) {
>> +		pfn_needed -= read_from_splitblock_table(splitblock_value_offset);
>> +		splitblock_value_offset += splitblock->entry_size;
>> +		++*cur_splitblock_num;
>> +	}
>
> Hi Wenjian,
>
> If splitblock->page_per_splitblock is 1G, and the system ram is 4G. Now
> I set 8 dumpfiles to store the splitted vmcore, say dump0...7. Then
> dump0/1/2/3 will store 1G of data, dump4/5/6/7 will be empty. So is it
> OK?
>
> Can we do anything to avoid this case or give some note to let people not
> be panikked by empty dump files?
>
> Thanks
> Baoquan
>
>

Hello Baoquan,

Actually, we have thought about it and talked at
http://lists.infradead.org/pipermail/kexec/2014-November/012880.html .

-- 
Thanks
Zhou Wenjian

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
