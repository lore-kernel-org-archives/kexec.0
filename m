Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
 by casper.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WXQCV-0006aa-8f
 for kexec@lists.infradead.org; Tue, 08 Apr 2014 07:12:08 +0000
Received: from tyo201.gate.nec.co.jp ([10.7.69.201])
 by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id s3879iNv018804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Tue, 8 Apr 2014 16:09:44 +0900 (JST)
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2 2/3] Generic handling of multi-page exclusions
Date: Tue, 8 Apr 2014 07:06:34 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971FF140@BPXM01GP.gisp.nec.co.jp>
References: <cover.1396632131.git.ptesarik@suse.cz>
 <25702884512808755449395c1622f2aed7b3be00.1396632131.git.ptesarik@suse.cz>
 <20140408.104907.132144009.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20140408.104907.132144009.d.hatayama@jp.fujitsu.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "ptesarik@suse.cz" <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

[...]
> diff --git a/makedumpfile.h b/makedumpfile.h
>> index 951ed1b..dfad569 100644
>> --- a/makedumpfile.h
>> +++ b/makedumpfile.h
>> @@ -816,6 +816,13 @@ struct mem_map_data {
>>  	unsigned long long	pfn_start;
>>  	unsigned long long	pfn_end;
>>  	unsigned long	mem_map;
>> +
>> +	/*
>> +	 * for excluding multi-page regions
>> +	 */
>> +	unsigned long		exclude_pfn_start;
>> +	unsigned long		exclude_pfn_end;
>
>unsigned long long		exclude_pfn_start;
>unsigned long long		exclude_pfn_end;
>
>The integers representing page frame numbers need to be defined as
>unsigned long long for architectures where physical address can have
>64-bit length but unsigned long has 32-bit only, such as x86 PAE.
>
>Kumagai-san, I saw this sometimes in the past. How about introducing
>specific abstract type for page frame number like below?
>
>typedef unsigned long long pfn_t;

Good idea! We should do it.

>maybe with some prefix. I think this also helps code readability
>because unsigned long long is too long.
>
>> +	unsigned long long	*exclude_pfn_counter;
>>  };
>
>Also, it seems to me better to introduce a new type for this
>processing rather than extending existing code. struct mem_map_data is
>not specific for the excluding processing.

I agree, too.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
