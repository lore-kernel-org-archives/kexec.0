From: Coiby Xu <coxu@redhat.com>
Date: Sun, 24 Apr 2022 10:09:29 +0800
Subject: [PATCH v2 1/1] Simplify the generation of man pages
In-Reply-To: <20220304151748.138775-1-artafinde@archlinux.org>
References: <20220304151748.138775-1-artafinde@archlinux.org>
Message-ID: <20220424020929.bcuqog7emxsmuwdt@Rk>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi,

I notice Fedora's kexec-tools failed to build using makedumpfile-1.7.1
because it assumes makedumpfile generates .gz man files like
makedumpfile.8.gz. Of course I can compress makedumpfile's man files
when building Fedora's kexec-tools to fix this issue. But I want to know
why you no longer compress man files in makedumpfile especially when
Arch Linux also uses .gz man files according to the package content [1]?

[1] https://archlinux.org/packages/community/x86_64/makedumpfile/

On Fri, Mar 04, 2022 at 03:17:48PM +0000, Leonidas Spyropoulos wrote:
>Use `sed` to simplify the man pages generation. Keep the .in files
>intact during make and generate the actual man pages with sed.
>Additionally package tools already gz the man pages during install so it
>doesn't really need to do that during make and it breaks reproducibility
>of the package due to timestamps on files.
>
>Motivation: https://reproducible-builds.org
>
>Signed-off-by: Leonidas Spyropoulos <artafinde@archlinux.org>
>---
> Makefile                                      | 20 +++++++++----------
> makedumpfile.8 => makedumpfile.8.in           |  2 +-
> makedumpfile.conf.5 => makedumpfile.conf.5.in |  2 +-
> 3 files changed, 11 insertions(+), 13 deletions(-)
> rename makedumpfile.8 => makedumpfile.8.in (99%)
> rename makedumpfile.conf.5 => makedumpfile.conf.5.in (99%)
>
>diff --git a/Makefile b/Makefile
>index 9f9fd22..f118b31 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -112,26 +112,24 @@ $(OBJ_ARCH): $(SRC_ARCH)
>
> makedumpfile: $(SRC_BASE) $(OBJ_PART) $(OBJ_ARCH)
> 	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -o $@ $< $(LIBS)
>-	echo .TH MAKEDUMPFILE 8 \"$(DATE)\" \"makedumpfile v$(VERSION)\" \"Linux System Administrator\'s Manual\" > temp.8
>-	grep -v "^.TH MAKEDUMPFILE 8" $(VPATH)makedumpfile.8 >> temp.8
>-	mv temp.8 makedumpfile.8
>-	gzip -c ./makedumpfile.8 > ./makedumpfile.8.gz
>-	echo .TH MAKEDUMPFILE.CONF 5 \"$(DATE)\" \"makedumpfile v$(VERSION)\" \"Linux System Administrator\'s Manual\" > temp.5
>-	grep -v "^.TH MAKEDUMPFILE.CONF 5" $(VPATH)makedumpfile.conf.5 >> temp.5
>-	mv temp.5 makedumpfile.conf.5
>-	gzip -c ./makedumpfile.conf.5 > ./makedumpfile.conf.5.gz
>+	@sed -e "s/@DATE@/$(DATE)/" \
>+	     -e "s/@VERSION@/$(VERSION)/" \
>+	     $(VPATH)makedumpfile.8.in > $(VPATH)makedumpfile.8
>+	@sed -e "s/@DATE@/$(DATE)/" \
>+	     -e "s/@VERSION@/$(VERSION)/" \
>+	     $(VPATH)makedumpfile.conf.5.in > $(VPATH)makedumpfile.conf.5
>
> eppic_makedumpfile.so: extension_eppic.c
> 	$(CC) $(CFLAGS) $(LDFLAGS) -shared -rdynamic -o $@ extension_eppic.c -fPIC -leppic -ltinfo
>
> clean:
>-	rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.8.gz makedumpfile.conf.5.gz
>+	rm -f $(OBJ) $(OBJ_PART) $(OBJ_ARCH) makedumpfile makedumpfile.8 makedumpfile.conf.5
>
> install:
> 	install -m 755 -d ${DESTDIR}/usr/sbin ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8 ${DESTDIR}/etc
> 	install -m 755 -t ${DESTDIR}/usr/sbin makedumpfile $(VPATH)makedumpfile-R.pl
>-	install -m 644 -t ${DESTDIR}/usr/share/man/man8 makedumpfile.8.gz
>-	install -m 644 -t ${DESTDIR}/usr/share/man/man5 makedumpfile.conf.5.gz
>+	install -m 644 -t ${DESTDIR}/usr/share/man/man8 makedumpfile.8
>+	install -m 644 -t ${DESTDIR}/usr/share/man/man5 makedumpfile.conf.5
> 	install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/etc/makedumpfile.conf.sample
> 	mkdir -p ${DESTDIR}/usr/share/makedumpfile-${VERSION}/eppic_scripts
> 	install -m 644 -t ${DESTDIR}/usr/share/makedumpfile-${VERSION}/eppic_scripts/ $(VPATH)eppic_scripts/*
>diff --git a/makedumpfile.8 b/makedumpfile.8.in
>similarity index 99%
>rename from makedumpfile.8
>rename to makedumpfile.8.in
>index ce8c700..d22588e 100644
>--- a/makedumpfile.8
>+++ b/makedumpfile.8.in
>@@ -1,4 +1,4 @@
>-.TH MAKEDUMPFILE 8 "8 Nov 2021" "makedumpfile v1.7.0++" "Linux System Administrator's Manual"
>+.TH MAKEDUMPFILE 8 "@DATE@" "makedumpfile v at VERSION@" "Linux System Administrator's Manual"
> .SH NAME
> makedumpfile \- make a small dumpfile of kdump
> .SH SYNOPSIS
>diff --git a/makedumpfile.conf.5 b/makedumpfile.conf.5.in
>similarity index 99%
>rename from makedumpfile.conf.5
>rename to makedumpfile.conf.5.in
>index 0f1a49b..54e1be8 100644
>--- a/makedumpfile.conf.5
>+++ b/makedumpfile.conf.5.in
>@@ -1,4 +1,4 @@
>-.TH MAKEDUMPFILE.CONF 5 "8 Nov 2021" "makedumpfile v1.7.0++" "Linux System Administrator's Manual"
>+.TH MAKEDUMPFILE.CONF 5 "@DATE@" "makedumpfile v at VERSION@" "Linux System Administrator's Manual"
> .SH NAME
> makedumpfile.conf \- The filter configuration file for makedumpfile(8).
> .SH DESCRIPTION
>-- 
>2.35.1
>
>
>_______________________________________________
>kexec mailing list
>kexec at lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec
>

-- 
Best regards,
Coiby


