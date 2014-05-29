Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 29 May 2014 09:01:52 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH RESEND] ARM: kdump: 2nd kernel should use strict
 pfn_valid in SPARSEMEM platform
Message-ID: <20140529080151.GB29812@arm.com>
References: <1401266668-34365-1-git-send-email-wangnan0@huawei.com>
 <5386BD6A.7020509@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5386BD6A.7020509@linaro.org>
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
Cc: Wang Nan <wangnan0@huawei.com>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <Catalin.Marinas@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geng Hui <hui.geng@huawei.com>, Simon Horman <horms@verge.net.au>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, May 29, 2014 at 05:54:02AM +0100, AKASHI Takahiro wrote:
> Catalin, Will
> 
> Can we assume that HAVE_ARCH_PFN_VALID is alway yes on arm64?
> Looking at arm64/Kconfig,
> config ARCH_HAS_HOLES_MEMORYMODEL
> 	def_bool y if SPARSEMEM
> ...
> config HAVE_ARCH_PFN_VALID
> 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
> 
> is this intentional?

Looks like an artifact of the way we constructed those option, so yes, we
could just make that a def_bool y if you like.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
