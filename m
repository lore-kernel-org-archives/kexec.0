Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KTCdg-0007BH-0u
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 09:27:32 +0000
Date: Wed, 13 Aug 2008 02:27:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kexec jump: fix compiling warning on xchg(&kexec_lock,
	0) in kernel_kexec()
Message-Id: <20080813022712.4bea5fea.akpm@linux-foundation.org>
In-Reply-To: <1218618760.24951.137.camel@caritas-dev.intel.com>
References: <1218618760.24951.137.camel@caritas-dev.intel.com>
Mime-Version: 1.0
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
To: Huang Ying <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Torvalds <torvalds@linux-foundation.org>, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, mingo@elte.hu, Linus, Vivek Goyal <vgoyal@redhat.com>

On Wed, 13 Aug 2008 17:12:40 +0800 Huang Ying <ying.huang@intel.com> wrote:

> Fix compiling warning on xchg(&kexec_lock, 0) in kernel_kexec().
>

Would prefer that thi code not use such a peculair idiom.  I don't
believe that it needs to.

I guess that's a separate activity.

> 
> ---
>  kernel/kexec.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1433,6 +1433,7 @@ module_init(crash_save_vmcoreinfo_init)
>  int kernel_kexec(void)
>  {
>  	int error = 0;
> +	int locked;
>  
>  	if (xchg(&kexec_lock, 1))
>  		return -EBUSY;
> @@ -1498,7 +1499,8 @@ int kernel_kexec(void)
>  #endif
>  
>   Unlock:
> -	xchg(&kexec_lock, 0);
> +	locked = xchg(&kexec_lock, 0);
> +	BUG_ON(!locked);
>  
>  	return error;
>  }
> 

Please always quote the compiler output in the changelog when fixing
warnings and build errors.

The patch is titled "kexec jump: ..." whereas this is just a plain old
kexec fix, which is applicable to mainline.

We don't need to create that local.  I queued this:



Subject: kexec: fix compilation warning on xchg(&kexec_lock, 0) in kernel_kexec()
From: Huang Ying <ying.huang@intel.com>

kernel/kexec.c: In function 'kernel_kexec':
kernel/kexec.c:1506: warning: value computed is not used

Signed-off-by: Huang Ying <ying.huang@intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/kexec.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN kernel/kexec.c~kexec-jump-fix-compiling-warning-on-xchgkexec_lock-0-in-kernel_kexec kernel/kexec.c
--- a/kernel/kexec.c~kexec-jump-fix-compiling-warning-on-xchgkexec_lock-0-in-kernel_kexec
+++ a/kernel/kexec.c
@@ -1503,7 +1503,8 @@ int kernel_kexec(void)
 	}
 
  Unlock:
-	xchg(&kexec_lock, 0);
+	if (!xchg(&kexec_lock, 0))
+		BUG();
 
 	return error;
 }
_


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
