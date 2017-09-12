Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-f169.google.com ([209.85.223.169])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1drrH8-0002Fu-AO
 for kexec@lists.infradead.org; Tue, 12 Sep 2017 19:55:26 +0000
Received: by mail-io0-f169.google.com with SMTP id v36so41406649ioi.1
 for <kexec@lists.infradead.org>; Tue, 12 Sep 2017 12:54:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701F0C85D@BPXM01GP.gisp.nec.co.jp>
References: <1504845625-27408-1-git-send-email-bhsharma@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701F0C85D@BPXM01GP.gisp.nec.co.jp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 13 Sep 2017 01:24:47 +0530
Message-ID: <CACi5LpPLSZnikt=D87bomhxKP26dCw4_Uj2gEpx+0sikviHo5Q@mail.gmail.com>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "dyoung@redhat.com" <dyoung@redhat.com>, "piliu@redhat.com" <piliu@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>

Hello Atsushi,

On Fri, Sep 8, 2017 at 2:01 PM, Atsushi Kumagai
<ats-kumagai@wm.jp.nec.com> wrote:
> Hello Bhupesh,
>
>>Kernel commit 2f18d533757da3899f4bedab0b2c051b080079dc lowered the
>>max real address on ppc64 to 53 bits.
>>
>>Make similar changes in makedumpfile (on basis of the underlying kernel
>>version), without which the makedumpfile will fail to create a dumpfile
>>and instead throw a SEGV fault as shown below on kernels >= v4.11:
>>
>> # makedumpfile --split -d 31 -x vmlinux vmcore dumpfile_{1,2,3} 2>&1
>>
>> The kernel version is not supported.
>> The makedumpfile operation may be incomplete.
>> [ 1196.252094] makedumpfile[2367]: unhandled signal 11 at
>> 00000100f7011ca8 nip 000000001001eecc lr 000000001001f3c0 code 30001
>> Segmentation fault
>>
>>Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>>---
>> makedumpfile.h | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>>diff --git a/makedumpfile.h b/makedumpfile.h
>>index 7d81bbcf2234..142753d84e8d 100644
>>--- a/makedumpfile.h
>>+++ b/makedumpfile.h
>>@@ -684,8 +684,9 @@ unsigned long get_kvbase_arm64(void);
>> #define PMD_MASKED_BITS_64K_4_6  0xc0000000000000ffUL
>>
>> #define PTE_RPN_MASK_DEFAULT  0xffffffffffffffffUL
>>-#define PTE_RPN_SIZE_L4_4_6   (info->page_size == 65536 ? 41 : 45)
>>-#define PTE_RPN_MASK_L4_4_6   (((1UL << PTE_RPN_SIZE_L4_4_6) - 1) << info->page_shift)
>>+#define PAGE_PA_MAX_L4_4_6    (info->kernel_version >= KERNEL_VERSION(4,11,0) ? 53 : 57)
>>+#define PTE_RPN_MASK_L4_4_6   \
>>+      (((1UL << PAGE_PA_MAX_L4_4_6) - 1) & ~((1UL << info->page_shift) - 1))
>
> This fix is a bit complicated, please introduce *_L4_4_11 simply.

Thanks for the review. I understood your point.
I will send a v2 shortly which should address your inputs.

Regards,
Bhupesh


>
>> #define PTE_RPN_SHIFT_L4_4_6  info->page_shift
>>
>> #define PGD_MASKED_BITS_4_7  0xc0000000000000ffUL
>>--
>>2.7.4
>>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
