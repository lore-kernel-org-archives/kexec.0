Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqvgV-0007Ut-7K
 for kexec@lists.infradead.org; Thu, 12 Dec 2013 02:07:27 +0000
Date: Thu, 12 Dec 2013 10:06:42 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 01/14] x86/mm: sparse warning fix for early_memremap
Message-ID: <20131212020642.GB3751@dhcp-16-126.nay.redhat.com>
References: <1386582147-9802-1-git-send-email-dyoung@redhat.com>
 <1386582147-9802-2-git-send-email-dyoung@redhat.com>
 <20131209150521.GE31650@pd.tnic>
 <20131210021221.GA3800@dhcp-16-126.nay.redhat.com>
 <20131211102025.GB19196@console-pimps.org>
 <20131211111240.GE21683@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131211111240.GE21683@pd.tnic>
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
Cc: Matt Fleming <matt@console-pimps.org>, linux-efi@vger.kernel.org, toshi.kani@hp.com, mjg59@srcf.ucam.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, vgoyal@redhat.com

On 12/11/13 at 12:12pm, Borislav Petkov wrote:
> On Wed, Dec 11, 2013 at 10:20:25AM +0000, Matt Fleming wrote:
> > This needs reviewing by at least one of the x86 folks, but it
> > certainly makes sense to me.
> 
> Ingo told me yesterday, it makes sense too. I'd guess we can try it.
> FWIW, all callers of early_memremap use the memory they get remapped as
> normal memory so we should be safe.
> 
> Maybe this whole discussion should be noted down in the commit message
> so that people know.

Thanks for the info. will add.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
