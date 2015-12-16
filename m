Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 16 Dec 2015 16:02:59 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v12 08/16] arm64/kexec: Add core kexec support
Message-ID: <20151216103259.GA316@dhcppc13.redhat.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151215182932.GF353@arm.com>
 <1450224870.24127.130.camel@infradead.org>
 <20151216071804.GI4674@dhcppc13.redhat.com>
 <56712F3A.7040805@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56712F3A.7040805@arm.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Will Deacon <will.deacon@arm.com>, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, linux-arm-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, marc.zyngier@arm.com, christoffer.dall@linaro.org

On 16/12/2015:09:30:34 AM, James Morse wrote:
> On 16/12/15 07:18, Pratyush Anand wrote:
> > We execute arm64_relocate_new_kernel() code with I-cache disabled. So, do we
> > really need to invalidate I-cache?
> 
> I got bitten by this, see Mark's earlier reply[0]:
> 
> Mark Rutland wrote:
> > The SCTLR_ELx.I only affects the attributes that the I-cache uses to
> > fetch with, not whether it is enabled (it cannot be disabled
> > architecturally).

Thanks James for pointing to it. I had missed that.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
