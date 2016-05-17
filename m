Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x234.google.com ([2607:f8b0:400e:c03::234])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b2avg-0002E3-77
 for kexec@lists.infradead.org; Tue, 17 May 2016 09:04:41 +0000
Received: by mail-pa0-x234.google.com with SMTP id xk12so4723866pac.0
 for <kexec@lists.infradead.org>; Tue, 17 May 2016 02:04:19 -0700 (PDT)
Date: Tue, 17 May 2016 18:07:53 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v15 00/20] arm64 kexec kernel patches v15
Message-ID: <20160517090602.GA31879@linaro.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Dave Young <dyoung@redhat.com>, linux-arm-kernel@lists.infradead.org

Marc, Dave

On Tue, May 17, 2016 at 09:06:54AM +0100, Marc Zyngier wrote:
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

Done. At the time of last week.
The only issue that I have now is a support for KASLR, but this is not
a kernel issue, but tool's. I'm now talking with Dave Anderson (RedHat)
about how we should fix it.

> 2) post these patches when -rc1 gets cut in two weeks from now,

Yes, we are planning to do so.

> 3) address the review comments in a timely manner,

I'd like to expect the code to be reviewed in a timely manner, too.
In v4.6, we have not got any comments (nor ack's) on kexec/kdump-specific
part of patches. If this happens again, it will make the turnaround of our
re-spinning even longer.

> 4) update the series once a week so that we see some actual progress

Yes if we have updates.

> If this happens, I can't see any reason why this code wouldn't get
> merged. But keeping kexec and kdump together is not what has prevented
> the code from getting merged until now.

Yeah, agree.

Thanks,
-Takahiro AKASHI

> 
> Thanks,
> 
> 	M.
> > 
> > On 04/01/16 at 11:39am, Geoff Levand wrote:
> >> Hi,
> >>
> >> On Fri, 2016-04-01 at 09:59 +0800, Dave Young wrote:
> >>> Geoff, for easier to review maybe you can send kexec patches first
> >>> then AKASHI Takahiro
> >>> can send the kdump patches as a standalone patchset?
> >>
> >> Marc Zyngier specifically asked for an integrated set
> >> of patches for easier review.  I will keep it that way
> >> for now.
> >>
> >> -Geoff
> > 
> 
> 
> -- 
> Jazz is not dead. It just smells funny...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
