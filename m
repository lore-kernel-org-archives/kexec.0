Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VnJKV-00036a-DH
 for kexec@lists.infradead.org; Mon, 02 Dec 2013 02:33:48 +0000
Date: Mon, 2 Dec 2013 10:32:52 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 00/12] kexec kernel efi runtime support
Message-ID: <20131202023252.GB3999@dhcp-16-126.nay.redhat.com>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <20131127125003.GG18170@console-pimps.org>
 <20131128020840.GB4282@dhcp-16-126.nay.redhat.com>
 <20131129082822.GA4186@dhcp-16-126.nay.redhat.com>
 <20131129170235.GG4266@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131129170235.GG4266@pd.tnic>
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
Cc: Matt Fleming <matt@console-pimps.org>, linux-efi@vger.kernel.org, toshi.kani@hp.com, mjg59@srcf.ucam.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 11/29/13 at 06:02pm, Borislav Petkov wrote:
> On Fri, Nov 29, 2013 at 04:28:22PM +0800, Dave Young wrote:
> > I think for anyone who are using early_memremap should know this is a
> > normal kernel memory instead of real __iomem
> 
> You can never ever assume that people are using kernel interfaces
> correctly.

But the semantic of early_memreamp should be that it will just return
a normal memory pointer instead of iomem so the fix to convert the internal
implementation to return a __force __kernel make sense to me.

For iounmap I think since we have early_memremap, we have reason to add
early_memunmap() so sparse will be happy.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
