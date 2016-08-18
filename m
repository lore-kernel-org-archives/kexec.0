Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 18 Aug 2016 16:23:39 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2 1/2] kexec: add dtb info to struct kimage
Message-ID: <20160818082339.GB845@dhcp-128-65.nay.redhat.com>
References: <1470956638-3589-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1470956638-3589-2-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1470956638-3589-2-git-send-email-bauerman@linux.vnet.ibm.com>
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
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, AKASHI Takahiro <takahiro.akashi@linaro.org>, David Laight <David.Laight@ACULAB.COM>, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>, linux-arm-kernel@lists.infradead.org

On 08/11/16 at 08:03pm, Thiago Jung Bauermann wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> Device tree blob must be passed to a second kernel on DTB-capable
> archs, like powerpc and arm64, but the current kernel interface
> lacks this support.
> 
> This patch adds dtb buffer information to struct kimage.
> When users don't specify dtb explicitly and the one used for the current
> kernel can be re-used, this change will be good enough for implementing
> kexec_file_load feature.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  include/linux/kexec.h | 3 +++
>  kernel/kexec_file.c   | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index d7437777baaa..4f85d284ed0b 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -192,6 +192,9 @@ struct kimage {
>  	char *cmdline_buf;
>  	unsigned long cmdline_buf_len;
>  
> +	void *dtb_buf;
> +	unsigned long dtb_buf_len;
> +
>  	/* File operations provided by image loader */
>  	struct kexec_file_ops *fops;
>  
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 503bc2d348e5..113af2f219b9 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -92,6 +92,9 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>  	vfree(image->initrd_buf);
>  	image->initrd_buf = NULL;
>  
> +	vfree(image->dtb_buf);
> +	image->dtb_buf = NULL;
> +
>  	kfree(image->cmdline_buf);
>  	image->cmdline_buf = NULL;
>  
> -- 
> 1.9.1
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
