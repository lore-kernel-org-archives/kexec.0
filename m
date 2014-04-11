Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WYV3q-0004aT-0i
 for kexec@lists.infradead.org; Fri, 11 Apr 2014 06:35:38 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [RFC PATCH]: merge identical code
Date: Fri, 11 Apr 2014 06:30:43 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE972017BD@BPXM01GP.gisp.nec.co.jp>
References: <20140408123131.GA10111@kernel-host>
 <0910DD04CBD6DE4193FCF86B9C00BE971FFF3A@BPXM01GP.gisp.nec.co.jp>
 <5347553F.2080907@huawei.com>
In-Reply-To: <5347553F.2080907@huawei.com>
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
To: "wangnan0@huawei.com" <wangnan0@huawei.com>
Cc: "horms@verge.net.au" <horms@verge.net.au>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "hui.geng@huawei.com" <hui.geng@huawei.com>

>On 2014/4/10 15:56, Atsushi Kumagai wrote:
>> Hello Wang,
>>
>>> Hi Kumagai,
>>>
>>> I found that in makedumpfile.c, there are many code like following:
>>>
>>>  if (info->flag_cyclic) {
>>>      proc_cyclic();
>>>  } else {
>>>      proc();
>>>  }
>>>
>>> The logical and code of proc_cyclic and proc are nearly identical.
>>>
>>> Do you want to merge them together?
>>
>> Yes, I think we should do this work.
>>
>> However, the similarity of them will be reduced since how to update
>> cyclic region is going to be changed in v1.5.6.
>> If you can carry out this work also for v1.5.6, I'll accept it.
>>
>> You can use the current devel branch because it's almost v1.5.6.
>> (Formally, v1.5.6 will be released next week.)
>>
>> https://sourceforge.net/p/makedumpfile/code/ci/devel/tree/
>>
>>
>> Thanks
>> Atsushi Kumagai
>>
>
>What about totaly remove non-cyclic functions and use a very large cyclic?

I also think it's a better way, give it a go :-)


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
