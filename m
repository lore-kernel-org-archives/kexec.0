Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 20 Oct 2015 14:26:20 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH 08/16] arm64/kexec: Add core kexec support
Message-ID: <20151020085620.GC31893@dhcppc13.redhat.com>
References: <cover.1445297709.git.geoff@infradead.org>
 <a1c2a702f127d9dade1f9af8ab13decb2ef1c0da.1445297709.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a1c2a702f127d9dade1f9af8ab13decb2ef1c0da.1445297709.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI@infradead.org, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Takahiro <takahiro.akashi@linaro.org>, christoffer.dall@linaro.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Geoff,

Thanks for the patches.

On 19/10/2015:11:38:53 PM, Geoff Levand wrote:
> +static void soft_restart(unsigned long addr)
> +{
> +	setup_mm_for_reboot();
> +	cpu_soft_restart(virt_to_phys(cpu_reset), addr,
> +		is_hyp_mode_available());

So now we do not flush cache for any memory region. Shouldn't we still flush
at least kernel and purgatory segments. 

kexec-tools loads a new kernel and purgatory executable. Some of those bits
might still be only in D-cache and we disable D-cache before control is passed
to the purgatory binary. Purgatory and some initial part of kernel code is
executed with D-cache disabled. So, We might land into a situation where correct
code is not executed while D-cache is disabled, no?

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
