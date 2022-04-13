From: Borislav Petkov <bp@alien8.de>
Date: Wed, 13 Apr 2022 10:32:38 +0200
Subject: [PATCH v2 0/2] x86/kexec: fix memory leak of elf header buffer
In-Reply-To: <YlY51XjPFN1vMvQV@MiWiFi-R3L-srv>
References: <20220223113225.63106-1-bhe@redhat.com>
 <YkWRQdp7TxV22ygO@MiWiFi-R3L-srv>
 <20220412192734.fcda8988d189c8e2e2830b03@linux-foundation.org>
 <YlY51XjPFN1vMvQV@MiWiFi-R3L-srv>
Message-ID: <YlaKpuRQfIZsyBtL@zn.tnic>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Apr 13, 2022 at 10:47:49AM +0800, Baoquan He wrote:
> Since it's also MM related, so ping you and x86 maintainers to see who
> can help pick them.

I'd leave that decision to akpm. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

