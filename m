Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 13 Dec 2021 14:34:39 +0000
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 3/3] iov-kaddr
Message-ID: <YbdZ/2Odm70modUf@casper.infradead.org>
References: <20211213141907.3064347-1-willy@infradead.org>
 <20211213141907.3064347-4-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213141907.3064347-4-willy@infradead.org>
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
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@arm.com>, Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:19:07PM +0000, Matthew Wilcox (Oracle) wrote:
> ---
>  fs/9p/vfs_dir.c     |  5 +----
>  fs/9p/xattr.c       |  6 ++----
>  include/linux/uio.h |  9 +++++++++
>  lib/iov_iter.c      | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 44 insertions(+), 8 deletions(-)

Ugh, this was NOT supposed to go out.  Sorry, I'll do a v3.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
