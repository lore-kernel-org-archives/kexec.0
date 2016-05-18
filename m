Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 18 May 2016 10:09:17 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v15 00/20] arm64 kexec kernel patches v15
Message-ID: <20160518020917.GB3073@dhcp-128-65.nay.redhat.com>
References: <cover.1457977401.git.geoff@infradead.org>
 <20160401015947.GA3835@dhcp-128-65.nay.redhat.com>
 <1459535954.20121.3.camel@infradead.org>
 <20160517054216.GA12543@dhcp-128-65.nay.redhat.com>
 <573AD11E.1030301@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <573AD11E.1030301@arm.com>
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
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Marc

On 05/17/16 at 09:06am, Marc Zyngier wrote:
> Hi Dave,
> 
> On 17/05/16 06:42, Dave Young wrote:
> > Marc, it has been discussed for long time, I think kdump code can be
> > logically splitted from this series so that we can get the kexec
> > done first? 
> 
> The basis for kexec are already on their way to mainline, as part of the
> hibernate series that James has put together.
> 
> I'd expect someone to:
> 
> 1) rebase the remaining kexec/kdump patches based on the current
> arm64/for-next/core,
> 2) post these patches when -rc1 gets cut in two weeks from now,
> 3) address the review comments in a timely manner,
> 4) update the series once a week so that we see some actual progress
> 
> If this happens, I can't see any reason why this code wouldn't get
> merged. But keeping kexec and kdump together is not what has prevented
> the code from getting merged until now.

Cool, thanks a lot for the clarification about the situation.

Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
