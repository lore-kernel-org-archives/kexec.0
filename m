Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bQRls-0000lS-P0
 for kexec@lists.infradead.org; Fri, 22 Jul 2016 04:09:09 +0000
Received: by mail-qt0-f173.google.com with SMTP id u25so55563069qtb.1
 for <kexec@lists.infradead.org>; Thu, 21 Jul 2016 21:08:47 -0700 (PDT)
Date: Fri, 22 Jul 2016 09:38:42 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v1 3/4] arm64: Add arm64 kexec support
Message-ID: <20160722040842.GA14911@localhost.localdomain>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <20160720153859.GG24691@leverpostej>
 <1469042361.2977.90.camel@infradead.org>
 <20160721103120.GB20559@leverpostej> <5790A902.6070601@arm.com>
 <1469137776.2977.128.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1469137776.2977.128.camel@infradead.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org

On 21/07/2016:02:49:36 PM, Geoff Levand wrote:
> On Thu, 2016-07-21 at 11:50 +0100, Robin Murphy wrote:
> > The Exynos UART (drivers/tty/serial/samsung.c) is one which comes to
> > mind as definitely existing, and on arm64 systems to boot. The TX
> > register is at offset 0x20 there.
> 
> Here's what I came up with.
> 
> 
> +	struct data {const char *name; int tx_offset;};
> +	static const struct data ok_list[] = {
> +	/*	{"armada-3700-uart", ?},	*/
> +		{"exynos4210-uart", 0x20},
> +	/*	{"ls1021a-lpuart", ?},		*/
> +	/*	{"meson-uart", ?},		*/
> +	/*	{"mt6577-uart", ?},		*/
> +		{"ns16550", 0},
> +		{"ns16550a", 0},
> +		{"pl011", 0},
> +		{NULL, 0}
> +	};

sinc functionality is just to debug the scenario when something goes wrong in
purgatory. IMHO, it should be disabled by default. So, why not to keep it as
simple as possible. Its a low level debugging mainly for developer, so user
should know the absolute address. Therefore, I think no need to parse earlycon
or earlyprintk from command line.  Whatever user passes in --port can be treated
as address of TX register. If TX offset is 0x20, then user can pass --port as
base+0x20. Additionally, we can pass TX register width as well. So what about
something like "--port=0x1c020000,1" where 0x1c020000 is TX register address and
1 says about it's width in bytes.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
