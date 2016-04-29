Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aw9Iw-0007mg-Tr
 for kexec@lists.infradead.org; Fri, 29 Apr 2016 14:22:03 +0000
Received: by mail-oi0-f41.google.com with SMTP id x201so119945052oif.3
 for <kexec@lists.infradead.org>; Fri, 29 Apr 2016 07:21:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1aviEu-0000ix-C1@rmk-PC.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
 <E1aviEu-0000ix-C1@rmk-PC.arm.linux.org.uk>
Date: Fri, 29 Apr 2016 19:51:42 +0530
Message-ID: <CAHB_Guoj5ywYZGJ441MK9tBu-L_e4skCbhHyRkeXEXn8vaytXQ@mail.gmail.com>
Subject: Re: [PATCH 04/12] ARM: provide arm_has_idmap_alias() helper
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
> Provide a helper to indicate whether we need to perform special handling
> for boot identity mapping aliases or not.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/memory.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index ca208335fde6..31c07a2cc100 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -295,6 +295,11 @@ extern long long arch_phys_to_idmap_offset;
>   * of physical memory for idmap purposes.  Most cases should leave these
>   * untouched.  Note: this can only return addresses less than 4GiB.
>   */
> +static inline bool arm_has_idmap_alias(void)
> +{
> +       return IS_ENABLED(CONFIG_MMU) && arch_phys_to_idmap_offset != 0;
> +}
> +
>  #define IDMAP_INVALID_ADDR ((u32)~0)
>
>  static inline unsigned long phys_to_idmap(phys_addr_t addr)

Reviewed-by: Pratyush Anand <panand@redhat.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
