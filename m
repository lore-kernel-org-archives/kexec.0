Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqguS-0005oT-8l
 for kexec@lists.infradead.org; Wed, 11 Dec 2013 10:20:52 +0000
Date: Wed, 11 Dec 2013 10:20:25 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH v5 01/14] x86/mm: sparse warning fix for early_memremap
Message-ID: <20131211102025.GB19196@console-pimps.org>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-2-git-send-email-dyoung@redhat.com>
 <20131209150521.GE31650@pd.tnic>
 <20131210021221.GA3800@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131210021221.GA3800@dhcp-16-126.nay.redhat.com>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, Borislav Petkov <bp@alien8.de>, ebiederm@xmission.com, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, vgoyal@redhat.com

On Tue, 10 Dec, at 10:12:21AM, Dave Young wrote:
> On 12/09/13 at 04:05pm, Borislav Petkov wrote:
> > On Mon, Dec 09, 2013 at 05:42:14PM +0800, Dave Young wrote:
> > > There's a lot of sparse warnings for code like below:
> > > void *a = early_memremap(phys_addr, size);
> > > 
> > > early_memremap intend to map kernel memory with ioremap facility, the return
> > > pointer should be a kernel ram pointer instead of iomem one.
> > > 
> > > For making the function clearer and supressing sparse warnings this patch
> > > do below two things:
> > > 1. cast to (__force void *) for the return value of early_memremap
> > 
> > I'd guess this is to shut up the __iomem thing? And we're getting that
> > because we're using ioremap, ... hohum...
> 
> Yes, IMHO early_memremap really should not return __iomem pointer since it's
> *memremap*... 

This needs reviewing by at least one of the x86 folks, but it certainly
makes sense to me.

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
