Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 25 Sep 2019 14:05:33 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 13/17] kexec: add machine_kexec_post_load()
Message-ID: <20190925060533.GB30921@dhcp-128-65.nay.redhat.com>
References: <20190923203427.294286-1-pasha.tatashin@soleen.com>
 <20190923203427.294286-14-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190923203427.294286-14-pasha.tatashin@soleen.com>
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, mark.rutland@arm.com, vladimir.murzin@arm.com, corbet@lwn.net, marc.zyngier@arm.com, catalin.marinas@arm.com, bhsharma@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, linux-mm@kvack.org, james.morse@arm.com, ebiederm@xmission.com, matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org

On 09/23/19 at 04:34pm, Pavel Tatashin wrote:
> It is the same as machine_kexec_prepare(), but is called after segments are
> loaded. This way, can do processing work with already loaded relocation
> segments. One such example is arm64: it has to have segments loaded in
> order to create a page table, but it cannot do it during kexec time,
> because at that time allocations won't be possible anymore.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/kexec.c          | 4 ++++
>  kernel/kexec_core.c     | 6 ++++++
>  kernel/kexec_file.c     | 4 ++++
>  kernel/kexec_internal.h | 2 ++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 1b018f1a6e0d..27b71dc7b35a 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -159,6 +159,10 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  
>  	kimage_terminate(image);
>  
> +	ret = machine_kexec_post_load(image);
> +	if (ret)
> +		goto out;
> +
>  	/* Install the new kernel and uninstall the old */
>  	image = xchg(dest_image, image);
>  
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 2c5b72863b7b..8360645d1bbe 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -587,6 +587,12 @@ static void kimage_free_extra_pages(struct kimage *image)
>  	kimage_free_page_list(&image->unusable_pages);
>  
>  }
> +
> +int __weak machine_kexec_post_load(struct kimage *image)
> +{
> +	return 0;
> +}
> +
>  void kimage_terminate(struct kimage *image)
>  {
>  	if (*image->entry != 0)
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index b8cc032d5620..cb531d768114 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -391,6 +391,10 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  
>  	kimage_terminate(image);
>  
> +	ret = machine_kexec_post_load(image);
> +	if (ret)
> +		goto out;
> +
>  	/*
>  	 * Free up any temporary buffers allocated which are not needed
>  	 * after image has been loaded
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index 48aaf2ac0d0d..39d30ccf8d87 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -13,6 +13,8 @@ void kimage_terminate(struct kimage *image);
>  int kimage_is_destination_range(struct kimage *image,
>  				unsigned long start, unsigned long end);
>  
> +int machine_kexec_post_load(struct kimage *image);
> +
>  extern struct mutex kexec_mutex;
>  
>  #ifdef CONFIG_KEXEC_FILE
> -- 
> 2.23.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
