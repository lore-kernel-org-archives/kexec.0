Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZgQN-00DzVB-Tv
 for kexec@lists.infradead.org; Thu, 22 Apr 2021 20:59:49 +0000
From: "Switzer, David" <david.switzer@intel.com>
Subject: RE: [PATCH v1 2/3] i40e: use minimal rx and tx ring buffers for kdump
Date: Thu, 22 Apr 2021 20:59:40 +0000
Message-ID: <MW3PR11MB474851ACCF8ADCC33EA928C6EB469@MW3PR11MB4748.namprd11.prod.outlook.com>
References: <20210304025543.334912-1-coxu@redhat.com>
 <20210304025543.334912-3-coxu@redhat.com>
In-Reply-To: <20210304025543.334912-3-coxu@redhat.com>
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
>Subject: [PATCH v1 2/3] i40e: use minimal rx and tx ring buffers for kdump
>
>Use the minimum of the number of descriptors thus we will allocate the minimal
>ring buffers for kdump.
>
>Signed-off-by: Coiby Xu <coxu@redhat.com>
>---
> drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
Tested-by: Dave Switzer <david.switzer@intel.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
