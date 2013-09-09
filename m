Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJ1ag-00062L-EF
 for kexec@lists.infradead.org; Mon, 09 Sep 2013 13:33:19 +0000
Date: Mon, 9 Sep 2013 09:32:48 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/3] drm/radeon: Implement radeon_pci_shutdown
Message-ID: <20130909133248.GH21435@phenom.dumpdata.com>
References: <20130908120947.GA360@x4>
 <20130908121058.GC360@x4>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130908121058.GC360@x4>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, dri-devel@lists.freedesktop.org

On Sun, Sep 08, 2013 at 02:10:58PM +0200, Markus Trippelsdorf wrote:
> Currently radeon devices are not properbly shutdown during kexec. This

properly

> cases a varity of issues, e.g. dpm initialization failures.
> Fix this by implementing a radeon_pci_shutdown function, that unloads
> the driver cleanly.
> 
> Signed-off-by: Markus Trippelsdorf <markus@trippelsdorf.de>
> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index cb4445f..d71edee 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -380,6 +380,15 @@ static const struct file_operations radeon_driver_kms_fops = {
>  #endif
>  };
>  
> +
> +static void
> +radeon_pci_shutdown(struct pci_dev *pdev)
> +{
> +	struct drm_device *dev = pci_get_drvdata(pdev);
> +
> +	radeon_driver_unload_kms(dev);
> +}
> +
>  static struct drm_driver kms_driver = {
>  	.driver_features =
>  	    DRIVER_USE_AGP |
> @@ -453,6 +462,7 @@ static struct pci_driver radeon_kms_pci_driver = {
>  	.remove = radeon_pci_remove,
>  	.suspend = radeon_pci_suspend,
>  	.resume = radeon_pci_resume,
> +	.shutdown = radeon_pci_shutdown,
>  };
>  
>  static int __init radeon_init(void)
> -- 
> Markus
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
