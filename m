Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 13 Dec 2016 13:50:16 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv5 00/11] CONFIG_DEBUG_VIRTUAL for arm64
Message-ID: <20161213135015.GC24607@leverpostej>
References: <1481068257-6367-1-git-send-email-labbott@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1481068257-6367-1-git-send-email-labbott@redhat.com>
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
To: Laura Abbott <labbott@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, x86@kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, xen-devel@lists.xenproject.org, David Vrabel <david.vrabel@citrix.com>, Kees Cook <keescook@chromium.org>, Marc Zyngier <marc.zyngier@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Juergen Gross <jgross@suse.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Christoffer Dall <christoffer.dall@linaro.org>

On Tue, Dec 06, 2016 at 03:50:46PM -0800, Laura Abbott wrote:
> Hi,
> 
> This is v5 of the series to add CONFIG_DEBUG_VIRTUAL for arm64. This mostly
> contains minor fixups including adding a few extra headers around and splitting
> things out into a few more sub-patches.
> 
> With a few more acks I think this should be ready to go. More testing is
> always appreciated though.

I've given the whole series a go with kasan, kexec, and hibernate (using
test_resume with the disk target), and everything looks happy. So FWIW,
for the series:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Hopefully this can be queued soon for v4.11!

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
