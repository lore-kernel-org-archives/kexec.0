Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ewllj-0001ke-Gx
 for kexec@lists.infradead.org; Fri, 16 Mar 2018 09:35:26 +0000
Received: by mail-lf0-f66.google.com with SMTP id y19-v6so14393291lfd.4
 for <kexec@lists.infradead.org>; Fri, 16 Mar 2018 02:35:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180314182448.bnvjtgyzipsuxcbe@lakrids.cambridge.arm.com>
References: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
 <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
 <20180313102158.GI25863@linaro.org>
 <20180313104715.prurmrizho4ddc4l@lakrids.cambridge.arm.com>
 <20180313110747.GJ25863@linaro.org>
 <20180313112016.ocx4qqhji3zfwjhs@lakrids.cambridge.arm.com>
 <CACi5LpN4DTYFVSVqru2j0y=CKr2ztrJ1gCW32sJBU=oUV2fcWw@mail.gmail.com>
 <20180314021050.GK25863@linaro.org>
 <20180314182448.bnvjtgyzipsuxcbe@lakrids.cambridge.arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 16 Mar 2018 15:05:10 +0530
Message-ID: <CACi5LpNyx5VKO6mYB1yXNPENPKhAfAJ7cUSBeVzVtXfF6+EPwg@mail.gmail.com>
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

On Wed, Mar 14, 2018 at 11:54 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Mar 14, 2018 at 11:10:53AM +0900, AKASHI Takahiro wrote:
>> If kaslr-seed has a critical value in terms of security, is kexec-tools
>> a right place? It is exposed to user space albeit for a short time of period.
>
> The kernel zeroes the seed in the DT at boot time, so the current seed
> isn't visible to userspace.
>
> If kexec-tools generates a seed, and inserts it into the DTB that it
> loads, this is only visible to kexec tools or other applications which
> can inspect its memory, so I don't think this is much of a concern.
> Anything with such privilege can presumably kexec() to arbitrary code
> anyhow.
>
> The next kernel will then zero its seed in the DT at boot time, so
> similarly this won't be visible to userspace on the new kernel.
>
> FWIW, having kexec tools generate a seed for the kexec_load() case makes
> sense to me.

Fair enough. I will try to take a stab at the same and come back with
my findings on this thread.

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
