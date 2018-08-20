Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1frlqy-0002qh-Vu
 for kexec@lists.infradead.org; Mon, 20 Aug 2018 15:12:26 +0000
Received: by mail-wr1-x444.google.com with SMTP id z96-v6so4636442wrb.8
 for <kexec@lists.infradead.org>; Mon, 20 Aug 2018 08:12:14 -0700 (PDT)
From: Chris Clayton <chris2553@googlemail.com>
Subject: Re: kexec: fix for "Unhandled rela relocation: R_X86_64_PLT32" error
References: <e590dc81-7df7-746d-98f2-710f85e03467@googlemail.com>
 <20180820083718.GZ4113@MiWiFi-R3L-srv>
 <cbf043a7-8e95-9486-3441-07ef8f2f86f5@googlemail.com>
 <20180820121721.GA4113@MiWiFi-R3L-srv> <20180820122131.GB4113@MiWiFi-R3L-srv>
Message-ID: <aabec0ea-6611-dc95-3f12-391469790d53@googlemail.com>
Date: Mon, 20 Aug 2018 16:12:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180820122131.GB4113@MiWiFi-R3L-srv>
Content-Language: en-GB
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
To: Baoquan He <bhe@redhat.com>, Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org



On 20/08/2018 13:21, Baoquan He wrote:
> Hi Chris,
> 
> On 08/20/18 at 08:17pm, Baoquan He wrote:
>> In response to a change in binutils, commit b21ebf2fb4c
>> (x86: Treat R_X86_64_PLT32 as R_X86_64_PC32) was applied to
>> the linux kernel during the 4.16 development cycle and has
>> since been backported to earlier stable kernel series. The
>> change results in the failure message in $SUBJECT when
>> rebooting via kexec.
>>
>> Fix this by replicating the change in kexec.
>>

OK.

>> Signed-off-by: Chris Clayton <chris2553@googlemail.com>
> 
> I adjusted the patch log a little bit, you have tested it on upstream
> kernel, right?
> 

At the time of my original message (25 July 2018), 4.18.0-rc6+ was the latest upstream. I tested my change on that and
on the latest stable 4.14 series kernel, which was 4.14.57. I've just tested it with 4.18.3 and 4.14.65 and it works
fine. I don't have a 4.19 development kernel installed at the moment - I'm busy with other stuff.

Chris


> Thanks
> Baoquan
> 
>> ---
>>  kexec/arch/x86_64/kexec-elf-rel-x86_64.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
>> index 7fdde73..db85b44 100644
>> --- a/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
>> +++ b/kexec/arch/x86_64/kexec-elf-rel-x86_64.c
>> @@ -79,6 +79,7 @@ void machine_apply_elf_rel(struct mem_ehdr *UNUSED(ehdr),
>>  			goto overflow;
>>  		break;
>>  	case R_X86_64_PC32: 
>> +	case R_X86_64_PLT32:
>>  		*(uint32_t *)location = value - address;
>>  		break;
>>  	default:
>> -- 
>> 2.13.6
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
