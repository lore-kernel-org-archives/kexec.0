Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ud10.udmedia.de ([194.117.254.50] helo=mail.ud10.udmedia.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJgJB-0007uL-QI
 for kexec@lists.infradead.org; Wed, 11 Sep 2013 09:01:58 +0000
Date: Wed, 11 Sep 2013 11:01:35 +0200
From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [PATCH 0/3] drm/radeon kexec fixes
Message-ID: <20130911090135.GB359@x4>
References: <20130908120947.GA360@x4> <87bo42eswi.fsf@xmission.com>
 <20130909092140.GA359@x4> <522D972D.5090805@vodafone.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <522D972D.5090805@vodafone.de>
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
To: Christian =?iso-8859-1?Q?K=F6nig?= <deathsimple@vodafone.de>
Cc: kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, dri-devel@lists.freedesktop.org

On 2013.09.09 at 11:38 +0200, Christian K=F6nig wrote:
> Am 09.09.2013 11:21, schrieb Markus Trippelsdorf:
> > On 2013.09.08 at 17:32 -0700, Eric W. Biederman wrote:
> >> Markus Trippelsdorf <markus@trippelsdorf.de> writes:
> >>
> >>> Here are a couple of patches that get kexec working with radeon devic=
es.
> >>> I've tested this on my RS780.
> >>> Comments or flames are welcome.
> >>> Thanks.
> >> A couple of high level comments.
> >>
> >> This looks promising for the usual case.
> >>
> >> Removing the printk at the end of the kexec path seems a little dubiou=
s,
> >> what of other cpus, interrupt handlers, etc.  Basically estabilishing a
> >> new rule on when printk is allowed seems a little dubious at this poin=
t,
> >> even if it is a useful debugging trick.
> > OK. I will drop this patch. It doesn't seem to be necessary, because I
> > cannot reproduce the printk related hang anymore.
> >
> >> Having a clean shutdown of the radeon definitely seems worth doing,
> >> because the cases where we care abouty video are when a person is in
> >> front of the system.
> > Yes. But please note that even with radeon_pci_shutdown implemented, I
> > still get ring test failures on roughly every eighth kexec boot:
> >
> >   [drm:r600_dma_ring_test] *ERROR* radeon: ring 3 test failed (0xCAFEDE=
AD)
> >   radeon 0000:01:05.0: disabling GPU acceleration
> >
> > That's definitely better than the current state of affairs, with ring
> > test failures on every second boot. But I haven't figured out the reason
> > for these failures yet. It's curious that once a ring test failure
> > occurs, it will reliably fail after each kexec invocation, no matter how
> > often repeated. Only a reboot brings the machine back to normal.
> =

> The main problem here is that the AMD gfx hardware doesn't really =

> support being reinitialized once booted (for various reasons). It's a =

> (intended) limitation of the hardware design that you can only =

> initialize certain blocks once every power cycle, so the whole approach =

> actually will never work 100% reliable.
> =

> All you can hope for is that stopping the hardware while shutting down =

> the old kernel and starting it again results in exactly the same =

> hardware parameters (offsets, clock etc...) otherwise starting the =

> blocks will just fail and you end up with disabled acceleration like abov=
e.
> =

> Sorry, but there isn't much we can do about this,

I've tested this further and it turned out that if I revert commit
f5d9b7f0f9 on top of my "drm/radeon: Implement radeon_pci_shutdown"
patch, the initialization failures seem to go away completely.

Any idea what's going on?

Here's the patch:

diff --git a/drivers/gpu/drm/radeon/r600_dpm.c b/drivers/gpu/drm/radeon/r60=
0_dpm.c
index fa0de46..4e8c1988 100644
--- a/drivers/gpu/drm/radeon/r600_dpm.c
+++ b/drivers/gpu/drm/radeon/r600_dpm.c
@@ -296,9 +296,9 @@ bool r600_dynamicpm_enabled(struct radeon_device *rdev)
 void r600_enable_sclk_control(struct radeon_device *rdev, bool enable)
 {
 	if (enable)
-		WREG32_P(SCLK_PWRMGT_CNTL, 0, ~SCLK_PWRMGT_OFF);
+		WREG32_P(GENERAL_PWRMGT, 0, ~SCLK_PWRMGT_OFF);
 	else
-		WREG32_P(SCLK_PWRMGT_CNTL, SCLK_PWRMGT_OFF, ~SCLK_PWRMGT_OFF);
+		WREG32_P(GENERAL_PWRMGT, SCLK_PWRMGT_OFF, ~SCLK_PWRMGT_OFF);
 }
 =

 void r600_enable_mclk_control(struct radeon_device *rdev, bool enable)


-- =

Markus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
