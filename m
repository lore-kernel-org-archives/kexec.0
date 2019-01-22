Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glr2X-0003hF-8I
 for kexec@lists.infradead.org; Tue, 22 Jan 2019 08:04:15 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 0/2] makedumpfile needs to remove the memory encryption
Date: Tue, 22 Jan 2019 16:03:55 +0800
Message-Id: <20190122080357.23381-1-lijiang@redhat.com>
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
Cc: dyoung@redhat.com, k-hagio@ab.jp.nec.com, anderson@redhat.com, bhe@redhat.com

The patchset did two things:
[1] add a new variable 'sme_mask' to number_table

The variable will be used to store the sme mask for crashed kernel,
the sme_mask denotes whether the old memory is encrypted or not.

[2] remove the memory encryption mask to obtain the true physical
address

For AMD machine with SME feature, if SME is enabled in the first
kernel, the crashed kernel's page table(pgd/pud/pmd/pte) contains
the memory encryption mask, so makedumpfile needs to remove the
memory encryption mask to obtain the true physical address.

References:

x86/kdump: Export the SME mask to vmcoreinfo
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=65f750e5457aef9a8085a99d613fea0430303e93
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=f263245a0ce2c4e23b89a58fa5f7dfc048e11929

Lianbo Jiang (2):
  Makedumpfile: add a new variable 'sme_mask' to number_table
  Remove the memory encryption mask to obtain the true physical address

 arch/x86_64.c  | 3 +++
 makedumpfile.c | 4 ++++
 makedumpfile.h | 1 +
 3 files changed, 8 insertions(+)

-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
