Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx4D3-0000wN-0H
 for kexec@lists.infradead.org; Fri, 22 Feb 2019 06:21:23 +0000
Received: by mail-pf1-f195.google.com with SMTP id h1so626865pfo.7
 for <kexec@lists.infradead.org>; Thu, 21 Feb 2019 22:21:19 -0800 (PST)
Subject: Re: [PATCH] makedumpfile/arm64: Add support for ARMv8.2-LVA (52-bit
 user-space VA support)
References: <1549569177-7116-1-git-send-email-bhsharma@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568114@BPXM09GP.gisp.nec.co.jp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <442e36d2-d7ef-6e42-7f9c-99cb1e6ff1be@redhat.com>
Date: Fri, 22 Feb 2019 11:51:12 +0530
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03568114@BPXM09GP.gisp.nec.co.jp>
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
To: kexec@lists.infradead.org, Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: Bhupesh SHARMA <bhupesh.linux@gmail.com>

Hi Kazu,

On 02/12/2019 03:33 AM, Kazuhito Hagio wrote:
> Hi Bhupesh,
> 
> On 2/7/2019 2:52 PM, Bhupesh Sharma wrote:
>> With ARMv8.2-LVA architecture extension availability, arm64 hardware
>> which supports this extension can support upto 52-bit virtual
>> addresses. It is specially useful for having a 52-bit user-space virtual
>> address space while the kernel can still retain 48-bit virtual
>> addresses.
>>
>> Since at the moment we enable the support of this extensions in the
>> kernel via a CONFIG flags (CONFIG_ARM64_USER_VA_BITS_52), so there are
>> no clear mechanisms in user-space to determine this CONFIG
>> flag value and use it to determine the PA address range values.
>>
>> 'makedumpfile' can instead use 'MAX_USER_VA_BITS' value to
>> determine the maximum virtual physical address supported by user-space.
>> If 'MAX_USER_VA_BITS' value is greater than 'VA_BITS' than we might be
>> running a use-case where user-space is 52-bit and underlying kernel is
>> still 48-bit. The increased 'PTRS_PER_PGD' value for such cases can then
>> be calculated as is done by the underlying kernel (see kernel file
>> 'arch/arm64/include/asm/pgtable-hwdef.h' for details):
> 
> Thank you for the patch.
> I can't test the config yet, but this looks necessary.

I am sorry, this review email somehow did not show up in my inbox.

>>
>> I have sent a kernel patch upstream to add 'MAX_USER_VA_BITS' to
>> vmcoreinfo for arm64 (see [0]).
>>
>> This patch is in accordance with ARMv8 Architecture Reference Manual
>> version D.a
>>
>> [0].
>> http://lists.infradead.org/pipermail/kexec/2019-February/022411.html
>>
>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>> ---
>>   arch/arm64.c   | 105 +++++++++++++++++++++++++++++++++++++++++----------------
>>   makedumpfile.c |   2 ++
>>   makedumpfile.h |   1 +
>>   3 files changed, 79 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/arm64.c b/arch/arm64.c
>> index a1db7dc63107..b522e93f4e80 100644
>> --- a/arch/arm64.c
>> +++ b/arch/arm64.c
>> @@ -47,6 +47,7 @@ typedef struct {
>>   static int lpa_52_bit_support_available;
>>   static int pgtable_level;
>>   static int va_bits;
>> +static int max_user_va_bits;
>>   static unsigned long kimage_voffset;
>>
>>   #define SZ_4K			4096
>> @@ -145,7 +146,7 @@ get_page_table_level_arm64(void)
>>   #define PGDIR_SHIFT		ARM64_HW_PGTABLE_LEVEL_SHIFT(4 - (get_page_table_level_arm64()))
>>   #define PGDIR_SIZE		(_AC(1, UL) << PGDIR_SHIFT)
>>   #define PGDIR_MASK		(~(PGDIR_SIZE-1))
>> -#define PTRS_PER_PGD		(1 << ((va_bits) - PGDIR_SHIFT))
>> +#define PTRS_PER_PGD		(1 << ((max_user_va_bits) - PGDIR_SHIFT))
>>
>>   /*
>>    * Section address mask and size definitions.
>> @@ -478,6 +479,46 @@ get_stext_symbol(void)
>>   	return(found ? kallsym : FALSE);
>>   }
>>
>> +static int
>> +get_va_bits_from_stext_arm64(void)
>> +{
>> +	ulong _stext;
>> +
>> +	_stext = get_stext_symbol();
>> +	if (!_stext) {
>> +		ERRMSG("Can't get the symbol of _stext.\n");
>> +		return FALSE;
>> +	}
>> +
>> +	/* Derive va_bits as per arch/arm64/Kconfig */
>> +	if ((_stext & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
>> +		va_bits = 36;
>> +	} else if ((_stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
>> +		va_bits = 39;
>> +	} else if ((_stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
>> +		va_bits = 42;
>> +	} else if ((_stext & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
>> +		va_bits = 47;
>> +	} else if ((_stext & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
>> +		va_bits = 48;
>> +	} else {
>> +		ERRMSG("Cannot find a proper _stext for calculating VA_BITS\n");
>> +		return FALSE;
>> +	}
>> +
>> +	DEBUG_MSG("va_bits      : %d\n", va_bits);
> 
> Please add "(_stext)" to the end of line for debugging.

Ok, will address in v3.

>> +
>> +	return TRUE;
>> +}
>> +
>> +static void
>> +get_page_offset_arm64(void)
>> +{
>> +	info->page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
>> +
>> +	DEBUG_MSG("page_offset  : %lx\n", info->page_offset);
>> +}
>> +
>>   int
>>   get_machdep_info_arm64(void)
>>   {
>> @@ -493,8 +534,37 @@ get_machdep_info_arm64(void)
>>   	/* Check if va_bits is still not initialized. If still 0, call
>>   	 * get_versiondep_info() to initialize the same.
>>   	 */
>> +	if (NUMBER(VA_BITS) != NOT_FOUND_NUMBER) {
>> +		va_bits = NUMBER(VA_BITS);
>> +		DEBUG_MSG("va_bits    : %d (vmcoreinfo)\n",
>> +				va_bits);
>> +	}
>> +
>> +	/* Check if va_bits is still not initialized. If still 0, call
>> +	 * get_versiondep_info() to initialize the same from _stext
>> +	 * symbol.
>> +	 */
>>   	if (!va_bits)
>> -		get_versiondep_info_arm64();
>> +		if (get_va_bits_from_stext_arm64() == ERROR)
>> +			return ERROR;
> 
> These ERRORs should be FALSE.

Ok, will address in v3.

>> +
>> +	get_page_offset_arm64();
>> +
>> +	if (NUMBER(MAX_USER_VA_BITS) != NOT_FOUND_NUMBER) {
>> +		max_user_va_bits = NUMBER(MAX_USER_VA_BITS);
>> +		DEBUG_MSG("max_user_va_bits : %d (vmcoreinfo)\n",
>> +				max_user_va_bits);
>> +	}
>> +
>> +	/* Check if max_user_va_bits is still not initialized.
>> +	 * If still 0, its not available in vmcoreinfo and its
>> +	 * safe to initialize it with va_bits.
>> +	 */
>> +	if (!max_user_va_bits) {
>> +		max_user_va_bits = va_bits;
>> +		DEBUG_MSG("max_user_va_bits : %d (default = va_bits)\n",
>> +				max_user_va_bits);
>> +	}
>>
>>   	if (!calculate_plat_config()) {
>>   		ERRMSG("Can't determine platform config values\n");
>> @@ -533,34 +603,11 @@ get_xen_info_arm64(void)
>>   int
>>   get_versiondep_info_arm64(void)
>>   {
>> -	ulong _stext;
>> -
>> -	_stext = get_stext_symbol();
>> -	if (!_stext) {
>> -		ERRMSG("Can't get the symbol of _stext.\n");
>> -		return FALSE;
>> -	}
>> -
>> -	/* Derive va_bits as per arch/arm64/Kconfig */
>> -	if ((_stext & PAGE_OFFSET_36) == PAGE_OFFSET_36) {
>> -		va_bits = 36;
>> -	} else if ((_stext & PAGE_OFFSET_39) == PAGE_OFFSET_39) {
>> -		va_bits = 39;
>> -	} else if ((_stext & PAGE_OFFSET_42) == PAGE_OFFSET_42) {
>> -		va_bits = 42;
>> -	} else if ((_stext & PAGE_OFFSET_47) == PAGE_OFFSET_47) {
>> -		va_bits = 47;
>> -	} else if ((_stext & PAGE_OFFSET_48) == PAGE_OFFSET_48) {
>> -		va_bits = 48;
>> -	} else {
>> -		ERRMSG("Cannot find a proper _stext for calculating VA_BITS\n");
>> -		return FALSE;
>> -	}
>> -
>> -	info->page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
>> +	if (!va_bits)
>> +		if (get_va_bits_from_stext_arm64() == ERROR)
>> +			return ERROR;
> 
> Same as above.

Ok, will address in v3.

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
