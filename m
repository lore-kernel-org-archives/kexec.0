Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v12 01/16] asm-generic: add kexec_file_load system call to
 unistd.h
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-2-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <f77fe157-f9f6-8dfc-eca0-1ecd687f671f@arm.com>
Date: Thu, 26 Jul 2018 14:35:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180724065759.19186-2-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, schwidefsky@de.ibm.com, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

Hi Akashi,

On 24/07/18 07:57, AKASHI Takahiro wrote:
> The initial user of this system call number is arm64.

This patch conflicts with commit db7a2d1809a5 ("asm-generic: unistd.h: Wire up
sys_rseq") in the arm64 tree.

Thanks,

James

> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 42990676a55e..c81f4a0df51f 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -734,9 +734,11 @@ __SYSCALL(__NR_pkey_free,     sys_pkey_free)
>  __SYSCALL(__NR_statx,     sys_statx)
>  #define __NR_io_pgetevents 292
>  __SC_COMP(__NR_io_pgetevents, sys_io_pgetevents, compat_sys_io_pgetevents)
> +#define __NR_kexec_file_load 293
> +__SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
>  
>  #undef __NR_syscalls
> -#define __NR_syscalls 293
> +#define __NR_syscalls 294
>  
>  /*
>   * 32 bit systems traditionally used different
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
