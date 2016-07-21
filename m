Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1469137776.2977.128.camel@infradead.org>
Subject: Re: [PATCH v1 3/4] arm64: Add arm64 kexec support
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 21 Jul 2016 14:49:36 -0700
In-Reply-To: <5790A902.6070601@arm.com>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <20160720153859.GG24691@leverpostej>
 <1469042361.2977.90.camel@infradead.org>
 <20160721103120.GB20559@leverpostej> <5790A902.6070601@arm.com>
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
To: Robin Murphy <robin.murphy@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Pratyush Anand <panand@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Thu, 2016-07-21 at 11:50 +0100, Robin Murphy wrote:
> The Exynos UART (drivers/tty/serial/samsung.c) is one which comes to
> mind as definitely existing, and on arm64 systems to boot. The TX
> register is at offset 0x20 there.

Here's what I came up with.


+	struct data {const char *name; int tx_offset;};
+	static const struct data ok_list[] = {
+	/*	{"armada-3700-uart", ?},	*/
+		{"exynos4210-uart", 0x20},
+	/*	{"ls1021a-lpuart", ?},		*/
+	/*	{"meson-uart", ?},		*/
+	/*	{"mt6577-uart", ?},		*/
+		{"ns16550", 0},
+		{"ns16550a", 0},
+		{"pl011", 0},
+		{NULL, 0}
+	};

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
