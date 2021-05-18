Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-2-arnd@kernel.org>
Date: Mon, 17 May 2021 22:57:24 -0500
In-Reply-To: <20210517203343.3941777-2-arnd@kernel.org> (Arnd Bergmann's
 message of "Mon, 17 May 2021 22:33:40 +0200")
Message-ID: <m1y2cc3d97.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/4] kexec: simplify compat_sys_kexec_load
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
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The compat version of sys_kexec_load() uses compat_alloc_user_space to
> convert the user-provided arguments into the native format.
>
> Move the conversion into the regular implementation with
> an in_compat_syscall() check to simplify it and avoid the
> compat_alloc_user_space() call.
>
> compat_sys_kexec_load() now behaves the same as sys_kexec_load().

Is it possible to do this without in_compat_syscall(),
and casting pointers to a wrong type?

We open ourselves up to bugs whenever we lie to the type system.

Skimming through the code it looks like it should be possible
to not need the in_compat_syscall and the casts to the wrong
type by changing the order of the code a little bit.

Eric


> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/kexec.h |  2 -
>  kernel/kexec.c        | 95 +++++++++++++++++++------------------------
>  2 files changed, 42 insertions(+), 55 deletions(-)
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 0c994ae37729..f61e310d7a85 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -88,14 +88,12 @@ struct kexec_segment {
>  	size_t memsz;
>  };
>  
> -#ifdef CONFIG_COMPAT
>  struct compat_kexec_segment {
>  	compat_uptr_t buf;
>  	compat_size_t bufsz;
>  	compat_ulong_t mem;	/* User space sees this as a (void *) ... */
>  	compat_size_t memsz;
>  };
> -#endif
>  
>  #ifdef CONFIG_KEXEC_FILE
>  struct purgatory_info {
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index c82c6c06f051..6618b1d9f00b 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -19,21 +19,46 @@
>  
>  #include "kexec_internal.h"
>  
> +static int copy_user_compat_segment_list(struct kimage *image,
> +					 unsigned long nr_segments,
> +					 void __user *segments)
> +{
> +	struct compat_kexec_segment __user *cs = segments;
> +	struct compat_kexec_segment segment;
> +	int i;
> +
> +	for (i = 0; i < nr_segments; i++) {
> +		if (copy_from_user(&segment, &cs[i], sizeof(segment)))
> +			return -EFAULT;
> +
> +		image->segment[i] = (struct kexec_segment) {
> +			.buf   = compat_ptr(segment.buf),
> +			.bufsz = segment.bufsz,
> +			.mem   = segment.mem,
> +			.memsz = segment.memsz,
> +		};
> +	}
> +
> +	return 0;
> +}
> +
> +
>  static int copy_user_segment_list(struct kimage *image,
>  				  unsigned long nr_segments,
>  				  struct kexec_segment __user *segments)
>  {
> -	int ret;
>  	size_t segment_bytes;
>  
>  	/* Read in the segments */
>  	image->nr_segments = nr_segments;
>  	segment_bytes = nr_segments * sizeof(*segments);
> -	ret = copy_from_user(image->segment, segments, segment_bytes);
> -	if (ret)
> -		ret = -EFAULT;
> +	if (in_compat_syscall())
> +		return copy_user_compat_segment_list(image, nr_segments, segments);
>  
> -	return ret;
> +	if (copy_from_user(image->segment, segments, segment_bytes))
> +		return -EFAULT;
> +
> +	return 0;
>  }
>  
>  static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
> @@ -233,8 +258,9 @@ static inline int kexec_load_check(unsigned long nr_segments,
>  	return 0;
>  }
>  
> -SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
> -		struct kexec_segment __user *, segments, unsigned long, flags)
> +static int kernel_kexec_load(unsigned long entry, unsigned long nr_segments,
> +			     struct kexec_segment __user * segments,
> +			     unsigned long flags)
>  {
>  	int result;
>  
> @@ -265,57 +291,20 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
>  	return result;
>  }
>  
> +SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
> +		struct kexec_segment __user *, segments, unsigned long, flags)
> +{
> +	return kernel_kexec_load(entry, nr_segments, segments, flags);
> +}
> +
>  #ifdef CONFIG_COMPAT
>  COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
>  		       compat_ulong_t, nr_segments,
>  		       struct compat_kexec_segment __user *, segments,
>  		       compat_ulong_t, flags)
>  {
> -	struct compat_kexec_segment in;
> -	struct kexec_segment out, __user *ksegments;
> -	unsigned long i, result;
> -
> -	result = kexec_load_check(nr_segments, flags);
> -	if (result)
> -		return result;
> -
> -	/* Don't allow clients that don't understand the native
> -	 * architecture to do anything.
> -	 */
> -	if ((flags & KEXEC_ARCH_MASK) == KEXEC_ARCH_DEFAULT)
> -		return -EINVAL;
> -
> -	ksegments = compat_alloc_user_space(nr_segments * sizeof(out));
> -	for (i = 0; i < nr_segments; i++) {
> -		result = copy_from_user(&in, &segments[i], sizeof(in));
> -		if (result)
> -			return -EFAULT;
> -
> -		out.buf   = compat_ptr(in.buf);
> -		out.bufsz = in.bufsz;
> -		out.mem   = in.mem;
> -		out.memsz = in.memsz;
> -
> -		result = copy_to_user(&ksegments[i], &out, sizeof(out));
> -		if (result)
> -			return -EFAULT;
> -	}
> -
> -	/* Because we write directly to the reserved memory
> -	 * region when loading crash kernels we need a mutex here to
> -	 * prevent multiple crash  kernels from attempting to load
> -	 * simultaneously, and to prevent a crash kernel from loading
> -	 * over the top of a in use crash kernel.
> -	 *
> -	 * KISS: always take the mutex.
> -	 */
> -	if (!mutex_trylock(&kexec_mutex))
> -		return -EBUSY;
> -
> -	result = do_kexec_load(entry, nr_segments, ksegments, flags);
> -
> -	mutex_unlock(&kexec_mutex);
> -
> -	return result;
> +	return kernel_kexec_load(entry, nr_segments,
> +				 (struct kexec_segment __user *)segments,
> +				 flags);
>  }
>  #endif

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
