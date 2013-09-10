Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJSgG-0005ax-8e
 for kexec@lists.infradead.org; Tue, 10 Sep 2013 18:28:53 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130908120947.GA360@x4> <87bo42eswi.fsf@xmission.com>
 <20130909092140.GA359@x4>
 <CADnq5_Oyd0hyr+WFYuA=a9Pa3i2e_ZY+Oc7LPawn8gSz3KPHUA@mail.gmail.com>
Date: Tue, 10 Sep 2013 11:27:59 -0700
In-Reply-To: <CADnq5_Oyd0hyr+WFYuA=a9Pa3i2e_ZY+Oc7LPawn8gSz3KPHUA@mail.gmail.com>
 (Alex Deucher's message of "Mon, 9 Sep 2013 09:04:01 -0400")
Message-ID: <87ppsg8rbk.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] drm/radeon kexec fixes
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Christian =?utf-8?Q?K=C3=B6nig?= <deathsimple@vodafone.de>, kexec@lists.infradead.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Markus Trippelsdorf <markus@trippelsdorf.de>

Alex Deucher <alexdeucher@gmail.com> writes:

> On Mon, Sep 9, 2013 at 5:21 AM, Markus Trippelsdorf
> <markus@trippelsdorf.de> wrote:
>
>> IIRC Alex said the sanity checks are expensive and boot-time could be
>> improved by dropping them. Maybe he can chime in?
>
> They shouldn't be necessary with a proper shutdown, but in this
> particular case, they are not very expensive.  What is expensive is
> having a separate sanity check functions for all the various hw blocks
> to teardown everything on startup prior to starting it up in case
> kexec, etc. left the system in a bad state.  It ends up amounting to a
> full tear down sequence followed by a full start up sequence every
> time you load the driver.
>
> I can't really comment on the first patch, but the rest seem fine.

Let me reask the question just a little bit.

Is it the sanity checks that are expensive?  Or is it the
reinitialization that is triggered by the sanity checks that is
expensive?

From what Christian said in the other reply it sounds like this is a
game we will never completely win, but it would be nice to have half a
chance in the kexec on panic case to have video.  So I am curious to
know if the checks are expensive when we are coming at hardware in a
clean state.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
