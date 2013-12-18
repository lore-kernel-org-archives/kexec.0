Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VtDSo-00006F-3d
 for kexec@lists.infradead.org; Wed, 18 Dec 2013 09:30:47 +0000
Date: Wed, 18 Dec 2013 17:29:45 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v6 14/14] x86: kdebugfs do not use __va for getting
 setup_data virt addr
Message-ID: <20131218092945.GC15594@dhcp-16-126.nay.redhat.com>
References: <1387186235-15972-1-git-send-email-dyoung@redhat.com>
 <1387186235-15972-15-git-send-email-dyoung@redhat.com>
 <20131216163501.GB3873@console-pimps.org>
 <20131217062417.GE6751@dhcp-16-126.nay.redhat.com>
 <20131217065346.GG6751@dhcp-16-126.nay.redhat.com>
 <20131217112452.GA3145@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131217112452.GA3145@console-pimps.org>
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

> > 
> > Reproduced it again in normal boot with memmap=exactmap, but I agree it's a corner
> > case, I remember I saw this in kdump kernel, but I still did not see it in today's
> > testing so I think move this issue out of this patch series is fine to me.
>  
> Please include the following oops when you submit this patch again.

Sure, will do if I can reproduce it again in kdump kernel.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
