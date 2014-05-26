Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wooo1-0002C9-9Q
 for kexec@lists.infradead.org; Mon, 26 May 2014 06:54:46 +0000
Date: Mon, 26 May 2014 15:54:22 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] vmcore-dmesg: Handle struct log to struct printk_log
 renaming
Message-ID: <20140526065421.GB13010@verge.net.au>
References: <20140522144314.GE13647@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140522144314.GE13647@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Taras Kondratiuk <taras.kondratiuk@linaro.org>, Kexec Mailing List <kexec@lists.infradead.org>, WANG Chao <chaowang@redhat.com>, Lubomir Rintel <lkundrak@v3.sk>

On Thu, May 22, 2014 at 10:43:14AM -0400, Vivek Goyal wrote:
> vmcore-dmesg has been failing for me for quite some time as struct log
> was renamed to struct printk_log.
> 
> 62e32ac printk: rename struct log to struct printk_log
> 
> This patch has been sitting in mailing list for quite some time. It
> is time to repost the patch.
> 
> I took original patch of Lubomir and modified a bit to take care of
> concern of hardcoded string length.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
> 
> Changes for v2:
>   * Clarified printk_log vs. log in some comments.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
