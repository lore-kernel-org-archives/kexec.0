Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jY5Pf-0006FT-A8
 for kexec@lists.infradead.org; Mon, 11 May 2020 10:11:57 +0000
Received: by mail-pj1-f69.google.com with SMTP id o13so17180742pjb.7
 for <kexec@lists.infradead.org>; Mon, 11 May 2020 03:11:48 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v2 0/2] net: Optimize the qed* allocations inside kdump kernel
Date: Mon, 11 May 2020 15:41:40 +0530
Message-Id: <1589191902-958-1-git-send-email-bhsharma@redhat.com>
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
To: netdev@vger.kernel.org
Cc: aelior@marvell.com, irusskikh@marvell.com, manishc@marvell.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, GR-everest-linux-l2@marvell.com, bhupesh.linux@gmail.com, davem@davemloft.net

Changes since v1:
----------------
- v1 can be seen here: http://lists.infradead.org/pipermail/kexec/2020-May/024935.html
- Addressed review comments received on v1:
  * Removed unnecessary paranthesis.
  * Used a different macro for minimum RX/TX ring count value in kdump
    kernel.

Since kdump kernel(s) run under severe memory constraint with the
basic idea being to save the crashdump vmcore reliably when the primary
kernel panics/hangs, large memory allocations done by a network driver
can cause the crashkernel to panic with OOM.

The qed* drivers take up approximately 214MB memory when run in the
kdump kernel with the default configuration settings presently used in
the driver. With an usual crashkernel size of 512M, this allocation
is equal to almost half of the total crashkernel size allocated.

See some logs obtained via memstrack tool (see [1]) below:
 dracut-pre-pivot[676]: ======== Report format module_summary: ========
 dracut-pre-pivot[676]: Module qed using 149.6MB (2394 pages), peak allocation 149.6MB (2394 pages)
 dracut-pre-pivot[676]: Module qede using 65.3MB (1045 pages), peak allocation 65.3MB (1045 pages)

This patchset tries to reduce the overall memory allocation profile of
the qed* driver when they run in the kdump kernel. With these
optimization we can see a saving of approx 85M in the kdump kernel:
 dracut-pre-pivot[671]: ======== Report format module_summary: ========
 dracut-pre-pivot[671]: Module qed using 124.6MB (1993 pages), peak allocation 124.7MB (1995 pages)
 <..snip..>
 dracut-pre-pivot[671]: Module qede using 4.6MB (73 pages), peak allocation 4.6MB (74 pages)

And the kdump kernel can save vmcore successfully via both ssh and nfs
interfaces.

This patchset contains two patches:
[PATCH 1/2] - Reduces the default TX and RX ring count in kdump kernel.
[PATCH 2/2] - Disables qed SRIOV feature in kdump kernel (as it is
              normally not a supported kdump target for saving
	      vmcore).

[1]. Memstrack tool: https://github.com/ryncsn/memstrack

Bhupesh Sharma (2):
  net: qed*: Reduce RX and TX default ring count when running inside
    kdump kernel
  net: qed: Disable SRIOV functionality inside kdump kernel

 drivers/net/ethernet/qlogic/qed/qed_sriov.h  | 10 +++++++---
 drivers/net/ethernet/qlogic/qede/qede.h      |  2 ++
 drivers/net/ethernet/qlogic/qede/qede_main.c | 13 ++++++++++---
 3 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
