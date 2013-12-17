Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vso5a-0002Nj-KU
 for kexec@lists.infradead.org; Tue, 17 Dec 2013 06:25:08 +0000
Date: Tue, 17 Dec 2013 14:24:17 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v6 14/14] x86: kdebugfs do not use __va for getting
 setup_data virt addr
Message-ID: <20131217062417.GE6751@dhcp-16-126.nay.redhat.com>
References: <1387186235-15972-1-git-send-email-dyoung@redhat.com>
 <1387186235-15972-15-git-send-email-dyoung@redhat.com>
 <20131216163501.GB3873@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131216163501.GB3873@console-pimps.org>
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

On 12/16/13 at 04:35pm, Matt Fleming wrote:
> On Mon, 16 Dec, at 05:30:35PM, Dave Young wrote:
> > kdump kernel will use memmap=exactmap kernel cmdline, but __va does not
> > work in case memmap=exactmap, so let's always use ioremap_cache.
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  arch/x86/kernel/kdebugfs.c | 35 +++++++++++------------------------
> >  1 file changed, 11 insertions(+), 24 deletions(-)
> 
> Dave, I've no idea why this change is necessary from the commit log. Is
> it required for kexec to function on EFI? Why does __va() not work in
> the memmap=exactmap case?
> 

During previous kdump tests I saw panics while reading the setup_data in debugfs.
I thought it is caused by some unmapped addresses. At that time I also reproduced
it by booting the non-kexec kernel with memmap=exact.

Since you are asking about this I'm testing it again but I seems can not
reproduce this problem any more, it's weird.

I should dug more about it and save the panic messages.

So let's drop this patch for now, I will keep an eye on this and address it later
if I can find the problem again.

--
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
