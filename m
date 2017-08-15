Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dhWKl-0002va-4d
 for kexec@lists.infradead.org; Tue, 15 Aug 2017 07:32:15 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH 0/2] makedumpfile/ppc64: enable the mem-usage option on ppc64
 platform
Date: Tue, 15 Aug 2017 15:21:04 +0800
Message-Id: <1502781666-20987-1-git-send-email-piliu@redhat.com>
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
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>

Currently, -mem-usage option can work on x86 and arm, and enable it on ppc64

Pingfan Liu (2):
  makedumpfile/ppc64: set page_offset in get_versiondep_info_ppc64()
  makedumpfile/ppc64: get the info of mem reserved for crashkernel

 arch/ppc64.c   | 37 +++++++++++++++++++++++++++++++++++++
 makedumpfile.c | 10 ++++++++++
 makedumpfile.h |  4 ++++
 3 files changed, 51 insertions(+)

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
