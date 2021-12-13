Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 13 Dec 2021 01:34:14 +0000
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/3] vmcore: Convert copy_oldmem_page() to take an iov_iter
Message-ID: <YbajFsMwJvQ6MC7N@casper.infradead.org>
References: <20211213000636.2932569-1-willy@infradead.org>
 <20211213000636.2932569-2-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213000636.2932569-2-willy@infradead.org>
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
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:06:34AM +0000, Matthew Wilcox (Oracle) wrote:
> +++ b/arch/arm/kernel/crash_dump.c
> @@ -27,9 +27,8 @@
>   * @buf. If @buf is in userspace, set @userbuf to %1. Returns number of bytes
>   * copied or negative error in case of failure.
>   */
> -ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> -			 size_t csize, unsigned long offset,
> -			 int userbuf)
> +ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
> +			 size_t csize, unsigned long offset)
>  {
>  	void *vaddr;
>  

I forgot to mention that I didn't adjust the kernel-doc.  I'm tempted to
remove it entirely, to be honest.  It's not included into the rst files,
and having the documentation repeated ten times across arch directories
isn't useful.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
