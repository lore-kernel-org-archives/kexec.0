Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YsM8a-0002ZS-LX
 for kexec@lists.infradead.org; Wed, 13 May 2015 02:11:09 +0000
Date: Wed, 13 May 2015 10:10:27 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v11 07/10] iommu/vt-d: enable kdump support in iommu module
Message-ID: <20150513021027.GA3736@dhcp-128-28.nay.redhat.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-8-git-send-email-zhen-hual@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1431337974-545-8-git-send-email-zhen-hual@hp.com>
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
To: "Li, Zhen-Hua" <zhen-hual@hp.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, tom.vaden@hp.com, rwright@hp.com, dwmw2@infradead.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dyoung@redhat.com, vgoyal@redhat.com

On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
> Modify the operation of the following functions when called during crash dump:
>     iommu_context_addr
>     free_context_table
>     get_domain_for_dev
>     init_dmars
>     intel_iommu_init
> 
> Bill Sumner:
>     Original version.
> 
> Zhenhua:
>     The name of new calling functions.
>     Do not disable and re-enable TE in kdump kernel.
>     Use the did and gaw from old context entry;
> 
> Signed-off-by: Bill Sumner <billsumnerlinux@gmail.com>
> Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
> ---
>  drivers/iommu/intel-iommu.c | 95 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 83 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 28c3c64..91545bf 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -397,6 +397,7 @@ static int copy_root_entry_table(struct intel_iommu *iommu);
>  static int intel_iommu_load_translation_tables(struct intel_iommu *iommu);
>  
>  static void iommu_check_pre_te_status(struct intel_iommu *iommu);
> +static u8 g_translation_pre_enabled;
Hi Zhenhua,

I haven't checked patch one by one, am going through the code flow.

About g_translation_pre_enabled, I don't think it's necessary to define
it as a global variable. Both its assignment and judgement are in
init_dmars(). In this situation a local variable translation_pre_enabled
in init_dmars() is enough.

You can assign value to it here:

		iommu_check_pre_te_status(iommu);
		if (iommu->pre_enabled_trans) {
			translation_pre_enabled = 1;
			...
		}

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
