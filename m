Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aw9ro-0002J9-V5
 for kexec@lists.infradead.org; Fri, 29 Apr 2016 14:58:05 +0000
Received: by mail-oi0-f46.google.com with SMTP id x19so120973736oix.2
 for <kexec@lists.infradead.org>; Fri, 29 Apr 2016 07:57:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1aviFK-0000jY-1S@rmk-PC.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviFK-0000jY-1S@rmk-PC.arm.linux.org.uk>
Date: Fri, 29 Apr 2016 20:27:43 +0530
Message-ID: <CAHB_GupLrhak5CrTQE9976Pq0RFRaXWf5r--rjKmnBNU1oyK9g@mail.gmail.com>
Subject: Re: [PATCH 09/12] kexec: ensure user memory sizes do not wrap
From: Pratyush Anand <panand@redhat.com>
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
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>, Rob Herring <robh+dt@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org

On Thu, Apr 28, 2016 at 2:58 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Ensure that user memory sizes do not wrap around when validating the
> user input, which can lead to the following input validation working
> incorrectly.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  kernel/kexec_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 8d34308ea449..d719a4d0ef55 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -169,6 +169,8 @@ int sanity_check_segment_list(struct kimage *image)
>
>                 mstart = image->segment[i].mem;
>                 mend   = mstart + image->segment[i].memsz;
> +               if (mstart > mend)
> +                       return result;
>                 if ((mstart & ~PAGE_MASK) || (mend & ~PAGE_MASK))
>                         return result;
>                 if (mend >= KEXEC_DESTINATION_MEMORY_LIMIT)

Reviewed-by: Pratyush Anand <panand@redhat.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
