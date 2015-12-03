Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1449172587.24127.12.camel@infradead.org>
Subject: Re: [PATCH v12 08/16] arm64/kexec: Add core kexec support
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 03 Dec 2015 11:56:27 -0800
In-Reply-To: <000b01d12d84$4313a930$c93afb90$@codeaurora.org>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151127131306.GE23908@dhcppc13.redhat.com>
 <1448909475.31214.27.camel@infradead.org>
 <20151201021615.GA5704@dhcppc13.redhat.com>
 <002101d12c66$ae985440$0bc8fcc0$@codeaurora.org>
 <1449096562.6139.74.camel@infradead.org>
 <000b01d12d84$4313a930$c93afb90$@codeaurora.org>
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
To: Azriel Samson <asamson@codeaurora.org>
Cc: 'Mark Rutland' <mark.rutland@arm.com>, 'Pratyush Anand' <panand@redhat.com>, marc.zyngier@arm.com, 'Catalin Marinas' <catalin.marinas@arm.com>, 'Will Deacon' <will.deacon@arm.com>, 'AKASHI Takahiro' <takahiro.akashi@linaro.org>, linux-arm-kernel@lists.infradead.org, 'Dave Young' <dyoung@redhat.com>, kexec@lists.infradead.org, christoffer.dall@linaro.org

Hi,

On Wed, 2015-12-02 at 21:37 -0700, Azriel Samson wrote:
> I pushed out a kexec-v12.1 branch to my linux-kexec repo [1] with fixes.
> Could you test it with both kexec reboot and kdump?  For kdump, use
> something like:
>  > CMDLINE += 'crashkernel=64M@2240M'
> 
> For kdump, I also require a version of the patch "arm64/kexec: Add support
> for kexec-lite". Without this, the dump capture kernel cannot find the
> device tree even on v11 that I tested.

Without that patch, does the 2nd stage kernel get the correct
dtb address in register x0?

Is the problem that the dtb data is corrupt when in the 2nd
stage kernel?

Is the dtb data OK when in the 1st stage kernel? 

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
