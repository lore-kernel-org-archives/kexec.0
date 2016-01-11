Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 11 Jan 2016 18:16:38 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH] kexec: Add --lite option
Message-ID: <20160111124638.GD21206@dhcppc13.redhat.com>
References: <20151022031718.GB11227@dhcp-129-115.nay.redhat.com>
 <20151022125012.GB20847@redhat.com>
 <1445540891.30908.144.camel@infradead.org>
 <1446703011.12676.83.camel@freescale.com>
 <20151207114547.GE16406@dhcppc13.redhat.com>
 <20151207114839.GF16406@dhcppc13.redhat.com>
 <56658696.6070103@arm.com>
 <20151207140755.GG16406@dhcppc13.redhat.com>
 <5666FE91.5010302@arm.com>
 <20151209092839.GN16406@dhcppc13.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151209092839.GN16406@dhcppc13.redhat.com>
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
To: James Morse <james.morse@arm.com>
Cc: Geoff Levand <geoff@infradead.org>, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Vivek Goyal <vgoyal@redhat.com>, Petitboot@lists.ozlabs.org, Scott Wood <scottwood@freescale.com>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org, Wei Fu <wefu@redhat.com>

+Fu

Hi James,

> On 08/12/2015:04:00:17 PM, James Morse wrote:
> > Hi Pratyush,

> > I haven't managed to get your kexec-tools branch to work with v10 of

Thanks for all your feedback. It helped to stabilize the code better. I took
all your suggestions and also did few other modifications [1]. Now, purgatory
does SHA verifications on mustang and seattle within a second. I think this
would be helpful in handling few of the kdump issues with watchdog. May be you
can give a try to the code in branch purgatory-enable-dcache of my tree. Any
feedback would be welcome.

~Pratyush

[1] https://github.com/pratyushanand/kexec-tools/commit/5679d4baaa5e644f8302982c6f468214ed3d3f3d

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
