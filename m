Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f4Gp7-0003o5-0i
 for kexec@lists.infradead.org; Fri, 06 Apr 2018 02:09:54 +0000
Received: by mail-pl0-x243.google.com with SMTP id a39-v6so2408345pla.10
 for <kexec@lists.infradead.org>; Thu, 05 Apr 2018 19:09:51 -0700 (PDT)
Date: Fri, 6 Apr 2018 11:09:50 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [Query] ARM64 kaslr support - randomness, seeding and kdump
Message-ID: <20180406020948.GE19607@linaro.org>
References: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
 <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
 <20180313102158.GI25863@linaro.org>
 <20180313104715.prurmrizho4ddc4l@lakrids.cambridge.arm.com>
 <20180313110747.GJ25863@linaro.org>
 <20180313112016.ocx4qqhji3zfwjhs@lakrids.cambridge.arm.com>
 <CACi5LpN4DTYFVSVqru2j0y=CKr2ztrJ1gCW32sJBU=oUV2fcWw@mail.gmail.com>
 <20180314021050.GK25863@linaro.org>
 <20180314182448.bnvjtgyzipsuxcbe@lakrids.cambridge.arm.com>
 <CACi5LpNyx5VKO6mYB1yXNPENPKhAfAJ7cUSBeVzVtXfF6+EPwg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACi5LpNyx5VKO6mYB1yXNPENPKhAfAJ7cUSBeVzVtXfF6+EPwg@mail.gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, kexec@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Bhupesh,

On Fri, Mar 16, 2018 at 03:05:10PM +0530, Bhupesh Sharma wrote:
> On Wed, Mar 14, 2018 at 11:54 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Mar 14, 2018 at 11:10:53AM +0900, AKASHI Takahiro wrote:
> >> If kaslr-seed has a critical value in terms of security, is kexec-tools
> >> a right place? It is exposed to user space albeit for a short time of period.
> >
> > The kernel zeroes the seed in the DT at boot time, so the current seed
> > isn't visible to userspace.
> >
> > If kexec-tools generates a seed, and inserts it into the DTB that it
> > loads, this is only visible to kexec tools or other applications which
> > can inspect its memory, so I don't think this is much of a concern.
> > Anything with such privilege can presumably kexec() to arbitrary code
> > anyhow.
> >
> > The next kernel will then zero its seed in the DT at boot time, so
> > similarly this won't be visible to userspace on the new kernel.
> >
> > FWIW, having kexec tools generate a seed for the kexec_load() case makes
> > sense to me.
> 
> Fair enough. I will try to take a stab at the same and come back with
> my findings on this thread.

How's your progress here?
I've already added kaslr support (i.e. "virtual randomisation") to
my kexec_file patch set.
# just a few lines of code, though

-Takahiro AKASHI


> Thanks,
> Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
