Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1469483761.2889.10.camel@infradead.org>
Subject: Re: [PATCH v1 3/4] arm64: Add arm64 kexec support
From: Geoff Levand <geoff@infradead.org>
Date: Mon, 25 Jul 2016 14:56:01 -0700
In-Reply-To: <5791EF62.5070006@arm.com>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <20160720153859.GG24691@leverpostej>
 <1469042361.2977.90.camel@infradead.org>
 <20160721103120.GB20559@leverpostej> <5790A902.6070601@arm.com>
 <1469137776.2977.128.camel@infradead.org>
 <20160722040842.GA14911@localhost.localdomain> <5791EF62.5070006@arm.com>
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
To: Robin Murphy <robin.murphy@arm.com>, Pratyush Anand <panand@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Fri, 2016-07-22 at 11:03 +0100, Robin Murphy wrote:

> I suggest we simply copy the purgatory
> console
> implementation from, say, ARM or Alpha.

I decided on what mips had.  It was a little more applicable.

I put the code I removed into a separate patch, 'arm64: Add
purgatory printing' that we can use to build the perfect bike
shed later.

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
