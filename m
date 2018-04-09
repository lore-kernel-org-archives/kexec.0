Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f5bWs-0001LD-Pk
 for kexec@lists.infradead.org; Mon, 09 Apr 2018 18:28:36 +0000
Received: by mail-lf0-f65.google.com with SMTP id p142-v6so7973134lfd.6
 for <kexec@lists.infradead.org>; Mon, 09 Apr 2018 11:28:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-s13JifH5f_BH_LUbSQYFyOW5QQGjN=ZqwBjTs-BMjYQ@mail.gmail.com>
References: <20180313102158.GI25863@linaro.org>
 <20180313104715.prurmrizho4ddc4l@lakrids.cambridge.arm.com>
 <20180313110747.GJ25863@linaro.org>
 <20180313112016.ocx4qqhji3zfwjhs@lakrids.cambridge.arm.com>
 <CACi5LpN4DTYFVSVqru2j0y=CKr2ztrJ1gCW32sJBU=oUV2fcWw@mail.gmail.com>
 <20180314021050.GK25863@linaro.org>
 <20180314182448.bnvjtgyzipsuxcbe@lakrids.cambridge.arm.com>
 <CACi5LpNyx5VKO6mYB1yXNPENPKhAfAJ7cUSBeVzVtXfF6+EPwg@mail.gmail.com>
 <20180406020948.GE19607@linaro.org>
 <CACi5LpPe_C0fLFzsAHPD54X=D+AsYjvSyZi0yt_6=wFrWmvetw@mail.gmail.com>
 <20180409043138.GF19607@linaro.org>
 <CAKv+Gu-s13JifH5f_BH_LUbSQYFyOW5QQGjN=ZqwBjTs-BMjYQ@mail.gmail.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 9 Apr 2018 23:58:21 +0530
Message-ID: <CACi5LpNAz41VZKkchkjc9SdxctK7Ui1zV_x=pyv0cEHFgfdHZQ@mail.gmail.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Ard,

On Mon, Apr 9, 2018 at 2:58 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 9 April 2018 at 06:31, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
>> Hi,
>>
>> On Mon, Apr 09, 2018 at 09:31:34AM +0530, Bhupesh Sharma wrote:
>>> Hi Akashi,
>>>
>>> On Fri, Apr 6, 2018 at 7:39 AM, AKASHI Takahiro
>>> <takahiro.akashi@linaro.org> wrote:
>>> > Bhupesh,
>>> >
>>> > On Fri, Mar 16, 2018 at 03:05:10PM +0530, Bhupesh Sharma wrote:
>>> >> On Wed, Mar 14, 2018 at 11:54 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>> >> > On Wed, Mar 14, 2018 at 11:10:53AM +0900, AKASHI Takahiro wrote:
>>> >> >> If kaslr-seed has a critical value in terms of security, is kexec-tools
>>> >> >> a right place? It is exposed to user space albeit for a short time of period.
>>> >> >
>>> >> > The kernel zeroes the seed in the DT at boot time, so the current seed
>>> >> > isn't visible to userspace.
>>> >> >
>>> >> > If kexec-tools generates a seed, and inserts it into the DTB that it
>>> >> > loads, this is only visible to kexec tools or other applications which
>>> >> > can inspect its memory, so I don't think this is much of a concern.
>>> >> > Anything with such privilege can presumably kexec() to arbitrary code
>>> >> > anyhow.
>>> >> >
>>> >> > The next kernel will then zero its seed in the DT at boot time, so
>>> >> > similarly this won't be visible to userspace on the new kernel.
>>> >> >
>>> >> > FWIW, having kexec tools generate a seed for the kexec_load() case makes
>>> >> > sense to me.
>>> >>
>>> >> Fair enough. I will try to take a stab at the same and come back with
>>> >> my findings on this thread.
>>> >
>>> > How's your progress here?
>>>
>>> I am almost done with the implementation.
>>> Unfortunately I lost most of the last week trying to revive my arm64
>>> board (which supports
>>> EFI_RNG_PROTOCOL and hence can be used to test the kaslr-seed related
>>> stuff), so I was not
>>> able to test the implementation.
>>>
>>> Now that the board is up, I think I can test and thrash out any
>>> missing clogs in the approach.
>>
>> Sounds good.
>>
>>> > I've already added kaslr support (i.e. "virtual randomisation") to
>>> > my kexec_file patch set.
>>> > # just a few lines of code, though
>>>
>>> Hmm, have you sent out a new version already (kexec_file_load), as the last
>>> version in my inbox still mentions in the cover letter that we need a
>>> EFI stub like approach
>>> to really support CONFIG_RANDOMIZE_BASE. Or, am I missing something?
>>
>> No, not yet.
>> While I've also added some sort of "physical randomisation",
>> I'd like to put my post on hold until v4.17-rc1.
>>
>>> I would love to have a look at the patch and try it at my end, so
>>> could you please share
>>> a pointer to the same.
>>
>> Your test will be very much appreciated.
>>
>
> Does this mean we have decided that we will enable KASLR in the kdump
> kernel anyway, even if x86 disables it explicitly?

No, we are mainly considering here the 'kexec warm reboot to another
kernel' case and not the kdump case (although theoretically both the
cases are pretty similar). So, I will use the terms primary and
secondary kernels below just theoretical clarity:

1. So let's consider the case where the arm64 primary kernel had
CONFIG_RANDOMIZE_BASE set to y and we have a compliant EFI firmware
which can support EFI_RNG_PROTOCOL and hence we have a non-zero
(valid) seed passed to the primary kernel.

2. Now the primary kernel reads the kaslr-seed and wipes it to 0 and
uses the value to randomize for e.g. the module base address.

3. In the case of kexec load (not kexec file load) or even kdump (for
brevity) , we rely on the user-space kexec-tools to pass an
appropriate dtb to the secondary kernel and since kaslr-seed is wiped
to 0 by the primary kernel, the secondary will work with *nokaslr* as
kaslr-seed is set to 0.

4. This can be true even in case the secondary kernel had
CONFIG_RANDOMIZE_BASE and CONFIG_RANDOMIZE_MODULE_REGION_FULL set to
y.

5. This behaviour probably needs fixing atleast for the kexec (as I
can think of no practical use-case for kdump) case.

What are your views on the same?

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
