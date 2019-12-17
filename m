Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 17 Dec 2019 14:49:23 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 0/5] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
Message-ID: <20191217134923.GE28788@zn.tnic>
References: <1574972621-25750-1-git-send-email-bhsharma@redhat.com>
 <20191214122734.GC28635@zn.tnic>
 <CACi5LpP2PPcmaQw95V4MUzhvENq9+mB7UR7eib2HADCDHLz4oA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACi5LpP2PPcmaQw95V4MUzhvENq9+mB7UR7eib2HADCDHLz4oA@mail.gmail.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Dave Anderson <anderson@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Will Deacon <will@kernel.org>, x86@kernel.org, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, James Morse <james.morse@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Catalin Marinas <catalin.marinas@arm.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Steve Capper <steve.capper@arm.com>

On Mon, Dec 16, 2019 at 12:16:12PM +0530, Bhupesh Sharma wrote:
> I remember there was a suggestion during the review of an earlier
> version to keep them as a separate patch(es) so that the documentation
> text is easier to review,

Documentation text is one sentence, respectively. Not really worth a
separate patch.

> I can merge the documentation patches with the respective patches
> (which export the variables/defines to vmcoreinfo) in v6,

Please do.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
