Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxRN1-0009Zm-Qq
 for kexec@lists.infradead.org; Wed, 15 Dec 2021 10:18:49 +0000
From: Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v2 0/5] s390: add support for extended cmdline length
Date: Wed, 15 Dec 2021 11:18:31 +0100
Message-Id: <20211215101836.1181165-1-svens@linux.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, prudo@redhat.com, Sven Schnelle <svens@linux.ibm.com>

Hi,

this patchset adds support for extended command line lengths on s390.
The former limit of 896 has been too short in a some configurations. The
linux kernel now provides an additional field in the parameter area
which contains the maximum allowed command line length. In older kernels
this field is zero. In that case the old limit of 896 bytes is used.
This was introduced with 5ecb2da660ab ("s390: support command lines
longer than 896 bytes") in linux.

And while at it, also add the --reuse-cmdline option and use
KEXEC_ALL_OPTIONS.

Changes in v2:

- add slurp_proc_file() to read proc files without knowing the size upfront
- move command_line string from global to function scope

Sven Schnelle (5):
  s390: add variable command line size
  s390: use KEXEC_ALL_OPTIONS
  add slurp_proc_file()
  use slurp_proc_file() in get_command_line()
  s390: add support for --reuse-cmdline

 kexec/arch/s390/crashdump-s390.c       |  3 +-
 kexec/arch/s390/include/arch/options.h | 10 +--
 kexec/arch/s390/kexec-image.c          | 84 ++++++++++++++++----------
 kexec/arch/s390/kexec-s390.h           | 21 ++++---
 kexec/kexec.c                          | 58 +++++++++++++-----
 5 files changed, 114 insertions(+), 62 deletions(-)

-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
