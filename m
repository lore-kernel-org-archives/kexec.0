Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 16 Dec 2021 10:28:36 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 1/3] vmcore: Convert copy_oldmem_page() to take an iov_iter
Message-ID: <YbsGxJRo1153aykr@osiris>
References: <20211213000636.2932569-1-willy@infradead.org>
 <20211213000636.2932569-2-willy@infradead.org>
 <20211213075725.GA20986@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213075725.GA20986@lst.de>
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
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@arm.com>, linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>

On Mon, Dec 13, 2021 at 08:57:25AM +0100, Christoph Hellwig wrote:
> On Mon, Dec 13, 2021 at 12:06:34AM +0000, Matthew Wilcox (Oracle) wrote:
> > Instead of passing in a 'buf' and 'userbuf' argument, pass in an iov_iter.
> > s390 needs more work to pass the iov_iter down further, or refactor,
> > but I'd be more comfortable if someone who can test on s390 did that work.
> > 
> > It's more convenient to convert the whole of read_from_oldmem() to
> > take an iov_iter at the same time, so rename it to read_from_oldmem_iter()
> > and add a temporary read_from_oldmem() wrapper that creates an iov_iter.
> 
> This looks pretty reasonable.  s390 could use some love from people that
> know the code, and yes, the kerneldoc comments should go away.

Sure, we will take care of this. Added to ToDo list.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
