Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dD0Q9-0004Yi-OS
 for kexec@lists.infradead.org; Tue, 23 May 2017 03:23:43 +0000
Received: by mail-pf0-f171.google.com with SMTP id n23so100411702pfb.2
 for <kexec@lists.infradead.org>; Mon, 22 May 2017 20:23:21 -0700 (PDT)
Subject: Re: [PATCH 2/2] Revert "[PATCH V2 1/4] x86_64: Calculate page_offset
 from pt_load"
References: <33710E6CAA200E4583255F4FB666C4E20D205C05@G01JPEXMBYT03>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <681cf021-74c0-25d2-a173-23ba50c38cab@redhat.com>
Date: Tue, 23 May 2017 08:53:16 +0530
MIME-Version: 1.0
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E20D205C05@G01JPEXMBYT03>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>, "'ats-kumagai@wm.jp.nec.com'" <ats-kumagai@wm.jp.nec.com>
Cc: "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>, "'bhe@redhat.com'" <bhe@redhat.com>

Hi Hatayama,

On Tuesday 23 May 2017 08:24 AM, Hatayama, Daisuke wrote:
> This reverts commit 0c9dd01d8ee2e4ec1821a11f5e174fdba56012b8 because
> the logic works well only on the kdump ELF format. It doesn't work
> well on sadump vmcores and qemu/KVM guest vmcores created by virsh
> dump --memory-only command where info->page_offset results in 0. These
> formats have to depend on kernel version dependency in the current
> situation.

I do not think that we should just revert it. Revert will break things on  
KASLR enabled kernel.

I have already posted a patch to calculate page_offset when pt_load is not  
available.

http://lists.infradead.org/pipermail/kexec/2017-May/018747.html

Probably,I can improve that patch in next version so that it takes care of  
sadump case as well.

Thanks for reporting this issue.

~Pratyush
>
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Pratyush Anand <panand@redhat.com>
> ---
>  arch/x86_64.c | 25 ++++---------------------
>  1 file changed, 4 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86_64.c b/arch/x86_64.c
> index e978a36..13f0c3f 100644
> --- a/arch/x86_64.c
> +++ b/arch/x86_64.c
> @@ -33,25 +33,6 @@ get_xen_p2m_mfn(void)
>  	return NOT_FOUND_LONG_VALUE;
>  }
>
> -static int
> -get_page_offset_x86_64(void)
> -{
> -	int i;
> -	unsigned long long phys_start;
> -	unsigned long long virt_start;
> -
> -	for (i = 0; get_pt_load(i, &phys_start, NULL, &virt_start, NULL); i++) {
> -		if (virt_start < __START_KERNEL_map
> -				&& phys_start != NOT_PADDR) {
> -			info->page_offset = virt_start - phys_start;
> -			return TRUE;
> -		}
> -	}
> -
> -	ERRMSG("Can't get any pt_load to calculate page offset.\n");
> -	return FALSE;
> -}
> -
>  int
>  get_phys_base_x86_64(void)
>  {
> @@ -179,8 +160,10 @@ get_versiondep_info_x86_64(void)
>  	else
>  		info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_31;
>
> -	if (!get_page_offset_x86_64())
> -		return FALSE;
> +	if (info->kernel_version < KERNEL_VERSION(2, 6, 27))
> +		info->page_offset = __PAGE_OFFSET_ORIG;
> +	else
> +		info->page_offset = __PAGE_OFFSET_2_6_27;
>
>  	if (info->kernel_version < KERNEL_VERSION(2, 6, 31)) {
>  		info->vmemmap_start = VMEMMAP_START_ORIG;
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
