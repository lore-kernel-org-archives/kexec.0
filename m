Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VWLKq-0008Im-4x
 for kexec@lists.infradead.org; Wed, 16 Oct 2013 07:16:01 +0000
Message-ID: <525E3CC3.7070705@cn.fujitsu.com>
Date: Wed, 16 Oct 2013 15:14:11 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Remove PACKED macro and use __attribute__((packed))
 directly
References: <20130905092121.GA8560@dhcp12-158.nay.redhat.com>
 <20131016071203.GA27801@verge.net.au>
In-Reply-To: <20131016071203.GA27801@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, WANG Chao <chaowang@redhat.com>

Hello simon,

On 10/16/2013 03:12 PM, Simon Horman wrote:
> On Thu, Sep 05, 2013 at 05:21:21PM +0800, WANG Chao wrote:
>> People are not always aware of PACKED macro and tend to
>> __attribute__((packed)) more directly. So let's remove PACKED to unify
>> things.
>>
>> Signed-off-by: WANG Chao <chaowang@redhat.com>
> 
> Thanks, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@verge.net.au>
> 
> I suggest re-posting with Andre Morton CCed to see
> if he will pick it up.

You should take this because this is a change in kexec-tools,
not in kernel source......:)

> 
>> ---
>>  include/x86/x86-linux.h | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/x86/x86-linux.h b/include/x86/x86-linux.h
>> index 0949dc2..c41e5f2 100644
>> --- a/include/x86/x86-linux.h
>> +++ b/include/x86/x86-linux.h
>> @@ -12,8 +12,6 @@
>>  
>>  #ifndef ASSEMBLY
>>  
>> -#define PACKED __attribute__((packed))
>> -
>>  #ifndef E820_RAM
>>  struct e820entry {
>>  	uint64_t addr;	/* start of memory segment */
>> @@ -23,7 +21,7 @@ struct e820entry {
>>  #define E820_RESERVED	2
>>  #define E820_ACPI	3 /* usable as RAM once ACPI tables have been read */
>>  #define E820_NVS	4
>> -} PACKED;
>> +} __attribute__((packed));
>>  #endif
>>  
>>  /* FIXME expand on drive_info_)struct... */
>> @@ -255,7 +253,7 @@ struct x86_linux_header {
>>  	uint64_t pref_address;			/* 0x258 */
>>  	uint32_t init_size;			/* 0x260 */
>>  	uint32_t handover_offset;		/* 0x264 */
>> -} PACKED;
>> +} __attribute__((packed));
>>  
>>  #endif /* ASSEMBLY */
>>  
>> -- 
>> 1.8.3.1
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
> 


-- 
Thanks.
Zhang Yanfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
