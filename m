Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SbiJT-0003ad-JT
 for kexec@lists.infradead.org; Tue, 05 Jun 2012 01:12:01 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 66A303EE0C0
 for <kexec@lists.infradead.org>; Tue,  5 Jun 2012 10:11:53 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 463A845DEB2
 for <kexec@lists.infradead.org>; Tue,  5 Jun 2012 10:11:53 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 04A6C45DEAD
 for <kexec@lists.infradead.org>; Tue,  5 Jun 2012 10:11:53 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E34AD1DB8043
 for <kexec@lists.infradead.org>; Tue,  5 Jun 2012 10:11:52 +0900 (JST)
Received: from m025.s.css.fujitsu.com (m025.s.css.fujitsu.com [10.0.81.65])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 9CB761DB8042
 for <kexec@lists.infradead.org>; Tue,  5 Jun 2012 10:11:52 +0900 (JST)
Date: Tue, 05 Jun 2012 10:10:46 +0900 (JST)
Message-Id: <20120605.101046.99023349.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH 0/4] makedumpfile: cyclic processing to keep memory
 consumption.
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <CAJGZr0L2OTA_Qv9hqXLGhK-Hs++ev+xHLZ9-OK8HbhON-CbSAQ@mail.gmail.com>
References: <CAJGZr0LSC3GKKTSDm9zH4YiY3V3B27O1t0v7YQWNho_Q+s3msw@mail.gmail.com>
 <20120604165449.e7236889.kumagai-atsushi@mxc.nes.nec.co.jp>
 <CAJGZr0L2OTA_Qv9hqXLGhK-Hs++ev+xHLZ9-OK8HbhON-CbSAQ@mail.gmail.com>
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
To: muvarov@gmail.com
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

From: Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [RFC PATCH 0/4] makedumpfile: cyclic processing to keep memory consumption.
Date: Mon, 4 Jun 2012 12:29:07 +0400

> 2012/6/4 Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> 
>> Hello Maxim,
>>
>> On Thu, 31 May 2012 10:50:39 +0400
>> Maxim Uvarov <muvarov@gmail.com> wrote:
>>

>>
>> After received your mail, I measured executing time with the patch below.
>> The result below was measured in 5GB memory machine.
>>
>> Result:
>>  a. makedumpfile -Kcd31
>>    excluding time:   6.55 [sec]
>>    writing time:     5.89 [sec]
>>
>>  b. makedumpfile -cd31
>>    excluding time:   0.21 [sec]
>>    writing time:     5.82 [sec]
>>
>> I don't think this result is good, the prototype has some points to be
>> improved for performance.
>> (e.g. buffer size, the way to exclude free pages, etc...)
>>
>> However, I think getting a bit of speed down can't be helped to keep
>> memory consumption.
>>
>>
> I'm asking because I have machines with several TBs of ram. And filtering
> and saving data from vmcore takes long time. (more then 30 minutes). I
> wonder if somebody already work on performance. Probably we can do SMP
> optimizations.
> 
> Maxim.

Hello Maxim,

I'm now benchmarking for three kinds of pralell compressions: no
compression, lzo and snappy. I'll post its result after completing it,
by Friday? if possible.

Also I'll soon post a patch for filtering free pages in constant time
based on mem_map, just a small extension of the patch Kumagai-san
posted previously, by which filtering score for -Kcd31 above would be
improved so much; it now repeats tracing free_list (memory size /
cyclic_size) times.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
