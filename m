Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132] helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.89 #1 (Red Hat Linux))
 id 1ej1f7-0000Nu-Vi
 for kexec@lists.infradead.org; Tue, 06 Feb 2018 11:43:47 +0000
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [makedumpfile PATCH 0/2] Add 5-level paging support
Date: Tue, 6 Feb 2018 19:43:01 +0800
Message-ID: <20180206114303.7077-1-douly.fnst@cn.fujitsu.com>
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
To: ats-kumagai@wm.jp.nec.com, mas-tachibana@vf.jp.nec.com, indou.takao@jp.fujitsu.com
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>, kexec@lists.infradead.org

this patchset adds 5-level paging support in makedumpfile

 -the 1th patch does some cleanup for the 4-level page
 -the 2th patch add the 5-level page tables support

Dou Liyang (2):
  arch/x86_64: Cleanup the address translation of the 4-level page
    tables
  arch/x86_64: Add 5-level paging support

 arch/x86_64.c  | 131 +++++++++++++++++++++++++++++++++++++++++----------------
 makedumpfile.h |  38 +++++++++++------
 2 files changed, 120 insertions(+), 49 deletions(-)

-- 
2.14.3




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
