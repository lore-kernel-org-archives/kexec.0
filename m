Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88510C83F03
	for <kexec@archiver.kernel.org>; Wed,  9 Jul 2025 19:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Aaeh9D+ikwp3Ley13PFBlSUeZztV8T7mxhMfmSHKWK4=; b=eQL/kBGfkI5qzC/IulpMDwUEjo
	b8VIaVsGsH3Sd4VNtl0sKCLBej0LCBag9EOlPMkupihFpPnZsSxBJrgcBhZZMmRfB8b7fFD66rV17
	bi0sgRJcAxOjudKzqK1rSrbb2uIb/bRaNZlbm9Imog9mRalqBoWsOeG6dHQ9rnfvmxgJehqm0Gz9C
	9VeXeMberxSYiQJb9k7/+TUaCB2RJ5pJXxwGJApmaW7A1wV9TQX0os3M7TuaJ/gAVBwNOTSPafIS9
	Hv4DXN3nM+Rfnf1eWOg875j7efGvFvdQeWOVYbTnB2rdRnafkBFt67bHzEMy/IQ7I8wEksbz+3ek0
	Sv4B25Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZaFx-00000009gSW-2BVZ;
	Wed, 09 Jul 2025 19:15:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZY5Q-00000009NCn-0vYk
	for kexec@lists.infradead.org;
	Wed, 09 Jul 2025 16:56:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DC9D8434FA
	for <kexec@lists.infradead.org>; Wed,  9 Jul 2025 16:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBED0C4CEF6
	for <kexec@lists.infradead.org>; Wed,  9 Jul 2025 16:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752080159;
	bh=s/nX8zIHBhz7UzymyaWsPZGQQ2RKaw+8h1/MMQwig60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U/UdVOQXVmJEsmdVD1AsBg5HBpSzOUI1TZShH/yMS15dEBsXh5s+bL0yo+mHEuheF
	 NOnoZrImJwF7we9U6+7ESNJhAyMuj6q0SVmPymnLHmAon+EebWOQuSyftxKIE3J3jg
	 f3HkXB7x61Bq4BgvxWKe4Fdsqxat+YPN2qr6h07ErO9iOL0FEcoku1BCfSnl9l2tsh
	 q4bxTS+v8pI68sL3lpCT/Bpwn7CobJpyV1PRSKrkVjMdMqVx7aYWqy4urXLnLVykaQ
	 1y0REjV4M/7UDXzYfF9KnMiKyLtOpGrA0Qw9bHkwnaal2fpuqhtg1kvcZPEG/teStJ
	 V4rRR2i9WyFPA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6120049f09fso58743eaf.2
        for <kexec@lists.infradead.org>; Wed, 09 Jul 2025 09:55:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUV1D7p6WHTcI9WP6W1w1/iF1eW/kbtPV1BUzyapNa5xw/pzouF0lRtf//bwpX+hjVIVVz5HA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwQ8p3Z3KfyjfmzGh+f89up/7kCIgv7643pZnof4fr6O90rZgcI
	Q4iKU79B5RtOSACG0QCBSJVNIGrmE7DZ8hM3BROzai6lxwA9fcOX6TQgb5Qj51OxKmHcdHpN/hI
	a7zKNZVXEyUExymlTpUetD4ZyTjuMKsE=
X-Google-Smtp-Source: AGHT+IHxv3XyTmAE7BWnt5snY9w8QZkCASN2KwEpMUnGi9WrPdGJGGZnolR2Q0GJi5QXAyrvQ+bxSShfBvGLYf4yfn0=
X-Received: by 2002:a05:6871:2b1c:b0:2b8:e4b9:47a3 with SMTP id
 586e51a60fabf-2fef871c3e8mr2134957fac.22.1752080158987; Wed, 09 Jul 2025
 09:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250708000215.793090-1-sashal@kernel.org> <20250708000215.793090-6-sashal@kernel.org>
 <87ms9esclp.fsf@email.froward.int.ebiederm.org> <aG2AcbhWmFwaHT6C@lappy>
 <87tt3mqrtg.fsf@email.froward.int.ebiederm.org> <aG2bAMGrDDSvOhbl@lappy>
 <87ms9dpc3b.fsf@email.froward.int.ebiederm.org> <29441021-5758-4565-b120-e9713c58f6d8@amd.com>
In-Reply-To: <29441021-5758-4565-b120-e9713c58f6d8@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Jul 2025 18:55:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gWD+pnkhWbW0ZF8+5PYxX6qRbeNoRuVo=CpwmMMLFjDg@mail.gmail.com>
X-Gm-Features: Ac12FXx_bufmZGZgpHOzEG3RZctbXShNv4NKhZDCMLVWf0RX27NUB7NRU_usyCE
Message-ID: <CAJZ5v0gWD+pnkhWbW0ZF8+5PYxX6qRbeNoRuVo=CpwmMMLFjDg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
 suspend sequence
To: Mario Limonciello <mario.limonciello@amd.com>, Sasha Levin <sashal@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, patches@lists.linux.dev, stable@vger.kernel.org, 
	Nat Wittstock <nat@fardog.io>, Lucian Langa <lucilanga@7pot.org>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, rafael@kernel.org, pavel@ucw.cz, 
	len.brown@intel.com, linux-pm@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250709_095600_299503_AE3A75CD 
X-CRM114-Status: GOOD (  51.52  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Jul 9, 2025 at 6:35=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 7/9/2025 12:23 PM, Eric W. Biederman wrote:
> > Sasha Levin <sashal@kernel.org> writes:
> >
> >> On Tue, Jul 08, 2025 at 04:46:19PM -0500, Eric W. Biederman wrote:
> >>> Sasha Levin <sashal@kernel.org> writes:
> >>>
> >>>> On Tue, Jul 08, 2025 at 02:32:02PM -0500, Eric W. Biederman wrote:
> >>>>>
> >>>>> Wow!
> >>>>>
> >>>>> Sasha I think an impersonator has gotten into your account, and
> >>>>> is just making nonsense up.
> >>>>
> >>>> https://lore.kernel.org/all/aDXQaq-bq5BMMlce@lappy/
> >>>
> >>> It is nice it is giving explanations for it's backporting decisions.
> >>>
> >>> It would be nicer if those explanations were clearly marked as
> >>> coming from a non-human agent, and did not read like a human being
> >>> impatient for a patch to be backported.
> >>
> >> Thats a fair point. I'll add "LLM Analysis:" before the explanation to
> >> future patches.
> >>
> >>> Further the machine given explanations were clearly wrong.  Do you ha=
ve
> >>> plans to do anything about that?  Using very incorrect justifications
> >>> for backporting patches is scary.
> >>
> >> Just like in the past 8 years where AUTOSEL ran without any explanatio=
n
> >> whatsoever, the patches are manually reviewed and tested prior to bein=
g
> >> included in the stable tree.
> >
> > I believe there is some testing done.  However for a lot of what I see
> > go by I would be strongly surprised if there is actually much manual
> > review.
> >
> > I expect there is a lot of the changes are simply ignored after a quick
> > glance because people don't know what is going on, or they are of too
> > little consequence to spend time on.
> >
> >> I don't make a point to go back and correct the justification, it's
> >> there more to give some idea as to why this patch was marked for
> >> review and may be completely bogus (in which case I'll drop the patch)=
.
> >>
> >> For that matter, I'd often look at the explanation only if I don't ful=
ly
> >> understand why a certain patch was selected. Most often I just use it =
as
> >> a "Yes/No" signal.
> >>
> >> In this instance I honestly haven't read the LLM explanation. I agree
> >> with you that the explanation is flawed, but the patch clearly fixes a
> >> problem:
> >>
> >>      "On AMD dGPUs this can lead to failed suspends under memory
> >>      pressure situations as all VRAM must be evicted to system memory
> >>      or swap."
> >>
> >> So it was included in the AUTOSEL patchset.
> >
> >
> >> Do you have an objection to this patch being included in -stable? So f=
ar
> >> your concerns were about the LLM explanation rather than actual patch.
> >
> > Several objections.
> > - The explanation was clearly bogus.
> > - The maintainer takes alarm.
> > - The patch while small, is not simple and not obviously correct.
> > - The patch has not been thoroughly tested.
> >
> > I object because the code does not appear to have been well tested
> > outside of the realm of fixing the issue.
> >
> > There is no indication that the kexec code path has ever been exercised=
.
> >
> > So this appears to be one of those changes that was merged under
> > the banner of "Let's see if this causes a regression".>
> > To the original authors.  I would have appreciated it being a little
> > more clearly called out in the change description that this came in
> > under "Let's see if this causes a regression".
> >
>
> As the original author of this patch I don't feel this patch is any
> different than any other patch in that regard.
> I don't write in a commit message the expected risk of a patch.
>
> There are always people that find interesting ways to exercise it and
> they could find problems that I didn't envision.
>
> > Such changes should not be backported automatically.  They should be
> > backported with care after the have seen much more usage/testing of
> > the kernel they were merged into.  Probably after a kernel release or
> > so.  This is something that can take some actual judgment to decide,
> > when a backport is reasonable.
>
> TBH - I didn't include stable in the commit message with the intent that
> after this baked a cycle or so that we could bring it back later if
> AUTOSEL hadn't picked it up by then.

I actually see an issue in this patch that I have overlooked
previously, so Sasha and "stable" folks - please drop this one.

Namely, the change in dpm_resume_end() is going too far.

> It's a real issue people have complained about for years that is
> non-obvious where the root cause is.
>
> Once we're all confident on this I'd love to discuss bringing it back
> even further to LTS kernels if it's viable.

Sure.

