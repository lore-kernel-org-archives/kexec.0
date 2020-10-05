Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 5 Oct 2020 18:16:08 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v12 6/9] arm64: kdump: reimplement crashkernel=X
Message-ID: <20201005171608.GC14576@gaia>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-7-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200907134745.25732-7-chenzhou10@huawei.com>
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
To: Chen Zhou <chenzhou10@huawei.com>
Cc: wangkefeng.wang@huawei.com, linux-doc@vger.kernel.org, bhsharma@redhat.com, huawei.libin@huawei.com, guohanjun@huawei.com, will@kernel.org, bhe@redhat.com, corbet@lwn.net, mingo@redhat.com, dyoung@redhat.com, John.P.donnelly@oracle.com, arnd@arndb.de, xiexiuqi@huawei.com, horms@verge.net.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, james.morse@arm.com, prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de

On Mon, Sep 07, 2020 at 09:47:42PM +0800, Chen Zhou wrote:
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 53acbeca4f57..1b24072f2bae 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -238,7 +238,18 @@ static void __init request_standard_resources(void)
>  		    kernel_data.end <= res->end)
>  			request_resource(res, &kernel_data);
>  #ifdef CONFIG_KEXEC_CORE
> -		/* Userspace will find "Crash kernel" region in /proc/iomem. */
> +		/*
> +		 * Userspace will find "Crash kernel" or "Crash kernel (low)"
> +		 * region in /proc/iomem.
> +		 * In order to distinct from the high region and make no effect
> +		 * to the use of existing kexec-tools, rename the low region as
> +		 * "Crash kernel (low)".
> +		 */
> +		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
> +				crashk_low_res.end <= res->end) {
> +			crashk_low_res.name = "Crash kernel (low)";
> +			request_resource(res, &crashk_low_res);
> +		}

With the changes in this series (including the above), how do the
current kexec-tools behave? Do they pick just the high region and the
loaded kernel will subsequently fail to boot?

-- 
Catalin

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
