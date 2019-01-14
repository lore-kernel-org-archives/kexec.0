Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj8DV-0000GC-Iw
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 19:48:15 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [RFC v1 0/8] Prototype for kexec signature verification within Xen
Date: Mon, 14 Jan 2019 13:47:57 -0600
Message-Id: <1547495285-28907-1-git-send-email-eric.devolder@oracle.com>
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

On April 20, 2018, I posted to xen-devel an RFC inquiring about
support for signature verification of kexec within Xen:

https://lists.xenproject.org/archives/html/xen-devel/2018-04/msg01655.html

Since then, I've worked towards a solution. For the purposes of
understanding signature verification, I built a standalone utility to
parse the xen.mb.efi PECOFF file, hash it contents, and extract its
digitial certificate and perform the Authenticode signature
verification. Once this was all working, I integrated the files into
Xen.

I have a working prototype, which integrates [enough] OpenSSL into
Xen to enable kexec signature verification. Alas I now have different
priorities, but my employer did ask that I post this set of changes.
You may do with them as you wish. I would be available for consultation
should somebody wish to pursue this further.

Being a prototype, it has the following known-to-me shortcomings:

1: Does not following Xen coding standard. There may be areas where I
do not use the most appropriate Xen style, call or macro, or error
checking.

2: The adaptation of OpenSSL into Xen is incomplete. There are a number
of stub routines that have not been implemented (but currently do not
seem to interfere with the signature verification operation). Some
possible ways to address this are:
 - Properly implement these routines
 - Investigate further the OpenSSL configury to see if these can be
   configured away (Note that I chose OpenSSL-1.1.0i specifically
   because that is what EDK2 uses, and EDK2 is as close to Xen
   embedded/kernel environment (Otherwise OpenSSL is primarily a
   userland package)).
 - All 150+ OpenSSL files are compiled-in, could look at eliminating
   files manually.
 - Maybe look at newer OpenSSL versions, which might have additional
   configurability?
 - Perhaps instead utilize libgcrypt + libksba instead of OpenSSL.

3: A configure option is needed for the signature verification. This
option should simultaneously disable kexec_load while enabling
kexec_file_load.

4: Linux has infrastructure to support multiple file types as well as
multiple signature verification techniques. By contrast, this prototype
is hardwired for PECOFF+Authenticode (EFI) format.

5: Linux has keyring infrastructure to support multiple certificates.
Currently the appropriate root certificate to satisfy Oracle-signed
Xen kernel is compiled-in. This area alone would need significant
attention if any hope in upstreaming is to occur.

5: There is probably a better PECOFF decoder than the one currently in
use.

6: Convert the usage of DLCL macros to Xen standard list operations.

7: For the include2/ xenossl.h header file hack to facilitate
compiling OpenSSL within Xen; that needs to be revisited. I did
this to deal with the standard header files the (userland) OpenSSL
expects present; rather than changing nearly every OpenSSL source
file.

8: Analysis to understand the compiled-size increase, as well
as the run-time size increase?

9: A true security audit on these changes? For example, this prototype
still relies upon the kexec userland tool to provide the purgatory
executable. For obvious security reasons, this needs to be migrated
within Xen, as Linux does (note that involves some level of ELF
parsing and relocation support).

10: Licensing of the various pieces may be problematic.

Note that there is a corresponding change to kexec-tools to
allow/enable the Xen kexec_file_load() hypercall. Those changes
are not part of this change set, but will be posted separately.

Anyway, this does work, for me.
eric



Eric DeVolder (8):
  kexec: add kexec_file_load to libxenctrl
  kexec: implement kexec_file_load() for PECOFF+Authenticode files
  kexec: new file openssl-1.1.0i.patch
  kexec: xen/common/Makefile: include building of OpenSSL
  kexec: changes to facilitate compiling OpenSSL within Xen
  kexec: support files for PECOFF Authenticode signature verification
  kexec: Xen compatible makefile for OpenSSL
  kexec: include OpenSSL build in xen.spec

 Makefile.openssl-1.1.0i         |  480 ++++++++++++++
 openssl-1.1.0i.patch            |  378 +++++++++++
 tools/libxc/xc_kexec.c          |   41 ++
 tools/libxc/xenctrl.h           |    4 +
 xen.spec                        |   78 +++
 xen/arch/x86/Rules.mk           |    2 +
 xen/common/Makefile             |    4 +
 xen/common/TrustedCert.h        |  113 ++++
 xen/common/dlcl.h               |  323 ++++++++++
 xen/common/kexec.c              |  131 +++-
 xen/common/pecoff.h             |  283 ++++++++
 xen/common/ped.c                |  579 +++++++++++++++++
 xen/common/ped.h                |  128 ++++
 xen/common/v_openssl.c          | 1348 +++++++++++++++++++++++++++++++++++++++
 xen/common/xmalloc_tlsf.c       |   25 +
 xen/include/asm-x86/types.h     |    2 +
 xen/include/public/kexec.h      |    4 +-
 xen/include/xen/types.h         |    3 +
 xen/include/xen/xmalloc.h       |    1 +
 xen/include2/assert.h           |    1 +
 xen/include2/bits/syslog-path.h |    1 +
 xen/include2/ctype.h            |    1 +
 xen/include2/errno.h            |    1 +
 xen/include2/features.h         |    1 +
 xen/include2/inttypes.h         |    1 +
 xen/include2/limits.h           |    1 +
 xen/include2/memory.h           |    1 +
 xen/include2/stdarg.h           |    1 +
 xen/include2/stddef.h           |    1 +
 xen/include2/stdint.h           |    1 +
 xen/include2/stdio.h            |    1 +
 xen/include2/stdlib.h           |    1 +
 xen/include2/string.h           |    1 +
 xen/include2/strings.h          |    1 +
 xen/include2/sys/time.h         |    1 +
 xen/include2/sys/types.h        |    1 +
 xen/include2/syslog.h           |    1 +
 xen/include2/time.h             |    1 +
 xen/include2/unistd.h           |    1 +
 xen/include2/xenossl.h          |  130 ++++
 40 files changed, 4074 insertions(+), 3 deletions(-)
 create mode 100644 Makefile.openssl-1.1.0i
 create mode 100644 openssl-1.1.0i.patch
 create mode 100644 xen/common/TrustedCert.h
 create mode 100755 xen/common/dlcl.h
 create mode 100644 xen/common/pecoff.h
 create mode 100644 xen/common/ped.c
 create mode 100644 xen/common/ped.h
 create mode 100644 xen/common/v_openssl.c
 create mode 100644 xen/include2/assert.h
 create mode 100644 xen/include2/bits/syslog-path.h
 create mode 100644 xen/include2/ctype.h
 create mode 100644 xen/include2/errno.h
 create mode 100644 xen/include2/features.h
 create mode 100644 xen/include2/inttypes.h
 create mode 100644 xen/include2/limits.h
 create mode 100644 xen/include2/memory.h
 create mode 100644 xen/include2/stdarg.h
 create mode 100644 xen/include2/stddef.h
 create mode 100644 xen/include2/stdint.h
 create mode 100644 xen/include2/stdio.h
 create mode 100644 xen/include2/stdlib.h
 create mode 100644 xen/include2/string.h
 create mode 100644 xen/include2/strings.h
 create mode 100644 xen/include2/sys/time.h
 create mode 100644 xen/include2/sys/types.h
 create mode 100644 xen/include2/syslog.h
 create mode 100644 xen/include2/time.h
 create mode 100644 xen/include2/unistd.h
 create mode 100644 xen/include2/xenossl.h

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
