Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jMujR-0003QS-Dj
 for kexec@lists.infradead.org; Fri, 10 Apr 2020 14:34:11 +0000
Date: Fri, 10 Apr 2020 16:33:58 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] efi/x86: Revert struct layout change to fix kexec boot
 regression
Message-ID: <20200410143313.GB8205@zn.tnic>
References: <20200410074320.16589-1-ardb@kernel.org>
 <20200410135644.GB6772@dhcp-128-65.nay.redhat.com>
 <20200410140151.GC6772@dhcp-128-65.nay.redhat.com>
 <CAMj1kXEM13Y5FCh8GvJGTueen3fa0u_JX66j0X10KPf4Z0c4Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXEM13Y5FCh8GvJGTueen3fa0u_JX66j0X10KPf4Z0c4Jg@mail.gmail.com>
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
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi <linux-efi@vger.kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, X86 ML <x86@kernel.org>, kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>

On Fri, Apr 10, 2020 at 04:22:49PM +0200, Ard Biesheuvel wrote:
> > BTW, a fixes tag is good to have..
> 
> I usually omit those for patches that fix bugs that were introduced in
> the current cycle.

A valid use case for having the Fixes: tag anyway are the backporting
kernels gangs which might pick up the first patch for whatever reason
and would probably be thankful if they find the second one, i.e., the
fix for the first one, through grepping or other, automated means.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
