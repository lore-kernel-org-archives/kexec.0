From: Guilherme G. Piccoli <gpiccoli@igalia.com>
Date: Wed, 11 May 2022 08:40:23 -0300
Subject: [PATCH] Makefile: Avoid installing files in /etc
In-Reply-To: <TYYPR01MB6777EDEDDCA5B2C32644730DDDC89@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <20220504165703.747333-1-gpiccoli@igalia.com>
 <TYYPR01MB6777EDEDDCA5B2C32644730DDDC89@TYYPR01MB6777.jpnprd01.prod.outlook.com>
Message-ID: <86f59a63-1ed1-7b7a-55b5-252968a19e62@igalia.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 10/05/2022 22:50, HAGIO KAZUHITO(?? ??) wrote:
> [...]
> 
> Fair enough, and as far as I've checked:
> 
> - The makedumpfile.conf.sample file does not need to be in /etc, because
> makedumpfile does not have any default path for it and reads a config
> file only when specified with --config option.
> (and IMO it's better to place such a sample config file, used rarely,
> in /usr/share.)
> 
> - Fedora/RHEL kexec-tools packaging does not use "make install" and have
> their own install command, at least this patch will not affect them:
> https://src.fedoraproject.org/rpms/kexec-tools/blob/main/f/kexec-tools.spec#_225
> 
> - Debian/Ubuntu makedumpfile packages apparently do not have the file:
> https://packages.debian.org/sid/amd64/makedumpfile/filelist
> 
> On the whole I will accept this.
> 
>> Notice that this patch intentionally skips
>> the change for the .spec file, which aims specific distros, by creating
>> RPM packages.
> 
> However, the .spec file depends on "make install", so I will add this:
> 
> diff --git a/makedumpfile.spec b/makedumpfile.spec
> index ef619b8c8af9..fd9efa0639cc 100644
> --- a/makedumpfile.spec
> +++ b/makedumpfile.spec
> @@ -25,7 +25,6 @@ make LINKTYPE=dynamic
>  %install
>  rm -rf %{buildroot}
>  mkdir -p %{buildroot}/usr/sbin
> -mkdir -p %{buildroot}/etc
>  mkdir -p %{buildroot}/usr/share/man/man5
>  mkdir -p %{buildroot}/usr/share/man/man8
>  mkdir -p %{buildroot}/usr/share/%{name}-%{version}/eppic-scripts/
> @@ -35,11 +34,11 @@ make install DESTDIR=%{buildroot}
>  rm -rf %{buildroot}
>  
>  %files
> -/etc/makedumpfile.conf.sample
>  /usr/sbin/makedumpfile
>  /usr/sbin/makedumpfile-R.pl
>  /usr/share/man/man5/makedumpfile.conf.5.gz
>  /usr/share/man/man8/makedumpfile.8.gz
> +/usr/share/%{name}-%{version}/makedumpfile.conf.sample
>  /usr/share/%{name}-%{version}/eppic_scripts/
>  
>  %changelog
> 
>> [...]
> The creation of ${DESTDIR}/etc is also not needed, will remove it and merge.
> 
> install:
> -	install -m 755 -d ${DESTDIR}/usr/sbin ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8 ${DESTDIR}/etc
> +	install -m 755 -d ${DESTDIR}/usr/sbin ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8
>  	install -m 755 -t ${DESTDIR}/usr/sbin makedumpfile $(VPATH)makedumpfile-R.pl
> 
> Please let me know if any problem.
> 
> Thanks,
> Kazu
> 

Hi Kazu, this is perfect - thanks a bunch for the great analysis. Feel
free to merge with your changes, it's much appreciated =)

Cheers,


Guilherme

