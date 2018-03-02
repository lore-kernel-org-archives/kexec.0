Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1erdYx-00054e-SG
 for kexec@lists.infradead.org; Fri, 02 Mar 2018 05:49:01 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/4] Makedumpfile: Add 5-level paging support
Date: Fri,  2 Mar 2018 13:48:37 +0800
Message-Id: <20180302054841.22195-1-bhe@redhat.com>
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
Cc: douly.fnst@cn.fujitsu.com, indou.takao@jp.fujitsu.com, mas-hayashi@tg.jp.nec.com, Baoquan He <bhe@redhat.com>, mas-tachibana@vf.jp.nec.com

Kernel has 5-level paging support and now can support boot-time
switching between 4/5-level paging mode. This patchset is used to add
5-level paging support in makedumpfile.

A kernel fix is posted to export 'pgtable_l5_enabled' to tell if
the corrupted kernel is in 5-level paging mode.
https://patchwork.kernel.org/patch/10253399/

Patch 0001 and 0004 were made by Dou Liyang. While it doesn't work on
the latest 5-level code. So add patch 0002 to introduce 'pgtable_l5_enabled'.
Change and take out the function check_5level_paging() from dou's old
patch and add it into patch 0003. Except of these, don't touch other
part of dou's patches.

Thanks, dou, for the effort!

Baoquan He (2):
  Makedumpfile: Add pgtable_l5_enabled to number_table
  Makedumpfile: Add a new function check_5level_paging()

Dou Liyang (2):
  arch/x86_64: Cleanup the address translation of the 4-level page
    tables
  arch/x86_64: Add 5-level paging support

 arch/x86_64.c  | 130 +++++++++++++++++++++++++++++++++++++++++----------------
 makedumpfile.c |   3 ++
 makedumpfile.h |  39 +++++++++++------
 3 files changed, 123 insertions(+), 49 deletions(-)

-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
