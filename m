From: Coiby Xu <coxu@redhat.com>
Date: Thu, 14 Apr 2022 09:44:46 +0800
Subject: [PATCH v5 3/3] arm64: kexec_file: use more system keyrings to
 verify kernel image signature
In-Reply-To: <20220411085938.GA163591@kunlun.suse.cz>
References: <20220401013118.348084-1-coxu@redhat.com>
 <20220401013118.348084-4-coxu@redhat.com>
 <20220411085938.GA163591@kunlun.suse.cz>
Message-ID: <20220414014446.tqopgaz2n3srwc6p@Rk>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Mon, Apr 11, 2022 at 10:59:38AM +0200, Michal Such?nek wrote:
>On Fri, Apr 01, 2022 at 09:31:18AM +0800, Coiby Xu wrote:
>> Currently, a problem faced by arm64 is if a kernel image is signed by a
>> MOK key, loading it via the kexec_file_load() system call would be
>> rejected with the error "Lockdown: kexec: kexec of unsigned images is
>> restricted; see man kernel_lockdown.7".
>
>This is because image_verify_sig uses only the primary keyring that
>contains only kernel built-in keys to verify the kexec image.
>
>> This patch allows to verify arm64 kernel image signature using not only
>> .builtin_trusted_keys but also .platform and .secondary_trusted_key
>> keyring.
>>
>> Acked-by: Will Deacon <will@kernel.org>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/arm64/kernel/kexec_image.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
>> index 9ec34690e255..51af1c22d6da 100644
>> --- a/arch/arm64/kernel/kexec_image.c
>> +++ b/arch/arm64/kernel/kexec_image.c
>> @@ -14,7 +14,6 @@
>>  #include <linux/kexec.h>
>>  #include <linux/pe.h>
>>  #include <linux/string.h>
>> -#include <linux/verification.h>
>>  #include <asm/byteorder.h>
>>  #include <asm/cpufeature.h>
>>  #include <asm/image.h>
>> @@ -133,8 +132,7 @@ static void *image_load(struct kimage *image,
>>  #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
>>  static int image_verify_sig(const char *kernel, unsigned long kernel_len)
>>  {
>> -	return verify_pefile_signature(kernel, kernel_len, NULL,
>> -				       VERIFYING_KEXEC_PE_SIGNATURE);
>> +	return kexec_kernel_verify_pe_sig(kernel, kernel_len);
>>  }
>>  #endif
>
>You can eliminate image_verify_sig here aswell and directly assign
>kexec_kernel_verify_pe_sig to fops.

Good suggestions, thanks!

>
>Thanks
>
>Michal
>

-- 
Best regards,
Coiby


