From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed,  4 May 2022 13:57:03 -0300
Subject: [PATCH] Makefile: Avoid installing files in /etc
Message-ID: <20220504165703.747333-1-gpiccoli@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Some Linux distros rely on having files in /etc (Debian, et al.),
others in *not* having them in such directory (like Arch Linux).
Fact is that the former distros have no issues in installing files
elsewhere, whereas Arch has issues in installing files on /etc,
specially if such files are present there when user try to reinstall
the packages - it fails. Arch packaging doesn't try to be smart as dpkg
for example (that compares config files to determine if user changed that).

With all of that said, this patch moves the sample conf file to
/usr/share, a move that is well-tolerated in all distros and shouldn't
cause regressions in packaging. Also, if some Linux distribution likes
the idea of adding files in /etc, they can tune it in their packaging
configuration scripts for makedumpfile, but we shouldn't have that
as default in the Makefile. Notice that this patch intentionally skips
the change for the .spec file, which aims specific distros, by creating
RPM packages.

Cc: Coiby Xu <coxu@redhat.com>
Cc: Kazuhito Hagio <k-hagio-ab@nec.com>
Cc: Leonidas Spyropoulos <artafinde@archlinux.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index cc6b0120aa7d..014be8110836 100644
--- a/Makefile
+++ b/Makefile
@@ -130,6 +130,6 @@ install:
 	install -m 755 -t ${DESTDIR}/usr/sbin makedumpfile $(VPATH)makedumpfile-R.pl
 	install -m 644 -t ${DESTDIR}/usr/share/man/man8 makedumpfile.8
 	install -m 644 -t ${DESTDIR}/usr/share/man/man5 makedumpfile.conf.5
-	install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/etc/makedumpfile.conf.sample
 	mkdir -p ${DESTDIR}/usr/share/makedumpfile-${VERSION}/eppic_scripts
+	install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/usr/share/makedumpfile-${VERSION}/makedumpfile.conf.sample
 	install -m 644 -t ${DESTDIR}/usr/share/makedumpfile-${VERSION}/eppic_scripts/ $(VPATH)eppic_scripts/*
-- 
2.36.0


