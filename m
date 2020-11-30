Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjmBC-0003wP-Q3
 for kexec@lists.infradead.org; Mon, 30 Nov 2020 16:37:35 +0000
Date: Mon, 30 Nov 2020 17:37:31 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] zlib: fix resource leak when gzdirect failed
Message-ID: <20201130163731.GB20208@vergenet.net>
References: <20201130064125.1379-1-qiuguorui1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201130064125.1379-1-qiuguorui1@huawei.com>
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
To: qiuguorui1 <qiuguorui1@huawei.com>
Cc: yszhou4tech@gmail.com, leeyou.li@huawei.com, kexec@lists.infradead.org, zengweilin@huawei.com

On Mon, Nov 30, 2020 at 02:41:25PM +0800, qiuguorui1 wrote:
> In function zlib_decompress_file, when gzdirect(fp) fails,
> we should gzclose fp before return.
> 
> Fixes: d606837b56d46 ("Fix zlib/lzma decompression.")
> Signed-off-by: qiuguorui1 <qiuguorui1@huawei.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
