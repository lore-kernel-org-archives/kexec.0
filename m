Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Date: Tue, 13 Aug 2013 12:18:02 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] ARM: kexec: offline non panic CPUs on Kdump panic
Message-ID: <20130813111802.GD30280@mudshark.cambridge.arm.com>
References: <1374817287-27952-1-git-send-email-vijay.kilari@gmail.com>
 <20130726104908.GC17886@mudshark.cambridge.arm.com>
 <51F2ACF7.9000008@wwwdotorg.org>
 <CALicx6ugumPG__rSAsTS95SH=6fTGqhpPFsQ8bLG-u-fbk0=pQ@mail.gmail.com>
 <51F7F0E1.5030200@wwwdotorg.org>
 <CALicx6tJFkGbvKO+-XZixj+8RSh1awFnXK91Pdew1+5Oa+dDqg@mail.gmail.com>
 <51F945F9.3050906@wwwdotorg.org>
 <CALicx6u5tkf_wvX8ZcVwbhUOkt3=Zz7214yR9pVce0TJ82Vt4A@mail.gmail.com>
 <51FA8C13.2060807@wwwdotorg.org>
 <CALicx6tihdPzZYMU5BUL-FUK9EvzvCimc6av=QM92Xa8zBwcBw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALicx6tihdPzZYMU5BUL-FUK9EvzvCimc6av=QM92Xa8zBwcBw@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vijay Kilari <vijay.kilari@gmail.com>
Cc: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, "Prasun.Kapoor@caviumnetworks.com" <Prasun.Kapoor@caviumnetworks.com>, Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Aug 12, 2013 at 01:18:38PM +0100, Vijay Kilari wrote:
> On Thu, Aug 1, 2013 at 9:55 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> > OK, if there are explicit measure to assure this already, then there's
> > no issue.
> 
> Hi Will,
> 
>  Can you please consider this patch?

Assuming that Stephen and I are understanding things correctly, then this
patch seems fine.

Can you put it into Russell's patch system please?

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
