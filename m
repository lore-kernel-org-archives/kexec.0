Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Ra25G-0006FV-D0
 for kexec@lists.infradead.org; Mon, 12 Dec 2011 09:22:10 +0000
Message-ID: <4EE5C82F.1000404@cn.fujitsu.com>
Date: Mon, 12 Dec 2011 17:23:59 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: fix off-by-one bug in page_to_pfn()
References: <4ECC8A6F.3040606@cn.fujitsu.com>
 <20111124142051.8b5df388.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20111124142051.8b5df388.kumagai-atsushi@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org

At 11/24/2011 01:20 PM, Atsushi Kumagai Write:
> Hi Wen,
> 
> Thank you for the patch. 
> I will check it.

Hi, kumagai

do you have any comment for this patch?

Thanks
Wen Congyang

> 
> Thanks
> Kumagai
> 
> 
> On Wed, 23 Nov 2011 13:53:51 +0800
> Wen Congyang <wency@cn.fujitsu.com> wrote:
> 
>> The pfn region in a mmd is [mmd->pfn_start, mmd->pfn_end).
>> So the max index should be mmd->pfn_end - mmd->pfn_start -1.
>> If index >=(not >) mmd->pfn_end - mmd->pfn_start, we should check
>> the next mmd.
>>
>> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
>>
>> ---
>>  makedumpfile.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index 7b7c266..db8e53f 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -2879,7 +2879,7 @@ page_to_pfn(unsigned long page)
>>  		if (page < mmd->mem_map)
>>  			continue;
>>  		index = (page - mmd->mem_map) / SIZE(page);
>> -		if (index > mmd->pfn_end - mmd->pfn_start)
>> +		if (index >= mmd->pfn_end - mmd->pfn_start)
>>  			continue;
>>  		pfn = mmd->pfn_start + index;
>>  		break;
>> -- 
>> 1.7.1
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
