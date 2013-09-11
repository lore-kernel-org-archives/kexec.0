Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mxout.vodafone.de ([80.84.1.40] helo=smtp-01.vodafone.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJgcF-0008K0-30
 for kexec@lists.infradead.org; Wed, 11 Sep 2013 09:21:40 +0000
Message-ID: <5230360B.90902@vodafone.de>
Date: Wed, 11 Sep 2013 11:21:15 +0200
From: =?ISO-8859-1?Q?Christian_K=F6nig?= <deathsimple@vodafone.de>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] drm/radeon kexec fixes
References: <20130908120947.GA360@x4> <87bo42eswi.fsf@xmission.com>
 <20130909092140.GA359@x4>
 <CADnq5_Oyd0hyr+WFYuA=a9Pa3i2e_ZY+Oc7LPawn8gSz3KPHUA@mail.gmail.com>
 <87ppsg8rbk.fsf@xmission.com>
 <CADnq5_MH3+VeLZzpRmHtU-BZzL680e_0577wk0honT002+3GZQ@mail.gmail.com>
 <20130911085306.GA359@x4>
In-Reply-To: <20130911085306.GA359@x4>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Alex Deucher <alexdeucher@gmail.com>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>

Am 11.09.2013 10:53, schrieb Markus Trippelsdorf:
> On 2013.09.10 at 16:40 -0400, Alex Deucher wrote:
>> On Tue, Sep 10, 2013 at 2:27 PM, Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>>> Alex Deucher <alexdeucher@gmail.com> writes:
>>>
>>>> On Mon, Sep 9, 2013 at 5:21 AM, Markus Trippelsdorf
>>>> <markus@trippelsdorf.de> wrote:
>>>>
>>>>> IIRC Alex said the sanity checks are expensive and boot-time could be
>>>>> improved by dropping them. Maybe he can chime in?
>>>> They shouldn't be necessary with a proper shutdown, but in this
>>>> particular case, they are not very expensive.  What is expensive is
>>>> having a separate sanity check functions for all the various hw blocks
>>>> to teardown everything on startup prior to starting it up in case
>>>> kexec, etc. left the system in a bad state.  It ends up amounting to a
>>>> full tear down sequence followed by a full start up sequence every
>>>> time you load the driver.
>>>>
>>>> I can't really comment on the first patch, but the rest seem fine.
>>> Let me reask the question just a little bit.
>>>
>>> Is it the sanity checks that are expensive?  Or is it the
>>> reinitialization that is triggered by the sanity checks that is
>>> expensive?
>>>
>>>  From what Christian said in the other reply it sounds like this is a
>>> game we will never completely win, but it would be nice to have half a
>>> chance in the kexec on panic case to have video.  So I am curious to
>>> know if the checks are expensive when we are coming at hardware in a
>>> clean state.
>> The particular sanity checks from this patch set are not expensive,
>> but we had previously discussed more extensive sanity checks for other
>> aspects of the chips in prior conversations.  Prior to this patch set,
>> the hw is not torn down properly (might have been in the middle of DMA
>> for example) when kexec happens.  That's why the sanity checks were
>> added in the first place.  With this patch set, the sanity checks
>> shouldn't be necessary.
> I think you're talking past each other.
> What Eric worries about is the =BBkexec on panic=AB case, where the shutd=
own
> method *isn't* called. In this case the sanity checks, that are only
> superfluous when the hardware was shutdown normally during kexec (the
> default case), may actually help. And because the checks aren't
> expensive, it wouldn't hurt to just leave them in place.

When we don't know the state the hardware is in it is really hard to get =

into a working configuration again, even with the sanity checks in place.

For example you can't just cut power or reset the UVD block without =

knowing it's state, cause then you have a good chance that you hit into =

the middle of a register or memory access of the VCPU. This usually =

results in the next few registers accesses only return either 0x0 or =

0xffffffff and after that the system completely locks up.

Isn't it possible to know that we are in a "kexec after panic" case and =

only try to initialize the display hardware and not all the other =

blocks? That would at least allow us to get an error message of what =

happened on the screen and otherwise advise the user to do a clean reset.

Christian.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
