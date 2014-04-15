Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZyRZ-0000Ut-Hd
 for kexec@lists.infradead.org; Tue, 15 Apr 2014 08:10:14 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 8B30E3EE1DA
 for <kexec@lists.infradead.org>; Tue, 15 Apr 2014 17:09:52 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 772C745DF42
 for <kexec@lists.infradead.org>; Tue, 15 Apr 2014 17:09:52 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.nic.fujitsu.com [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id E620145DF44
 for <kexec@lists.infradead.org>; Tue, 15 Apr 2014 17:09:51 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D961A1DB8040
 for <kexec@lists.infradead.org>; Tue, 15 Apr 2014 17:09:51 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 83DE11DB803E
 for <kexec@lists.infradead.org>; Tue, 15 Apr 2014 17:09:51 +0900 (JST)
Date: Tue, 15 Apr 2014 17:09:44 +0900 (JST)
Message-Id: <20140415.170944.354986844.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v2 2/3] Generic handling of multi-page exclusions
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE972037DB@BPXM01GP.gisp.nec.co.jp>
References: <20140410124717.498e0145@hananiah.suse.cz>
 <20140411.105944.62065753.d.hatayama@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE972037DB@BPXM01GP.gisp.nec.co.jp>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, ptesarik@suse.cz

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2 2/3] Generic handling of multi-page exclusions
Date: Tue, 15 Apr 2014 01:20:46 +0000

>>From: Petr Tesarik <ptesarik@suse.cz>
>>Subject: Re: [PATCH v2 2/3] Generic handling of multi-page exclusions
>>Date: Thu, 10 Apr 2014 12:47:17 +0200
>>
>>> On Tue, 8 Apr 2014 07:06:34 +0000
>>> Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
>>>
>>>> [...]
>>>> > diff --git a/makedumpfile.h b/makedumpfile.h
>>>> >> index 951ed1b..dfad569 100644
>>>> >> --- a/makedumpfile.h
>>>> >> +++ b/makedumpfile.h
>>>> >> @@ -816,6 +816,13 @@ struct mem_map_data {
>>>> >>  	unsigned long long	pfn_start;
>>>> >>  	unsigned long long	pfn_end;
>>>> >>  	unsigned long	mem_map;
>>>> >> +
>>>> >> +	/*
>>>> >> +	 * for excluding multi-page regions
>>>> >> +	 */
>>>> >> +	unsigned long		exclude_pfn_start;
>>>> >> +	unsigned long		exclude_pfn_end;
>>>> >
>>>> >unsigned long long		exclude_pfn_start;
>>>> >unsigned long long		exclude_pfn_end;
>>>> >
>>>> >The integers representing page frame numbers need to be defined as
>>>> >unsigned long long for architectures where physical address can have
>>>> >64-bit length but unsigned long has 32-bit only, such as x86 PAE.
>>>> >
>>>> >Kumagai-san, I saw this sometimes in the past. How about introducing
>>>> >specific abstract type for page frame number like below?
>>>> >
>>>> >typedef unsigned long long pfn_t;
>>>>
>>>> Good idea! We should do it.
>>>
>>> Like the following patch?
>>>
>>> From 9f3f6876bf1e8c93690097c510dff9982651bfa5 Mon Sep 17 00:00:00 2001
>>> From: Petr Tesarik <ptesarik@suse.cz>
>>> Date: Thu, 10 Apr 2014 12:40:31 +0200
>>> Subject: [PATCH] Introduce the pfn_t type
>>>
>>> Replace unsigned long long with pfn_t where:
>>>
>>>   a. the variable denotes a PFN
>>>   b. the variable is a number of pages
>>>
>>> The number of pages is converted to a pfn_t, because it is a result of
>>> subtracting two PFNs or incremented in a loop over a range of PFNs, so
>>> it can get as large as a PFN.
>>>
>>> Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
>>
>>Thanks!
>>
>>Only concern is that pfn_t could be too generic; could collide with
>>symbols from any other libraries. On kernel, I found that kvm and um
>>defines pfn_t.
>>
>>So, it's better to prefix pfn_t with the letters indicating that this
>>is relevant to makedumpfile.
>>
>>But I don't come up with good prefix...
> 
> We don't need to be serious, just keeping identity is the important
> thing. So how about kdump_pfn_t or mdf_pfn_t?
> ("makedumpfile" is a long name and it hasn't a good shortening,
> it might be better to rename it :-P)
> 

It seems to me the latter mdf_ is better.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
