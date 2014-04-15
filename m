Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZs5L-00019K-EW
 for kexec@lists.infradead.org; Tue, 15 Apr 2014 01:22:52 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2 2/3] Generic handling of multi-page exclusions
Date: Tue, 15 Apr 2014 01:20:46 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE972037DB@BPXM01GP.gisp.nec.co.jp>
References: <20140408.104907.132144009.d.hatayama@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971FF140@BPXM01GP.gisp.nec.co.jp>
 <20140410124717.498e0145@hananiah.suse.cz>
 <20140411.105944.62065753.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20140411.105944.62065753.d.hatayama@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "ptesarik@suse.cz" <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>From: Petr Tesarik <ptesarik@suse.cz>
>Subject: Re: [PATCH v2 2/3] Generic handling of multi-page exclusions
>Date: Thu, 10 Apr 2014 12:47:17 +0200
>
>> On Tue, 8 Apr 2014 07:06:34 +0000
>> Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
>>
>>> [...]
>>> > diff --git a/makedumpfile.h b/makedumpfile.h
>>> >> index 951ed1b..dfad569 100644
>>> >> --- a/makedumpfile.h
>>> >> +++ b/makedumpfile.h
>>> >> @@ -816,6 +816,13 @@ struct mem_map_data {
>>> >>  	unsigned long long	pfn_start;
>>> >>  	unsigned long long	pfn_end;
>>> >>  	unsigned long	mem_map;
>>> >> +
>>> >> +	/*
>>> >> +	 * for excluding multi-page regions
>>> >> +	 */
>>> >> +	unsigned long		exclude_pfn_start;
>>> >> +	unsigned long		exclude_pfn_end;
>>> >
>>> >unsigned long long		exclude_pfn_start;
>>> >unsigned long long		exclude_pfn_end;
>>> >
>>> >The integers representing page frame numbers need to be defined as
>>> >unsigned long long for architectures where physical address can have
>>> >64-bit length but unsigned long has 32-bit only, such as x86 PAE.
>>> >
>>> >Kumagai-san, I saw this sometimes in the past. How about introducing
>>> >specific abstract type for page frame number like below?
>>> >
>>> >typedef unsigned long long pfn_t;
>>>
>>> Good idea! We should do it.
>>
>> Like the following patch?
>>
>> From 9f3f6876bf1e8c93690097c510dff9982651bfa5 Mon Sep 17 00:00:00 2001
>> From: Petr Tesarik <ptesarik@suse.cz>
>> Date: Thu, 10 Apr 2014 12:40:31 +0200
>> Subject: [PATCH] Introduce the pfn_t type
>>
>> Replace unsigned long long with pfn_t where:
>>
>>   a. the variable denotes a PFN
>>   b. the variable is a number of pages
>>
>> The number of pages is converted to a pfn_t, because it is a result of
>> subtracting two PFNs or incremented in a loop over a range of PFNs, so
>> it can get as large as a PFN.
>>
>> Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
>
>Thanks!
>
>Only concern is that pfn_t could be too generic; could collide with
>symbols from any other libraries. On kernel, I found that kvm and um
>defines pfn_t.
>
>So, it's better to prefix pfn_t with the letters indicating that this
>is relevant to makedumpfile.
>
>But I don't come up with good prefix...

We don't need to be serious, just keeping identity is the important
thing. So how about kdump_pfn_t or mdf_pfn_t?
("makedumpfile" is a long name and it hasn't a good shortening,
it might be better to rename it :-P)


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
