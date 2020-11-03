Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 3 Nov 2020 08:35:33 +0000
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/4] kexec: simplify compat_sys_kexec_load
Message-ID: <20201103083533.GB9092@infradead.org>
References: <20201102123151.2860165-1-arnd@kernel.org>
 <20201102123151.2860165-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201102123151.2860165-2-arnd@kernel.org>
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
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, Borislav Petkov <bp@alien8.de>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>

> +	for (i=0; i < nr_segments; i++) {

Missing spaces around the "=".

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
> +	return kernel_kexec_load(entry, nr_segments,
> +				 (struct kexec_segment __user *)segments,
> +				 flags);
>  }

I don't think we need sys_compat_kexec_load at all now, all the syscall
tables can simply switch to sys_kexec_load for the compat case as well
now.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
