Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1467827067.8880.43.camel@infradead.org>
Subject: Re: [PATCH v21 7/8] arm64: kdump: update a kernel doc
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 06 Jul 2016 10:44:27 -0700
In-Reply-To: <20160706075226.27609-8-takahiro.akashi@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-8-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com
Cc: kexec@lists.infradead.org, james.morse@arm.com, linux-arm-kernel@lists.infradead.org

On Wed, 2016-07-06 at 16:52 +0900, AKASHI Takahiro wrote:
> --- a/Documentation/kdump/kdump.txt
> +++ b/Documentation/kdump/kdump.txt
> @@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
>  a remote system.
>  
>  Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
> -s390x and arm architectures.
> +s390x, arm and arm64 architectures.
>  
>  When the system kernel boots, it reserves a small section of memory for
>  the dump-capture kernel. This ensures that ongoing Direct Memory Access
> @@ -249,6 +249,13 @@ Dump-capture kernel config options (Arch Dependent, arm)
>  
>      AUTO_ZRELADDR=y
>  
> +Dump-capture kernel config options (Arch Dependent, arm64)
> +----------------------------------------------------------
> +
> +- Please note that kvm at the dump-capture kernel will not be enabled

kvm of the dump-capture kernel

> +  on non-VHE system even if it is configured. This is because we have

on non-VHE systems

> +  no chance to reset CPU state to EL2 on panic.

This is because the CPU state cannot be reset to EL2 on panic.




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
