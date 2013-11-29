Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VmRNf-0006WT-PO
 for kexec@lists.infradead.org; Fri, 29 Nov 2013 16:57:28 +0000
Date: Fri, 29 Nov 2013 17:56:56 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 11/12] x86: reserve setup_data ranges late after
 parsing memmap cmdline
Message-ID: <20131129165656.GF4266@pd.tnic>
References: <1385445477-9665-1-git-send-email-dyoung@redhat.com>
 <1385445477-9665-12-git-send-email-dyoung@redhat.com>
 <20131127150710.GH32267@pd.tnic>
 <20131129083551.GB4186@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131129083551.GB4186@dhcp-16-126.nay.redhat.com>
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
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

On Fri, Nov 29, 2013 at 04:35:52PM +0800, Dave Young wrote:
> Is below changes ok to you?

Almost perfect! Just a micro-nitpick below:

> Currently e820_reserve_setup_data is called before parsing early params,
> it works in normal case. But for memmap=exactmap, the final memory ranges
> are created after parsing memmap= cmdline params, so the previous
> e820_reserve_setup_data has no effect. For example for setup_data ranges

s/ for/,/

> will still be marked as normal system ram, thus when later sysfs driver
> ioremap them kernel will warn about mapping normal ram.
> 
> This patch fix it by moving the e820_reserve_setup_data callback after
> parsing early params so they can be set as reserved ranges and later
> ioremap will be fine with it.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
