Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzaXM-005who-3C
 for kexec@lists.infradead.org; Tue, 21 Dec 2021 08:30:21 +0000
Date: Tue, 21 Dec 2021 09:30:17 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 3/3] vmcore: Convert read_from_oldmem() to take an
 iov_iter
Message-ID: <20211221083017.GC6008@lst.de>
References: <20211213143927.3069508-1-willy@infradead.org>
 <20211213143927.3069508-4-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213143927.3069508-4-willy@infradead.org>
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
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@arm.com>, Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 02:39:27PM +0000, Matthew Wilcox (Oracle) wrote:
> Remove the read_from_oldmem() wrapper introduced earlier and convert
> all the remaining callers to pass an iov_iter.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
