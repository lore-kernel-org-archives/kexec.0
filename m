Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjLVI-0000YD-Qu
 for kexec@lists.infradead.org; Tue, 15 Jan 2019 09:59:30 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH 0/2] make kexec work with efi=noruntime or efi=old_map
Date: Tue, 15 Jan 2019 17:58:32 +0800
Message-Id: <20190115095834.22617-1-kasong@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, Kairui Song <kasong@redhat.com>, bhe@redhat.com, erik.schmauss@intel.com, x86@kernel.org, kexec@lists.infradead.org, robert.moore@intel.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, lenb@kernel.org

This patch series fix the kexec panic on efi=noruntime or efi=old_map
and leverage acpi_rsdp_addr to make the second kernel boot up properly.

Kairui Song (2):
  x86, kexec_file_load: Don't setup EFI info if EFI runtime is not
    enabled
  x86, kexec_file_load: make it work with efi=noruntime or efi=old_map

Update from V1:
 - Add a cover letter and fix some type in commit message
 - Previous patches are not sent in a single thread

 arch/x86/kernel/kexec-bzimage64.c | 24 ++++++++++++++++++++++++
 drivers/acpi/acpica/tbxfroot.c    |  3 +--
 include/acpi/acpixf.h             |  2 +-
 3 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
