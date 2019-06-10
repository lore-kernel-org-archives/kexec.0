Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1haIPl-0006yz-TS
 for kexec@lists.infradead.org; Mon, 10 Jun 2019 11:24:39 +0000
Date: Mon, 10 Jun 2019 13:24:31 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/kexec: Add ACPI NVS region to the ident map
Message-ID: <20190610112431.GC5488@zn.tnic>
References: <20190610073617.19767-1-kasong@redhat.com>
 <20190610095150.GA5488@zn.tnic>
 <CACPcB9f-sussXaOuOau6=CD85pS2KhcsknpJDQH_aEkwvLfvVA@mail.gmail.com>
 <20190610105959.GB5488@zn.tnic>
 <1555938c-e00f-d40f-5f24-146aec7a67eb@ce.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1555938c-e00f-d40f-5f24-146aec7a67eb@ce.jp.nec.com>
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc: the arch/x86 maintainers <x86@kernel.org>, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dirk van der Merwe <dirk.vandermerwe@netronome.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>

On Mon, Jun 10, 2019 at 11:07:05AM +0000, Junichi Nomura wrote:
> I had tested the version I posted here on bunch of physical machines
> I had access and confirmed it didn't broke working setups:
> https://lore.kernel.org/lkml/20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp/
> 
> Since the logic in the patch seems unchanged, I'm very sure it's ok.

Ok, thanks for testing.

I'll add your Tested-by.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
