Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 12 Jan 2016 10:06:38 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: Add --lite option
Message-ID: <20160112010638.GC3860@verge.net.au>
References: <20151022125012.GB20847@redhat.com>
 <1445540891.30908.144.camel@infradead.org>
 <1446703011.12676.83.camel@freescale.com>
 <20151207114547.GE16406@dhcppc13.redhat.com>
 <20151207114839.GF16406@dhcppc13.redhat.com>
 <56658696.6070103@arm.com>
 <20151207140755.GG16406@dhcppc13.redhat.com>
 <5666FE91.5010302@arm.com>
 <20151209092839.GN16406@dhcppc13.redhat.com>
 <20160111124638.GD21206@dhcppc13.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160111124638.GD21206@dhcppc13.redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: Geoff Levand <geoff@infradead.org>, kexec@lists.infradead.org, James Morse <james.morse@arm.com>, Vivek Goyal <vgoyal@redhat.com>, Petitboot@lists.ozlabs.org, Scott Wood <scottwood@freescale.com>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org, Wei Fu <wefu@redhat.com>

On Mon, Jan 11, 2016 at 06:16:38PM +0530, Pratyush Anand wrote:
> +Fu
> 
> Hi James,
> 
> > On 08/12/2015:04:00:17 PM, James Morse wrote:
> > > Hi Pratyush,
> 
> > > I haven't managed to get your kexec-tools branch to work with v10 of
> 
> Thanks for all your feedback. It helped to stabilize the code better. I took
> all your suggestions and also did few other modifications [1]. Now, purgatory
> does SHA verifications on mustang and seattle within a second. I think this
> would be helpful in handling few of the kdump issues with watchdog. May be you
> can give a try to the code in branch purgatory-enable-dcache of my tree. Any
> feedback would be welcome.

Please post the patches here for review.

Thanks

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
