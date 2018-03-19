Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ey07S-000259-RN
 for kexec@lists.infradead.org; Mon, 19 Mar 2018 19:06:57 +0000
Received: by mail-lf0-f66.google.com with SMTP id y2-v6so24969401lfc.5
 for <kexec@lists.infradead.org>; Mon, 19 Mar 2018 12:06:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180319144529.vkfrrkc4bdhwvvbi@dragonfly>
References: <1521455739-8022-1-git-send-email-bhsharma@redhat.com>
 <20180319144529.vkfrrkc4bdhwvvbi@dragonfly>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 20 Mar 2018 00:36:41 +0530
Message-ID: <CACi5LpObqAJ=yC_e2G80JsspfzEx50Rq=J2G_UAnoT3UqS4HFQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] dt-ops: Add helper API to dump fdt blob
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, Bhupesh SHARMA <bhupesh.linux@gmail.com>, James Morse <james.morse@arm.com>, Dave Young <dyoung@redhat.com>

On Mon, Mar 19, 2018 at 8:15 PM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> On Mon, Mar 19, 2018 at 04:05:38PM +0530, Bhupesh Sharma wrote:
>> At several occasions it would be useful to dump the fdt
>> blob being passed to the second (kexec/kdump) kernel
>> when '-d' flag is specified while invoking kexec/kdump.
>
> Why not just save binary data to a file and interpret it
> with dtc command?

Well, there are a couple of reasons for that which can be understood
from a system which is in a production environment (for e.g. I have
worked on one arm64 system in the past which used a yocto based
distribution in which kexec -p was launched with a -d option as a part
of initial ramfs scriptware):

- In a production environment, installing and executing tools like dtc
(which might not have been installed by default via 'yum' or 'apt-get
install' or other means is not only an additional step, but we might
not get a chance to run it even if it is installed if we have a early
crash in kdump itself (for e.g. consider the 'acpi table access' issue
in the arm64 crashkernel we discussed some time back
<https://www.spinics.net/lists/arm-kernel/msg616632.html>):

a) In such a case the primary kernel has already crashed, so we had no
opportunity to run a dtc interpreter there and the kdump kernel itself
has crashed in a very early boot phase. So we didn't get a chance to
execute 'dtc' on the kdump kernel command prompt (if the kdump scripts
are configured not to reboot the primary again).

b) Also when an early arm64 kdump crash is reported by a customer, we
usually only have access to the primary and secondary console log
which also might include the 'kexec -p -d' log messages, which can
point us to a discrepancy in dtc nodes like 'linux,usable-memory"
which might have caused a early crashkernel crash.

Personally, so-far I have found this dtb dumping facility of use in
debugging atleast a couple of arm64 crashkernel crash/panic issues.
Till the arm64 kexec/kdump implementation matures further, I feel this
dumping facility is of good use to ease crashkernel panic debugs.

Regards,
Bhupesh


>
>> This allows one to look at the device-tree fields that
>> is being passed to the secondary kernel and accordingly
>> debug issues.
>>
>> This can be specially useful for the arm64 case, where
>> kexec_load() or kdump passes important information like
>> 'linux,usable-memory' ranges to the second kernel, and
>> the correctness of the ranges can be verified by
>> looking at the device-tree dump with '-d' flag specified.
>>
>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>> ---
>>  kexec/dt-ops.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  kexec/dt-ops.h |   1 +
>>  2 files changed, 134 insertions(+)
>>
>> diff --git a/kexec/dt-ops.c b/kexec/dt-ops.c
>> index 915dbf55afd2..caf6f8df6e6b 100644
>> --- a/kexec/dt-ops.c
>> +++ b/kexec/dt-ops.c
>> @@ -8,6 +8,10 @@
>>  #include "kexec.h"
>>  #include "dt-ops.h"
>>
>> +#define ALIGN(x, a)  (((x) + ((a) - 1)) & ~((a) - 1))
>> +#define PALIGN(p, a) ((void *)(ALIGN((unsigned long)(p), (a))))
>> +#define GET_CELL(p)  (p += 4, *((const uint32_t *)(p-4)))
>> +
>>  static const char n_chosen[] = "/chosen";
>>
>>  static const char p_bootargs[] = "bootargs";
>> @@ -143,3 +147,132 @@ int dtb_delete_property(char *dtb, const char *node, const char *prop)
>>
>>       return result;
>>  }
>> +
>> +static uint64_t is_printable_string(const void* data, uint64_t len)
>> +{
>> +     const char *s = data;
>> +     const char *ss;
>> +
>> +     /* Check for zero length strings */
>> +     if (len == 0) {
>> +             return 0;
>> +     }
>> +
>> +     /* String must be terminated with a '\0' */
>> +     if (s[len - 1] != '\0') {
>> +             return 0;
>> +     }
>> +
>> +     ss = s;
>> +     while (*s) {
>> +             s++;
>> +     }
>> +
>> +     /* Traverse till we hit a '\0' or reach 'len' */
>> +     if (*s != '\0' || (s + 1 - ss) < len) {
>> +             return 0;
>> +     }
>> +
>> +     return 1;
>> +}
>> +
>> +static void print_data(const char* data, uint64_t len)
>> +{
>> +     uint64_t i;
>> +     const char *p = data;
>> +
>> +     /* Check for non-zero length */
>> +     if (len == 0)
>> +             return;
>> +
>> +     if (is_printable_string(data, len)) {
>> +             dbgprintf(" = \"%s\"", (const char *)data);
>> +     } else if ((len % 4) == 0) {
>> +             dbgprintf(" = <");
>> +             for (i = 0; i < len; i += 4) {
>> +                     dbgprintf("0x%08x%s",
>> +                                     fdt32_to_cpu(GET_CELL(p)),
>> +                                     i < (len - 4) ? " " : "");
>> +             }
>> +             dbgprintf(">");
>> +     } else {
>> +             dbgprintf(" = [");
>> +             for (i = 0; i < len; i++)
>> +                     dbgprintf("%02x%s", *p++,
>> +                                     i < len - 1 ? " " : "");
>> +             dbgprintf("]");
>> +     }
>> +}
>> +
>> +void dump_fdt(void* fdt)
>> +{
>> +     struct fdt_header *bph;
>> +     const char* p_struct;
>> +     const char* p_strings;
>> +     const char* p;
>> +     const char* s;
>> +     const char* t;
>> +     uint32_t off_dt;
>> +     uint32_t off_str;
>> +     uint32_t tag;
>> +     uint64_t sz;
>> +     uint64_t depth;
>> +     uint64_t shift;
>> +     uint32_t version;
>> +
>> +     depth = 0;
>> +     shift = 4;
>> +
>> +     bph = fdt;
>> +     off_dt = fdt32_to_cpu(bph->off_dt_struct);
>> +     off_str = fdt32_to_cpu(bph->off_dt_strings);
>> +     p_struct = (const char*)fdt + off_dt;
>> +     p_strings = (const char*)fdt + off_str;
>> +     version = fdt32_to_cpu(bph->version);
>> +
>> +     p = p_struct;
>> +     while ((tag = fdt32_to_cpu(GET_CELL(p))) != FDT_END) {
>> +
>> +             if (tag == FDT_BEGIN_NODE) {
>> +                     s = p;
>> +                     p = PALIGN(p + strlen(s) + 1, 4);
>> +
>> +                     if (*s == '\0')
>> +                             s = "/";
>> +
>> +                     dbgprintf("%*s%s {\n", (int)(depth * shift), " ", s);
>> +
>> +                     depth++;
>> +                     continue;
>> +             }
>> +
>> +             if (tag == FDT_END_NODE) {
>> +                     depth--;
>> +
>> +                     dbgprintf("%*s};\n", (int)(depth * shift), " ");
>> +                     continue;
>> +             }
>> +
>> +             if (tag == FDT_NOP) {
>> +                     dbgprintf("%*s// [NOP]\n", (int)(depth * shift), " ");
>> +                     continue;
>> +             }
>> +
>> +             if (tag != FDT_PROP) {
>> +                     dbgprintf("%*s ** Unknown tag 0x%08x\n",
>> +                                     (int)(depth * shift), " ", tag);
>> +                     break;
>> +             }
>> +             sz = fdt32_to_cpu(GET_CELL(p));
>> +             s = p_strings + fdt32_to_cpu(GET_CELL(p));
>> +             if (version < 16 && sz >= 8)
>> +                     p = PALIGN(p, 8);
>> +             t = p;
>> +
>> +             p = PALIGN(p + sz, 4);
>> +
>> +             dbgprintf("%*s%s", (int)(depth * shift), " ", s);
>> +             print_data(t, sz);
>> +             dbgprintf(";\n");
>> +     }
>> +}
>> diff --git a/kexec/dt-ops.h b/kexec/dt-ops.h
>> index e70d15d8ffbf..25b9b569f2b7 100644
>> --- a/kexec/dt-ops.h
>> +++ b/kexec/dt-ops.h
>> @@ -9,5 +9,6 @@ int dtb_set_property(char **dtb, off_t *dtb_size, const char *node,
>>       const char *prop, const void *value, int value_len);
>>
>>  int dtb_delete_property(char *dtb, const char *node, const char *prop);
>> +void dump_fdt(void *fdt) ;
>>
>>  #endif
>> --
>> 2.7.4
>>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
