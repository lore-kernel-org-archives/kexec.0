Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from szxga03-in.huawei.com ([119.145.14.66])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQU8R-0001tL-BQ
 for kexec@lists.infradead.org; Thu, 20 Mar 2014 03:59:17 +0000
Message-ID: <532A6725.3010903@huawei.com>
Date: Thu, 20 Mar 2014 11:57:25 +0800
From: Wang Nan <wangnan0@huawei.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] kexec: pass initrd position in dtb
References: <1395282993-37549-1-git-send-email-wangnan0@huawei.com>
 <1395282993-37549-3-git-send-email-wangnan0@huawei.com>
 <20140320032645.GB4722@dhcp-16-126.nay.redhat.com>
 <20140320033459.GC4722@dhcp-16-126.nay.redhat.com>
In-Reply-To: <20140320033459.GC4722@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

On 2014/3/20 11:34, Dave Young wrote:
> On 03/20/14 at 11:26am, Dave Young wrote:
>> On 03/20/14 at 10:36am, Wang Nan wrote:
>>> This patch append the position of initrd to dtb when loading arm kernel
>>> and initrd without using atag.
>>>
>>> Signed-off-by: Wang Nan <wangnan0@huawei.com>
>>> Cc: Simon Horman <horms@verge.net.au>
>>> Cc: Dave Young <dyoung@redhat.com>
>>> Cc: Geng Hui <hui.geng@huawei.com>
>>> ---
>>>  kexec/arch/arm/kexec-zImage-arm.c | 84 +++++++++++++++++++++++++++------------
>>>  1 file changed, 59 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
>>> index 8a35018..15d8829 100644
>>> --- a/kexec/arch/arm/kexec-zImage-arm.c
>>> +++ b/kexec/arch/arm/kexec-zImage-arm.c
>>> @@ -20,6 +20,7 @@
>>>  #include "kexec-arm.h"
>>>  #include "../../fs2dt.h"
>>>  #include "crashdump-arm.h"
>>> +#include "libfdt_internal.h"
>>
>> I guess it's for the FDT_TAGALIGN and FDT_TAGSIZE?
>> libfdt_internal.h should be used as internal header for libfdt, a better way is
>> adding another patch which move these 2 macros to fdt.h
> 
> Or moving your new function setup_dtb_prop to libfdt, I'm not sure if it works on
> other arch though.
> 
>> Thanks
>> Dave


What about following midification (FDT_TAGSIZE is in fdt.h)?
I'll send it formally if you agree this one.

diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
index 15d8829..1cd4ed0 100644
--- a/kexec/arch/arm/kexec-zImage-arm.c
+++ b/kexec/arch/arm/kexec-zImage-arm.c
@@ -20,7 +20,6 @@
 #include "kexec-arm.h"
 #include "../../fs2dt.h"
 #include "crashdump-arm.h"
-#include "libfdt_internal.h"

 #define BOOT_PARAMS_SIZE 1536

@@ -229,8 +228,8 @@ static int setup_dtb_prop(char **bufp, off_t *sizep, const char *node_name,
        dtb_buf = *bufp;

        *sizep = fdt_totalsize(*bufp) + FDT_TAGSIZE + len +
-               FDT_TAGALIGN(strlen(node_name) + 1) +
-               FDT_TAGALIGN(strlen(prop_name) + 1) +
+               _ALIGN(strlen(node_name) + 1, FDT_TAGSIZE) +
+               _ALIGN(strlen(prop_name) + 1, FDT_TAGSIZE) +
                sizeof(struct fdt_property);

        dtb_buf = xrealloc(dtb_buf, *sizep);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
