From: HAGIO KAZUHITO=?unknown-8bit?b?6JCp5bC+IOS4gOS7gQ==?= <k-hagio-ab@nec.com>
Date: Wed, 11 May 2022 01:50:58 +0000
Subject: [PATCH] Makefile: Avoid installing files in /etc
In-Reply-To: <20220504165703.747333-1-gpiccoli@igalia.com>
References: <20220504165703.747333-1-gpiccoli@igalia.com>
Message-ID: <TYYPR01MB6777EDEDDCA5B2C32644730DDDC89@TYYPR01MB6777.jpnprd01.prod.outlook.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

-----Original Message-----
> Some Linux distros rely on having files in /etc (Debian, et al.),
> others in *not* having them in such directory (like Arch Linux).
> Fact is that the former distros have no issues in installing files
> elsewhere, whereas Arch has issues in installing files on /etc,
> specially if such files are present there when user try to reinstall
> the packages - it fails. Arch packaging doesn't try to be smart as dpkg
> for example (that compares config files to determine if user changed that).
> 
> With all of that said, this patch moves the sample conf file to
> /usr/share, a move that is well-tolerated in all distros and shouldn't
> cause regressions in packaging. Also, if some Linux distribution likes
> the idea of adding files in /etc, they can tune it in their packaging
> configuration scripts for makedumpfile, but we shouldn't have that
> as default in the Makefile.

Fair enough, and as far as I've checked:

- The makedumpfile.conf.sample file does not need to be in /etc, because
makedumpfile does not have any default path for it and reads a config
file only when specified with --config option.
(and IMO it's better to place such a sample config file, used rarely,
in /usr/share.)

- Fedora/RHEL kexec-tools packaging does not use "make install" and have
their own install command, at least this patch will not affect them:
https://src.fedoraproject.org/rpms/kexec-tools/blob/main/f/kexec-tools.spec#_225

- Debian/Ubuntu makedumpfile packages apparently do not have the file:
https://packages.debian.org/sid/amd64/makedumpfile/filelist

On the whole I will accept this.

> Notice that this patch intentionally skips
> the change for the .spec file, which aims specific distros, by creating
> RPM packages.

However, the .spec file depends on "make install", so I will add this:

diff --git a/makedumpfile.spec b/makedumpfile.spec
index ef619b8c8af9..fd9efa0639cc 100644
--- a/makedumpfile.spec
+++ b/makedumpfile.spec
@@ -25,7 +25,6 @@ make LINKTYPE=dynamic
 %install
 rm -rf %{buildroot}
 mkdir -p %{buildroot}/usr/sbin
-mkdir -p %{buildroot}/etc
 mkdir -p %{buildroot}/usr/share/man/man5
 mkdir -p %{buildroot}/usr/share/man/man8
 mkdir -p %{buildroot}/usr/share/%{name}-%{version}/eppic-scripts/
@@ -35,11 +34,11 @@ make install DESTDIR=%{buildroot}
 rm -rf %{buildroot}
 
 %files
-/etc/makedumpfile.conf.sample
 /usr/sbin/makedumpfile
 /usr/sbin/makedumpfile-R.pl
 /usr/share/man/man5/makedumpfile.conf.5.gz
 /usr/share/man/man8/makedumpfile.8.gz
+/usr/share/%{name}-%{version}/makedumpfile.conf.sample
 /usr/share/%{name}-%{version}/eppic_scripts/
 
 %changelog

> 
> Cc: Coiby Xu <coxu@redhat.com>
> Cc: Kazuhito Hagio <k-hagio-ab@nec.com>
> Cc: Leonidas Spyropoulos <artafinde@archlinux.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index cc6b0120aa7d..014be8110836 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -130,6 +130,6 @@ install:
>  	install -m 755 -t ${DESTDIR}/usr/sbin makedumpfile $(VPATH)makedumpfile-R.pl
>  	install -m 644 -t ${DESTDIR}/usr/share/man/man8 makedumpfile.8
>  	install -m 644 -t ${DESTDIR}/usr/share/man/man5 makedumpfile.conf.5
> -	install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/etc/makedumpfile.conf.sample
>  	mkdir -p ${DESTDIR}/usr/share/makedumpfile-${VERSION}/eppic_scripts
> +	install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/usr/share/makedumpfile-${VERSION}/makedumpfile.conf.sample
>  	install -m 644 -t ${DESTDIR}/usr/share/makedumpfile-${VERSION}/eppic_scripts/ $(VPATH)eppic_scripts/*
> --
> 2.36.0

The creation of ${DESTDIR}/etc is also not needed, will remove it and merge.

install:
-	install -m 755 -d ${DESTDIR}/usr/sbin ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8 ${DESTDIR}/etc
+	install -m 755 -d ${DESTDIR}/usr/sbin ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8
 	install -m 755 -t ${DESTDIR}/usr/sbin makedumpfile $(VPATH)makedumpfile-R.pl

Please let me know if any problem.

Thanks,
Kazu


