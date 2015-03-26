Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1427408957.6526.1.camel@infradead.org>
Subject: Re: [PATCH 3/5] arm64: kdump: do not go into EL2 before starting a
 crash dump kernel
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <1427358533-3754-4-git-send-email-takahiro.akashi@linaro.org>
References: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
 <1427358533-3754-4-git-send-email-takahiro.akashi@linaro.org>
Date: Thu, 26 Mar 2015 15:29:17 -0700
Mime-Version: 1.0
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
Cc: linux-arm-kernel@lists.infradead.org, hbabus@us.ibm.com, linaro-kernel@lists.linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, broonie@kernel.org, david.griego@linaro.org, kexec@lists.infradead.org, vgoyal@redhat.com

On Thu, 2015-03-26 at 17:28 +0900, AKASHI Takahiro wrote:
> @@ -64,7 +65,11 @@ void soft_restart(unsigned long addr)
>  	setup_mm_for_reboot();
>  
>  	cpu_soft_restart(virt_to_phys(cpu_reset),
> -		is_hyp_mode_available(), addr);
> +#ifdef CONFIG_KEXEC
> +		!in_crash_kexec &&
> +#endif

Why not define in_crash_kexec without condition on CONFIG_KEXEC, say
here in process.c and then avoid these preprocessor conditionals.

> +		is_hyp_mode_available(),
> +		addr);
>  
>  	/* Should never get here */
>  	BUG();




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
