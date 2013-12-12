Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqveN-0007RM-9E
 for kexec@lists.infradead.org; Thu, 12 Dec 2013 02:05:16 +0000
Date: Thu, 12 Dec 2013 10:04:26 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 02/14] efi: use early_memremap and early_memunmap
Message-ID: <20131212020426.GA3751@dhcp-16-126.nay.redhat.com>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-3-git-send-email-dyoung@redhat.com>
 <20131211103903.GC19196@console-pimps.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131211103903.GC19196@console-pimps.org>
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
Cc: mjg59@srcf.ucam.org, Mark Salter <msalter@redhat.com>, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On 12/11/13 at 10:39am, Matt Fleming wrote:
> (Cc'ing Leif and Mark for the ARM-side of things)
> 
> On Mon, 09 Dec, at 05:42:15PM, Dave Young wrote:
> > In arch/x86/platform/efi/efi.c and drivers/firmware/efi/efi.c turn to use
> > early_memremap/early_memunmap instead of early_ioremap/early_iounmap so sparse
> > will be happy.
> > 
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  arch/x86/platform/efi/efi.c | 20 ++++++++++----------
> >  drivers/firmware/efi/efi.c  |  4 ++--
> >  2 files changed, 12 insertions(+), 12 deletions(-)
>  
> This looks like a rather nice cleanup but the commit log could use a
> little bit of tweaking...
> 
>   - Please start your commit title (the part after the subsystem tag)
>     with a capital letter, e.g.
> 
>       efi: Use early_memremap...
> 
>   - You need to explain in the commit title that you're fixing a sparse
>     warning. Anyone reading the patch subject will have no idea _why_
>     you're using early_memremap() and early_memunmap().
> 
>   - In the commit message body explain why sparse is currently unhappy.

Sure, will do.

--
Thanks for review
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
