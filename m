Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YKhOx-0005IJ-2T
 for kexec@lists.infradead.org; Mon, 09 Feb 2015 06:00:55 +0000
Date: Mon, 9 Feb 2015 15:00:32 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/3] Fix zlib/lzma decompression.
Message-ID: <20150209060032.GD29385@verge.net.au>
References: <1422720608-28700-1-git-send-email-yszhou4tech@gmail.com>
 <1422720608-28700-2-git-send-email-yszhou4tech@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1422720608-28700-2-git-send-email-yszhou4tech@gmail.com>
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
To: Yousong Zhou <yszhou4tech@gmail.com>
Cc: kexec@lists.infradead.org

On Sun, Feb 01, 2015 at 12:10:07AM +0800, Yousong Zhou wrote:
> Let {zlib,lzma}_decompress_file() return NULL if anything wrong happened
> to allow the other method to have a chance to run.
> 
> Signed-off-by: Yousong Zhou <yszhou4tech@gmail.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
