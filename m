From: Christoph Hellwig <hch@lst.de>
Date: Wed, 13 Apr 2022 18:40:52 +0200
Subject: [PATCH v5 RESEND 2/3] vmcore: Convert __read_vmcore to use an
 iov_iter
In-Reply-To: <20220408090636.560886-3-bhe@redhat.com>
References: <20220408090636.560886-1-bhe@redhat.com>
 <20220408090636.560886-3-bhe@redhat.com>
Message-ID: <20220413164052.GB31487@lst.de>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, Apr 08, 2022 at 05:06:35PM +0800, Baoquan He wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This gets rid of copy_to() and let us use proc_read_iter() instead
> of proc_read().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Baoquan He <bhe@redhat.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

