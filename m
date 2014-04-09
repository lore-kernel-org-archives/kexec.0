Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WXmhU-0002gw-8M
 for kexec@lists.infradead.org; Wed, 09 Apr 2014 07:13:38 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 466873EE0F1
 for <kexec@lists.infradead.org>; Wed,  9 Apr 2014 16:13:09 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3821245DE5C
 for <kexec@lists.infradead.org>; Wed,  9 Apr 2014 16:13:09 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1CE7545DE60
 for <kexec@lists.infradead.org>; Wed,  9 Apr 2014 16:13:09 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0C6E81DB8040
 for <kexec@lists.infradead.org>; Wed,  9 Apr 2014 16:13:09 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id AE5391DB8051
 for <kexec@lists.infradead.org>; Wed,  9 Apr 2014 16:13:08 +0900 (JST)
Date: Wed, 09 Apr 2014 16:12:56 +0900 (JST)
Message-Id: <20140409.161256.251190143.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v2 2/3] Generic handling of multi-page exclusions
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20140408120728.03224214@hananiah.suse.cz>
References: <20140408085436.51340ae2@hananiah.suse.cz>
 <20140408.171903.322808733.d.hatayama@jp.fujitsu.com>
 <20140408120728.03224214@hananiah.suse.cz>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: ptesarik@suse.cz
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v2 2/3] Generic handling of multi-page exclusions
Date: Tue, 8 Apr 2014 12:07:28 +0200

> On Tue, 08 Apr 2014 17:19:03 +0900 (JST)
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
>> From: Petr Tesarik <ptesarik@suse.cz>
>> Subject: Re: [PATCH v2 2/3] Generic handling of multi-page exclusions
>> Date: Tue, 8 Apr 2014 08:54:36 +0200
>> 
>> > On Tue, 08 Apr 2014 10:49:07 +0900 (JST)
>> > HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>> >> 
>> >> Also, it seems to me better to introduce a new type for this
>> >> processing rather than extending existing code. struct mem_map_data is
>> >> not specific for the excluding processing.
>> > 
>> > Kind of agreed. OTOH it will most likely be embedded in struct
>> > mem_map_data anyway, because exactly one such object per mm is needed.
>> > 
>> > Petr T
>> 
>> I don't understand well. It seems to me a single object is enough. Is
>> it possible to nr_pages cover multiple mm's?
> 
> In fact, I believe it may be sufficient, but the loop nesting is like
> this (pseudo-code):
> 
>   for each cycle:
>     for each mm:
>        call __exclude_unnecessary_pages
> 
> I'm not 100% sure that the region cannot change back and forth between
> two consecutive calls to __exclude_unnecessary_pages.
> 
> Thinking about it some more, this can be harmful only if there are
> overlapping memory maps... Can it happen, or can I safely ignore this
> possibility?
> 
> Petr T

The list of mm is sorted and not overlapping. See get_mm_sparsemem(),
get_mm_sparsemem(), get_mm_discontigmem() and get_mm_flatmem() from
get_mem_map(). In particular, in get_mm_discontigmem(), sorting and
removing overlapping portions are done explicitly.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
