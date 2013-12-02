Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnJcV-0003Kv-TQ
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 02:52:24 +0000
Date: Mon, 2 Dec 2013 10:51:41 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 06/12] efi: export efi runtime memory mapping to sysfs
Message-ID: <20131202025141.GE3999@dhcp-16-126.nay.redhat.com>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-7-git-send-email-dyoung@redhat.com>
 <20131127114402.GB32267@pd.tnic>
 <20131129094034.GI4186@dhcp-16-126.nay.redhat.com>
 <20131129115029.GB4266@pd.tnic>
 <20131129115953.GD11775@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131129115953.GD11775@console-pimps.org>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, Borislav Petkov <bp@alien8.de>, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 11/29/13 at 11:59am, Matt Fleming wrote:
> On Fri, 29 Nov, at 12:50:29PM, Borislav Petkov wrote:
> > > I did not add KEXEC because I thought it can be used for debugging
> > > purpose.
> > 
> > mfleming is thinking about it :)
>  
> I finally finished my thought. The sysfs code should be automatically
> enabled only if CONFIG_KEXEC is enabled, and not on my default because
> it is a debug interface. While it's true that the code may be useful for
> debugging the memory mappings of EFI systems, it doesn't make sense to
> always turn it on just for CONFIG_X86 and CONFIG_EFI.

Ok, will enable it only for CONFIG_X86 and CONFIG_EFI and CONFIG_KEXEC

> 
> -- 
> Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
