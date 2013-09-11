Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ud10.udmedia.de ([194.117.254.50] helo=mail.ud10.udmedia.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJgB0-0007fH-6e
 for kexec@lists.infradead.org; Wed, 11 Sep 2013 08:53:31 +0000
Date: Wed, 11 Sep 2013 10:53:06 +0200
From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [PATCH 0/3] drm/radeon kexec fixes
Message-ID: <20130911085306.GA359@x4>
References: <20130908120947.GA360@x4> <87bo42eswi.fsf@xmission.com>
 <20130909092140.GA359@x4>
 <CADnq5_Oyd0hyr+WFYuA=a9Pa3i2e_ZY+Oc7LPawn8gSz3KPHUA@mail.gmail.com>
 <87ppsg8rbk.fsf@xmission.com>
 <CADnq5_MH3+VeLZzpRmHtU-BZzL680e_0577wk0honT002+3GZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADnq5_MH3+VeLZzpRmHtU-BZzL680e_0577wk0honT002+3GZQ@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>

On 2013.09.10 at 16:40 -0400, Alex Deucher wrote:
> On Tue, Sep 10, 2013 at 2:27 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
> > Alex Deucher <alexdeucher@gmail.com> writes:
> >
> >> On Mon, Sep 9, 2013 at 5:21 AM, Markus Trippelsdorf
> >> <markus@trippelsdorf.de> wrote:
> >>
> >>> IIRC Alex said the sanity checks are expensive and boot-time could be
> >>> improved by dropping them. Maybe he can chime in?
> >>
> >> They shouldn't be necessary with a proper shutdown, but in this
> >> particular case, they are not very expensive.  What is expensive is
> >> having a separate sanity check functions for all the various hw blocks
> >> to teardown everything on startup prior to starting it up in case
> >> kexec, etc. left the system in a bad state.  It ends up amounting to a
> >> full tear down sequence followed by a full start up sequence every
> >> time you load the driver.
> >>
> >> I can't really comment on the first patch, but the rest seem fine.
> >
> > Let me reask the question just a little bit.
> >
> > Is it the sanity checks that are expensive?  Or is it the
> > reinitialization that is triggered by the sanity checks that is
> > expensive?
> >
> > From what Christian said in the other reply it sounds like this is a
> > game we will never completely win, but it would be nice to have half a
> > chance in the kexec on panic case to have video.  So I am curious to
> > know if the checks are expensive when we are coming at hardware in a
> > clean state.
> =

> The particular sanity checks from this patch set are not expensive,
> but we had previously discussed more extensive sanity checks for other
> aspects of the chips in prior conversations.  Prior to this patch set,
> the hw is not torn down properly (might have been in the middle of DMA
> for example) when kexec happens.  That's why the sanity checks were
> added in the first place.  With this patch set, the sanity checks
> shouldn't be necessary.

I think you're talking past each other. =

What Eric worries about is the =BBkexec on panic=AB case, where the shutdown
method *isn't* called. In this case the sanity checks, that are only
superfluous when the hardware was shutdown normally during kexec (the
default case), may actually help. And because the checks aren't
expensive, it wouldn't hurt to just leave them in place.

-- =

Markus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
