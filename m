Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Date: Wed, 2 Mar 2016 01:38:48 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 00/19] arm64 kexec kernel patches v13
Message-ID: <20160302013848.GG14022@arm.com>
References: <cover.1452884156.git.geoff@infradead.org>
 <c7575f853ccc491bb0212e025aab1cc9@NASANEXM01H.na.qualcomm.com>
 <56D5D763.4030304@codeaurora.org>
 <1456881475.6738.18.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1456881475.6738.18.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: 'Mark Rutland' <mark.rutland@arm.com>, marc.zyngier@arm.com, catalin.marinas@arm.com, Azriel Samson <asamson@codeaurora.org>, kexec@lists.infradead.org, 'AKASHI Takahiro' <takahiro.akashi@linaro.org>, james.morse@arm.com, christoffer.dall@linaro.org, virajm@codeaurora.org, linux-arm-kernel@lists.infradead.org

On Tue, Mar 01, 2016 at 05:17:55PM -0800, Geoff Levand wrote:
> On Tue, 2016-03-01 at 10:54 -0700, Azriel Samson wrote:
> 
> > We have been using the kexec/kdump patches on ARM64 and would like to
> > use them from upstream.
> > 
> > Assuming these are not going to be in Linux-4.5, a rebased set on 
> > Linux-4.5 would be very useful.
> 
> I'm waiting for one of two things to happen, either Marc Zyngier gives
> an ack for the patch 'arm64: kvm: allows kvm cpu hotplug', or the arm64
> maintainers decide they will accept my proposal to merge kexec with a
> conditional in the Kconfig that only allows one of KVM or kexec to be
> selected.

Depending on !KVM isn't even an option as far as I'm concerned. It basically
makes this all dead code.

As for awaiting an ack on the kvm hotplug patch, afaict, Akashi was going
to address James's comments on the last posting [1].

> The kexec patches have been in review for 20 months now, with only
> minor changes in the past 15.  I don't expect much would be gained in
> posting the kexec series again unless there is a chance they would be
> merged.

Why do you say that? v13 attracted lots of comments from a variety of
reviewers, so the onus is on you to address that feedback and post a
new version. Alternatively, declare that you no longer to intend to work
on the series, and perhaps then somebody else can pick it up and finish
the job.

Will

[1] http://lkml.kernel.org/r/56A873C0.6090406@linaro.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
