Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj6cw-00ExX1-5y
 for kexec@lists.infradead.org; Tue, 18 May 2021 20:47:43 +0000
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v3 1/4] kexec: simplify compat_sys_kexec_load
Date: Tue, 18 May 2021 20:47:36 +0000
Message-ID: <dcc79c4336234b6a84b597e0e39d65d0@AcuMS.aculab.com>
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-2-arnd@kernel.org>
In-Reply-To: <20210517203343.3941777-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
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
To: 'Arnd Bergmann' <arnd@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

From: Arnd Bergmann
> Sent: 17 May 2021 21:34
> 
> The compat version of sys_kexec_load() uses compat_alloc_user_space to
> convert the user-provided arguments into the native format.
> 
> Move the conversion into the regular implementation with
> an in_compat_syscall() check to simplify it and avoid the
> compat_alloc_user_space() call.
> 
> compat_sys_kexec_load() now behaves the same as sys_kexec_load().
> 
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

How many segments are there?
The multiple copy_from_user() will be slow.

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

Should there be a bound check on nr_segments?
I can't see one in the code in this patch.

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

An alternate sequence (which Eric will like even less!) is to
do a single copy_from_user() for the entire compat size array
into the 'normal' buffer and then do a reverse order conversion
of each array entry from 'compat' to '64 bit'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
