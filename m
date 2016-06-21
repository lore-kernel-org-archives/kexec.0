Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFEug-0006Sd-AF
 for kexec@lists.infradead.org; Tue, 21 Jun 2016 06:11:55 +0000
Received: by mail-qk0-f180.google.com with SMTP id c73so7879423qkg.2
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 23:11:33 -0700 (PDT)
Date: Tue, 21 Jun 2016 11:41:28 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH 0/2] Simple fix to the ARM kexec tools implementation
Message-ID: <20160621061128.GC29309@dhcppc9>
References: <20160617194405.GN1041@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160617194405.GN1041@n2100.armlinux.org.uk>
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
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>, Kees Cook <keescook@google.com>

On 17/06/2016:08:44:05 PM, Russell King - ARM Linux wrote:
> This is the "simple" fix for the ARM kexec tools code, which makes
> the code actually do what the comments describe.
> 
> There are two problems:
> 
> 1. When placing the initrd, we do not take account of the 32k offset
>    that is required for the kernel image.
> 
> 2. The code claims to allow the zImage decompressor to expand by a
>    factor of 4, but only allows space for a factor of 3, since the
>    decompressor itself has to fit in this memory space as well.
> 
> Changing the code to follow the comments allows Keystone II to kexec
> with DEBUG_RODATA enabled, at least with the kernel I've been testing
> with.
> 
> This is a stop-gap solution until a better solution can be implemented.

Yes, so until we have proper header for zImage, these patches looks fine to me.
For both of the patches:

Reviewed-by: Pratyush Anand <panand@redhat.com>

> 
>  kexec/arch/arm/kexec-zImage-arm.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
