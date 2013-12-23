Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vuuvr-0006iw-5E
 for kexec@lists.infradead.org; Mon, 23 Dec 2013 02:07:50 +0000
Date: Mon, 23 Dec 2013 10:06:48 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v7 09/12] efi: passing kexec necessary efi data via
 setup_data
Message-ID: <20131223020648.GA3760@dhcp-16-126.nay.redhat.com>
References: <1387533742-18018-1-git-send-email-dyoung@redhat.com>
 <1387533742-18018-10-git-send-email-dyoung@redhat.com>
 <20131221145348.GC29501@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131221145348.GC29501@console-pimps.org>
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

> > +		if (data)
> > +			early_memunmap(data, sizeof(*data));
> >  #ifdef CONFIG_X86_32
> >  		if (tmp >> 32) {
> >  			pr_err("EFI data located above 4GB, disabling EFI.\n");
> 
> This isn't correct, and means we now won't trigger this pr_err() if
> booting a CONFIG_X86_32 kernel with EFI_64BIT and where the ->fw_vendor,
> ->runtime or ->tables pointer is above 4GB - you've mixed up systab and
> systab64. I've fixed this up like so when applying this patch,

You are right, I missed this 32bit tmp value, thanks for taking care of this.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
