Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 8 Apr 2020 11:46:55 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/defconfig: Enable CONFIG_KEXEC_FILE
Message-ID: <20200408104655.GA92698@C02TD0UTHF1T.local>
References: <1586212300-30797-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1586212300-30797-1-git-send-email-bhsharma@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, bhupesh.linux@gmail.com, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, Apr 07, 2020 at 04:01:40AM +0530, Bhupesh Sharma wrote:
> kexec_file_load() syscall interface is now supported for
> arm64 architecture as well via commits:
> 3751e728cef2 ("arm64: kexec_file: add crash dump support") and
> 3ddd9992a590 ("arm64: enable KEXEC_FILE config")].
> 
> This patch enables config KEXEC_FILE by default in the
> arm64 defconfig, so that user-space tools like kexec-tools
> can use the same as the default interface for kexec/kdump
> on arm64.
> 
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: kexec@lists.infradead.org
> 
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 24e534d85045..fa122f4341a2 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -66,6 +66,7 @@ CONFIG_SCHED_SMT=y
>  CONFIG_NUMA=y
>  CONFIG_SECCOMP=y
>  CONFIG_KEXEC=y
> +CONFIG_KEXEC_FILE=y
>  CONFIG_CRASH_DUMP=y
>  CONFIG_XEN=y
>  CONFIG_COMPAT=y
> -- 
> 2.7.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
