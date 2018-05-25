Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH] PCI: Try to clean up resources via remove if shutdown
 doesn't exist
References: <1527257063-15843-1-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <d0970733-d56b-9a96-26cd-4c911c127579@codeaurora.org>
Date: Fri, 25 May 2018 10:36:49 -0700
MIME-Version: 1.0
In-Reply-To: <1527257063-15843-1-git-send-email-okaya@codeaurora.org>
Content-Language: en-US
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
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, open list <linux-kernel@vger.kernel.or>

[+cc kexec]

On 5/25/2018 7:04 AM, Sinan Kaya wrote:
> It is up to a driver to implement shutdown() callback. If shutdown()
> callback is not implemented, PCI device can have pending interrupt and
> even do DMA transactions while the system is going down.
> 
> If kexec is in use, this can damage the newly booting kexec kernel
> or even prevent it from booting altogether. Fallback to calling the
> remove() callback if shutdown() isn't implemented for a given driver.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/pci-driver.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 6ace470..4ac72e3 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -475,8 +475,17 @@ static void pci_device_shutdown(struct device *dev)
>  
>  	pm_runtime_resume(dev);
>  
> +	/*
> +	 * Try shutdown callback if it exists, otherwise fallback to remove
> +	 * callback. PCI drivers can do DMA and have pending interrupts.
> +	 * Leaving the DMA and interrupts pending could damage the newly
> +	 * booting kexec kernel as well as prevent it from booting altogether
> +	 * if the pending interrupt is level.
> +	 */
>  	if (drv && drv->shutdown)
>  		drv->shutdown(pci_dev);
> +	else if (drv && drv->remove)
> +		drv->remove(pci_dev);
>  
>  	/*
>  	 * If this is a kexec reboot, turn off Bus Master bit on the
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
