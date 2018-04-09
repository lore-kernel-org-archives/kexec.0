Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f5OT6-0003dY-II
 for kexec@lists.infradead.org; Mon, 09 Apr 2018 04:31:50 +0000
Received: by mail-it0-x243.google.com with SMTP id b5-v6so9127953itj.1
 for <kexec@lists.infradead.org>; Sun, 08 Apr 2018 21:31:35 -0700 (PDT)
Date: Mon, 9 Apr 2018 13:31:39 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [Query] ARM64 kaslr support - randomness, seeding and kdump
Message-ID: <20180409043138.GF19607@linaro.org>
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
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACi5LpPe_C0fLFzsAHPD54X=D+AsYjvSyZi0yt_6=wFrWmvetw@mail.gmail.com>
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

Hi,

On Mon, Apr 09, 2018 at 09:31:34AM +0530, Bhupesh Sharma wrote:
> Hi Akashi,
> 
> On Fri, Apr 6, 2018 at 7:39 AM, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> > Bhupesh,
> >
> > On Fri, Mar 16, 2018 at 03:05:10PM +0530, Bhupesh Sharma wrote:
> >> On Wed, Mar 14, 2018 at 11:54 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > On Wed, Mar 14, 2018 at 11:10:53AM +0900, AKASHI Takahiro wrote:
> >> >> If kaslr-seed has a critical value in terms of security, is kexec-tools
> >> >> a right place? It is exposed to user space albeit for a short time of period.
> >> >
> >> > The kernel zeroes the seed in the DT at boot time, so the current seed
> >> > isn't visible to userspace.
> >> >
> >> > If kexec-tools generates a seed, and inserts it into the DTB that it
> >> > loads, this is only visible to kexec tools or other applications which
> >> > can inspect its memory, so I don't think this is much of a concern.
> >> > Anything with such privilege can presumably kexec() to arbitrary code
> >> > anyhow.
> >> >
> >> > The next kernel will then zero its seed in the DT at boot time, so
> >> > similarly this won't be visible to userspace on the new kernel.
> >> >
> >> > FWIW, having kexec tools generate a seed for the kexec_load() case makes
> >> > sense to me.
> >>
> >> Fair enough. I will try to take a stab at the same and come back with
> >> my findings on this thread.
> >
> > How's your progress here?
> 
> I am almost done with the implementation.
> Unfortunately I lost most of the last week trying to revive my arm64
> board (which supports
> EFI_RNG_PROTOCOL and hence can be used to test the kaslr-seed related
> stuff), so I was not
> able to test the implementation.
> 
> Now that the board is up, I think I can test and thrash out any
> missing clogs in the approach.

Sounds good.

> > I've already added kaslr support (i.e. "virtual randomisation") to
> > my kexec_file patch set.
> > # just a few lines of code, though
> 
> Hmm, have you sent out a new version already (kexec_file_load), as the last
> version in my inbox still mentions in the cover letter that we need a
> EFI stub like approach
> to really support CONFIG_RANDOMIZE_BASE. Or, am I missing something?

No, not yet.
While I've also added some sort of "physical randomisation",
I'd like to put my post on hold until v4.17-rc1.

> I would love to have a look at the patch and try it at my end, so
> could you please share
> a pointer to the same.

Your test will be very much appreciated.

Thanks,
-Takahiro AKASHI
> 
> Regards,
> Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
