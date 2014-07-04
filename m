Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X2she-0005Gg-5k
 for kexec@lists.infradead.org; Fri, 04 Jul 2014 01:54:18 +0000
Received: from kw-mxq.gw.nic.fujitsu.com (unknown [10.0.237.131])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id AC51E3EE183
 for <kexec@lists.infradead.org>; Fri,  4 Jul 2014 10:53:49 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id B77C3AC0531
 for <kexec@lists.infradead.org>; Fri,  4 Jul 2014 10:53:48 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 996D71DB8046
 for <kexec@lists.infradead.org>; Fri,  4 Jul 2014 10:53:47 +0900 (JST)
Message-ID: <53B6091F.4010707@jp.fujitsu.com>
Date: Fri, 04 Jul 2014 10:53:35 +0900
From: "HATAYAMA, Daisuke" <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Makedumpfile: vmcore size estimate
References: <1402490345-18656-1-git-send-email-bhe@redhat.com>
 <20140611135701.GA1592@dhcp-17-102.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9722440E@BPXM01GP.gisp.nec.co.jp>
 <20140623125723.GB29112@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9723992E@BPXM01GP.gisp.nec.co.jp>
 <20140626123118.GB11136@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9723B033@BPXM01GP.gisp.nec.co.jp>
 <20140702081349.GA20309@dhcp-16-105.nay.redhat.com>
In-Reply-To: <20140702081349.GA20309@dhcp-16-105.nay.redhat.com>
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
To: "bhe@redhat.com" <bhe@redhat.com>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>



(2014/07/02 17:13), bhe@redhat.com wrote:
> On 07/02/14 at 12:25am, Atsushi Kumagai wrote:
>>> On Thu, Jun 26, 2014 at 08:21:58AM +0000, Atsushi Kumagai wrote:
>
>>> I still don't understand that why makedumpfile can't provide an estimate
>>> * of that momement * reasonably.
>>
>> I think *estimate* is inappropriate to express this feature since it just
>> analyze the memory usage at that moment, I want to avoid a misunderstanding
>> that this feature is a prediction.
>
> I agree that understanding it as analyze memory usage is better.
>
>>
>>> I don't want to implement a separate utility for this as makedumpfile
>>> already has all the logic to go through pages, prepare bitmaps and figure
>>> out which ones will be dumped. It will be just duplication of code and
>>> waste of effort.
>>>
>>> We have a real problem at our hand. What do we tell customers that how
>>> big your dump partition should be. They have a multi tera byte machine. Do
>>> we tell them that create a multi tera byte dedicated dump partition.
>>> That's not practical at all.
>>>
>>> And asking them to guess is not reasonable either. makedumpfile can make
>>> much more educated guesses. It is not perfect but it is still much better
>>> than user making a wild guess.
>>
>> Well, fine. I have 2 requests for accepting this feature:
>>
>>    - Make this feature as simple as possible.
>>      I don't want to take time to maintain this, so I prefer the
>>      other idea which, Baoquan said, is like HP UX's feature.
>
> OK, I will try. In fact it's simple to just show the number of dumpable
> pages.
>
>>
>>    - Don't provide this feature as "vmcore size estimate", it just
>>      show the number of dumpable pages at the moment. Then please show
>>      the WARNING message to inform users about it.
>
> OK, good suggestion. Will do.
>

There are things that make users to guess actual vmcore size; not only compression but also additional meta-data, note data, header, bitmaps, of vmcores. I think it important to stress that the actual dump size should be larger than the number of pages displayed there so you (users) should care about that enough.

For fail safe, it should address ENOSPC case more. Sadly, preparing too small disks for vmcores is human error. In general, we cannot avoid this in real world. It's important to make vmcore valid even in case of ENOSPC in the sense that at least generated part of vmcore can correctly be analized by crash. In this direction, I previously sent the patch to create 1st bitmap first but this patch alone is still unsatisfactory to deal with the issue. It's necessary to flush the 2nd bitmap and the data left in caches too.

>>
>> Could you remake your patch, Baoquan?
>>

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
