From: Christoph Hellwig <hch@lst.de>
Date: Wed, 6 Apr 2022 06:42:44 +0200
Subject: [PATCH] mm/vmalloc: fix spinning drain_vmap_work after reading
 from /proc/vmcore
In-Reply-To: <75014514645de97f2d9e087aa3df0880ea311b77.1649187356.git.osandov@fb.com>
References: <75014514645de97f2d9e087aa3df0880ea311b77.1649187356.git.osandov@fb.com>
Message-ID: <20220406044244.GA9959@lst.de>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Tue, Apr 05, 2022 at 12:40:31PM -0700, Omar Sandoval wrote:
> A simple way to "fix" this would be to make set_iounmap_nonlazy() set
> vmap_lazy_nr to lazy_max_pages() instead of lazy_max_pages() + 1. But, I
> think it'd be better to get rid of this hack of clobbering vmap_lazy_nr.
> Instead, this fix makes __copy_oldmem_page() explicitly drain the vmap
> areas itself.

This fixes the bug and the interface also is better than what we had
before.  But a vmap/iounmap_eager would seem even better.  But hey,
right now it has one caller in always built ?n x86 arch code, so maybe
it isn't worth spending more effort on this.

