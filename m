Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g4Z8K-00010A-5H
 for kexec@lists.infradead.org; Mon, 24 Sep 2018 22:15:13 +0000
Subject: [PATCH 0/3] find_next_iomem_res() fixes
From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 24 Sep 2018 17:14:37 -0500
Message-ID: <153782698067.130337.12079523922130875402.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180921073211.20097-2-lijiang@redhat.com>
References: <20180921073211.20097-2-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: dan.j.williams@intel.com, brijesh.singh@amd.com, bhe@redhat.com, thomas.lendacky@amd.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, tglx@linutronix.de, bp@suse.de, dyoung@redhat.com, akpm@linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Hi Lianbo,

These three patches are a possible replacement for your first patch
("[PATCH 1/3 v3] resource: fix an error which walks through iomem
resources").

I think the interface of find_next_iomem_res() can be improved to make
the code easier to read and also avoid the errors you're fixing.

I can't test these, so they've only been compiled.  If you can test
them and if you like them, feel free to incorporate them into your
series.  If not, just drop them (but please at least fix the same
error in walk_system_ram_range()).

---

Bjorn Helgaas (3):
      x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one error
      resource: Include resource end in walk_*() interfaces
      resource: Fix find_next_iomem_res() iteration issue


 arch/x86/include/asm/kexec.h |    2 -
 kernel/resource.c            |   96 ++++++++++++++++++------------------------
 2 files changed, 43 insertions(+), 55 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
