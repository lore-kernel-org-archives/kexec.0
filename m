Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z5sA1-0003mE-6T
 for kexec@lists.infradead.org; Fri, 19 Jun 2015 09:00:29 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5J8wS6X011892
 for <kexec@lists.infradead.org>; Fri, 19 Jun 2015 16:58:28 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v2 00/10] makedumpfile: parallel processing
Date: Fri, 19 Jun 2015 16:56:34 +0800
Message-ID: <1434704204-2634-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

This patch set implements parallel processing by means of multiple threads.
With this patch set, it is available to use multiple threads to read
and compress pages. This parallel process will save time.
This feature only supports creating dumpfile in kdump-compressed format from
vmcore in kdump-compressed format or elf format. Currently, sadump and
 xen kdump are not supported.

Qiao Nuohan (10):
  Add readpage_kdump_compressed_parallel
  Add mappage_elf_parallel
  Add readpage_elf_parallel
  Add read_pfn_parallel
  Add function to initial bitmap for parallel use
  Add filter_data_buffer_parallel
  Add write_kdump_pages_parallel to allow parallel process
  Initial and free data used for parallel process
  Make makedumpfile available to read and compress pages parallelly
  Add usage and manual about multiple threads process

 Makefile       |    2 +
 erase_info.c   |   29 ++-
 erase_info.h   |    2 +
 makedumpfile.8 |   24 ++
 makedumpfile.c | 1096 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 makedumpfile.h |   80 ++++
 print_info.c   |   16 +
 7 files changed, 1246 insertions(+), 3 deletions(-)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
