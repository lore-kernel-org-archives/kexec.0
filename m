Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1estgJ-0002q5-Tc
 for kexec@lists.infradead.org; Mon, 05 Mar 2018 17:13:50 +0000
Received: by mail-pl0-f66.google.com with SMTP id y8-v6so10006480pll.13
 for <kexec@lists.infradead.org>; Mon, 05 Mar 2018 09:13:37 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v2 0/3] makedumpfile/arm64: Add '--mem-usage' support
Date: Mon,  5 Mar 2018 22:42:53 +0530
Message-Id: <1520269976-8850-1-git-send-email-bhsharma@redhat.com>
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
To: kexec@lists.infradead.org
Cc: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, bhsharma@redhat.com, bhupesh.linux@gmail.com, Takuya Nakayama <tak-nakayama@tg.jp.nec.com>, Daisuke Nishimura <dai-nishimura@rc.jp.nec.com>

Changes since v1:
----------------
- Updated patchset to read _stext symbol from '/proc/kallsyms' rather
  than from 'vmlinux' file.

Its good to have the makedumpfile '--mem-usage' support
for arm64 architecture as well, as it allows one to see the page numbers
of current system (1st kernel) in different use.

Using this we can know how many pages are dumpable when different
dump_level is specified.

Normally for x86_64, makedumpfile analyzes the 'System Ram' and
'kernel text' program segment of /proc/kcore excluding
the crashkernel range, then calculates the page number of different
kind per vmcoreinfo.

We use the similar logic for arm64, but in addition we determine
information like VA_BITS from kernel symbol like '_stext'.
This allows us to get the VA_BITS before 'set_kcore_vmcoreinfo()'
is called.

Also I have validated the '--mem-usage' makedumpfile option on several
ppc64/ppc64le and s390x machines, so update the makedumpfile.8
documentation to indicate that '--mem-usage' option is supported
not only on x86_64, but also on ppc64, s390x and arm64.

After this patch, when using the '--mem-usage' option with makedumpfile,
we get the correct information about the different pages. For e.g.
here is an output from my arm64 board:

TYPE		PAGES			EXCLUDABLE	DESCRIPTION
----------------------------------------------------------------------
ZERO		49524           	yes		Pages filled with zero
NON_PRI_CACHE	15143           	yes		Cache pages without private flag
PRI_CACHE	29147           	yes		Cache pages with private flag
USER		3684            	yes		User process pages
FREE		1450569         	yes		Free pages
KERN_DATA	14243           	no		Dumpable kernel data

page size:		65536
Total pages on system:	1562310
Total size on system:	102387548160     Byte

Cc: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>
Cc: Takuya Nakayama <tak-nakayama@tg.jp.nec.com>
Cc: Daisuke Nishimura <dai-nishimura@rc.jp.nec.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

Bhupesh Sharma (3):
  Add a new helper file 'tools.c' that provides some useful APIs
  arm64: Add support to read symbols like _stext from '/proc/kallsyms'
  Documentation: Update documentation regarding --mem-usage' option

 Makefile       |   2 +-
 arch/arm64.c   |  78 +++++-
 common.h       |   8 +
 makedumpfile.8 |   2 +-
 makedumpfile.h |  14 ++
 tools.c        | 766 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 864 insertions(+), 6 deletions(-)
 create mode 100644 tools.c

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
