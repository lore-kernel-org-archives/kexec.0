Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fVuWO-0002uI-Ft
 for kexec@lists.infradead.org; Thu, 21 Jun 2018 08:01:01 +0000
Received: by mail-pf0-f193.google.com with SMTP id r11-v6so1125498pfl.6
 for <kexec@lists.infradead.org>; Thu, 21 Jun 2018 01:00:37 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-ops: Add helper API to dump fdt blob
From: Bhupesh Sharma <bhsharma@redhat.com>
References: <1525036956-7440-1-git-send-email-bhsharma@redhat.com>
 <1525036956-7440-2-git-send-email-bhsharma@redhat.com>
 <20180508021420.GH11326@linaro.org>
 <feceb9c5-088b-5db2-c45f-79d53eece79a@redhat.com>
Message-ID: <f121cde1-2e21-d98b-1a4d-464de90e9467@redhat.com>
Date: Thu, 21 Jun 2018 13:30:28 +0530
MIME-Version: 1.0
In-Reply-To: <feceb9c5-088b-5db2-c45f-79d53eece79a@redhat.com>
Content-Language: en-US
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, kexec@lists.infradead.org, bhupesh.linux@gmail.com, dyoung@redhat.com, horms@verge.net.au, james.morse@arm.com

Hi Akashi,

On 06/20/2018 03:59 PM, Bhupesh Sharma wrote:
> Hi Akashi,
> 
> Apologies for delay in replying. Somehow my email filter rules messed up 
> and the review email was sent to another folder.
> 
> Please see my comments inline:
> 
> On 05/08/2018 07:44 AM, AKASHI Takahiro wrote:
>> Bhupesh,
>>
>> On Mon, Apr 30, 2018 at 02:52:35AM +0530, Bhupesh Sharma wrote:
>>> At several occasions it would be useful to dump the fdt
>>> blob being passed to the second (kexec/kdump) kernel
>>> when '-d' flag is specified while invoking kexec/kdump.
>>>
>>> This allows one to look at the device-tree fields that
>>> is being passed to the secondary kernel and accordingly
>>> debug issues.
>>>
>>> This can be specially useful for the arm64 case, where
>>> kexec_load() or kdump passes important information like
>>> 'linux,usable-memory' ranges to the second kernel, and
>>> the correctness of the ranges can be verified by
>>> looking at the device-tree dump with '-d' flag specified.
>>>
>>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>>> ---
>>>   kexec/dt-ops.c | 143 
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   kexec/dt-ops.h |   1 +
>>>   2 files changed, 144 insertions(+)
>>>
>>> diff --git a/kexec/dt-ops.c b/kexec/dt-ops.c
>>> index 915dbf55afd2..cb95920e5c3e 100644
>>> --- a/kexec/dt-ops.c
>>> +++ b/kexec/dt-ops.c
>>> @@ -8,6 +8,10 @@
>>>   #include "kexec.h"
>>>   #include "dt-ops.h"
>>> +#define ALIGN(x, a)    (((x) + ((a) - 1)) & ~((a) - 1))
>>> +#define PALIGN(p, a)    ((void *)(ALIGN((unsigned long)(p), (a))))
>>
>> Pointer doesn't always fit to unsigned long.
>>
>>> +#define GET_CELL(p)    (p += 4, *((const uint32_t *)(p-4)))
>>
>> Tricky :) Inline function would be better.
> 
> Ok.
> 

Well, I was working on converting this into an inline function, but the 
final implementation turned out to be more 'trickier' then the macro, so 
I would suggest that we stick to the macro for now (for the v4) and 
later when I can think of a better approach, I will submit another patch 
to fix the issue.

Please let me know in case of any concerns.
I would try to send out v4 later today.

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
