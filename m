Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f3DdH-00062O-JR
 for kexec@lists.infradead.org; Tue, 03 Apr 2018 04:33:20 +0000
Received: by mail-it0-x242.google.com with SMTP id h143-v6so21499410ita.4
 for <kexec@lists.infradead.org>; Mon, 02 Apr 2018 21:33:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180402190454.GB29890@light.dominikbrodowski.net>
References: <20180402190454.GB29890@light.dominikbrodowski.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Apr 2018 21:33:07 -0700
Message-ID: <CA+55aFyaVVKKbXPFzW1Tr7CTpiLCK+1nGdhS21wnm1j64bqWPA@mail.gmail.com>
Subject: Re: [GIT PULL] remove in-kernel calls to syscalls
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
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>, linux-mm <linux-mm@kvack.org>, "H. Peter Anvin" <hpa@zytor.com>, tautschn@amazon.co.uk, Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, the arch/x86 maintainers <x86@kernel.org>, hmclauchlan@fb.com, Christoph Hellwig <hch@infradead.org>, Jiri Slaby <jslaby@suse.com>, Darren Hart <dvhart@infradead.org>, Jaswinder Singh <jaswinder@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Network Development <netdev@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>

On Mon, Apr 2, 2018 at 12:04 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> This patchset removes all in-kernel calls to syscall functions in the
> kernel with the exception of arch/.

Ok, this finished off my arch updates for today, I'll probably move on
to driver pulls tomorrow.

Anyway, it's in my tree, will push out once my test build finishes.

                Linus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
