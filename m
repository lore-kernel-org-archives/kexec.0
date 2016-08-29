Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1beILA-0004Ke-RK
 for kexec@lists.infradead.org; Mon, 29 Aug 2016 08:54:49 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/3] makedumpfile: Add support of mm randomization
Date: Mon, 29 Aug 2016 16:54:19 +0800
Message-Id: <1472460862-29842-1-git-send-email-bhe@redhat.com>
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
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, thgarnie@google.com, Baoquan He <bhe@redhat.com>

Hi Atsushi and Thomas,

This is a draft patchset. I just checked x86_64 implementation according to
Thomas's mm randomization related patches. Not sure if this will affect
other ARCH or XEN. Especially for patch 1/3 and patch 2/3, just a original
idea. I tested on x86_64, passed.

And also kernel patch need be adjusted so that number_table.X of makedumpfile
can be used. Will add comment to Thomas's kernel patch.

Baoquan He (3):
  makedumpfile: Get info->kernel_version from SYMBOL(init_uts_ns)
    earlier
  makedumpfile: Move get_versiondep_info calling earlier
  makedumpfile: Add support for MM randomization

 arch/x86_64.c  | 26 +++++++++-----------------
 makedumpfile.c | 45 ++++++++++++++++++++++++++++++++++++---------
 makedumpfile.h |  3 +++
 3 files changed, 48 insertions(+), 26 deletions(-)

-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
