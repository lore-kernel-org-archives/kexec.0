Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fAiAU-0004nV-OY
 for kexec@lists.infradead.org; Mon, 23 Apr 2018 20:34:36 +0000
Received: by mail-lf0-f66.google.com with SMTP id b23-v6so16981930lfg.4
 for <kexec@lists.infradead.org>; Mon, 23 Apr 2018 13:34:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180418115225.7hvhsua25rhfqvjs@lakrids.cambridge.arm.com>
References: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
 <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
 <CACi5LpNKbSejFecV+G8X53t4VDwsTvJywWLgLVw9qsD7u6REvg@mail.gmail.com>
 <20180418115225.7hvhsua25rhfqvjs@lakrids.cambridge.arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 24 Apr 2018 02:04:21 +0530
Message-ID: <CACi5LpPb-vSBu1fheroPFG1QJStwZ2nFATakTSFytyY8uOx4ow@mail.gmail.com>
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

Hi Mark,

On Wed, Apr 18, 2018 at 5:22 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Sun, Apr 15, 2018 at 01:44:16AM +0530, Bhupesh Sharma wrote:
>> 4. Accordingly, I wanted to get opinions on whether arm64 timer count is a good
>> entropy source on platforms which indeed support EFI_RNG_PROTOCOL?
>
> On its own, the timer is not a good entropy source.
>
> If we have the EFI_RNG_PROTOCOL, we can use that directly.
>
>> And whether we should  be looking to extend 'arch_get_random_*' or
>> 'random_get_entropy' for arm64, to provide seed/entropy using APIs
>> like 'efi_random_get_seed'?
>
> The EFI RNG protocol is only available during boot services, so we can't
> call this during the usual operation of the kernel. The seed the stub
> generates into the RNG table is already thrown into the entropy pool by
> efi_config_parse_tables(). Look for LINUX_EFI_RANDOM_SEED_TABLE_GUID.
>
> So any attemps to acquire a random number via the usual APIs will in
> part be affects by this entropy, and nothing needs to be done to
> arch_get_random_* to use this entropy.

Sorry for the late reply, it took me some time to have a relook at the
code on the basis of your inputs.

Actually I remember discussing this with a few folks some time back in
one of the UEFI forum events, but its still not very clear to me why
the UEFI specifications would not have the EFI RNG protocol as a
runtime service and only as a boot-time service.

I believe that getting the RNG number directly from the firmware (via
a runtime service call) is probably better than relying on OS RNG
sources like '/dev/random' and '/dev/urandom' which may have known
limitations (which have been discussed time and again on several
upstream threads on lkml).

Also if the EFI RNG protocol is implemented as a runtime protocol in
the UEFI specifications, perhaps we can use 'get_random_bytes_arch()'
like APIs from the kernel to generate arch specific random numbers
faster as compared to relying on the 'chacha20' like interfaces.

Also, I now understand that with the early efi stub boot the following
function call sequence adds initial/boot time randomness to the
'/dev/urandom' pool, so thanks for sharing the pointers for the same:

efi_config_parse_tables ()
    -> add_device_randomness ()
        ->     if (!crng_ready()) {
                     crng_fast_load(buf, size);

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
