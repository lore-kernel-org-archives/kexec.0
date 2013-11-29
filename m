Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VmJh1-0001jd-IP
 for kexec@lists.infradead.org; Fri, 29 Nov 2013 08:44:56 +0000
Date: Fri, 29 Nov 2013 16:44:14 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 09/12] x86: add xloadflags bit for efi runtime support
 on kexec
Message-ID: <20131129084414.GD4186@dhcp-16-126.nay.redhat.com>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-10-git-send-email-dyoung@redhat.com>
 <20131127142732.GF32267@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131127142732.GF32267@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 11/27/13 at 03:27pm, Borislav Petkov wrote:
> On Tue, Nov 26, 2013 at 01:57:54PM +0800, Dave Young wrote:
> > Old kexec-tools can not load new kernel. The reason is previously kexec-tools
> 
> The reason is, kexec-tools ... previously, thus efi failed to initialize ...

Good suggestion

> 
> > do not fill efi_info in x86 setup header thus efi init fail and switch
> > to noefi boot. In new kexec-tools it will by default fill efi_info and
> > pass other efi required infomation to 2nd kernel so kexec kernel efi
> > initialization will success finally.
> 
> 		      succeed

Will fix

> 
> > 
> > To prevent from breaking userspace, add a new xloadflags bit so kexec-tools
> > will check the flag and switch to old logic.
> > 
> > changelog:
> > Matt: +&& defined(CONFIG_KEXEC)
> > HPA: document the flag.
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> 
> Other than that:
> 
> Acked-by: Borislav Petkov <bp@suse.de>
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
