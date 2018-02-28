Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132] helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.89 #1 (Red Hat Linux))
 id 1eqvvn-0005z1-Pb
 for kexec@lists.infradead.org; Wed, 28 Feb 2018 07:13:41 +0000
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [RESEND makedumpfile PATCH 0/2] Add 5-level paging support
Date: Wed, 28 Feb 2018 15:13:06 +0800
Message-ID: <20180228071308.17854-1-douly.fnst@cn.fujitsu.com>
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
Cc: mas-tachibana@vf.jp.nec.com, indou.takao@jp.fujitsu.com, mas-hayashi@tg.jp.nec.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

this patchset adds 5-level paging support in makedumpfile

 -the 1th patch does some cleanup for the preparation of 5-level page tables support
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
