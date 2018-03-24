Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from trem.minaslivre.org ([148.251.208.85] helo=grilo.cascardo.info)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ezrVN-0004hY-3z
 for kexec@lists.infradead.org; Sat, 24 Mar 2018 22:19:18 +0000
Date: Sat, 24 Mar 2018 19:18:50 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@debian.org>
Subject: Re: [PATCH net-next v2 2/2] cxgb4: collect hardware dump in second
 kernel
Message-ID: <20180324221849.GW14312@siri.cascardo.eti.br>
References: <cover.1521888444.git.rahul.lakkireddy@chelsio.com>
 <f06cca21650affa10d83a28dbd7fb577792e35a9.1521888444.git.rahul.lakkireddy@chelsio.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f06cca21650affa10d83a28dbd7fb577792e35a9.1521888444.git.rahul.lakkireddy@chelsio.com>
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
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: indranil@chelsio.com, netdev@vger.kernel.org, nirranjan@chelsio.com, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, davem@davemloft.net, stephen@networkplumber.org, ganeshgr@chelsio.com, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, kexec@lists.infradead.org, ebiederm@xmission.com

On Sat, Mar 24, 2018 at 04:26:34PM +0530, Rahul Lakkireddy wrote:
> Register callback to collect hardware/firmware dumps in second kernel
> before hardware/firmware is initialized.  The dumps for each device
> will be available under /sys/kernel/crashdd/cxgb4/ directory in second
> kernel.
> 
> Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
> Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
> ---
> v2:
> - No Changes.
> 
> Changes since rfc v2:
> - Update comments and commit message for sysfs change.
> 
> rfc v2:
> - Updated dump registration to the new API in patch 1.
[...]
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> index e880be8e3c45..265cb026f868 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> @@ -5527,6 +5527,18 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	if (err)
>  		goto out_free_adapter;
>  
> +	if (is_kdump_kernel()) {
> +		/* Collect hardware state and append to
> +		 * /sys/kernel/crashdd/cxgb4/ directory
> +		 */
> +		err = cxgb4_cudbg_crashdd_add_dump(adapter);
> +		if (err) {
> +			dev_warn(adapter->pdev_dev,
> +				 "Fail collecting crash device dump, err: %d. Continuing\n",
> +				 err);
> +			err = 0;
> +		}
> +	}
>  

The problem I see with this approach is that you require that the driver
is built into the kdump kernel (or present as a module in the kdump
initramfs), and that you will probe the device during the collection of
the dumps.

IMHO, if you are going to require the device to be probed by the same
driver during kdump, you might just as well use the device object itself
to present the crash data. I think that's what Stephen Hemminger meant
when he said to use sysfs. No need at all for any special crashdd. Just
add an attribute or attribute group to the device object.

Otherwise, as Eric Biederman pointed out, you should just add that data
into the vmcore before you kexec, so you don't even need to look at a
different file, and the driver does not even need to be present in the
kdump kernel.

Cascardo.

>  	if (!is_t4(adapter->params.chip)) {
>  		s_qpp = (QUEUESPERPAGEPF0_S +
> -- 
> 2.14.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
