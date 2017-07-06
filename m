Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dT1au-0006op-CU
 for kexec@lists.infradead.org; Thu, 06 Jul 2017 07:53:02 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [makedumpfile PATCH v2] Prevent data loss in last page of ELF
 core dumpfile
Date: Thu, 6 Jul 2017 07:40:39 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EEE471@BPXM01GP.gisp.nec.co.jp>
References: <1499274802-30844-1-git-send-email-eric.devolder@oracle.com>
 <20170705224914.GM4448@olila.local.net-space.pl>
In-Reply-To: <20170705224914.GM4448@olila.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>, Eric DeVolder <eric.devolder@oracle.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>

>> diff --git a/makedumpfile.c b/makedumpfile.c
>> index e69b6df..26296f1 100644
>> --- a/makedumpfile.c
>> +++ b/makedumpfile.c
>> @@ -5410,7 +5410,8 @@ create_1st_bitmap_file(void)
>>  		if (pfn_start > info->max_mapnr)
>>  			continue;
>>  		pfn_end = MIN(pfn_end, info->max_mapnr);
>> -
>> +        /* Account for last page if it has less than page_size data in it */
>> +        if (phys_end & (info->page_size-1)) ++pfn_end;
>
>Something is wrong with column alignment. Tabs instead of spaces?
>And "++pfn_end;" should be in new line.
>
>Daniel

I have no additional comments, thanks for your work.

BTW, I found the same issues in places where paddr_to_pfn() expects that
the end physical address is page-size aligned like get_max_mapnr(), 
I'll fix that as well.


Thanks,
Atsushi Kumagai


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
