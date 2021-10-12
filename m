Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ma8tL-00BNhx-HI
 for kexec@lists.infradead.org; Tue, 12 Oct 2021 03:55:53 +0000
Received: by mail-pf1-f198.google.com with SMTP id
 t79-20020a627852000000b0044d0ecd9f7aso2590779pfc.13
 for <kexec@lists.infradead.org>; Mon, 11 Oct 2021 20:55:47 -0700 (PDT)
Date: Tue, 12 Oct 2021 11:53:24 +0800
From: Coiby Xu <coxu@redhat.com>
Subject: Re: [PATCH v2 1/2] kexec, KEYS: make the code in
 bzImage64_verify_sig generic
Message-ID: <20211012035324.ctwuaaaig5yin7ve@localhost.localdomain>
References: <20211009095458.297191-1-coxu@redhat.com>
 <20211009095458.297191-2-coxu@redhat.com> <87ily3br3n.fsf@disp2133>
MIME-Version: 1.0
In-Reply-To: <87ily3br3n.fsf@disp2133>
Content-Disposition: inline
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>

On Mon, Oct 11, 2021 at 08:58:36AM -0500, Eric W. Biederman wrote:
>Coiby Xu <coxu@redhat.com> writes:
>
>> The code in bzImage64_verify_sig could make use of system keyrings including
>> .buitin_trusted_keys, .secondary_trusted_keys and .platform keyring to verify
>> signed kernel image as PE file. Make it generic so both x86_64 and arm64 can
>> use it.
>
>The naming is problematic.
>
>At a minimum please name the new function kexec_kernel_verify_pe_sig.
>AKA what you named it without the "arch_" prefix.  A function named with
>an "arch_" prefix  implies that it has an architecture specific
>implementation.

Thanks for bringing up this issue and providing the fix and the explanation.

>
>It looks like arch_kexec_kernel_verify_sig should be killed as well
>as it only has one implementation in the generic code.  And the code
>should always call kexec_image_verify_sig_default.  Not that you should
>do that but I am pointing it out as it seems that is the bad example you
>are copying.

Yes, you are right about it. This is a leftover issue of commit 
9ec4ecef0af7790551109283ca039a7c52de343c ("kexec_file,x86,powerpc: factor 
out kexec_file_ops functions"),
     
     As arch_kexec_kernel_image_{probe,load}(),
     arch_kimage_file_post_load_cleanup() and arch_kexec_kernel_verify_sig()
     are almost duplicated among architectures, they can be commonalized with
     an architecture-defined kexec_file_ops array.  So let's factor them out.

That commit moves the architecture specific implementation of 
arch_kexec_kernel_verify_sig to kexec_file_ops->verify_sig. So actually 
arch_kexec_kernel_verify_sig should be removed. Then we rename
kexec_image_verify_sig_default to kimage_validate_signature and call 
it in kimage_validate_signature directly. I'll include a new patch to do 
the clean-up work in v3.

>
>Eric
>
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>> ---
>>  arch/x86/kernel/kexec-bzimage64.c | 13 +------------
>>  include/linux/kexec.h             |  3 +++
>>  kernel/kexec_file.c               | 17 +++++++++++++++++
>>  3 files changed, 21 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>> index 170d0fd68b1f..4136dd3be5a9 100644
>> --- a/arch/x86/kernel/kexec-bzimage64.c
>> +++ b/arch/x86/kernel/kexec-bzimage64.c
>> @@ -17,7 +17,6 @@
>>  #include <linux/kernel.h>
>>  #include <linux/mm.h>
>>  #include <linux/efi.h>
>> -#include <linux/verification.h>
>>
>>  #include <asm/bootparam.h>
>>  #include <asm/setup.h>
>> @@ -531,17 +530,7 @@ static int bzImage64_cleanup(void *loader_data)
>>  #ifdef CONFIG_KEXEC_BZIMAGE_VERIFY_SIG
>>  static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
>>  {
>> -	int ret;
>> -
>> -	ret = verify_pefile_signature(kernel, kernel_len,
>> -				      VERIFY_USE_SECONDARY_KEYRING,
>> -				      VERIFYING_KEXEC_PE_SIGNATURE);
>> -	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
>> -		ret = verify_pefile_signature(kernel, kernel_len,
>> -					      VERIFY_USE_PLATFORM_KEYRING,
>> -					      VERIFYING_KEXEC_PE_SIGNATURE);
>> -	}
>> -	return ret;
>> +	return arch_kexec_kernel_verify_pe_sig(kernel, kernel_len);
>>  }
>>  #endif
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 0c994ae37729..d45f32336dbe 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -19,6 +19,7 @@
>>  #include <asm/io.h>
>>
>>  #include <uapi/linux/kexec.h>
>> +#include <linux/verification.h>
>>
>>  #ifdef CONFIG_KEXEC_CORE
>>  #include <linux/list.h>
>> @@ -199,6 +200,8 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image);
>>  #ifdef CONFIG_KEXEC_SIG
>>  int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>>  				 unsigned long buf_len);
>> +int arch_kexec_kernel_verify_pe_sig(const char *kernel,
>> +				    unsigned long kernel_len);
>>  #endif
>>  int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>>
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 33400ff051a8..0530275b7aa3 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -106,6 +106,23 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>>  {
>>  	return kexec_image_verify_sig_default(image, buf, buf_len);
>>  }
>> +
>> +#ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
>> +int arch_kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len)
>> +{
>> +	int ret;
>> +
>> +	ret = verify_pefile_signature(kernel, kernel_len,
>> +				      VERIFY_USE_SECONDARY_KEYRING,
>> +				      VERIFYING_KEXEC_PE_SIGNATURE);
>> +	if (ret == -ENOKEY && IS_ENABLED(CONFIG_INTEGRITY_PLATFORM_KEYRING)) {
>> +		ret = verify_pefile_signature(kernel, kernel_len,
>> +					      VERIFY_USE_PLATFORM_KEYRING,
>> +					      VERIFYING_KEXEC_PE_SIGNATURE);
>> +	}
>> +	return ret;
>> +}
>> +#endif
>>  #endif
>>
>>  /*
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
