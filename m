Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1als3H-0001ux-Lr
 for kexec@lists.infradead.org; Fri, 01 Apr 2016 05:55:25 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 0/2] Export new VMCOREINFO about compound page
Date: Fri, 1 Apr 2016 05:53:58 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E35EA4@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9701E25FC7@BPXM01GP.gisp.nec.co.jp>
 <20160304080459.GA3056@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20160304080459.GA3056@dhcp-128-65.nay.redhat.com>
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
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>

Hello Andrew,

>> This patch set is to follow up modifications of struct page for
>> makedumpfile which filters dump file.
>> It's necessary to filter unnecessary compound pages in newer kernel
>> as usual.
>>
>> Incidentally, [PATCH 1/2] was post in:
>>
>>   https://lkml.org/lkml/2016/1/27/92
>>
>> but it didn't get any response, I repost it here.
>>
>> Atsushi Kumagai (2):
>>       kexec: update VMCOREINFO for compound_order/dtor
>>       kexec: export OFFSET(page.compound_head) to check anonymous page
>>
>> kernel/kexec_core.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>>
>
>Acked-by: Dave Young <dyoung@redhat.com>
>
>Thanks
>Dave

Could you pick these patches ?

  https://lkml.org/lkml/2016/3/1/25
  https://lkml.org/lkml/2016/3/1/26

Thanks,
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
