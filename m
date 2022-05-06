From: Baoquan He <bhe@redhat.com>
Date: Sat, 7 May 2022 07:14:51 +0800
Subject: [PATCH v24 6/6] docs: kdump: Update the crashkernel description
 for arm64
In-Reply-To: <20220506114402.365-7-thunder.leizhen@huawei.com>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-7-thunder.leizhen@huawei.com>
Message-ID: <20220506231451.GB122876@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/06/22 at 07:44pm, Zhen Lei wrote:
> Now arm64 has added support for "crashkernel=X,high" and
> "crashkernel=Y,low". Unlike x86, crash low memory is not allocated if
> "crashkernel=Y,low" is not specified.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 3f1cc5e317ed4a5..aa44c61114aa4b8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -808,7 +808,7 @@
>  			Documentation/admin-guide/kdump/kdump.rst for an example.
>  
>  	crashkernel=size[KMG],high
> -			[KNL, X86-64] range could be above 4G. Allow kernel
> +			[KNL, X86-64, ARM64] range could be above 4G. Allow kernel
>  			to allocate physical memory region from top, so could
>  			be above 4G if system have more than 4G ram installed.
>  			Otherwise memory region will be allocated below 4G, if
> @@ -821,7 +821,7 @@
>  			that require some amount of low memory, e.g. swiotlb
>  			requires at least 64M+32K low memory, also enough extra
>  			low memory is needed to make sure DMA buffers for 32-bit
> -			devices won't run out. Kernel would try to allocate at
> +			devices won't run out. Kernel would try to allocate
>  			at least 256M below 4G automatically.
>  			This one let user to specify own low range under 4G
>  			for second kernel instead.
> @@ -829,6 +829,11 @@
>  			It will be ignored when crashkernel=X,high is not used
>  			or memory reserved is below 4G.
>  
> +			[KNL, ARM64] range in low memory.
> +			This one let user to specify a low range in DMA zone for
                                          ^ not needed,
                        Maybe Catalin can fix it when merging.

Other than this, LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> +			crash dump kernel.
> +			It will be ignored when crashkernel=X,high is not used.
> +
>  	cryptomgr.notests
>  			[KNL] Disable crypto self-tests
>  
> -- 
> 2.25.1
> 


