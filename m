Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VIpQ4-0001Em-Tc
 for kexec@lists.infradead.org; Mon, 09 Sep 2013 00:33:33 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130908120947.GA360@x4>
Date: Sun, 08 Sep 2013 17:32:45 -0700
In-Reply-To: <20130908120947.GA360@x4> (Markus Trippelsdorf's message of "Sun, 
 8 Sep 2013 14:09:47 +0200")
Message-ID: <87bo42eswi.fsf@xmission.com>
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
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Alex Deucher <alexdeucher@gmail.com>, kexec@lists.infradead.org, dri-devel@lists.freedesktop.org

Markus Trippelsdorf <markus@trippelsdorf.de> writes:

> Here are a couple of patches that get kexec working with radeon devices.
> I've tested this on my RS780. 
> Comments or flames are welcome.
> Thanks.

A couple of high level comments.

This looks promising for the usual case.

Removing the printk at the end of the kexec path seems a little dubious,
what of other cpus, interrupt handlers, etc.  Basically estabilishing a
new rule on when printk is allowed seems a little dubious at this point,
even if it is a useful debugging trick.

Having a clean shutdown of the radeon definitely seems worth doing,
because the cases where we care abouty video are when a person is in
front of the system.

I don't know if you want to remove the sanity checks.  They seem cheap
and safe regardless.  Are they expensive or ineffective?  Moreover if
they work a reasonable amount of the time that means that the kexec on
panic case (where we don't shut anything down) can actually use the
video, and that in general the driver will be more robust.  I don't
expect anyone much cares as kexec on panic is mostly used to just write
a core file to the network, or the local disk.  But if it is easy to
keep that case working most of the time, why not.

Eric

> Markus Trippelsdorf (3):
>   kexec: get rid of late printk
>   drm/radeon: Implement radeon_pci_shutdown
>   drm/radeon: get rid of r100_restore_sanity hack
>
>  drivers/gpu/drm/radeon/r100.c        | 27 ---------------------------
>  drivers/gpu/drm/radeon/r300.c        |  2 --
>  drivers/gpu/drm/radeon/r420.c        |  2 --
>  drivers/gpu/drm/radeon/r520.c        |  2 --
>  drivers/gpu/drm/radeon/radeon_asic.h |  1 -
>  drivers/gpu/drm/radeon/radeon_drv.c  | 10 ++++++++++
>  drivers/gpu/drm/radeon/rs400.c       |  2 --
>  drivers/gpu/drm/radeon/rs600.c       |  2 --
>  drivers/gpu/drm/radeon/rs690.c       |  2 --
>  drivers/gpu/drm/radeon/rv515.c       |  2 --
>  kernel/kexec.c                       |  1 -
>  11 files changed, 10 insertions(+), 43 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
