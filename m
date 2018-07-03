Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v10 07/14] arm64: enable KEXEC_FILE config
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-8-takahiro.akashi@linaro.org>
From: James Morse <james.morse@arm.com>
Message-ID: <9545cb7f-9648-660a-f034-a94f186a8224@arm.com>
Date: Tue, 3 Jul 2018 17:33:20 +0100
MIME-Version: 1.0
In-Reply-To: <20180623022058.10935-8-takahiro.akashi@linaro.org>
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
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

Hi Akashi,

On 23/06/18 03:20, AKASHI Takahiro wrote:
> Modify arm64/Kconfig to enable kexec_file_load support.

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 42c090cf0292..f68318f61c85 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -835,6 +835,16 @@ config KEXEC
>  	  but it is independent of the system firmware.   And like a reboot
>  	  you can start any kernel with it, not just Linux.
>  
> +config KEXEC_FILE
> +	bool "kexec file based system call"
> +	select KEXEC_CORE
> +	select BUILD_BIN2C

Wasn't BIN2C only needed for purgatory?

x86/powerpc/s390 all select CRYPTO_SHA256 here, presumably for arch-specific
verification mechanisms. I assume we're using SIGNED_PE_FILE_VERIFICATION instead.


> +	help
> +	  This is new version of kexec system call. This system call is
> +	  file based and takes file descriptors as system call argument
> +	  for kernel and initramfs as opposed to list of segments as
> +	  accepted by previous system call.
> +
>  config CRASH_DUMP
>  	bool "Build kdump crash kernel"
>  	help


Acked-by: James Morse <james.morse@arm.com>


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
