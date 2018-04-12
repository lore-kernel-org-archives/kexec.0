Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f6gsp-0003Fm-NQ
 for kexec@lists.infradead.org; Thu, 12 Apr 2018 18:23:45 +0000
Subject: [PATCH v1 0/2] kexec: Remove "weak" annotations from headers
From: Bjorn Helgaas <helgaas@kernel.org>
Date: Thu, 12 Apr 2018 13:23:29 -0500
Message-ID: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
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
To: Eric Biederman <ebiederm@xmission.com>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

"Weak" annotations in header files are error-prone because they make
every definition weak.  Remove them from include/linux/kexec.h.

These were introduced in two separate commits, so this is in two
patches so they can be easily backported to stable kernels (some of
them date back to v4.3 and one only goes back to v4.10).

---

Bjorn Helgaas (2):
      kexec: Remove "weak" from kexec_file function declarations
      kexec: Remove "weak" from arch_kexec_walk_mem() declaration


 include/linux/kexec.h |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
