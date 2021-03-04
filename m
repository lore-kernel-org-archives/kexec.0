Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHeAM-005ElG-W7
 for kexec@lists.infradead.org; Thu, 04 Mar 2021 02:56:44 +0000
Received: by mail-pf1-f200.google.com with SMTP id z5so759024pfz.19
 for <kexec@lists.infradead.org>; Wed, 03 Mar 2021 18:56:27 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
Subject: [PATCH v1 2/3] i40e: use minimal rx and tx ring buffers for kdump
Date: Thu,  4 Mar 2021 10:55:42 +0800
Message-Id: <20210304025543.334912-3-coxu@redhat.com>
In-Reply-To: <20210304025543.334912-1-coxu@redhat.com>
References: <20210304025543.334912-1-coxu@redhat.com>
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
To: netdev@vger.kernel.org
Cc: kexec@lists.infradead.org, intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, open list <linux-kernel@vger.kernel.org>

Use the minimum of the number of descriptors thus we will allocate the
minimal ring buffers for kdump.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 77bf8c392750..d6868c7aee05 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11029,6 +11029,11 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 		return -ENODATA;
 	}
 
+	if (is_kdump_kernel()) {
+		vsi->num_tx_desc = I40E_MIN_NUM_DESCRIPTORS;
+		vsi->num_rx_desc = I40E_MIN_NUM_DESCRIPTORS;
+	}
+
 	return 0;
 }
 
-- 
2.30.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
