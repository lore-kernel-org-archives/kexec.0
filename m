From: Christoph Hellwig <hch@lst.de>
Date: Wed, 13 Apr 2022 18:41:09 +0200
Subject: [PATCH v5 RESEND 3/3] vmcore: Convert read_from_oldmem() to
 take an iov_iter
In-Reply-To: <20220408090636.560886-4-bhe@redhat.com>
References: <20220408090636.560886-1-bhe@redhat.com>
 <20220408090636.560886-4-bhe@redhat.com>
Message-ID: <20220413164109.GC31487@lst.de>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, Apr 08, 2022 at 05:06:36PM +0800, Baoquan He wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Remove the read_from_oldmem() wrapper introduced earlier and convert
> all the remaining callers to pass an iov_iter.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

