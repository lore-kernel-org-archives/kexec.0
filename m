Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 16 Dec 2015 13:06:22 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v12 11/16] arm64: kdump: reserve memory for crash dump
 kernel
Message-ID: <20151216073622.GJ4674@dhcppc13.redhat.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <bc962621bd537244b54fc35627a456ab40bc6d26.1448403503.git.geoff@infradead.org>
 <20151215172953.GD353@arm.com> <5670F45E.7060100@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5670F45E.7060100@linaro.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, marc.zyngier@arm.com, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, christoffer.dall@linaro.org

On 16/12/2015:02:19:26 PM, AKASHI Takahiro wrote:
> On 12/16/2015 02:29 AM, Will Deacon wrote:
> >#else
> >
> >static void __init reserve_crashkernel(void) {};
> 
> OK.

Then may be you do not need to protect calling of reserve_crashkernel() with
CONFIG_KEXEC_CORE as well.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
