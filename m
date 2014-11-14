Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xp5bW-0003Xh-Sa
 for kexec@lists.infradead.org; Fri, 14 Nov 2014 01:23:16 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: Add description of incomplete dump file
Date: Fri, 14 Nov 2014 01:21:28 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D67CF1@BPXM01GP.gisp.nec.co.jp>
References: <1415780989-10652-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701D669B6@BPXM01GP.gisp.nec.co.jp>
 <54647A13.30700@cn.fujitsu.com>
In-Reply-To: <54647A13.30700@cn.fujitsu.com>
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
To: "zhouwj-fnst@cn.fujitsu.com" <zhouwj-fnst@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>On 11/13/2014 05:01 PM, Atsushi Kumagai wrote:
>> Hello Zhou,
>>
>>> Add description of incomplete elf and kdump-compressed dump file
>>> in IMPLEMENTATION.
>>
>> That's a good idea, thanks Zhou.
>> I have some comments.
>>
>>> Signed-off-by: Qiao Nuohan<qiaonuohan@cn.fujitsu.com>
>>> Signed-off-by: Zhou Wenjian<zhouwj-fnst@cn.fujitsu.com>
>>> ---
>>> IMPLEMENTATION |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>> 1 files changed, 76 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/IMPLEMENTATION b/IMPLEMENTATION
>>> index 2f4cfd6..8f8a945 100644
>>> --- a/IMPLEMENTATION
>>> +++ b/IMPLEMENTATION
>>> @@ -112,3 +112,79 @@
>>>          unsigned long long      page_flags;     /* page flags */
>>>      } page_desc_t;
>>>
>>> +* The incomplete DUMPFILE
>>> +  When generating DUMPFILE, if ENOSPACE error happens, the DUMPFILE will be
>>> +  incomplete.
>>> +
>>> +  - The incomplete kdump-compressed DUMPFILE
>>> +
>>> +           the complete                  the incomplete
>>> +    +-----------------------+    +-----------------------+
>>> +    |      main header      |    |      main header      |  have incomplete flag
>>> +    |-----------------------+    |-----------------------+
>>> +    |      sub header       |    |      sub header       |
>>> +    |-----------------------+    |-----------------------+
>>> +    |      1st-bitmap       |    |      1st-bitmap       |
>>> +    |-----------------------+    |-----------------------+
>>> +    |      2nd-bitmap       |    |      2nd-bitmap       |
>>> +    |-----------------------+    |-----------------------+
>>> +    | page header for pfn 0 |    | page header for pfn 0 |
>>> +    | page header for pfn 1 |    | page header for pfn 1 |
>>> +    |                  :    |    |                  :    |
>>> +    | page header for pfn N |    | page header for pfn N |  The page headers after
>>> +    |                  :    |    |                       |  N don't exist. The
>>> +    | page header for pfn Z |    |                       |  value of it is zero,
>>> +    |-----------------------|    |-----------------------|  when try to read it.
>>> +    |   page data (pfn 0)   |    |   page data (pfn 0)   |
>>> +    |   page data (pfn 1)   |    |   page data (pfn 1)   |
>>> +    |                  :    |    |                  :    |
>>> +    |   page data (pfn N)   |    |   page data (pfn N)   |
>>> +    |                  :    |    +-----------------------+
>>> +    |   page data (pfn Z)   |
>>> +    +-----------------------+
>>> +
>>> +    The incomplete flag is set into status of disk_dump_header by
>>> +                          status |= DUMP_DH_COMPRESSED_INCOMPLETE
>>> +    DUMP_DH_COMPRESSED_INCOMPLETE : 0x8
>>> +
>>> +    The page header and page data are written in pairs. When writting page data
>>
>> s/writting/writing/
>>
>>> +    (pfn N+1), if ENOSPACE error happens, the page headers after N won't be
>>> +    written either.
>>> +
>>> +    If there is no page data dumped into the DUMPFILE, the DUMPFILE can't be
>>> +    analysed by crash.
>>> +
>>> +  - The incomplete elf DUMPFILE
>>
>> There is no description of the ELF format itself in this documentation
>> unlike the kdump-compressed format, I would be glad if you could write it.
>>
>>> +
>>> +      the complete          the incomplete
>>> +    +-------------+         +-------------+
>>> +    |  elf header |         |  elf header |  have incomplete flag
>>> +    |-------------+         |-------------+
>>> +    |  PT_NOTE    |         |  PT_NOTE    |
>>> +    |  PT_LOAD(1) |         |  PT_LOAD(1) |
>>> +    |         :   |         |         :   |
>>> +    |  PT_LOAD(N) |         |  PT_LOAD(N) |  The PT_LOAD after N don't exist.
>>> +    |         :   |         |             |  The value of it is zero, when try
>>> +    |  PT_LOAD(Z) |         |             |  to read it.
>>> +    |-------------+         |-------------+
>>
>> The whole program header must exist since reserve_diskspace()
>> pre-allocates enough space for it, the description above isn't right.
>>
>The space exists, but since PT_LOAD and segment are written in pairs,
>if ENOSPACE happens, the left PT_LOAD won't be generated and won't be
>written as well. The space reserved is for the PT_LOAD still in buffer.

Oh, it slipped my mind. You are right.


Thanks
Atsushi Kumagai

>--
>Thanks
>Zhou Wenjian
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
