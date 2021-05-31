Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lngo4-00C6zu-TM
 for kexec@lists.infradead.org; Mon, 31 May 2021 12:14:10 +0000
Date: Mon, 31 May 2021 15:13:58 +0300
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2] x86/efi: unconditionally hold the whole low-1MB
 memory regions
Message-ID: <YLTTBpX13mWCysWx@kernel.org>
References: <20210531090023.16471-1-lijiang@redhat.com>
 <YLSnkKeoQnokXVsK@zn.tnic> <YLSzUBQ/7CyINu87@kernel.org>
 <YLS/1sqz6Bncg5VU@zn.tnic>
 <CANU+ZyeFxeGXhxDx_ojB_hmiD-b8aTkqJcmc4fBHAS39vS7ZiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANU+ZyeFxeGXhxDx_ojB_hmiD-b8aTkqJcmc4fBHAS39vS7ZiQ@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: lijiang <lijiang@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, kexec@lists.infradead.org, ardb@kernel.org, dvhart@infradead.org, andy@infradead.org, tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com, luto@amacapital.net, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>

On Mon, May 31, 2021 at 07:00:59PM +0800, lijiang wrote:
> Thank you for the information, Boris and Mike.
> 
> BTW: I just noticed that Mike's patch is incorrect, maybe it's a typo:
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 7850111008a8b..e262ca858787f 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -450,6 +450,18 @@ void __init efi_free_boot_services(void)
> size -= rm_size;
> }
> + /*
> + * Don't free memory under 1M for two reasons:
> + * - BIOS might clobber it
> + * - Crash kernel needs it to be reserved
> + */
> + if (start + size < SZ_1M)
> + continue;
> + if (start < SZ_1M) {
> + size -= (start - SZ_1M);
> ^^^^^^^^^^^^^^^^^^^^^^^^
> 
> It looks like: size -= (SZ_1M - start);

Right, thanks!

> + start = SZ_1M;
> + }
> +
> memblock_free_late(start, size);
> }
> 
> Mike's patch link:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/commit/?h=x86/
> reservelow&id=479fb34676ac448529b605854cf48c007e796ccd
 
-- 
Sincerely yours,
Mike.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
