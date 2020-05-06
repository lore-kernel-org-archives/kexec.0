Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 6 May 2020 13:31:12 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/2] arm64/crash_core: Export KERNELPACMASK in
 vmcoreinfo
Message-ID: <20200506123112.GF8043@willie-the-truck>
References: <1587968702-19996-1-git-send-email-amit.kachhap@arm.com>
 <20200504171741.GD1833@willie-the-truck>
 <bc5e6fc5-15f4-40bb-4466-816de5912893@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc5e6fc5-15f4-40bb-4466-816de5912893@arm.com>
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
To: Amit Kachhap <amit.kachhap@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>, Vincenzo Frascino <Vincenzo.Frascino@arm.com>, linux-arm-kernel@lists.infradead.org

On Wed, May 06, 2020 at 05:32:56PM +0530, Amit Kachhap wrote:
> On 5/4/20 10:47 PM, Will Deacon wrote:
> > On Mon, Apr 27, 2020 at 11:55:01AM +0530, Amit Daniel Kachhap wrote:
> > > diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
> > > index eece20d..32d5900 100644
> > > --- a/arch/arm64/include/asm/compiler.h
> > > +++ b/arch/arm64/include/asm/compiler.h
> > > @@ -19,6 +19,9 @@
> > >   #define __builtin_return_address(val)					\
> > >   	(void *)(ptrauth_clear_pac((unsigned long)__builtin_return_address(val)))
> > > +#else  /* !CONFIG_ARM64_PTR_AUTH */
> > > +#define	ptrauth_user_pac_mask()		0ULL
> > > +#define	ptrauth_kernel_pac_mask()	0ULL
> > 
> > This doesn't look quite right to me, since you still have to take into
> > account the case where CONFIG_ARM64_PTR_AUTH=y but the feature is not
> > available at runtime:
> 
> Yes agree with you here. However the config gaurd is saving some extra
> computation for __builtin_return_address. There are some compiler
> support being added in __builtin_extract_return_address to mask the PAC.
> Hopefully that will improve this code. In the meantime let it be like this.

Does the extra computation matter? Isn't it just a couple of instructions?

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
