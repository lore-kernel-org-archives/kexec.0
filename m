Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fAuRk-0002hy-2d
 for kexec@lists.infradead.org; Tue, 24 Apr 2018 09:41:36 +0000
Received: by mail-io0-x244.google.com with SMTP id d26-v6so21922078ioc.2
 for <kexec@lists.infradead.org>; Tue, 24 Apr 2018 02:41:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACi5LpN6NzDaxtvMK2P1XAbM=vyKQ0RU2shH51wGWKozyDFtfQ@mail.gmail.com>
References: <1523737180-7705-1-git-send-email-bhsharma@redhat.com>
 <20180416023014.GD13168@linaro.org>
 <CACi5LpMym2adROYwO-PFTft88Nm74JMkOGecVENKuFn_apw7yA@mail.gmail.com>
 <CACi5LpN6NzDaxtvMK2P1XAbM=vyKQ0RU2shH51wGWKozyDFtfQ@mail.gmail.com>
From: "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Date: Tue, 24 Apr 2018 18:40:58 +0900
Message-ID: <CAB5YjtBOvbE4SZAqMr_sNjkjoApA-uUA861u6CsX2_V7=mgTuQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: Add support to supply 'kaslr-seed' to secondary
 kernel
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>

Bhupesh,

On 23 April 2018 at 20:05, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> Hello Akashi,
>
> On Tue, Apr 17, 2018 at 12:35 AM, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>> Hello Akashi,
>>
>> Thanks for the review comments.
>>
>> On Mon, Apr 16, 2018 at 8:00 AM, AKASHI Takahiro
>> <takahiro.akashi@linaro.org> wrote:
>>> Bhupesh,
>>>
>>> On Sun, Apr 15, 2018 at 01:49:40AM +0530, Bhupesh Sharma wrote:
>>>> This patch adds the support to supply 'kaslr-seed' to secondary kernel,
>>>> when we do a 'kexec warm reboot to another kernel' (although the
>>>> behaviour remains the same for the 'kdump' case as well) on arm64
>>>> platforms using the 'kexec_load' invocation method.
>>>>
>>>> Lets consider the case where the primary kernel working on the arm64
>>>> platform supports kaslr (i.e 'CONFIG_RANDOMIZE_BASE' was set to y and
>>>> we have a compliant EFI firmware which supports EFI_RNG_PROTOCOL and
>>>> hence can pass a non-zero (valid) seed to the primary kernel).
>>>>
>>>> Now the primary kernel reads the 'kaslr-seed' and wipes it to 0 and
>>>> uses the seed value to randomize for e.g. the module base address
>>>> offset.
>>>>
>>>> In the case of 'kexec_load' (or even kdump for brevity),
>>>> we rely on the user-space kexec-tools to pass an appropriate dtb to the
>>>> secondary kernel and since 'kaslr-seed' is wiped to 0 by the primary
>>>> kernel, the secondary will essentially work with *nokaslr* as
>>>> 'kaslr-seed' is set to 0 when it is passed to the secondary kernel.
>>>>
>>>> This can be true even in case the secondary kernel had
>>>> 'CONFIG_RANDOMIZE_BASE' and 'CONFIG_RANDOMIZE_MODULE_REGION_FULL' set to
>>>> y.
>>>>
>>>> This patch addresses this issue by first checking if the device tree
>>>> provided by the firmware to the kernel supports the 'kaslr-seed'
>>>> property and verifies that it is really wiped to 0. If this condition is
>>>> met, it fixes up the 'kaslr-seed' property by using the getrandom()
>>>> syscall to get a suitable random number.
>>>>
>>>> I verified this patch on my Qualcomm arm64 board and here are some test
>>>> results:
>>>>
>>>> 1. Ensure that the primary kernel is boot'ed with 'kaslr-seed'
>>>>    dts property and it is really wiped to 0:
>>>>
>>>>    [root@qualcomm-amberwing]# dtc -I dtb -O dts /sys/firmware/fdt | grep -A 10 -i chosen
>>>>       chosen {
>>>>               kaslr-seed = <0x0 0x0>;
>>>>               ...
>>>>       }
>>>>
>>>> 2. Now issue 'kexec_load' to load the secondary kernel (let's assume
>>>>    that we are using the same kernel as the secondary kernel):
>>>>    # kexec -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname
>>>>      -r`.img --reuse-cmdline -d
>>>>
>>>> 3. Issue 'kexec -e' to warm boot to the secondary:
>>>>    # kexec -e
>>>>
>>>> 4. Now after the secondary boots, confirm that the load address of the
>>>>    modules is randomized in every successive boot:
>>>>
>>>>    [root@qualcomm-amberwing]# cat /proc/modules
>>>>    sunrpc 524288 1 - Live 0xffff0307db190000
>>>>    vfat 262144 1 - Live 0xffff0307db110000
>>>>    fat 262144 1 vfat, Live 0xffff0307db090000
>>>>    crc32_ce 262144 0 - Live 0xffff0307d8c70000
>>>>    ...
>>>>
>>>> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
>>>> ---
>>>>  kexec/arch/arm64/kexec-arm64.c | 135 +++++++++++++++++++++++++++++------------
>>>>  1 file changed, 97 insertions(+), 38 deletions(-)
>>>>
>>>> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
>>>> index 62f37585b788..2ab11227447a 100644
>>>> --- a/kexec/arch/arm64/kexec-arm64.c
>>>> +++ b/kexec/arch/arm64/kexec-arm64.c
>>>> @@ -15,6 +15,11 @@
>>>>  #include <linux/elf-em.h>
>>>>  #include <elf.h>
>>>>
>>>> +#include <unistd.h>
>>>> +#include <syscall.h>
>>>> +#include <errno.h>
>>>> +#include <linux/random.h>
>>>> +
>>>>  #include "kexec.h"
>>>>  #include "kexec-arm64.h"
>>>>  #include "crashdump.h"
>>>> @@ -392,11 +397,13 @@ static int fdt_setprop_range(void *fdt, int nodeoffset,
>>>>  static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
>>>>  {
>>>>       uint32_t address_cells, size_cells;
>>>> -     int range_len;
>>>> -     int nodeoffset;
>>>> +     uint64_t fdt_val64;
>>>> +     uint64_t *prop;
>>>>       char *new_buf = NULL;
>>>> +     int len, range_len;
>>>> +     int nodeoffset;
>>>>       int new_size;
>>>> -     int result;
>>>> +     int result, kaslr_seed;
>>>>
>>>>       result = fdt_check_header(dtb->buf);
>>>>
>>>> @@ -407,47 +414,99 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
>>>>
>>>>       result = set_bootargs(dtb, command_line);
>>>>
>>>> -     if (on_crash) {
>>>> -             /* determine #address-cells and #size-cells */
>>>> -             result = get_cells_size(dtb->buf, &address_cells, &size_cells);
>>>> -             if (result) {
>>>> -                     fprintf(stderr,
>>>> -                             "kexec: cannot determine cells-size.\n");
>>>> -                     result = -EINVAL;
>>>> -                     goto on_error;
>>>> -             }
>>>> +     /* determine #address-cells and #size-cells */
>>>> +     result = get_cells_size(dtb->buf, &address_cells, &size_cells);
>>>> +     if (result) {
>>>> +             fprintf(stderr, "kexec: cannot determine cells-size.\n");
>>>> +             result = -EINVAL;
>>>> +             goto on_error;
>>>> +     }
>>>>
>>>> -             if (!cells_size_fitted(address_cells, size_cells,
>>>> -                                     &elfcorehdr_mem)) {
>>>> -                     fprintf(stderr,
>>>> -                             "kexec: elfcorehdr doesn't fit cells-size.\n");
>>>> +     if (!cells_size_fitted(address_cells, size_cells,
>>>> +                             &elfcorehdr_mem)) {
>>>> +             fprintf(stderr, "kexec: elfcorehdr doesn't fit cells-size.\n");
>>>> +             result = -EINVAL;
>>>> +             goto on_error;
>>>> +     }
>>>> +
>>>> +     if (!cells_size_fitted(address_cells, size_cells,
>>>> +                             &crash_reserved_mem)) {
>>>> +             fprintf(stderr, "kexec: usable memory range doesn't fit cells-size.\n");
>>>> +             result = -EINVAL;
>>>> +             goto on_error;
>>>> +     }
>>>> +
>>>> +     /* duplicate dt blob */
>>>> +     range_len = sizeof(uint32_t) * (address_cells + size_cells);
>>>> +     new_size = fdt_totalsize(dtb->buf)
>>>> +             + fdt_prop_len(PROP_ELFCOREHDR, range_len)
>>>> +             + fdt_prop_len(PROP_USABLE_MEM_RANGE, range_len);
>>>> +
>>>> +     new_buf = xmalloc(new_size);
>>>> +     result = fdt_open_into(dtb->buf, new_buf, new_size);
>>>> +     if (result) {
>>>> +             dbgprintf("%s: fdt_open_into failed: %s\n", __func__,
>>>> +                             fdt_strerror(result));
>>>> +             result = -ENOSPC;
>>>> +             goto on_error;
>>>> +     }
>>>> +
>>>> +     /* fixup 'kaslr-seed' with a random value, if supported */
>>>> +     nodeoffset = fdt_path_offset(new_buf, "/chosen");
>>>> +     prop = fdt_getprop_w(new_buf, nodeoffset,
>>>> +                     "kaslr-seed", &len);
>>>> +     if (!prop || len != sizeof(uint64_t)) {
>>>
>>> Do we need this check?
>>> Please note that people are allowed to provide a dtb explicitly
>>> at command line and may want to use kexec as bootloader on
>>> no-uefi platform.
>>
>> I agree. Lets look at the original behaviour (before this patch). We
>> used to unpack and fixup dtb properties and then pack it back when
>> 'on_crash' was true (i.e only for the kdump case). In case of 'kexec'
>> we do not fixup the dtb (as per my understanding, please correct me if
>> I am wrong here).
>>
>> With this patch I wanted the dtb's kaslr-seed property to be fixed-up
>> (if its supported and is wiped to 0 by the primary kernel). But this
>> check is harmless in case we don't find the 'kaslr-seed' property in
>> the dtb (for e.g. on non-uefi/u-boot based arm64 platforms).
>>
>> In case the property is not seen in the dtb, we just print a debug
>> message (if '-d' flag was used to launch kexec) and proceed to perform
>> fixup of other dtb properties (like 'linux, usable-memory-range) in
>> case 'on_crash' is true (i.e. 'kexec -p' use case). In the 'kexec -l'
>> case since we don't do any other fixups in the original approach so we
>> retain the same behavior here.
>>
>>>> +             dbgprintf("%s: no kaslr-seed found: %s\n",
>>>> +                             __func__, fdt_strerror(result));
>>>> +             /* for kexec warm reboot case, we don't need to fixup
>>>> +              * other dtb properties
>>>> +              */
>>>> +             if (!on_crash)
>>>> +                     goto free_new_buf;
>>>> +
>>>> +     } else {
>>>> +             kaslr_seed = fdt64_to_cpu(*prop);
>>>> +
>>>> +             /* kaslr_seed must be wiped clean by primary
>>>> +              * kernel during boot
>>>> +              */
>>>> +             if (kaslr_seed != 0) {
>>>> +                     dbgprintf("%s: kaslr-seed is not wiped to 0.\n",
>>>> +                                     __func__);
>>>
>>> Ditto
>>> If this is a user-provided dtb, there is no reason to reject it.
>>> I think all what is needed here is to feed a *sane* dtb to kexec.
>>>
>>> So along with the comment above, it may be useful to add a command line
>>> option for turning on or off "kaslr-seed".
>>
>> Please see my comments above. Since the 'kaslr-seed' property just
>> needs to be read from the dtb, we probably don't need a separate
>> command line option for the same as we already have nokaslr available.
>> If we want the secondary kernel to boot with *nokaslr*, we can pass
>> the same to the secondary via the command line arguments.
>>
>> BTW, I also tried the behaviour with --dtb being passed while invoking
>> the 'kexec -l' with the patch in question and the resulting behaviour
>> is correct, i.e. we see that if the secondary kernel supports
>> CONFIG_RANDOMIZE_BASE=y, we get the resulting randomization in module
>> load address (for e.g.):
>>
>> # kexec -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname
>> -r`.img --command-line="$(cat /proc/cmdline)" --dtb /sys/firmware/fdt
>> -d
>>
>> # kexec -e
>>
>> On successive kexec warm reboots I see that '/proc/kallsyms' and
>> '/proc/modules' have randomized addresses.
>>
>>>>                       result = -EINVAL;
>>>>                       goto on_error;
>>>>               }
>>>>
>>>> -             if (!cells_size_fitted(address_cells, size_cells,
>>>> -                                     &crash_reserved_mem)) {
>>>> -                     fprintf(stderr,
>>>> -                             "kexec: usable memory range doesn't fit cells-size.\n");
>>>> +             /*
>>>> +              * Invoke the getrandom system call with
>>>> +              * GRND_NONBLOCK, to make sure we
>>>> +              * have a valid random seed to pass to the
>>>> +              * secondary kernel.
>>>> +              */
>>>> +             result = syscall(SYS_getrandom, &fdt_val64,
>>>> +                             sizeof(fdt_val64),
>>>> +                             GRND_NONBLOCK);
>>>
>>> Why do you use syscall() here?
>>
>> I found that the standard way to invokde a getrandom() call is via a
>> SYSCALL (please see
>> <https://nikmav.blogspot.in/2016/10/random-generator-linux.html>).
>>
>>>> +
>>>> +             if(result == -1) {
>>>> +                     dbgprintf("%s: Reading random bytes failed.\n",
>>>> +                                     __func__);
>>>>                       result = -EINVAL;
>>>>                       goto on_error;
>>>>               }
>>>>
>>>> -             /* duplicate dt blob */
>>>> -             range_len = sizeof(uint32_t) * (address_cells + size_cells);
>>>> -             new_size = fdt_totalsize(dtb->buf)
>>>> -                     + fdt_prop_len(PROP_ELFCOREHDR, range_len)
>>>> -                     + fdt_prop_len(PROP_USABLE_MEM_RANGE, range_len);
>>>> -
>>>> -             new_buf = xmalloc(new_size);
>>>> -             result = fdt_open_into(dtb->buf, new_buf, new_size);
>>>> +             nodeoffset = fdt_path_offset(new_buf, "/chosen");
>>>> +             result = fdt_setprop_inplace(new_buf,
>>>> +                             nodeoffset, "kaslr-seed",
>>>> +                             &fdt_val64, sizeof(fdt_val64));
>>>>               if (result) {
>>>> -                     dbgprintf("%s: fdt_open_into failed: %s\n", __func__,
>>>> -                             fdt_strerror(result));
>>>> -                     result = -ENOSPC;
>>>> +                     dbgprintf("%s: fdt_setprop failed: %s\n",
>>>> +                                     __func__, fdt_strerror(result));
>>>> +                     result = -EINVAL;
>>>>                       goto on_error;
>>>>               }
>>>> +     }
>>>>
>>>> +     if (on_crash) {
>>>>               /* add linux,elfcorehdr */
>>>>               nodeoffset = fdt_path_offset(new_buf, "/chosen");
>>>>               result = fdt_setprop_range(new_buf, nodeoffset,
>>>> @@ -455,7 +514,7 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
>>>>                               address_cells, size_cells);
>>>>               if (result) {
>>>>                       dbgprintf("%s: fdt_setprop failed: %s\n", __func__,
>>>> -                             fdt_strerror(result));
>>>> +                                     fdt_strerror(result));
>>>>                       result = -EINVAL;
>>>>                       goto on_error;
>>>>               }
>>>> @@ -467,23 +526,23 @@ static int setup_2nd_dtb(struct dtb *dtb, char *command_line, int on_crash)
>>>>                               address_cells, size_cells);
>>>>               if (result) {
>>>>                       dbgprintf("%s: fdt_setprop failed: %s\n", __func__,
>>>> -                             fdt_strerror(result));
>>>> +                                     fdt_strerror(result));
>>>>                       result = -EINVAL;
>>>>                       goto on_error;
>>>>               }
>>>> -
>>>> -             fdt_pack(new_buf);
>>>> -             dtb->buf = new_buf;
>>>> -             dtb->size = fdt_totalsize(new_buf);
>>>>       }
>>>>
>>>> -     dump_reservemap(dtb);
>>>> +     fdt_pack(new_buf);
>>>> +     dtb->buf = new_buf;
>>>> +     dtb->size = fdt_totalsize(new_buf);
>>>>
>>>> +     dump_reservemap(dtb);
>>>>
>>>>       return result;
>>>>
>>>>  on_error:
>>>>       fprintf(stderr, "kexec: %s failed.\n", __func__);
>>>> +free_new_buf:
>>>
>>> Well, technically correct, but it looks odd as it is placed
>>> on *error* return path.
>>
>> I agree. I was not too comfortable with placing this label here.
>> I will try to find a better approach in v2.
>>
>>> You also miss dump_reservemap().
>>
>> Oops. Sure will fix this in v2.
>>
>> Regards,
>> Bhupesh
>
> I was about to send a v2 for this feature and was wondering if you
> have any further comments on the comments I shared last on the review
> comments you had for the v1. If yes, I can try and include them in the
> v2.

I have no more comments for now.

Thanks,
-Takahiro AKASHI

> Please let me know.
>
> Thanks,
> Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
