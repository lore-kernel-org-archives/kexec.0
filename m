Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-vb0-x229.google.com ([2607:f8b0:400c:c02::229])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJUjm-0000HS-9B
 for kexec@lists.infradead.org; Tue, 10 Sep 2013 20:40:39 +0000
Received: by mail-vb0-f41.google.com with SMTP id g17so5436727vbg.14
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2013 13:40:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87ppsg8rbk.fsf@xmission.com>
References: <20130908120947.GA360@x4> <87bo42eswi.fsf@xmission.com>
 <20130909092140.GA359@x4>
 <CADnq5_Oyd0hyr+WFYuA=a9Pa3i2e_ZY+Oc7LPawn8gSz3KPHUA@mail.gmail.com>
 <87ppsg8rbk.fsf@xmission.com>
Date: Tue, 10 Sep 2013 16:40:16 -0400
Message-ID: <CADnq5_MH3+VeLZzpRmHtU-BZzL680e_0577wk0honT002+3GZQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/radeon kexec fixes
From: Alex Deucher <alexdeucher@gmail.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: =?ISO-8859-1?Q?Christian_K=F6nig?= <deathsimple@vodafone.de>, kexec@lists.infradead.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Markus Trippelsdorf <markus@trippelsdorf.de>

On Tue, Sep 10, 2013 at 2:27 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Alex Deucher <alexdeucher@gmail.com> writes:
>
>> On Mon, Sep 9, 2013 at 5:21 AM, Markus Trippelsdorf
>> <markus@trippelsdorf.de> wrote:
>>
>>> IIRC Alex said the sanity checks are expensive and boot-time could be
>>> improved by dropping them. Maybe he can chime in?
>>
>> They shouldn't be necessary with a proper shutdown, but in this
>> particular case, they are not very expensive.  What is expensive is
>> having a separate sanity check functions for all the various hw blocks
>> to teardown everything on startup prior to starting it up in case
>> kexec, etc. left the system in a bad state.  It ends up amounting to a
>> full tear down sequence followed by a full start up sequence every
>> time you load the driver.
>>
>> I can't really comment on the first patch, but the rest seem fine.
>
> Let me reask the question just a little bit.
>
> Is it the sanity checks that are expensive?  Or is it the
> reinitialization that is triggered by the sanity checks that is
> expensive?
>
> From what Christian said in the other reply it sounds like this is a
> game we will never completely win, but it would be nice to have half a
> chance in the kexec on panic case to have video.  So I am curious to
> know if the checks are expensive when we are coming at hardware in a
> clean state.

The particular sanity checks from this patch set are not expensive,
but we had previously discussed more extensive sanity checks for other
aspects of the chips in prior conversations.  Prior to this patch set,
the hw is not torn down properly (might have been in the middle of DMA
for example) when kexec happens.  That's why the sanity checks were
added in the first place.  With this patch set, the sanity checks
shouldn't be necessary.

Alex

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
