Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1467827339.8880.45.camel@infradead.org>
Subject: Re: [PATCH v21 2/8] arm64: limit memory regions based on DT
 property, usable-memory
From: Geoff Levand <geoff@infradead.org>
Date: Wed, 06 Jul 2016 10:48:59 -0700
In-Reply-To: <20160706075226.27609-3-takahiro.akashi@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-3-takahiro.akashi@linaro.org>
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
> Crash dump kernel will be run with a limited range of memory as System
> RAM.
> 
> On arm64, we will use a device-tree property under /chosen,
>    linux,usable-memory = 
> in order for primary kernel either on uefi or non-uefi (device tree only)
> system to hand over the information about usable memory region to crash
> dump kernel. This property will supercede entries in uefi memory map table
> and "memory" nodes in a device tree.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

This all looks OK.

Reviewed-by: Geoff Levand <geoff@infradead.org>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
