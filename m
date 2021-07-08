Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-co1nam11on2043.outbound.protection.outlook.com
 ([40.107.220.43] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1O8M-00GAwq-S0
 for kexec@lists.infradead.org; Thu, 08 Jul 2021 07:07:45 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
Subject: [PATCH v2 makedumpfile 0/3] Add option to limit file size
Date: Thu, 8 Jul 2021 16:06:08 +0900
Message-ID: <20210708070611.291260-1-bpoirier@nvidia.com>
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
To: kexec@lists.infradead.org

See feature description in patch "Add -L option to limit output file
size"

v1:
	http://lists.infradead.org/pipermail/kexec/2021-June/022728.html
v2:
	Add patches 1, 2 to support dmesg limit with different kernel
	versions.

	Stricter parsing of -L option value.

	Instead of using RLIMIT_FSIZE, use write_bytes or SEEK_CUR to
	enforce limit. This better integrates with the -F option for
	stdout output.

Benjamin Poirier (3):
  Fix off by one error when checking cache_size
  Dump dmesg using write_and_check_space()
  Add -L option to limit output file size

 makedumpfile.8 |  12 ++++--
 makedumpfile.c | 115 +++++++++++++++++++++++++++++++++++--------------
 makedumpfile.h |   6 ++-
 print_info.c   |   3 ++
 printk.c       |  24 +++++++----
 sadump_info.c  |   2 +-
 6 files changed, 116 insertions(+), 46 deletions(-)

-- 
2.32.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
