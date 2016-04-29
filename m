Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aw9rO-0002A0-B8
 for kexec@lists.infradead.org; Fri, 29 Apr 2016 14:57:39 +0000
Received: by mail-oi0-f48.google.com with SMTP id x201so121148225oif.3
 for <kexec@lists.infradead.org>; Fri, 29 Apr 2016 07:57:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1aviFE-0000jS-UI@rmk-PC.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviFE-0000jS-UI@rmk-PC.arm.linux.org.uk>
Date: Fri, 29 Apr 2016 20:27:17 +0530
Message-ID: <CAHB_Gupx7QgRdAaFuNSTdP6ZErSPRiaFcVYfeFXGbmqezAvSAA@mail.gmail.com>
Subject: Re: [PATCH 08/12] kexec: don't invoke OOM-killer for control page
 allocation
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
> If we are unable to find a suitable page when allocating the control
> page, do not invoke the OOM-killer: killing processes probably isn't
> going to help.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  include/linux/kexec.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 2cc643c6e870..1b32ab587f66 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -41,7 +41,7 @@
>  #endif
>
>  #ifndef KEXEC_CONTROL_MEMORY_GFP
> -#define KEXEC_CONTROL_MEMORY_GFP GFP_KERNEL
> +#define KEXEC_CONTROL_MEMORY_GFP (GFP_KERNEL | __GFP_NORETRY)
>  #endif
>
>  #ifndef KEXEC_CONTROL_PAGE_SIZE

Reviewed-by: Pratyush Anand <panand@redhat.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
