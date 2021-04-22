Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZgRW-00DzXI-Hi
 for kexec@lists.infradead.org; Thu, 22 Apr 2021 21:00:59 +0000
From: "Switzer, David" <david.switzer@intel.com>
Subject: RE: [PATCH v1 1/3] i40e: use minimal tx and rx pairs for kdump
Date: Thu, 22 Apr 2021 21:00:53 +0000
Message-ID: <MW3PR11MB4748DAD8745E21A92A7CD38FEB469@MW3PR11MB4748.namprd11.prod.outlook.com>
References: <20210304025543.334912-1-coxu@redhat.com>
 <20210304025543.334912-2-coxu@redhat.com>
In-Reply-To: <20210304025543.334912-2-coxu@redhat.com>
Content-Language: en-US
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
To: Coiby Xu <coxu@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, Jakub
 Kicinski <kuba@kernel.org>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, open
 list <linux-kernel@vger.kernel.org>


>-----Original Message-----
>From: Coiby Xu <coxu@redhat.com>
>Sent: Wednesday, March 3, 2021 6:56 PM
>To: netdev@vger.kernel.org
>Cc: kexec@lists.infradead.org; intel-wired-lan@lists.osuosl.org; Jakub Kicinski
><kuba@kernel.org>; Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen,
>Anthony L <anthony.l.nguyen@intel.com>; David S. Miller
><davem@davemloft.net>; open list <linux-kernel@vger.kernel.org>
>Subject: [PATCH v1 1/3] i40e: use minimal tx and rx pairs for kdump
>
>Set the number of the MSI-X vectors to 1. When MSI-X is enabled, it's not allowed
>to use more TC queue pairs than MSI-X vectors
>(pf->num_lan_msix) exist. Thus the number of tx and rx pairs
>(vsi->num_queue_pairs) will be equal to the number of MSI-X vectors, i.e., 1.
>
>Signed-off-by: Coiby Xu <coxu@redhat.com>
>---
> drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++++++++
> 1 file changed, 9 insertions(+)
>
Tested-by: Dave Switzer <david.switzer@intel.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
