Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VrQoK-0003MQ-B1
 for kexec@lists.infradead.org; Fri, 13 Dec 2013 11:21:37 +0000
Date: Fri, 13 Dec 2013 15:27:42 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 09/14] efi: passing kexec necessary efi data via
 setup_data
Message-ID: <20131213072742.GC11164@dhcp-16-126.nay.redhat.com>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-10-git-send-email-dyoung@redhat.com>
 <20131211222057.GB8863@pd.tnic>
 <20131212030619.GG3751@dhcp-16-126.nay.redhat.com>
 <20131212071743.GJ3751@dhcp-16-126.nay.redhat.com>
 <20131212210439.GB30162@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131212210439.GB30162@pd.tnic>
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

On 12/12/13 at 10:04pm, Borislav Petkov wrote:
> On Thu, Dec 12, 2013 at 03:17:43PM +0800, Dave Young wrote:
> > Rethink about this issue, moving them to efi_$(BITS).c I need move the
> > efi_setup from a static variable to an extern, It looks not worth.
> 
> Dave, would you please do what is suggested to you? A big part of
> the efi code is split into 32-bit and 64-bit functionality. If you
> have a serious argument why it shouldn't be done so then sure, by all
> means, but stop coming up with silly arguments like having an extern
> declaration is a bad thing. Please.

Ok, will do.

--
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
