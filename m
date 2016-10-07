Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bsOtx-0000sO-BB
 for kexec@lists.infradead.org; Fri, 07 Oct 2016 06:45:02 +0000
Received: by mail-oi0-f54.google.com with SMTP id m72so47350410oik.3
 for <kexec@lists.infradead.org>; Thu, 06 Oct 2016 23:44:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b88cbd6b-923d-d0c9-ce23-b9ef99aca256@gmail.com>
References: <20160907043401.6403-1-takahiro.akashi@linaro.org>
 <20160907043401.6403-3-takahiro.akashi@linaro.org>
 <b88cbd6b-923d-d0c9-ce23-b9ef99aca256@gmail.com>
From: Pratyush Anand <panand@redhat.com>
Date: Fri, 7 Oct 2016 12:14:39 +0530
Message-ID: <CAHB_Guoa+7Gnas59TRwKbqXT2b40hj30PzkEVYMse6oT3nu1Gg@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] kexec: generalize and rename get_kernel_stext_sym()
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
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

On Thu, Oct 6, 2016 at 6:58 PM, Matthias Brugger <matthias.bgg@gmail.com> wrote:
> On 09/07/2016 06:33 AM, AKASHI Takahiro wrote:
>>
>> From: Pratyush Anand <panand@redhat.com>
>>
>> get_kernel_stext_sym() has been defined for both arm and i386. Other
>> architecture might need some other kernel symbol address. Therefore
>> rewrite
>> this function as generic function to get any kernel symbol address.
>>
>> More over, kallsyms is not arch specific representation, therefore have
>> common function for all arches.
>>
>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>> [created symbols.c]
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> ---
>>  kexec/Makefile                  |  1 +
>>  kexec/arch/arm/crashdump-arm.c  | 40
>> +---------------------------------------
>>  kexec/arch/i386/crashdump-x86.c | 32 +-------------------------------
>>  kexec/kexec.h                   |  2 ++
>>  kexec/symbols.c                 | 41
>> +++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 46 insertions(+), 70 deletions(-)
>>  create mode 100644 kexec/symbols.c
>>
>> diff --git a/kexec/Makefile b/kexec/Makefile
>> index 39f365f..2b4fb3d 100644
>> --- a/kexec/Makefile
>> +++ b/kexec/Makefile
>> @@ -26,6 +26,7 @@ KEXEC_SRCS_base += kexec/kernel_version.c
>>  KEXEC_SRCS_base += kexec/lzma.c
>>  KEXEC_SRCS_base += kexec/zlib.c
>>  KEXEC_SRCS_base += kexec/kexec-xen.c
>> +KEXEC_SRCS_base += kexec/symbols.c
>>
>>  KEXEC_GENERATED_SRCS += $(PURGATORY_HEX_C)
>>
>> diff --git a/kexec/arch/arm/crashdump-arm.c
>> b/kexec/arch/arm/crashdump-arm.c
>> index 4a89b5e..2bc898b 100644
>> --- a/kexec/arch/arm/crashdump-arm.c
>> +++ b/kexec/arch/arm/crashdump-arm.c
>> @@ -73,48 +73,10 @@ static struct crash_elf_info elf_info = {
>>
>>  extern unsigned long long user_page_offset;
>>
>> -/* Retrieve kernel _stext symbol virtual address from /proc/kallsyms */
>> -static unsigned long long get_kernel_stext_sym(void)
>> -{
>> -       const char *kallsyms = "/proc/kallsyms";
>> -       const char *stext = "_stext";
>> -       char sym[128];
>> -       char line[128];
>> -       FILE *fp;
>> -       unsigned long long vaddr = 0;
>> -       char type;
>> -
>> -       fp = fopen(kallsyms, "r");
>> -       if (!fp) {
>> -               fprintf(stderr, "Cannot open %s\n", kallsyms);
>> -               return 0;
>> -       }
>> -
>> -       while(fgets(line, sizeof(line), fp) != NULL) {
>> -               unsigned long long addr;
>> -
>> -               if (sscanf(line, "%Lx %c %s", &addr, &type, sym) != 3)
>> -                       continue;
>> -
>> -               if (strcmp(sym, stext) == 0) {
>> -                       dbgprintf("kernel symbol %s vaddr = %#llx\n",
>> stext, addr);
>> -                       vaddr = addr;
>> -                       break;
>> -               }
>> -       }
>> -
>> -       fclose(fp);
>> -
>> -       if (vaddr == 0)
>> -               fprintf(stderr, "Cannot get kernel %s symbol address\n",
>> stext);
>> -
>> -       return vaddr;
>> -}
>> -
>>  static int get_kernel_page_offset(struct kexec_info *info,
>>                 struct crash_elf_info *elf_info)
>>  {
>> -       unsigned long long stext_sym_addr = get_kernel_stext_sym();
>> +       unsigned long long stext_sym_addr = get_kernel_sym("stext");
>>         if (stext_sym_addr == 0) {
>>                 if (user_page_offset != (-1ULL)) {
>>                         elf_info->page_offset = user_page_offset;
>> diff --git a/kexec/arch/i386/crashdump-x86.c
>> b/kexec/arch/i386/crashdump-x86.c
>> index bbc0f35..664eb3b 100644
>> --- a/kexec/arch/i386/crashdump-x86.c
>> +++ b/kexec/arch/i386/crashdump-x86.c
>> @@ -102,36 +102,6 @@ static int get_kernel_paddr(struct kexec_info
>> *UNUSED(info),
>>         return -1;
>>  }
>>
>> -/* Retrieve kernel _stext symbol virtual address from /proc/kallsyms */
>> -static unsigned long long get_kernel_stext_sym(void)
>> -{
>> -       const char *kallsyms = "/proc/kallsyms";
>> -       const char *stext = "_stext";
>> -       char sym[128];
>> -       char line[128];
>> -       FILE *fp;
>> -       unsigned long long vaddr;
>> -       char type;
>> -
>> -       fp = fopen(kallsyms, "r");
>> -       if (!fp) {
>> -               fprintf(stderr, "Cannot open %s\n", kallsyms);
>> -               return 0;
>> -       }
>> -
>> -       while(fgets(line, sizeof(line), fp) != NULL) {
>> -               if (sscanf(line, "%Lx %c %s", &vaddr, &type, sym) != 3)
>> -                       continue;
>> -               if (strcmp(sym, stext) == 0) {
>> -                       dbgprintf("kernel symbol %s vaddr = %16llx\n",
>> stext, vaddr);
>> -                       return vaddr;
>> -               }
>> -       }
>> -
>> -       fprintf(stderr, "Cannot get kernel %s symbol address\n", stext);
>> -       return 0;
>> -}
>> -
>>  /* Retrieve info regarding virtual address kernel has been compiled for
>> and
>>   * size of the kernel from /proc/kcore. Current /proc/kcore parsing from
>>   * from kexec-tools fails because of malformed elf notes. A kernel patch
>> has
>> @@ -182,7 +152,7 @@ static int get_kernel_vaddr_and_size(struct kexec_info
>> *UNUSED(info),
>>
>>         /* Traverse through the Elf headers and find the region where
>>          * _stext symbol is located in. That's where kernel is mapped */
>> -       stext_sym = get_kernel_stext_sym();
>> +       stext_sym = get_kernel_sym("stext");
>
>
>
> I think this should be get_kernel_sym("_stext");

OK.

>
> Apart from that as Simon already mentioned, due to commit
> 9f62cbd ("kexec/arch/i386: Add support for KASLR memory randomization")
> this patch does not apply cleanly.
>

Will rebase with latest.

Thanks for your review.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
