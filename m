Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.244])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KBXMJ-0003cz-Fm
	for kexec@lists.infradead.org; Wed, 25 Jun 2008 15:56:36 +0000
Received: by rv-out-0708.google.com with SMTP id b17so11234572rvf.42
	for <kexec@lists.infradead.org>; Wed, 25 Jun 2008 08:56:33 -0700 (PDT)
Message-ID: <86802c440806250856i5b6c608ag848ad78d83b2337c@mail.gmail.com>
Date: Wed, 25 Jun 2008 08:56:33 -0700
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH 1/3] e820_update_range(): Strip size of original region
In-Reply-To: <1214395342-20375-2-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
References: <1214395342-20375-1-git-send-email-bwalle@suse.de>
	<1214395342-20375-2-git-send-email-bwalle@suse.de>
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
> This patch fixes a bug in e820_update_range(): Previously, if a region was
> partially covered, then e820_update_range() only added a new E820 range but
> didn't update the end/size of the previous range. That lead to duplicate
> covering of a region.
>
> Patch tested on i386 and x86-64 with patch that uses e820_update_range()
> to limit the E820 map when "mem" parameter is specified on the command line.
>
>
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> ---
>  arch/x86/kernel/e820.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index e285ea3..e466073 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -422,6 +422,7 @@ u64 __init e820_update_range(u64 start, u64 size, unsigned old_type,
>                final_end = min(start + size, ei->addr + ei->size);
>                if (final_start >= final_end)
>                        continue;
> +               ei->size -= final_end - final_start;
>                e820_add_region(final_start, final_end - final_start,
>                                         new_type);
>                real_updated_size += final_end - final_start;
> --

this one is not needed, I sent one updated to Ingo, and it is in
tip/setup-memory
[PATCH] x86: change size if e820_update/remove_range

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
