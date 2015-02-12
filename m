Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YLoyq-0003MQ-2l
 for kexec@lists.infradead.org; Thu, 12 Feb 2015 08:18:36 +0000
Date: Thu, 12 Feb 2015 03:10:41 -0500
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/4] configure.ac: apply necessary quotes to result of
 macro expansion.
Message-ID: <20150212081039.GL11309@verge.net.au>
References: <1423572374-20841-1-git-send-email-yszhou4tech@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1423572374-20841-1-git-send-email-yszhou4tech@gmail.com>
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

On Tue, Feb 10, 2015 at 08:46:11PM +0800, Yousong Zhou wrote:
> This can fix the following error when searching for lzma support and
> while at it also apply the practice to other uses of the same pattern.
> 
> 	checking for lzma_code in -llzma... ./configure: line 4756: ac_fn_c_try_link: command not found

Thanks, I have applied this and the other three patches in the series.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
