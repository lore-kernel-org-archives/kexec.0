Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mout.gmx.net ([212.227.15.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fnd8n-0004ua-GR
 for kexec@lists.infradead.org; Thu, 09 Aug 2018 05:05:43 +0000
Message-ID: <1533791114.5087.30.camel@gmx.de>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
From: Mike Galbraith <efault@gmx.de>
Date: Thu, 09 Aug 2018 07:05:14 +0200
In-Reply-To: <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
 <20180809042153.GA4377@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>

On Thu, 2018-08-09 at 12:21 +0800, Dave Young wrote:
> Hi Mike,
> 
> Thanks for the patch!
> On 08/08/18 at 04:03pm, Mike Galbraith wrote:
> > When booting with efi=noruntime, we call efi_runtime_map_copy() while
> > loading the kdump kernel, and trip over a NULL efi.memmap.map.  Avoid
> > that and a useless allocation when the only mapping we can use (1:1)
> > is not available.
> 
> At first glance, efi_get_runtime_map_size should return 0 in case
> noruntime.

I actually made it do that in a separate patch first, and keyed on that
in a second, but then decided to not notice anything odd in efi land
(run Forest run!), and just fix the bug that now bites latest RT due to
it turning efi runtime off by default.

> Also since we are here, would you mind to restructure the bzImage64_load
> function, and try to move all efi related code to setup_efi_state()?
> 
> 
> setup_boot_parameters(struct kimage *image, struct boot_params *params,
>                       unsigned long params_load_addr,
>                       unsigned int efi_map_offset, unsigned int efi_map_sz,
>                       unsigned int efi_setup_data_offset)
> {
> [snip]
> 
> #ifdef CONFIG_EFI
>         /* Setup EFI state */
>         setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
>                         efi_setup_data_offset);
> #endif
> 
> [snip]
> }
> 
> Currently bzImage64_load prepares the efi_map_offset, efi_map_sz,
>  and efi_setup_data_offset and then pass it to setup_boot_parameters and
> setup_efi_state.  It should be better to move those efi_* variables to
> setup_efi_state().
> 
> So we can call setup_efi_state only when efi runtime is enabled.

Yeah, I thought the same, but wanted to keep it dinky.

	-Mike

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
