Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ud10.udmedia.de ([194.117.254.50] helo=mail.ud10.udmedia.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VIdqL-000228-Bs
 for kexec@lists.infradead.org; Sun, 08 Sep 2013 12:11:54 +0000
Date: Sun, 8 Sep 2013 14:11:30 +0200
From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: [PATCH 3/3] drm/radeon: get rid of r100_restore_sanity hack
Message-ID: <20130908121130.GD360@x4>
References: <20130908120947.GA360@x4>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130908120947.GA360@x4>
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

Now that radeon devices are properly shutdown during kexec, we can get
rid of r100_restore_sanity.

Signed-off-by: Markus Trippelsdorf <markus@trippelsdorf.de>
---
 drivers/gpu/drm/radeon/r100.c        | 27 ---------------------------
 drivers/gpu/drm/radeon/r300.c        |  2 --
 drivers/gpu/drm/radeon/r420.c        |  2 --
 drivers/gpu/drm/radeon/r520.c        |  2 --
 drivers/gpu/drm/radeon/radeon_asic.h |  1 -
 drivers/gpu/drm/radeon/rs400.c       |  2 --
 drivers/gpu/drm/radeon/rs600.c       |  2 --
 drivers/gpu/drm/radeon/rs690.c       |  2 --
 drivers/gpu/drm/radeon/rv515.c       |  2 --
 9 files changed, 42 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 9fc61dd..d53dcd8 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -3938,31 +3938,6 @@ void r100_fini(struct radeon_device *rdev)
 	rdev->bios = NULL;
 }
 
-/*
- * Due to how kexec works, it can leave the hw fully initialised when it
- * boots the new kernel. However doing our init sequence with the CP and
- * WB stuff setup causes GPU hangs on the RN50 at least. So at startup
- * do some quick sanity checks and restore sane values to avoid this
- * problem.
- */
-void r100_restore_sanity(struct radeon_device *rdev)
-{
-	u32 tmp;
-
-	tmp = RREG32(RADEON_CP_CSQ_CNTL);
-	if (tmp) {
-		WREG32(RADEON_CP_CSQ_CNTL, 0);
-	}
-	tmp = RREG32(RADEON_CP_RB_CNTL);
-	if (tmp) {
-		WREG32(RADEON_CP_RB_CNTL, 0);
-	}
-	tmp = RREG32(RADEON_SCRATCH_UMSK);
-	if (tmp) {
-		WREG32(RADEON_SCRATCH_UMSK, 0);
-	}
-}
-
 int r100_init(struct radeon_device *rdev)
 {
 	int r;
@@ -3975,8 +3950,6 @@ int r100_init(struct radeon_device *rdev)
 	radeon_scratch_init(rdev);
 	/* Initialize surface registers */
 	radeon_surface_init(rdev);
-	/* sanity check some register to avoid hangs like after kexec */
-	r100_restore_sanity(rdev);
 	/* TODO: disable VGA need to use VGA request */
 	/* BIOS*/
 	if (!radeon_get_bios(rdev)) {
diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.c
index d8dd269..57ba534 100644
--- a/drivers/gpu/drm/radeon/r300.c
+++ b/drivers/gpu/drm/radeon/r300.c
@@ -1480,8 +1480,6 @@ int r300_init(struct radeon_device *rdev)
 	/* Initialize surface registers */
 	radeon_surface_init(rdev);
 	/* TODO: disable VGA need to use VGA request */
-	/* restore some register to sane defaults */
-	r100_restore_sanity(rdev);
 	/* BIOS*/
 	if (!radeon_get_bios(rdev)) {
 		if (ASIC_IS_AVIVO(rdev))
diff --git a/drivers/gpu/drm/radeon/r420.c b/drivers/gpu/drm/radeon/r420.c
index 4e796ec..9ee3360 100644
--- a/drivers/gpu/drm/radeon/r420.c
+++ b/drivers/gpu/drm/radeon/r420.c
@@ -371,8 +371,6 @@ int r420_init(struct radeon_device *rdev)
 	/* Initialize surface registers */
 	radeon_surface_init(rdev);
 	/* TODO: disable VGA need to use VGA request */
-	/* restore some register to sane defaults */
-	r100_restore_sanity(rdev);
 	/* BIOS*/
 	if (!radeon_get_bios(rdev)) {
 		if (ASIC_IS_AVIVO(rdev))
diff --git a/drivers/gpu/drm/radeon/r520.c b/drivers/gpu/drm/radeon/r520.c
index e1aece7..4709c10 100644
--- a/drivers/gpu/drm/radeon/r520.c
+++ b/drivers/gpu/drm/radeon/r520.c
@@ -256,8 +256,6 @@ int r520_init(struct radeon_device *rdev)
 	radeon_scratch_init(rdev);
 	/* Initialize surface registers */
 	radeon_surface_init(rdev);
-	/* restore some register to sane defaults */
-	r100_restore_sanity(rdev);
 	/* TODO: disable VGA need to use VGA request */
 	/* BIOS*/
 	if (!radeon_get_bios(rdev)) {
diff --git a/drivers/gpu/drm/radeon/radeon_asic.h b/drivers/gpu/drm/radeon/radeon_asic.h
index 818bbe6..6eee9e2 100644
--- a/drivers/gpu/drm/radeon/radeon_asic.h
+++ b/drivers/gpu/drm/radeon/radeon_asic.h
@@ -122,7 +122,6 @@ void r100_mc_resume(struct radeon_device *rdev, struct r100_mc_save *save);
 void r100_vram_init_sizes(struct radeon_device *rdev);
 int r100_cp_reset(struct radeon_device *rdev);
 void r100_vga_render_disable(struct radeon_device *rdev);
-void r100_restore_sanity(struct radeon_device *rdev);
 int r100_cs_track_check_pkt3_indx_buffer(struct radeon_cs_parser *p,
 					 struct radeon_cs_packet *pkt,
 					 struct radeon_bo *robj);
diff --git a/drivers/gpu/drm/radeon/rs400.c b/drivers/gpu/drm/radeon/rs400.c
index b8074a8..23bbf89 100644
--- a/drivers/gpu/drm/radeon/rs400.c
+++ b/drivers/gpu/drm/radeon/rs400.c
@@ -510,8 +510,6 @@ int rs400_init(struct radeon_device *rdev)
 	/* Initialize surface registers */
 	radeon_surface_init(rdev);
 	/* TODO: disable VGA need to use VGA request */
-	/* restore some register to sane defaults */
-	r100_restore_sanity(rdev);
 	/* BIOS*/
 	if (!radeon_get_bios(rdev)) {
 		if (ASIC_IS_AVIVO(rdev))
diff --git a/drivers/gpu/drm/radeon/rs600.c b/drivers/gpu/drm/radeon/rs600.c
index 670b555..cfe6f80 100644
--- a/drivers/gpu/drm/radeon/rs600.c
+++ b/drivers/gpu/drm/radeon/rs600.c
@@ -1018,8 +1018,6 @@ int rs600_init(struct radeon_device *rdev)
 	radeon_scratch_init(rdev);
 	/* Initialize surface registers */
 	radeon_surface_init(rdev);
-	/* restore some register to sane defaults */
-	r100_restore_sanity(rdev);
 	/* BIOS */
 	if (!radeon_get_bios(rdev)) {
 		if (ASIC_IS_AVIVO(rdev))
diff --git a/drivers/gpu/drm/radeon/rs690.c b/drivers/gpu/drm/radeon/rs690.c
index d8ddfb3..e1f4036 100644
--- a/drivers/gpu/drm/radeon/rs690.c
+++ b/drivers/gpu/drm/radeon/rs690.c
@@ -789,8 +789,6 @@ int rs690_init(struct radeon_device *rdev)
 	radeon_scratch_init(rdev);
 	/* Initialize surface registers */
 	radeon_surface_init(rdev);
-	/* restore some register to sane defaults */
-	r100_restore_sanity(rdev);
 	/* TODO: disable VGA need to use VGA request */
 	/* BIOS*/
 	if (!radeon_get_bios(rdev)) {
diff --git a/drivers/gpu/drm/radeon/rv515.c b/drivers/gpu/drm/radeon/rv515.c
index 8ea1573..f9692d7 100644
--- a/drivers/gpu/drm/radeon/rv515.c
+++ b/drivers/gpu/drm/radeon/rv515.c
@@ -627,8 +627,6 @@ int rv515_init(struct radeon_device *rdev)
 	/* Initialize surface registers */
 	radeon_surface_init(rdev);
 	/* TODO: disable VGA need to use VGA request */
-	/* restore some register to sane defaults */
-	r100_restore_sanity(rdev);
 	/* BIOS*/
 	if (!radeon_get_bios(rdev)) {
 		if (ASIC_IS_AVIVO(rdev))
-- 
Markus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
