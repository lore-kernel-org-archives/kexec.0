Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgTUT-009g38-Lt
 for kexec@lists.infradead.org; Tue, 11 May 2021 14:36:07 +0000
Received: by mail-oi1-x229.google.com with SMTP id z3so17980411oib.5
 for <kexec@lists.infradead.org>; Tue, 11 May 2021 07:35:57 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] kernel.h: Split out panic and oops helpers
References: <20210511074137.33666-1-andriy.shevchenko@linux.intel.com>
From: Alex Elder <elder@ieee.org>
Message-ID: <c6fa5d2c-84e2-2046-19f0-66cf5dd72077@ieee.org>
Date: Tue, 11 May 2021 09:35:54 -0500
MIME-Version: 1.0
In-Reply-To: <20210511074137.33666-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-xtensa@linux-xtensa.org, openipmi-developer@lists.sourceforge.net, linux-clk@vger.kernel.org, linux-edac@vger.kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-hyperv@vger.kernel.org, coresight@lists.linaro.org, linux-leds@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org, linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org, kexec@lists.infradead.org, rcu@vger.kernel.org, linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org

On 5/11/21 2:41 AM, Andy Shevchenko wrote:
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> Here is the attempt to start cleaning it up by splitting out panic and
> oops helpers.
> 
> There are several purposes of doing this:
> - dropping dependency in bug.h
> - dropping a loop by moving out panic_notifier.h
> - unload kernel.h from something which has its own domain
> 
> At the same time convert users tree-wide to use new headers, although
> for the time being include new header back to kernel.h to avoid twisted
> indirected includes for existing users.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Corey Minyard <cminyard@mvista.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Kees Cook <keescook@chromium.org>
> Acked-by: Wei Liu <wei.liu@kernel.org>
> Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Co-developed-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Acked-by: Sebastian Reichel <sre@kernel.org>
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Acked-by: Helge Deller <deller@gmx.de> # parisc
> ---
> v3: rebased on top of v5.13-rc1, collected a few more tags
> 
> Note WRT Andrew's SoB tag above: I have added it since part of the cases
> I took from him. Andrew, feel free to amend or tell me how you want me
> to do.
> 

Acked-by: Alex Elder <elder@kernel.org>

. . .

> diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
> index a5f7a79a1923..34b68dc43886 100644
> --- a/drivers/net/ipa/ipa_smp2p.c
> +++ b/drivers/net/ipa/ipa_smp2p.c
> @@ -8,6 +8,7 @@
>   #include <linux/device.h>
>   #include <linux/interrupt.h>
>   #include <linux/notifier.h>
> +#include <linux/panic_notifier.h>
>   #include <linux/soc/qcom/smem.h>
>   #include <linux/soc/qcom/smem_state.h>
>   

. . .

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
