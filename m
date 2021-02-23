Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEV1A-000183-7D
 for kexec@lists.infradead.org; Tue, 23 Feb 2021 10:34:14 +0000
Subject: Re: [PATCH 1/1] kexec-tools: fix build on pre 4.4 kernels
References: <20210205081559.15956-1-fede@evolware.org>
From: Kairui Song <kasong@redhat.com>
Message-ID: <4501fa78-355d-eb7c-69c4-5665620aa1a1@redhat.com>
Date: Tue, 23 Feb 2021 18:32:39 +0800
MIME-Version: 1.0
In-Reply-To: <20210205081559.15956-1-fede@evolware.org>
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
To: Federico Pellegrin <fede@evolware.org>, kexec@lists.infradead.org

On 2/5/21 4:15 PM, Federico Pellegrin wrote:
> kexec build will fail on older kernels (pre 4.4) as the define
> VIDEO_CAPABILITY_64BIT_BASE was not present at that time.
>
> This patch adds it, as per linux/include/uapi/linux/screen_info.h,
> if not present.
>
> Signed-off-by: Federico Pellegrin <fede@evolware.org>
> ---
>   kexec/arch/i386/x86-linux-setup.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index 76e1185..ab54a4a 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -37,6 +37,10 @@
>   #include "x86-linux-setup.h"
>   #include "../../kexec/kexec-syscall.h"
>   
> +#ifndef VIDEO_CAPABILITY_64BIT_BASE
> +#define VIDEO_CAPABILITY_64BIT_BASE (1 << 1)	/* Frame buffer base is 64-bit */
> +#endif
> +
>   void init_linux_parameters(struct x86_linux_param_header *real_mode)
>   {
>   	/* Fill in the values that are usually provided by the kernel. */

Thanks for the fix, I didn't notice pre 4.4 kernels don't have this defined
when I submitted that patch.

Reviewed-by: Kairui Song <kasong@redhat.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
