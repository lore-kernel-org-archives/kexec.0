Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g3BVI-0003hM-Pc
 for kexec@lists.infradead.org; Fri, 21 Sep 2018 02:49:14 +0000
Message-ID: <5BA45C16.9090701@huawei.com>
Date: Fri, 21 Sep 2018 10:48:54 +0800
From: zhong jiang <zhongjiang@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kernel: kexec_file: remove some duplicated include file
References: <1537420323-30658-1-git-send-email-zhongjiang@huawei.com>
 <20180921021524.GP2555@MiWiFi-R3L-srv> <5BA4570F.6050700@huawei.com>
 <20180921023529.GQ2555@MiWiFi-R3L-srv>
In-Reply-To: <20180921023529.GQ2555@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, ebiederm@xmission.com, linux-kernel@vger.kernel.org

On 2018/9/21 10:35, Baoquan He wrote:
> On 09/21/18 at 10:27am, zhong jiang wrote:
>> On 2018/9/21 10:15, Baoquan He wrote:
>>> On 09/20/18 at 01:12pm, zhong jiang wrote:
>>>> kexec.h and slab.h have duplicated include. hence just remove
>>>> redundant file.
>>> They have duplicated include, why do you remove both of them?
>> because we include the kexec.h and slab.h twice in kexec_file.c. It's unnecessary.
> OK, Could you rewrite the log with this? The old log makes me think
> kexec.h and slab.h themselves have duplicated include.
Ok,  I will rewrite the log and repost in v2. Thanks

Sincerely,
zhong jiang
>> Thanks,
>> zhong jiang
>>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>>> ---
>>>>  kernel/kexec_file.c | 2 --
>>>>  1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>>> index c6a3b68..35cf0ad 100644
>>>> --- a/kernel/kexec_file.c
>>>> +++ b/kernel/kexec_file.c
>>>> @@ -25,8 +25,6 @@
>>>>  #include <linux/elf.h>
>>>>  #include <linux/elfcore.h>
>>>>  #include <linux/kernel.h>
>>>> -#include <linux/kexec.h>
>>>> -#include <linux/slab.h>
>>>>  #include <linux/syscalls.h>
>>>>  #include <linux/vmalloc.h>
>>>>  #include "kexec_internal.h"
>>>> -- 
>>>> 1.7.12.4
>>>>
>>>>
>>>> _______________________________________________
>>>> kexec mailing list
>>>> kexec@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/kexec
>>> .
>>>
>>
> .
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
