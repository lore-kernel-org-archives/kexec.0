Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VxG4O-0000yj-VE
 for kexec@lists.infradead.org; Sun, 29 Dec 2013 13:06:17 +0000
Date: Sun, 29 Dec 2013 13:05:46 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH v7 09/12] efi: passing kexec necessary efi data via
 setup_data
Message-ID: <20131229130546.GA2618@console-pimps.org>
References: <1387533742-18018-1-git-send-email-dyoung@redhat.com>
 <1387533742-18018-10-git-send-email-dyoung@redhat.com>
 <20131221160416.GD29501@console-pimps.org>
 <20131223020958.GB3760@dhcp-16-126.nay.redhat.com>
 <20131223080741.GB28919@console-pimps.org>
 <20131225031259.GB6333@dhcp-16-126.nay.redhat.com>
 <20131225033205.GC6333@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131225033205.GC6333@dhcp-16-126.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: mjg59@srcf.ucam.org, msalter@redhat.com, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, leif.lindholm@linaro.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, mingo@kernel.org, vgoyal@redhat.com

On Wed, 25 Dec, at 11:32:05AM, Dave Young wrote:
> 
> Matt, if you want to remove the map[0] please fold below one line
> patch? I have no strong opinion.
> 
> Index: linux/arch/x86/include/asm/efi.h
> ===================================================================
> --- linux.orig/arch/x86/include/asm/efi.h
> +++ linux/arch/x86/include/asm/efi.h
> @@ -139,7 +139,6 @@ struct efi_setup_data {
>  	u64 tables;
>  	u64 smbios;
>  	u64 reserved[8];
> -	efi_memory_desc_t map[0];
>  };
>  
>  extern u64 efi_setup;

Thanks Dave, I will fold this in. I would suggest updating your
kexec-tools patches so that the two structures are in sync.

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
