Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYWHg-0005tA-2n
 for kexec@lists.infradead.org; Sun, 16 Dec 2018 13:16:41 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 0/2 v3] kdump,
 vmcoreinfo: Export the value of sme mask to vmcoreinfo
Date: Sun, 16 Dec 2018 21:16:15 +0800
Message-Id: <20181216131617.2612-1-lijiang@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

This patchset did two things:
a. add a new document for vmcoreinfo

This document lists some variables that export to vmcoreinfo, and briefly
describles what these variables indicate. It should be instructive for
many people who do not know the vmcoreinfo, and it would normalize the
exported variable as a standard ABI between kernel and use-space.

b. export the value of sme mask to vmcoreinfo

For AMD machine with SME feature, makedumpfile tools need to know whether
the crash kernel was encrypted or not. If SME is enabled in the first
kernel, the crash kernel's page table(pgd/pud/pmd/pte) contains the
memory encryption mask, so need to remove the sme mask to obtain the true
physical address.

Changes since v1:
1. No need to export a kernel-internal mask to userspace, so copy the
value of sme_me_mask to a local variable 'sme_mask' and write the value
of sme_mask to vmcoreinfo.
2. Add comment for the code.
3. Improve the patch log.
4. Add the vmcoreinfo documentation.

Changes since v2:
1. Improve the vmcoreinfo document, add more descripts for these
variables exported.
2. Fix spelling errors in the document.

Lianbo Jiang (2):
  kdump: add the vmcoreinfo documentation
  kdump,vmcoreinfo: Export the value of sme mask to vmcoreinfo

 Documentation/kdump/vmcoreinfo.txt | 456 +++++++++++++++++++++++++++++
 arch/x86/kernel/machine_kexec_64.c |  14 +
 2 files changed, 470 insertions(+)
 create mode 100644 Documentation/kdump/vmcoreinfo.txt

-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
