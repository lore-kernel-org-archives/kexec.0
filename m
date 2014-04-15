Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wa0Ix-0007zu-9k
 for kexec@lists.infradead.org; Tue, 15 Apr 2014 10:09:28 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2 2/3] Generic handling of multi-page exclusions
Date: Tue, 15 Apr 2014 10:06:41 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97203CF4@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE971FF28C@BPXM01GP.gisp.nec.co.jp>
 <20140409.162708.93024867.d.hatayama@jp.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720389C@BPXM01GP.gisp.nec.co.jp>
 <20140415.172750.504112652.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20140415.172750.504112652.d.hatayama@jp.fujitsu.com>
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
To: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>
Cc: "ptesarik@suse.cz" <ptesarik@suse.cz>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
>Subject: RE: [PATCH v2 2/3] Generic handling of multi-page exclusions
>Date: Tue, 15 Apr 2014 04:18:31 +0000
>
>>>> At that time, I chose the current code since it was simpler and safer.
>>>> http://www.mail-archive.com/kexec%40lists.infradead.org/msg10207.html
>>>>
>>>> Don't you like this ?
>>>>
>>>
>>>Sorry. I had forgotten this. We should keep the sanity check
>>>there. But in our policy, we should not pass to set_bitmap_cyclic(),
>>>pfn and cycle where pfn is not in the cycle. We should chceck that in
>>>the caller side and pass pfn in the cycle only.
>>>
>>>Also, on the current implementation, even if pfn outside a current
>>>cycle is passed to set_bitmap_cyclic(), we don't have any means to
>>>know that.
>>>
>>>So, how about warning that only once at runtime?
>>
>> Sounds good, it will be helpful to detect bugs in caller side.
>> Like this?
>>
>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index 75092a8..da960ad 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -3361,9 +3361,16 @@ int
>>  set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val, struct cycle *cycle)
>>  {
>>  	int byte, bit;
>> +	static int warning = 0;
>>
>> -        if (pfn < cycle->start_pfn || cycle->end_pfn <= pfn)
>> +        if (pfn < cycle->start_pfn || cycle->end_pfn <= pfn) {
>> +		if (!warning) {
>> +			MSG("WARNING: PFN out of cycle range. (pfn:%llx, ", pfn);
>> +			MSG("cycle:[%llx-%llx])\n", cycle->start_pfn, cycle->end_pfn);
>> +			warning = 1;
>> +		}
>>                  return FALSE;
>> +	}
>>
>>  	/*
>>  	 * If val is 0, clear bit on the bitmap.
>>
>
>Yes, I thought this logic.

Thanks, I've pushed this into devel branch.

Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
