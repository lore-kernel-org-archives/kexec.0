Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g3E4J-00020b-2w
 for kexec@lists.infradead.org; Fri, 21 Sep 2018 05:33:32 +0000
Message-ID: <5BA48294.8090503@huawei.com>
Date: Fri, 21 Sep 2018 13:33:08 +0800
From: zhong jiang <zhongjiang@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCHv2] kernel: kexec_file: remove some duplicated include file
References: <1537498098-19171-1-git-send-email-zhongjiang@huawei.com>
 <CACi5LpMPZiv7zgZLR9SD=2SPPT8W3RuP6=NHD4rzqVnpB4xkaA@mail.gmail.com>
In-Reply-To: <CACi5LpMPZiv7zgZLR9SD=2SPPT8W3RuP6=NHD4rzqVnpB4xkaA@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 2018/9/21 13:21, Bhupesh Sharma wrote:
> Hi,
>
> On Fri, Sep 21, 2018 at 8:18 AM, zhong jiang <zhongjiang@huawei.com> wrote:
>> We include kexec.h and slab.h twice in kexec_file.c. It's unnecessary.
>> hence just remove them.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  kernel/kexec_file.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index c6a3b68..35cf0ad 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -25,8 +25,6 @@
>>  #include <linux/elf.h>
>>  #include <linux/elfcore.h>
>>  #include <linux/kernel.h>
>> -#include <linux/kexec.h>
>> -#include <linux/slab.h>
>>  #include <linux/syscalls.h>
>>  #include <linux/vmalloc.h>
>>  #include "kexec_internal.h"
>> --
>> 1.7.12.4
>>
> Nice catch.
> Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>
>
> BTW while we are at it, can you also send out a separate patch to list the
> include files in this file (i.e. kexec_file.c) alphabetically (similar
> to other linux source files - see
> <https://patchwork.kernel.org/patch/10258279/> for example). Something
> like:
>
> #include <crypto/hash.h>
> #include <crypto/sha.h>
> #include <linux/capability.h>
> #include <linux/elf.h>
> #include <linux/elfcore.h>
> #include <linux/file.h>
> #include <linux/fs.h>
> #include <linux/ima.h>
> #include <linux/kernel.h>
> #include <linux/kexec.h>
> #include <linux/list.h>
> #include <linux/mm.h>
> #include <linux/mutex.h>
> #include <linux/slab.h>
> #include <linux/syscalls.h>
> #include <linux/vmalloc.h>
> #include "kexec_internal.h"
>
> This will improve readability and also reduce similar instances of
> include files being added twice in this source file in future.
>
> Thanks,
> Bhupesh
Thank you for suggestion, I do not know whether all of maintainer care about this or not.
Anyhow I will try it.

Sincerely,
zhong jiang




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
