Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ve0-x232.google.com ([2607:f8b0:400c:c01::232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJkVb-0005l9-Dr
 for kexec@lists.infradead.org; Wed, 11 Sep 2013 13:31:05 +0000
Received: by mail-ve0-f178.google.com with SMTP id jw12so5920680veb.9
 for <kexec@lists.infradead.org>; Wed, 11 Sep 2013 06:30:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130911090135.GB359@x4>
References: <20130908120947.GA360@x4> <87bo42eswi.fsf@xmission.com>
 <20130909092140.GA359@x4> <522D972D.5090805@vodafone.de>
 <20130911090135.GB359@x4>
Date: Wed, 11 Sep 2013 09:30:40 -0400
Message-ID: <CADnq5_M5-jGvjv=BBR1+T4RN_WUbSqpkiOCepAbj7vH_9phE-g@mail.gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: =?ISO-8859-1?Q?Christian_K=F6nig?= <deathsimple@vodafone.de>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>

On Wed, Sep 11, 2013 at 5:01 AM, Markus Trippelsdorf
<markus@trippelsdorf.de> wrote:
> On 2013.09.09 at 11:38 +0200, Christian K=F6nig wrote:
>> Am 09.09.2013 11:21, schrieb Markus Trippelsdorf:
>> > On 2013.09.08 at 17:32 -0700, Eric W. Biederman wrote:
>> >> Markus Trippelsdorf <markus@trippelsdorf.de> writes:
>> >>
>> >>> Here are a couple of patches that get kexec working with radeon devi=
ces.
>> >>> I've tested this on my RS780.
>> >>> Comments or flames are welcome.
>> >>> Thanks.
>> >> A couple of high level comments.
>> >>
>> >> This looks promising for the usual case.
>> >>
>> >> Removing the printk at the end of the kexec path seems a little dubio=
us,
>> >> what of other cpus, interrupt handlers, etc.  Basically estabilishing=
 a
>> >> new rule on when printk is allowed seems a little dubious at this poi=
nt,
>> >> even if it is a useful debugging trick.
>> > OK. I will drop this patch. It doesn't seem to be necessary, because I
>> > cannot reproduce the printk related hang anymore.
>> >
>> >> Having a clean shutdown of the radeon definitely seems worth doing,
>> >> because the cases where we care abouty video are when a person is in
>> >> front of the system.
>> > Yes. But please note that even with radeon_pci_shutdown implemented, I
>> > still get ring test failures on roughly every eighth kexec boot:
>> >
>> >   [drm:r600_dma_ring_test] *ERROR* radeon: ring 3 test failed (0xCAFED=
EAD)
>> >   radeon 0000:01:05.0: disabling GPU acceleration
>> >
>> > That's definitely better than the current state of affairs, with ring
>> > test failures on every second boot. But I haven't figured out the reas=
on
>> > for these failures yet. It's curious that once a ring test failure
>> > occurs, it will reliably fail after each kexec invocation, no matter h=
ow
>> > often repeated. Only a reboot brings the machine back to normal.
>>
>> The main problem here is that the AMD gfx hardware doesn't really
>> support being reinitialized once booted (for various reasons). It's a
>> (intended) limitation of the hardware design that you can only
>> initialize certain blocks once every power cycle, so the whole approach
>> actually will never work 100% reliable.
>>
>> All you can hope for is that stopping the hardware while shutting down
>> the old kernel and starting it again results in exactly the same
>> hardware parameters (offsets, clock etc...) otherwise starting the
>> blocks will just fail and you end up with disabled acceleration like abo=
ve.
>>
>> Sorry, but there isn't much we can do about this,
>
> I've tested this further and it turned out that if I revert commit
> f5d9b7f0f9 on top of my "drm/radeon: Implement radeon_pci_shutdown"
> patch, the initialization failures seem to go away completely.
>
> Any idea what's going on?
>

You are disabling dynamic power management with that patch reverted.
The patch fixed a copy paste typo in the register.  Bit 0
(SCLK_PWRMGT_OFF) of register SCLK_PWRMGT_CNTL controls whether
dynamic engine clock control is enabled.  Bit 0 (GLOBAL_PWRMGT_EN) of
register GENERAL_PWRMGT controls whether dynamic power management
(dynamic engine/memory/voltage, controls etc.) is enabled at all.

Alex

> Here's the patch:
>
> diff --git a/drivers/gpu/drm/radeon/r600_dpm.c b/drivers/gpu/drm/radeon/r=
600_dpm.c
> index fa0de46..4e8c1988 100644
> --- a/drivers/gpu/drm/radeon/r600_dpm.c
> +++ b/drivers/gpu/drm/radeon/r600_dpm.c
> @@ -296,9 +296,9 @@ bool r600_dynamicpm_enabled(struct radeon_device *rde=
v)
>  void r600_enable_sclk_control(struct radeon_device *rdev, bool enable)
>  {
>         if (enable)
> -               WREG32_P(SCLK_PWRMGT_CNTL, 0, ~SCLK_PWRMGT_OFF);
> +               WREG32_P(GENERAL_PWRMGT, 0, ~SCLK_PWRMGT_OFF);
>         else
> -               WREG32_P(SCLK_PWRMGT_CNTL, SCLK_PWRMGT_OFF, ~SCLK_PWRMGT_=
OFF);
> +               WREG32_P(GENERAL_PWRMGT, SCLK_PWRMGT_OFF, ~SCLK_PWRMGT_OF=
F);
>  }
>
>  void r600_enable_mclk_control(struct radeon_device *rdev, bool enable)
>
>
> --
> Markus
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
