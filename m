Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj8DY-0000Hg-1C
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 19:48:18 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [RFC v1 8/8] kexec: include OpenSSL build in xen.spec
Date: Mon, 14 Jan 2019 13:48:05 -0600
Message-Id: <1547495285-28907-9-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1547495285-28907-1-git-send-email-eric.devolder@oracle.com>
References: <1547495285-28907-1-git-send-email-eric.devolder@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xen-devel@lists.xen.org
Cc: daniel.kiper@oracle.com, eric.devolder@oracle.com, kexec@lists.infradead.org, boris.ostrovsky@oracle.com

The changes to xen.spec are needed to unpack, configure and
generate a Makefile for building OpenSSL within Xen.

The changes to xen.spec also apply patches which are primarily
the new files as part of the signature verification effort,
as well as some tweaks to Xen files to facilitate compiling of
OpenSSL.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 xen.spec | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/xen.spec b/xen.spec
index 4e36f7e..e026f28 100644
--- a/xen.spec
+++ b/xen.spec
@@ -1,5 +1,7 @@
 %{!?buildid: %{expand: %%define buildid 1}}
 
+%define openssl     openssl-1.1.0i
+
 Name: xen
 Version: 4.4.4
 Release: %{buildid}%{?dist}
@@ -9,6 +11,15 @@ License: GPL
 URL: http://www.xenproject.org/
 BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root
 Source0: xen-4.4.tar.gz
+Source100: https://www.openssl.org/source/%{openssl}.tar.gz
+# FIX!!! This needs also for nosource 100
+Patch101: 0001-kexec-add-kexec_file_load-to-libxenctrl.patch
+Patch102: 0002-kexec-implement-kexec_file_load-for-PECOFF-Authentic.patch
+Patch103: 0003-kexec-new-file-openssl-1.1.0i.patch.patch
+Patch104: 0004-kexec-xen-common-Makefile-include-building-of-OpenSS.patch
+Patch105: 0005-kexec-changes-to-facilitate-compiling-OpenSSL-within.patch
+Patch106: 0006-kexec-support-files-for-PECOFF-Authenticode-signatur.patch
+Patch107: 0007-kexec-Xen-compatible-makefile-for-OpenSSL.patch
 
 %if 0%{?sbsignxen}
 Source21: securebootca.cer
@@ -72,6 +83,73 @@ manage Xen virtual machines.
 
 %prep
 %setup -q -n xen-4.4
+%patch101 -p1
+%patch102 -p1
+%patch104 -p1
+%patch105 -p1
+%patch106 -p1
+%patch107 -p1
+
+tar -z -x -v -f %{SOURCE100}
+%patch103 -p2
+mkdir -p $RPM_BUILD_DIR/openssl
+
+# Taken from EDK2 UEFI linux-x86_64
+(cd %{openssl} ; ./Configure --prefix=$RPM_BUILD_DIR/openssl \
+    UEFI \
+    no-afalgeng \
+    no-asm \
+    no-async \
+    no-autoalginit \
+    no-autoerrinit \
+    no-bf \
+    no-blake2 \
+    no-camellia \
+    no-capieng \
+    no-cast \
+    no-chacha \
+    no-ct \
+    no-deprecated \
+    no-dgram \
+    no-dsa \
+    no-dso \
+    no-dynamic-engine \
+    no-ec \
+    no-ec2m \
+    no-engine \
+    no-err \
+    no-filenames \
+    no-gost \
+    no-hw \
+    no-idea \
+    no-mdc2 \
+    no-ocb \
+    no-poly1305 \
+    no-posix-io \
+    no-rc2 \
+    no-rfc3779 \
+    no-rmd160 \
+    no-scrypt \
+    no-seed \
+    no-shared \
+    no-sock \
+    no-srp \
+    no-ssl \
+    no-stdio \
+    no-threads \
+    no-ts \
+    no-ui \
+    no-whirlpool \
+    )
+#   no-pic \
+#   no-cms \
+
+# Essential
+(cd %{openssl} ; make build_all_generated)
+
+mv %{openssl}/Makefile %{openssl}/Makefile.original
+mv Makefile.%{openssl} %{openssl}/Makefile
+mv %{openssl} xen/common
 
 %build
 %configure --enable-xend --enable-ovmf
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
