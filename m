Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1evpuu-0001Ih-9I
 for kexec@lists.infradead.org; Tue, 13 Mar 2018 19:49:02 +0000
Received: by mail-lf0-f68.google.com with SMTP id y19-v6so1240567lfd.4
 for <kexec@lists.infradead.org>; Tue, 13 Mar 2018 12:48:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180313112016.ocx4qqhji3zfwjhs@lakrids.cambridge.arm.com>
References: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
 <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
 <20180313102158.GI25863@linaro.org>
 <20180313104715.prurmrizho4ddc4l@lakrids.cambridge.arm.com>
 <20180313110747.GJ25863@linaro.org>
 <20180313112016.ocx4qqhji3zfwjhs@lakrids.cambridge.arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 14 Mar 2018 01:18:47 +0530
Message-ID: <CACi5LpN4DTYFVSVqru2j0y=CKr2ztrJ1gCW32sJBU=oUV2fcWw@mail.gmail.com>
Subject: Re: [Query] ARM64 kaslr support - randomness, seeding and kdump
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On Tue, Mar 13, 2018 at 4:50 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Mar 13, 2018 at 08:07:49PM +0900, AKASHI Takahiro wrote:
>> On Tue, Mar 13, 2018 at 10:47:15AM +0000, Mark Rutland wrote:
>> > On Tue, Mar 13, 2018 at 07:22:03PM +0900, AKASHI Takahiro wrote:
>> > > On Mon, Mar 12, 2018 at 08:58:00PM +0000, Ard Biesheuvel wrote:
>> > > > On 12 March 2018 at 20:14, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>> >
>> > > More importantly, neither arm64 _kexec_ supports kaslr.

Sorry if my earlier email was not clear on this, but I meant both the
kdump/kexec cases.

While for kdump there is no current requirement for physical
randomization, for kexec it would be good to support the same as the
primary kernel was already supporting kaslr and the secondary kernel
(if compiled with CONFIG_RANDOMIZE_BASE) would randomizes the virtual
address at which the kernel image is loaded.

If we have physical randomization supported in this case in the
secondary/kexec kernel we can avoid potential misuse related to the
physical address being known at which the secondary/kexec kernel is
loaded.

>> >
>> > The below is just considering this, and ignoring kdump (where I don't
>> > think we care at all about KASLR).
>> >
>> > > Currently kexec-tools is set to determine where the kernel actually be
>> > > loaded, using a constant offset, text_offset, which comes from an image's
>> > > boot header and relocation of an image to the load address is performed
>> > > at the very end of the first kernel without knowing whether the 2nd kernel
>> > > has kaslr support enabled or not.
>> >
>> > The kexec tools shouldn't need to know whether the kernel supports KASLR
>> > at all.
>> >
>> > If the new kernel image has bit 3 (Kernel physical placement) set, kexec
>> > tools can choose to randomize the physical load address, regardless of
>> > whether that kernel has KASLR enabled.
>>
>> So, by definition, is randomness, if we say so, in physical address not
>> part of KASLR?
>
> Physical randomization is not part of the kernel's KASLR implementation.
>
> We happen to do it in the EFI stub, because we can in that context. But
> generally, physical randomization is not part of arm64's in-kernel
> KASLR.
>
> For various reasons, the physical address that the kernel is loaded to
> may be arbitrary, so we have to cope with physical randomization
> regardless.

Indeed, since the primary kernel depends on the  firmware's
EFI_RNG_PROTOCOL implementation (if available) to randomise the
physical location of the kernel Image, for the secondary/kexec kernel,
if can have two approaches to enable physical randomization:

- Implement a UEFI stub for loading the kexec kernel as well, or

- Extend the 'kexec-tools' to invoke the entropy source available in
the primary kernel (provided by the firmware via EFI_RNG_PROTOCOL)  to
generate a random seed to randomize the physical address and populate
it in the '/chosen/kaslr-seed' property of the device-tree being
passed to the secondary/kexec kernel and let the normal code flow in
' arch/arm64/kernel/kaslr.c', function 'kaslr_early_init' to get the
seed for the secondary kernel from the '/chosen/kaslr-seed' property
itself.

Personally the later approach looks simpler to me from a implementation p-o-v.

For example, currently in the kernel we normally invoke 'update_fdt'
(inside 'drivers/fimrware/efi/libstub/fdt.c') from the UEFI stub,
wherein we have this check for CONFIG_RANDOMIZE_BASE:

static efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
                   unsigned long orig_fdt_size,
                   void *fdt, int new_fdt_size, char *cmdline_ptr,
                   u64 initrd_addr, u64 initrd_size)
{

...
    if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
        efi_status_t efi_status;

        efi_status = efi_get_random_bytes(sys_table, sizeof(fdt_val64),
                          (u8 *)&fdt_val64);
        if (efi_status == EFI_SUCCESS) {
            status = fdt_setprop(fdt, node, "kaslr-seed",
                         &fdt_val64, sizeof(fdt_val64));
            if (status)
                goto fdt_set_fail;
        } else if (efi_status != EFI_NOT_FOUND) {
            return efi_status;
        }
    }
...
}

I am thinking of modifying the kexec-tools code for arm64 (which
already processes the device tree to pass it to the secondary/kexec
kernel), so that we can do something like the following:

        --> efi_get_random_bytes(sys_table, sizeof(fdt_val64),
                          (u8 *)&fdt_val64);
        ------> fdt_setprop(fdt, node, "kaslr-seed", &fdt_val64,
sizeof(fdt_val64));

Now when the modified dtb is passed to the secondary/kexec kernel it
will automatically find a valid seed, will wipe it to zero for
security reasons and use the same to perform physical randomization.

If this looks sensible I will try to take a stab at this approach and
share results on thread in the coming days.
Please share your inputs.

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
