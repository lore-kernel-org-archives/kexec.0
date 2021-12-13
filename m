Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwgDA-008BsD-Fw
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 07:57:29 +0000
Date: Mon, 13 Dec 2021 08:57:25 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] vmcore: Convert copy_oldmem_page() to take an iov_iter
Message-ID: <20211213075725.GA20986@lst.de>
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
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 12:06:34AM +0000, Matthew Wilcox (Oracle) wrote:
> Instead of passing in a 'buf' and 'userbuf' argument, pass in an iov_iter.
> s390 needs more work to pass the iov_iter down further, or refactor,
> but I'd be more comfortable if someone who can test on s390 did that work.
> 
> It's more convenient to convert the whole of read_from_oldmem() to
> take an iov_iter at the same time, so rename it to read_from_oldmem_iter()
> and add a temporary read_from_oldmem() wrapper that creates an iov_iter.

This looks pretty reasonable.  s390 could use some love from people that
know the code, and yes, the kerneldoc comments should go away.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
