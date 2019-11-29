Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Fri, 29 Nov 2019 10:24:22 +0000
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 0/5] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
Message-ID: <20191129102421.GA28322@willie-the-truck>
References: <1574972621-25750-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1574972621-25750-1-git-send-email-bhsharma@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Boris Petkov <bp@alien8.de>, Dave Anderson <anderson@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, James Morse <james.morse@arm.com>, Thomas Gleixner <tglx@linutronix.de>, bhupesh.linux@gmail.com, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org, Steve Capper <steve.capper@arm.com>

On Fri, Nov 29, 2019 at 01:53:36AM +0530, Bhupesh Sharma wrote:
> Changes since v4:
> ----------------
> - v4 can be seen here:
>   http://lists.infradead.org/pipermail/kexec/2019-November/023961.html
> - Addressed comments from Dave and added patches for documenting
>   new variables appended to vmcoreinfo documentation.
> - Added testing report shared by Akashi for PATCH 2/5.

Please can you fix your mail setup? The last two times you've sent this
series it seems to get split into two threads, which is really hard to
track in my inbox:

First thread:

https://lore.kernel.org/lkml/1574972621-25750-1-git-send-email-bhsharma@redhat.com/

Second thread:

https://lore.kernel.org/lkml/1574972716-25858-1-git-send-email-bhsharma@redhat.com/

Thanks,

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
