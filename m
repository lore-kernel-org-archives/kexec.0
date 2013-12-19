Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vtgg7-0007Vt-Ln
 for kexec@lists.infradead.org; Thu, 19 Dec 2013 16:42:28 +0000
Date: Thu, 19 Dec 2013 16:41:44 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH v6 10/14] efi: only print saved efi runtime maps instead
 of all memmap ranges for kexec
Message-ID: <20131219164144.GG3145@console-pimps.org>
References: <1387186235-15972-1-git-send-email-dyoung@redhat.com>
 <1387186235-15972-11-git-send-email-dyoung@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1387186235-15972-11-git-send-email-dyoung@redhat.com>
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
Cc: mjg59@srcf.ucam.org, msalter@redhat.com, linux-efi@vger.kernel.org, toshi.kani@hp.com, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, leif.lindholm@linaro.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, akpm@linux-foundation.org, mingo@kernel.org, vgoyal@redhat.com

On Mon, 16 Dec, at 05:30:31PM, Dave Young wrote:
> For kexec/kdump kernel efi runtime mappings are saved, printing original whole
> memmap ranges does not make sense anymore. So introduce a new function to only
> print runtime maps in case kexec/kdump kernel is used.
> 
> changelog:
> Matt: use efi_setup instead of esdata
>       share function print_efi_memmap for both normal and kexec boot.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/platform/efi/efi.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)

Thinking about this a bit more, I'm not at all sure why this patch
exists.

Why do we not want to print the entire memory map range like we did in
the first kernel? The e820 map is printed exactly like it was in the
first kernel, why should the EFI memmap be special?

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
