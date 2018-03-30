Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f1ozq-0002Fk-V8
 for kexec@lists.infradead.org; Fri, 30 Mar 2018 08:02:53 +0000
Date: Fri, 30 Mar 2018 16:02:32 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] powerpc: kexec_file: Fix error code when trying to load
 kdump kernel
Message-ID: <20180330080232.GB4323@dhcp-128-65.nay.redhat.com>
References: <20180329190543.25118-1-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180329190543.25118-1-bauerman@linux.vnet.ibm.com>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On 03/29/18 at 04:05pm, Thiago Jung Bauermann wrote:
> kexec_file_load() on powerpc doesn't support kdump kernels yet, so it
> returns -ENOTSUPP in that case.
> 
> I've recently learned that this errno is internal to the kernel and isn't
> supposed to be exposed to userspace. Therefore, change to -EOPNOTSUPP which
> is defined in an uapi header.
> 
> This does indeed make kexec-tools happier. Before the patch, on ppc64le:
> 
>   # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
>   kexec_file_load failed: Unknown error 524
> 
> After the patch:
> 
>   # ~bauermann/src/kexec-tools/build/sbin/kexec -s -p /boot/vmlinuz
>   kexec_file_load failed: Operation not supported
> 
> Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
> Reported-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/machine_kexec_file_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> This is a minor issue, but since it's a simple patch it might be worth
> applying it to stable branches.
> 
> This is the kexec-tools thread where this problem was brought up:
> 
> https://lists.infradead.org/pipermail/kexec/2018-March/020346.html
> 
> And this is an instance of a similar fix being applied elsewhere in the
> kernel, for the same reasons:
> 
> https://patchwork.kernel.org/patch/8490791/
> 
> The test shown in the commit log was made using Hari Bathini's patch
> adding kexec_file_load() support to kexec-tools in ppc64.
> 
> diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
> index e4395f937d63..45e0b7d5f200 100644
> --- a/arch/powerpc/kernel/machine_kexec_file_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_file_64.c
> @@ -43,7 +43,7 @@ int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
>  
>  	/* We don't support crash kernels yet. */
>  	if (image->type == KEXEC_TYPE_CRASH)
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>  
>  	for (i = 0; i < ARRAY_SIZE(kexec_file_loaders); i++) {
>  		fops = kexec_file_loaders[i];
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
