Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vuyio-0001Xm-Ii
 for kexec@lists.infradead.org; Mon, 23 Dec 2013 06:10:35 +0000
Date: Mon, 23 Dec 2013 14:09:50 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v7 09/12] efi: passing kexec necessary efi data via
 setup_data
Message-ID: <20131223060950.GA9279@dhcp-16-126.nay.redhat.com>
References: <1387533742-18018-1-git-send-email-dyoung@redhat.com>
 <1387533742-18018-10-git-send-email-dyoung@redhat.com>
 <20131221160416.GD29501@console-pimps.org>
 <20131223020958.GB3760@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131223020958.GB3760@dhcp-16-126.nay.redhat.com>
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
To: Matt Fleming <matt@console-pimps.org>
Cc: mjg59@srcf.ucam.org, msalter@redhat.com, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, leif.lindholm@linaro.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, mingo@kernel.org, vgoyal@redhat.com

> > Do we actually need the 'map' entry in efi_setup_data now that you're
> > passing it via efi_info (which is much better approach!)? Also, we don't
> > need the global nr_efi_runtime_map or efi_runtime_map variables now,
> > right?
> 
> The map is still necessary because we need store the map somewhere and pass
> the physicall address to kexec kernel. Passing them in setup_data is the
> only better way currently...
> 
> In efi_info there's only an entry for the map physical address, the original
> map area is not valid any more.

For kexec kernel it might be ok to use the old map area, but for kdump kernel
we can only use the memory which is early reserved with crashkernel= cmdline.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
