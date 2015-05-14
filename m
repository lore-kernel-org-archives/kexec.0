Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <55542EC9.1060504@redhat.com>
Date: Thu, 14 May 2015 10:42:41 +0530
From: Pratyush Anand <panand@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: Kexec: Add support for binary image
References: <770bae1ed7d53e74874f99343070b4c5a69cb9a2.1429704995.git.panand@redhat.com>
 <1430933681.12082.23.camel@infradead.org>
In-Reply-To: <1430933681.12082.23.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org

Hi Geoff,

Thanks for the review.

On Wednesday 06 May 2015 11:04 PM, Geoff Levand wrote:
> Hi,
>
> On Wed, 2015-04-22 at 17:56 +0530, Pratyush Anand wrote:
>
>> @@ -30,6 +32,7 @@ static const char arm64_opts_usage[] __attribute__ ((unused)) =
>>   "     --dtb=FILE            Use FILE as the device tree blob.\n"
>>   "     --initrd=FILE         Use FILE as the kernel initial ramdisk.\n"
>>   "     --lite                Fast reboot, no memory integrity checks.\n"
>> +"     --page-offset         Kernel page-offset for binary image load.\n"
>
> Sorry I didn't see this before, but page-offset is for Image load, so
> should go in the image_arm64_usage().
>

OK, will modify.

> I think it is OK to keep page_offset in struct arm64_opts, then just
> ignore it for the other file formats.
>

Since arm64_opts.page_offset is used by only binary image file format, 
so should be OK.

>>   "     --port=ADDRESS        Purgatory output to port ADDRESS.\n"
>>   "     --ramdisk=FILE        Use FILE as the kernel initial ramdisk.\n"
>>   "     --reuse-cmdline       Use command line arg of primary kernel.\n";
>
>> --- a/kexec/arch/arm64/kexec-image-arm64.c
>> +++ b/kexec/arch/arm64/kexec-image-arm64.c
>> +static unsigned long long get_kernel_page_offset(void)
>> +{
>> +	unsigned long long text_sym_addr = get_kernel_text_sym();
>> +	unsigned long long text_page_offset =
>> +		text_sym_addr & 0xFFFFFFFFFFE00000;
>> +
>> +	if(arm64_opts.page_offset) {
>> +		if (text_page_offset != arm64_opts.page_offset)
>> +			dbgprintf("User page offset did not match with text page offset\n");
>
> I'd like to see the values printed.

OK, will modify.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
