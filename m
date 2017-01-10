Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 10 Jan 2017 12:41:05 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCHv6 00/11] CONFIG_DEBUG_VIRTUAL for arm64
Message-ID: <20170110124105.GH21598@arm.com>
References: <1483464113-1587-1-git-send-email-labbott@redhat.com>
 <edc8eaa2-5414-506c-1dad-f2404ef19c81@gmail.com>
 <b3de65da-8a74-2510-268e-34516cc2de77@redhat.com>
 <20170104114449.GA18193@arm.com>
 <e13dc77e-6709-8122-9856-35aee876b836@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e13dc77e-6709-8122-9856-35aee876b836@gmail.com>
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
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, x86@kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org, Andrey Ryabinin <aryabinin@virtuozzo.com>, Laura Abbott <labbott@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, Marc Zyngier <marc.zyngier@arm.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, Andrew Morton <akpm@linux-foundation.org>, Christoffer Dall <christoffer.dall@linaro.org>

On Wed, Jan 04, 2017 at 02:30:50PM -0800, Florian Fainelli wrote:
> On 01/04/2017 03:44 AM, Will Deacon wrote:
> > On Tue, Jan 03, 2017 at 03:25:53PM -0800, Laura Abbott wrote:
> >> On 01/03/2017 02:56 PM, Florian Fainelli wrote:
> >>> On 01/03/2017 09:21 AM, Laura Abbott wrote:
> >>>> Happy New Year!
> >>>>
> >>>> This is a very minor rebase from v5. It only moves a few headers around.
> >>>> I think this series should be ready to be queued up for 4.11.
> >>>
> >>> FWIW:
> >>>
> >>> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> >>>
> >>
> >> Thanks!
> >>
> >>> How do we get this series included? I would like to get the ARM 32-bit
> >>> counterpart included as well (will resubmit rebased shortly), but I have
> >>> no clue which tree this should be going through.
> >>>
> >>
> >> I was assuming this would go through the arm64 tree unless Catalin/Will
> >> have an objection to that.
> > 
> > Yup, I was planning to pick it up for 4.11.
> > 
> > Florian -- does your series depend on this? If so, then I'll need to
> > co-ordinate with Russell (probably via a shared branch that we both pull)
> > if you're aiming for 4.11 too.
> 
> Yes, pretty much everything in Laura's patch series is relevant, except
> the arm64 bits.

Ok, then. Laura -- could you please reorder your patches so that the
non-arm64 bits come first? That way, I can put those on a separate branch
and have it pulled by both arm64 and rmk, so that the prequisities are
shared between the architectures.

Thanks,

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
