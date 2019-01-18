Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkS5o-0005HH-Tn
 for kexec@lists.infradead.org; Fri, 18 Jan 2019 11:13:46 +0000
From: Kairui Song <kasong@redhat.com>
Subject: [PATCH v3 0/3] make kexec work with efi=noruntime or efi=old_map
Date: Fri, 18 Jan 2019 19:13:07 +0800
Message-Id: <20190118111310.29589-1-kasong@redhat.com>
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
Cc: rafael.j.wysocki@intel.com, Kairui Song <kasong@redhat.com>, bhe@redhat.com, erik.schmauss@intel.com, x86@kernel.org, kexec@lists.infradead.org, robert.moore@intel.com, linux-acpi@vger.kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, fanc.fnst@cn.fujitsu.com, lenb@kernel.org

This patch series fix the kexec panic on efi=noruntime or efi=old_map
pass acpi_rsdp_addr to the second kernel and make it boot up properly.

Update from V2:
 - Store acpi rsdp value, and add an acpi_os_get_root_pointer_late as
   a helper, leveraging existing codes so we don't need to reparse RSDP.

Update from V1:
 - Add a cover letter and fix some type in commit message
 - Previous patches are not sent in a single thread

Kairui Song (3):
  x86, kexec_file_load: Don't setup EFI info if EFI runtime is not
    enabled
  acpi: store acpi_rsdp address for later kexec usage
  x86, kexec_file_load: make it work with efi=noruntime or efi=old_map

 arch/x86/kernel/kexec-bzimage64.c | 13 +++++++++++++
 drivers/acpi/osl.c                | 10 ++++++++++
 include/linux/acpi.h              |  3 +++
 3 files changed, 26 insertions(+)

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
