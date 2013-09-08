Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ud10.udmedia.de ([194.117.254.50] helo=mail.ud10.udmedia.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VIdoq-0001ya-3q
 for kexec@lists.infradead.org; Sun, 08 Sep 2013 12:10:21 +0000
Date: Sun, 8 Sep 2013 14:09:47 +0200
From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: [PATCH 0/3] drm/radeon kexec fixes
Message-ID: <20130908120947.GA360@x4>
MIME-Version: 1.0
Content-Disposition: inline
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
To: dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexdeucher@gmail.com>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>

Here are a couple of patches that get kexec working with radeon devices.
I've tested this on my RS780. 
Comments or flames are welcome.
Thanks.

Markus Trippelsdorf (3):
  kexec: get rid of late printk
  drm/radeon: Implement radeon_pci_shutdown
  drm/radeon: get rid of r100_restore_sanity hack

 drivers/gpu/drm/radeon/r100.c        | 27 ---------------------------
 drivers/gpu/drm/radeon/r300.c        |  2 --
 drivers/gpu/drm/radeon/r420.c        |  2 --
 drivers/gpu/drm/radeon/r520.c        |  2 --
 drivers/gpu/drm/radeon/radeon_asic.h |  1 -
 drivers/gpu/drm/radeon/radeon_drv.c  | 10 ++++++++++
 drivers/gpu/drm/radeon/rs400.c       |  2 --
 drivers/gpu/drm/radeon/rs600.c       |  2 --
 drivers/gpu/drm/radeon/rs690.c       |  2 --
 drivers/gpu/drm/radeon/rv515.c       |  2 --
 kernel/kexec.c                       |  1 -
 11 files changed, 10 insertions(+), 43 deletions(-)

-- 
Markus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
