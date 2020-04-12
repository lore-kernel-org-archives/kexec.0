Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jNTen-0000w1-4C
 for kexec@lists.infradead.org; Sun, 12 Apr 2020 03:51:42 +0000
Date: Sun, 12 Apr 2020 11:51:11 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [GIT PULL 0/9] EFI fixes for v5.7-rc
Message-ID: <20200412035111.GA10163@dhcp-128-65.nay.redhat.com>
References: <20200409130434.6736-1-ardb@kernel.org>
 <20200409190109.GB45598@mit.edu>
 <CAMj1kXGiA3PAybR7r9tatL7WV5iU7B1OQxQok3d-JmRnhX1TnA@mail.gmail.com>
 <20200409201632.GC45598@mit.edu>
 <CAMj1kXFqKGSqm_y+ht4mmmu10TrhSyiTG8V3PxRYGodpZ=xNFQ@mail.gmail.com>
 <20200409235716.GF45598@mit.edu>
 <CAMj1kXH4VtNcJugpG_UR10ewGiOApTiw=C3FsuyAQQyg67Q8Aw@mail.gmail.com>
 <20200410135442.GA6772@dhcp-128-65.nay.redhat.com>
 <20200411194351.GQ45598@mit.edu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200411194351.GQ45598@mit.edu>
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
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-efi <linux-efi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Gary Lin <glin@suse.com>, Sergey Shatunov <me@prok.pw>, Colin Ian King <colin.king@canonical.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, Jiri Slaby <jslaby@suse.cz>, Ard Biesheuvel <ardb@kernel.org>

On 04/11/20 at 03:43pm, Theodore Y. Ts'o wrote:
> On Fri, Apr 10, 2020 at 09:54:42PM +0800, Dave Young wrote:
> > 
> > The runtime cleanup looks a very good one, but I also missed that,
> > userspace kexec-tools will break with the efi setup_data changes. But
> > kexec_file_load will just work with the cleanup applied.
> 
> Hmmm, I wonder if there could be some kselftest or kunit tests that
> would make it easier to pick up these sorts of regressions earlier?

I thought about that before, but did not go with any actual actions.
kexec test needs a system reboot, Kdump is even harder to test, that is
the reason I hesitated about.

But since the breakage happens here and there frequently, it is time to
try it.  I think I will play with it, but I might be slow because of
other things,  welcome to post patches if anyone is interested :)

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
