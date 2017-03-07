Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cl3xh-00005A-GA
 for kexec@lists.infradead.org; Tue, 07 Mar 2017 01:30:51 +0000
Received: by mail-pf0-f179.google.com with SMTP id j5so67680657pfb.2
 for <kexec@lists.infradead.org>; Mon, 06 Mar 2017 17:30:27 -0800 (PST)
Subject: Re: [PATCH] build_mem_phdrs(): check if p_paddr is invalid
References: <e45f4027aa72ea9009ae03f471894d62ccc135bb.1488346530.git.panand@redhat.com>
 <20170301071317.GA3534@dhcp-128-65.nay.redhat.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <c1f408fe-2283-0b37-a035-9080a31e91e2@redhat.com>
Date: Tue, 7 Mar 2017 06:53:20 +0530
MIME-Version: 1.0
In-Reply-To: <20170301071317.GA3534@dhcp-128-65.nay.redhat.com>
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, bhe@redhat.com

Hi Simon,

On Wednesday 01 March 2017 12:43 PM, Dave Young wrote:
> On 03/01/17 at 11:19am, Pratyush Anand wrote:
>> Currently, all the p_paddr of PT_LOAD headers are assigned to 0, which
>> is not correct and could be misleading, since 0 is a valid physical
>> address.
>>
>> Upstream kernel commit "464920104bf7 /proc/kcore: update physical
>> address for kcore ram and text" fixed it and now invalid PT_LOAD is
>> assigned as -1.
>>
>> kexec/arch/i386/crashdump-x86.c:get_kernel_vaddr_and_size() uses kcore
>> interface and so calls build_mem_phdrs() for kcore PT_LOAD headers.
>>
>> This patch fixes build_mem_phdrs() to check if p_paddr is invalid.

Any comment on this?

>>
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>> ---
>>  kexec/kexec-elf.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kexec/kexec-elf.c b/kexec/kexec-elf.c
>> index 1d6320a2f0e6..be60bbd48486 100644
>> --- a/kexec/kexec-elf.c
>> +++ b/kexec/kexec-elf.c
>> @@ -432,7 +432,8 @@ static int build_mem_phdrs(const char *buf, off_t len, struct mem_ehdr *ehdr,
>>  			}
>>  			return -1;
>>  		}
>> -		if ((phdr->p_paddr + phdr->p_memsz) < phdr->p_paddr) {
>> +		if (phdr->p_paddr != (unsigned long long)-1 &&
>> +			(phdr->p_paddr + phdr->p_memsz) < phdr->p_paddr) {
>>  			/* The memory address wraps */
>>  			if (probe_debug) {
>>  				fprintf(stderr, "ELF address wrap around\n");
>> --
>> 2.9.3
>>
>
> Acked-by: Dave Young <dyoung@redhat.com>
>



~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
