Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hHQaW-0006qy-A6
 for kexec@lists.infradead.org; Fri, 19 Apr 2019 10:17:46 +0000
Date: Fri, 19 Apr 2019 12:17:33 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH] kexec, x86/boot: map systab region in identity
 mapping before accessing it
Message-ID: <20190419101733.GA10324@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Kairui Song <kasong@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>, Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Junichi Nomura <j-nomura@ce.jp.nec.com>, Dave Young <dyoung@redhat.com>

Breaking thread because this one got too big.

On Fri, Apr 19, 2019 at 04:34:58PM +0800, Kairui Song wrote:
> There are two approach to fix it, detect if the systab is mapped, and
> avoid reading it if not.

Ok, so tglx and I discussed this situation which is slowly getting out
of hand with all the tinkering.

So, here's what we should do - scream loudly now if some of this doesn't
make any sense.

1. Junichi's patch should get the systab check above added and sent to
5.1 so that at least some EFI kexecing can work with 5.1

2. Then, the fact whether the kernel has been kexec'ed and which
addresses it should use early, should all be passed through boot_params
which is either setup by kexec(1) or by the first kernel itself, in the
kexec_file_load() case.

> the systab region is not mapped by the identity mapping provided by
> kexec.

3. Then that needs to be fixed in the first kernel as it is a
shortcoming of us starting to parse systab very early. It is the kexec
setup code's problem not the early compressed stage's problem that the
EFI systab is not mapped.

Anything else I've forgotten? Anything I've misrepresented?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
