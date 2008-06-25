Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.244])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KBXQg-0004a1-Ie
	for kexec@lists.infradead.org; Wed, 25 Jun 2008 16:01:06 +0000
Received: by rv-out-0708.google.com with SMTP id b17so11236404rvf.42
	for <kexec@lists.infradead.org>; Wed, 25 Jun 2008 09:01:05 -0700 (PDT)
Message-ID: <86802c440806250901n68278ab1ma1add38c165122af@mail.gmail.com>
Date: Wed, 25 Jun 2008 09:01:05 -0700
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH 3/3] Limit E820 map when a user-defined memory map is
	specified
In-Reply-To: <1214395342-20375-4-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
References: <1214395342-20375-1-git-send-email-bwalle@suse.de>
	<1214395342-20375-4-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

On Wed, Jun 25, 2008 at 5:02 AM, Bernhard Walle <bwalle@suse.de> wrote:
> This patch brings back limiting of the E820 map when a user-defined
> E820 map is specified. While the behaviour of i386 (32 bit) was to limit
> the E820 map (and /proc/iomem), the behaviour of x86-64 (64 bit) was not to
> limit.
>
> That patch limits the E820 map again for both x86 architectures.
>
> Code was tested for compilation and booting on a 32 bit and 64 bit system.
>
>
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> ---
>  arch/x86/kernel/e820.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index 7d1109b..19b7f05 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -979,6 +979,8 @@ static int __init parse_memopt(char *p)
>
>        mem_size = memparse(p, &p);
>        end_user_pfn = mem_size>>PAGE_SHIFT;
> +       e820_update_range(mem_size, ULLONG_MAX, E820_RAM, E820_RESERVED);
> +
>        return 0;
>  }
>  early_param("mem", parse_memopt);
> @@ -1023,6 +1025,7 @@ static int __init parse_memmap_opt(char *p)
>                e820_add_region(start_at, mem_size, E820_RESERVED);
>        } else {
>                end_user_pfn = (mem_size >> PAGE_SHIFT);
> +               e820_update_range(mem_size, ULLONG_MAX, E820_RAM, E820_RESERVED);
>        }
>        return *p == '\0' ? 0 : -EINVAL;
>  }
> --

only this one is needed now. but please change ULLONG_MAX to
ULLONG_MAX - mem_size

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
