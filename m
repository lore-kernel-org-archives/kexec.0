Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WL3t6-000221-Pq
 for kexec@lists.infradead.org; Wed, 05 Mar 2014 04:57:01 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH 10/10] Install sample eppic scripts
Date: Wed, 5 Mar 2014 04:54:36 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971F1AC3@BPXM01GP.gisp.nec.co.jp>
References: <20140227063007.5924.5819.stgit@aruna-ThinkPad-T420>
 <20140227063204.5924.43768.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20140227063204.5924.43768.stgit@aruna-ThinkPad-T420>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: "aruna@linux.vnet.ibm.com" <aruna@linux.vnet.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>Install sample eppic scripts in the documentation directory
>
>Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
>---
> Makefile          |    1 +
> makedumpfile.spec |    3 +++
> 2 files changed, 4 insertions(+)
>
>diff --git a/Makefile b/Makefile
>index 10178ba..6e8e9b9 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -91,3 +91,4 @@ install:
> 	cp makedumpfile.8.gz ${DESTDIR}/usr/share/man/man8
> 	cp makedumpfile.conf.5.gz ${DESTDIR}/usr/share/man/man5
> 	cp makedumpfile.conf ${DESTDIR}/etc/makedumpfile.conf.sample
>+	cp eppic_scripts/* ${DESTDIR}/usr/share/makedumpfile-${VERSION}/eppic_scripts/

Please write a patch for the latest version,
v1.5.5 uses install command instead of cp:

        install -m 755 -d ${DESTDIR}/usr/sbin ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8 ${DESTDIR}/etc
        install -m 755 -t ${DESTDIR}/usr/sbin makedumpfile makedumpfile-R.pl
        install -m 644 -t ${DESTDIR}/usr/share/man/man8 makedumpfile.8.gz
        install -m 644 -t ${DESTDIR}/usr/share/man/man5 makedumpfile.conf.5.gz
        install -m 644 -D makedumpfile.conf ${DESTDIR}/etc/makedumpfile.conf.sample


Thanks
Atsushi Kumagai

>diff --git a/makedumpfile.spec b/makedumpfile.spec
>index ea7fba4..7f5d1d4 100644
>--- a/makedumpfile.spec
>+++ b/makedumpfile.spec
>@@ -28,6 +28,8 @@ mkdir -p %{buildroot}/bin
> mkdir -p %{buildroot}/etc
> mkdir -p %{buildroot}/usr/share/man/man5
> mkdir -p %{buildroot}/usr/share/man/man8
>+mkdir -p %{buildroot}/usr/share/%{name}-%{version}/
>+mkdir -p %{buildroot}/usr/share/%{name}-%{version}/eppic-scripts/
> make install DESTDIR=%{buildroot}
>
> %clean
>@@ -39,6 +41,7 @@ rm -rf %{buildroot}
> /bin/makedumpfile-R.pl
> /usr/share/man/man5/makedumpfile.conf.5.gz
> /usr/share/man/man8/makedumpfile.8.gz
>+%doc /usr/share/%{name}-%{version}/eppic_scripts/
>
> %changelog
> * Fri Aug 21 2008 Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
