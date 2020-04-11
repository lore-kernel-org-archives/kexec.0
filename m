Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jNM3B-0002zG-Fq
 for kexec@lists.infradead.org; Sat, 11 Apr 2020 19:44:22 +0000
Date: Sat, 11 Apr 2020 15:43:51 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [GIT PULL 0/9] EFI fixes for v5.7-rc
Message-ID: <20200411194351.GQ45598@mit.edu>
References: <20200409130434.6736-1-ardb@kernel.org>
 <20200409190109.GB45598@mit.edu>
 <CAMj1kXGiA3PAybR7r9tatL7WV5iU7B1OQxQok3d-JmRnhX1TnA@mail.gmail.com>
 <20200409201632.GC45598@mit.edu>
 <CAMj1kXFqKGSqm_y+ht4mmmu10TrhSyiTG8V3PxRYGodpZ=xNFQ@mail.gmail.com>
 <20200409235716.GF45598@mit.edu>
 <CAMj1kXH4VtNcJugpG_UR10ewGiOApTiw=C3FsuyAQQyg67Q8Aw@mail.gmail.com>
 <20200410135442.GA6772@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200410135442.GA6772@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: linux-efi <linux-efi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Gary Lin <glin@suse.com>, Sergey Shatunov <me@prok.pw>, Colin Ian King <colin.king@canonical.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, Jiri Slaby <jslaby@suse.cz>, Ard Biesheuvel <ardb@kernel.org>

On Fri, Apr 10, 2020 at 09:54:42PM +0800, Dave Young wrote:
> 
> The runtime cleanup looks a very good one, but I also missed that,
> userspace kexec-tools will break with the efi setup_data changes. But
> kexec_file_load will just work with the cleanup applied.

Hmmm, I wonder if there could be some kselftest or kunit tests that
would make it easier to pick up these sorts of regressions earlier?

      	      	     	     	      	    - Ted

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
