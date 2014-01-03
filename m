Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from arkanian.console-pimps.org ([212.110.184.194])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vz5vz-0008Aa-2E
 for kexec@lists.infradead.org; Fri, 03 Jan 2014 14:41:11 +0000
Date: Fri, 3 Jan 2014 14:40:44 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH tip/efi-kexec] x86: setup.c build fix
Message-ID: <20140103144044.GD2618@console-pimps.org>
References: <20140103035648.GA5291@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140103035648.GA5291@darkstar.nay.redhat.com>
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
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, mingo@kernel.org, hpa@zytor.com

On Fri, 03 Jan, at 11:56:49AM, Dave Young wrote:
> In case without CONFIG_EFI, there will be below build error:
>    arch/x86/built-in.o: In function `setup_arch':
> >> (.init.text+0x9dc): undefined reference to `parse_efi_setup'
> 
> Thus fix it by adding blank inline function in asm/efi.h
> Also remove an unused declaration for variable efi_data_len.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  arch/x86/include/asm/efi.h |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Thanks Dave. I picked up both patches.

-- 
Matt Fleming, Intel Open Source Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
