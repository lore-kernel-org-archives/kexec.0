Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VmJYv-0001TX-BI
 for kexec@lists.infradead.org; Fri, 29 Nov 2013 08:36:33 +0000
Date: Fri, 29 Nov 2013 16:35:52 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v4 11/12] x86: reserve setup_data ranges late after
 parsing memmap cmdline
Message-ID: <20131129083551.GB4186@dhcp-16-126.nay.redhat.com>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-12-git-send-email-dyoung@redhat.com>
 <20131127150710.GH32267@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131127150710.GH32267@pd.tnic>
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

On 11/27/13 at 04:07pm, Borislav Petkov wrote:
> On Tue, Nov 26, 2013 at 01:57:56PM +0800, Dave Young wrote:
> > Kdump kernel using memmap=exactmap, move e820_reserve_setup_data after
> > parsing early params so they can be set reserved finally. Or kdump kernel
> > will warn about ioremap a normal ram range.
> 
> I had to stare for a while at this commit message, rereading it a couple
> of times and looking at the code in order to understand why you're
> moving the call further down.
> 
> Please rewrite it into something more readable.
> 
> The usual structure which you could use is:
> 
> 1. Currently we have A
> 2. We need B
> 3. In order to achieve it, we do C
> 
> or something to that effect.

Is below changes ok to you?

Currently e820_reserve_setup_data is called before parsing early params,
it works in normal case. But for memmap=exactmap, the final memory ranges
are created after parsing memmap= cmdline params, so the previous
e820_reserve_setup_data has no effect. For example for setup_data ranges
will still be marked as normal system ram, thus when later sysfs driver
ioremap them kernel will warn about mapping normal ram.

This patch fix it by moving the e820_reserve_setup_data callback after
parsing early params so they can be set as reserved ranges and later
ioremap will be fine with it.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
