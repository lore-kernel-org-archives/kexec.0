Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-f181.google.com ([209.85.223.181])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1drrIp-0003jh-2I
 for kexec@lists.infradead.org; Tue, 12 Sep 2017 19:57:01 +0000
Received: by mail-io0-f181.google.com with SMTP id g32so36724292ioj.2
 for <kexec@lists.infradead.org>; Tue, 12 Sep 2017 12:56:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <41ff60d5-7010-87f4-b861-6e83e374b0c8@linux.vnet.ibm.com>
References: <1504845625-27408-1-git-send-email-bhsharma@redhat.com>
 <20170911013522.GA2704@dhcp-128-65.nay.redhat.com>
 <41ff60d5-7010-87f4-b861-6e83e374b0c8@linux.vnet.ibm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 13 Sep 2017 01:26:37 +0530
Message-ID: <CACi5LpOofuSfj+kLWrcOmW5g1H5v8PpDfE+iJF=tBYyJnK3VAg@mail.gmail.com>
Subject: Re: [Makedumpfile PATCH] book3s/ppc64: Lower the max real address to
 53 bits for kernels >= v4.11
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
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, Pingfan Liu <piliu@redhat.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>

Hi Hari,

On Mon, Sep 11, 2017 at 2:29 PM, Hari Bathini
<hbathini@linux.vnet.ibm.com> wrote:
>
> On Monday 11 September 2017 07:05 AM, Dave Young wrote:
>>
>> Cc more people.
>>
>> On 09/08/17 at 10:10am, Bhupesh Sharma wrote:
>>>
>>> Kernel commit 2f18d533757da3899f4bedab0b2c051b080079dc lowered the
>>> max real address on ppc64 to 53 bits.
>>>
>>> Make similar changes in makedumpfile (on basis of the underlying kernel
>>> version), without which the makedumpfile will fail to create a dumpfile
>>> and instead throw a SEGV fault as shown below on kernels >= v4.11:
>>>
>>>   # makedumpfile --split -d 31 -x vmlinux vmcore dumpfile_{1,2,3} 2>&1
>>>
>>>   The kernel version is not supported.
>>>   The makedumpfile operation may be incomplete.
>>>   [ 1196.252094] makedumpfile[2367]: unhandled signal 11 at
>>>   00000100f7011ca8 nip 000000001001eecc lr 000000001001f3c0 code 30001
>>>   Segmentation fault
>
>
> I have not hit the above problem, but for the sake of correctness,
> this patch is needed for >= 4.11.0 kernels. So..
>
> Acked-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

Thanks for the review.  As Atsushi suggested some changes in v1, I am
sharing a v2 version shortly.

Kindly review the same as well.

Regards,
Bhupesh

>>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>>> ---
>>>   makedumpfile.h | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/makedumpfile.h b/makedumpfile.h
>>> index 7d81bbcf2234..142753d84e8d 100644
>>> --- a/makedumpfile.h
>>> +++ b/makedumpfile.h
>>> @@ -684,8 +684,9 @@ unsigned long get_kvbase_arm64(void);
>>>   #define PMD_MASKED_BITS_64K_4_6  0xc0000000000000ffUL
>>>     #define PTE_RPN_MASK_DEFAULT  0xffffffffffffffffUL
>>> -#define PTE_RPN_SIZE_L4_4_6   (info->page_size == 65536 ? 41 : 45)
>>> -#define PTE_RPN_MASK_L4_4_6   (((1UL << PTE_RPN_SIZE_L4_4_6) - 1) <<
>>> info->page_shift)
>>> +#define PAGE_PA_MAX_L4_4_6    (info->kernel_version >=
>>> KERNEL_VERSION(4,11,0) ? 53 : 57)
>>> +#define PTE_RPN_MASK_L4_4_6   \
>>> +       (((1UL << PAGE_PA_MAX_L4_4_6) - 1) & ~((1UL << info->page_shift)
>>> - 1))
>>>   #define PTE_RPN_SHIFT_L4_4_6  info->page_shift
>>>     #define PGD_MASKED_BITS_4_7  0xc0000000000000ffUL
>>> --
>>> 2.7.4
>>>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
