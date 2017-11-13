Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-f68.google.com ([209.85.214.68])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eEARj-0003hB-Jb
 for kexec@lists.infradead.org; Mon, 13 Nov 2017 08:50:26 +0000
Received: by mail-it0-f68.google.com with SMTP id m191so8435055itg.2
 for <kexec@lists.infradead.org>; Mon, 13 Nov 2017 00:50:02 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: Re: [PATCH] kdump: print a message in case crashkernel size parsing
 resulted in zero bytes
References: <20171113054311.GA4971@dhcp-128-65.nay.redhat.com>
Message-ID: <a8a5d2ae-579e-262c-4231-49ab967b0108@redhat.com>
Date: Mon, 13 Nov 2017 14:19:54 +0530
MIME-Version: 1.0
In-Reply-To: <20171113054311.GA4971@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, kexec@lists.infradead.org, bhe@redhat.com, vgoyal@redhat.com

Hi Dave,

Cc: arm kernel mailing list for wider distribution

On 11/13/2017 11:13 AM, Dave Young wrote:
> In parse_crashkernel_mem, it silently return in case we get zero
> bytes in the parsing function.  It is useful for debugging for
> adding a warning message especially sometimes kernel can not boot
> up correctly.
>
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  kernel/crash_core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> --- linux-x86.orig/kernel/crash_core.c
> +++ linux-x86/kernel/crash_core.c
> @@ -108,7 +108,8 @@ static int __init parse_crashkernel_mem(
>                  return -EINVAL;
>              }
>          }
> -    }
> +    } else
> +        pr_warn("crashkernel size resulted in zero bytes\n");
>
>      return 0;
>  }
>
This is a useful change as finding this debug message in the boot logs allows better debug of crashkernel related issues.

However I have one minor point:

- The comment above 'parse_crashkernel_mem' currently mentions:
  * The function returns 0 on success and -EINVAL on failure.
  */

- I am wondering if we hit the WARNING case where the crashkernel size resulted in 0 bytes, then should we still be returning 0 from this function. Or, should this be replaced with 'return -EINVAL'.

- If not, can we atleast update the comment above this function to better document the return values and where having a 'return 0' should be ok, even if crashkernel size resulted in 0 bytes.

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
