Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZDO7t-0002sO-Uw
 for kexec@lists.infradead.org; Fri, 10 Jul 2015 02:33:22 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t6A2V8gH010643
 for <kexec@lists.infradead.org>; Fri, 10 Jul 2015 10:31:08 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v1 0/4] makedumpfile: optimize the way of generating
 incomplete kdump core
Date: Fri, 10 Jul 2015 10:28:49 +0800
Message-ID: <1436495333-22892-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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


In current implementation, when generating kdump core,
it behaves as the following logic.

1. Write page header into the buffer cd_header.
2. If buffer is full, flush the buffer.
3. Write page data into the buffer cd_page.
4. If buffer is full, flush the buffer.

When enospc occurs in flushing cd_page, it always still
has much data in cd_header. The size of page data is 170
times the size of page header. It leads to that quite a
lot of page data been written into file can't be used.

The page header may also meet that. The page data can be
compressed, so the size of page data can also be much smaller
than the size of page header.

This patch set changes the logic of generating kdump core.
The new logic is:

1. Before writing page header and data into buffer, if the buffer
   will be full, write the data of the buffer into file.
2. Then, write the page header and data info buffer.

When enospc occurs in writing the cd_header into file, fill the
cd_header with zero and re-write the cd_header.
When enospc occurs in writing the cd_page into file, fill part
of the cd_header with zero according to how many pages in cd_page
have been written. 

Zhou Wenjian (4):
  Add write_cd_buf
  Add get_pfn_offset
  Add write_kdump_page
  Use write_kdump_page instead of write_cache in
    write_kdump_pages_cyclic

 makedumpfile.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 96 insertions(+), 11 deletions(-)

-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
