Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1422383697.21823.19.camel@infradead.org>
Subject: Re: [PATCH 4/8] arm64: Add EL2 switch to soft_restart
From: Geoff Levand <geoff@infradead.org>
Date: Tue, 27 Jan 2015 10:34:57 -0800
In-Reply-To: <20150127164619.GL17721@leverpostej>
References: <cover.1421449714.git.geoff@infradead.org>
 <bb44d4eee4fab15278e4a8829a0981878bc9acd7.1421449714.git.geoff@infradead.org>
 <20150126190223.GO23313@leverpostej>
 <1422308928.21823.16.camel@infradead.org>
 <20150127164619.GL17721@leverpostej>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <Marc.Zyngier@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Mark,

On Tue, 2015-01-27 at 16:46 +0000, Mark Rutland wrote:
> On Mon, Jan 26, 2015 at 09:48:48PM +0000, Geoff Levand wrote:
> > This conditional is just if KVM, do things the old way (don't try to
> > switch exception levels).  It is to handle the system shutdown case.
> 
> Having grepped treewide for soft_restart, other than kexec there are no
> users for arm64. So surely kexec is the only case to cater for at the
> moment?

Yes, I think you're right, and so it seems we can drop this patch and
just have the 'Add checks for KVM' patch.

> > Another patch in this series '[PATCH 7/8] arm64/kexec: Add checks for
> > KVM' assures kexec cannot happen when KVM is configured.
> 
> It would be better to just move this earlier (or event better, implement
> kvm teardown).

Yes, I hope we don't really need to have any KVM work-arounds.

-Geoff




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
