Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1458065710.3391.8.camel@infradead.org>
Subject: Re: [PATCH v15 03/20] arm64: Convert hcalls to use HVC immediate value
From: Geoff Levand <geoff@infradead.org>
Date: Tue, 15 Mar 2016 11:15:10 -0700
In-Reply-To: <20160315135030.GA3701@e103592.cambridge.arm.com>
References: <cover.1457977401.git.geoff@infradead.org>
 <c23696b455e99b5b111ae559c7998f3c56a664df.1457977402.git.geoff@infradead.org>
 <20160315135030.GA3701@e103592.cambridge.arm.com>
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
To: Dave Martin <Dave.Martin@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi,

On Tue, 2016-03-15 at 13:50 +0000, Dave Martin wrote:
> On Mon, Mar 14, 2016 at 05:48:00PM +0000, Geoff Levand wrote:
> > The existing arm64 hcall implementations are limited in that they only
> > allow for two distinct hcalls; with the x0 register either zero or not
> > zero.  Also, the API of the hyp-stub exception vector routines and the
> > KVM exception vector routines differ; hyp-stub uses a non-zero value in
> > x0 to implement __hyp_set_vectors, whereas KVM uses it to implement
> > kvm_call_hyp.
> > 
> > To allow for additional hcalls to be defined and to make the arm64 hcall
> > API more consistent across exception vector routines, change the hcall
> > implementations to use the 16 bit immediate value of the HVC instruction
> > to specify the hcall type.
> 
> I'm a bit concerned about namespace pollution on the HVC immediate here.
> Existing users tend allocate a single "random" number to identify the
> API -- Xen and Jailhouse do this for example.
> 
> If we start using the HVC immediate to select functions, not just APIs,
> the space is going to fill up a lot faster, if we have a multiplex
> multiple APIs through it.

This was discussed and concluded that we have 16 bits to fill up,
and that is enough.  Functions can still be multiplexed through a
single HVC immediate if the user chooses to do so.

> 
> (We don't currently seem to multiplex APIs much here, except that we
> do use HVC for PSCI calls from the guest, and it could be used for
> additional paravirtualised services in the future).
> 
> > Define three new preprocessor macros HVC_CALL_HYP, HVC_GET_VECTORS, and
> > HVC_SET_VECTORS to be used as hcall type specifiers and convert the
> > existing __hyp_get_vectors(), __hyp_set_vectors() and kvm_call_hyp()
> > routines to use these new macros when executing an HVC call.  Also,
> > change the corresponding hyp-stub and KVM el1_sync exception vector
> > routines to use these new macros.
> 
> It would also be preferable to keep the 32-bit and 64-bit APIs the same;
> we should avoid having them different unless there's a clinching
> technical reason...

Please expand on why you see it as preferable.  What problems do
you see?

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
