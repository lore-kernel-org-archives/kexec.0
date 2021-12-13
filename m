Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwgGB-008COy-9s
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 08:00:36 +0000
Date: Mon, 13 Dec 2021 09:00:31 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] vmcore: Convert __read_vmcore to use an iov_iter
Message-ID: <20211213080031.GB20986@lst.de>
References: <20211213000636.2932569-1-willy@infradead.org>
 <20211213000636.2932569-3-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213000636.2932569-3-willy@infradead.org>
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

On Mon, Dec 13, 2021 at 12:06:35AM +0000, Matthew Wilcox (Oracle) wrote:
> +	/* trim iter to not go beyond EOF */
> +	if (iter->count > vmcore_size - *fpos)
> +		iter->count = vmcore_size - *fpos;

Nit: iov_iter_truncate()

Otherwise this looks good from a cursory view.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
