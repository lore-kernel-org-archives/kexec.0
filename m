Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jroZE-0003dy-C5
 for kexec@lists.infradead.org; Sat, 04 Jul 2020 20:15:21 +0000
Received: by mail-qv1-f71.google.com with SMTP id a12so17059685qvt.22
 for <kexec@lists.infradead.org>; Sat, 04 Jul 2020 13:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <1586212300-30797-1-git-send-email-bhsharma@redhat.com>
 <20200408104655.GA92698@C02TD0UTHF1T.local>
 <CACi5LpP0WqYGxrJL6BJia-ceSR5XbjytsSY+P74xaDJZTJA8jA@mail.gmail.com>
 <20200428100710.GD3868@gaia>
 <CACi5LpPW2zmq0-UDnU_115ePxXKWG+1i6UciVWPpq=PzQHrkOw@mail.gmail.com>
 <CACi5LpMnbFbmqWOn0GfPD2H50UcZ0XHQ7X+Cd0E-cS-zfL7tQQ@mail.gmail.com>
 <CACi5LpPcPoVwWBviuCfCri1xQSc34iXkQ8BTcTqXDEcYHSuoEQ@mail.gmail.com>
 <20200703163844.GD14950@gaia>
In-Reply-To: <20200703163844.GD14950@gaia>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Sun, 5 Jul 2020 01:45:01 +0530
Message-ID: <CACi5LpNWJNTGpBXAP7rR-9yVmnVSgJddwo25fGeirOthrguwHA@mail.gmail.com>
Subject: Re: [PATCH] arm64/defconfig: Enable CONFIG_KEXEC_FILE
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, kexec mailing list <kexec@lists.infradead.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, arm@kernel.org, James Morse <james.morse@arm.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Will Deacon <will@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Fri, Jul 3, 2020 at 10:09 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Jul 03, 2020 at 12:55:03AM +0530, Bhupesh Sharma wrote:
> > On Fri, May 15, 2020 at 2:44 PM Bhupesh Sharma <bhsharma@redhat.com> wrote:
> > > On Thu, Apr 30, 2020 at 10:05 AM Bhupesh Sharma <bhsharma@redhat.com> wrote:
> > > > On Tue, Apr 28, 2020 at 3:37 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > >
> > > > > On Tue, Apr 28, 2020 at 01:55:58PM +0530, Bhupesh Sharma wrote:
> > > > > > On Wed, Apr 8, 2020 at 4:17 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > > > On Tue, Apr 07, 2020 at 04:01:40AM +0530, Bhupesh Sharma wrote:
> > > > > > > >  arch/arm64/configs/defconfig | 1 +
> > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > >
> > > > > > > > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > > > > > > > index 24e534d85045..fa122f4341a2 100644
> > > > > > > > --- a/arch/arm64/configs/defconfig
> > > > > > > > +++ b/arch/arm64/configs/defconfig
> > > > > > > > @@ -66,6 +66,7 @@ CONFIG_SCHED_SMT=y
> > > > > > > >  CONFIG_NUMA=y
> > > > > > > >  CONFIG_SECCOMP=y
> > > > > > > >  CONFIG_KEXEC=y
> > > > > > > > +CONFIG_KEXEC_FILE=y
> > > > > > > >  CONFIG_CRASH_DUMP=y
> > > > > > > >  CONFIG_XEN=y
> > > > > > > >  CONFIG_COMPAT=y
> > > > > > > > --
> > > > > > > > 2.7.4
> > > > > >
> > > > > > Thanks a lot  Mark.
> > > > > >
> > > > > > Hi Catalin, Will,
> > > > > >
> > > > > > Can you please help pick this patch in the arm tree. We have an
> > > > > > increasing number of user-cases from distro users
> > > > > > who want to use kexec_file_load() as the default interface for
> > > > > > kexec/kdump on arm64.
> > > > >
> > > > > We could pick it up if it doesn't conflict with the arm-soc tree. They
> > > > > tend to pick most of the defconfig changes these days (and could as well
> > > > > pick this one).
> > > >
> > > > Thanks Catalin.
> > > > (+Cc Arnd)
> > > >
> > > > Hi Arnd,
> > > >
> > > > Can you please help pick this change via the arm-soc tree?
> > >
> > > Ping. Any updates on this defconfig patch.
> >
> > Ping. Seems there is no reply from Arnd on this patch.
> > Can you please help pull in this one as well. It has been pending for
> > quite some time now.
>
> I can queue it for 5.9.

Many thanks, Catalin.

Regards,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
