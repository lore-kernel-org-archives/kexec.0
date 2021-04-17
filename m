Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lXfGd-004eYI-NG
 for kexec@lists.infradead.org; Sat, 17 Apr 2021 07:21:25 +0000
Date: Sat, 17 Apr 2021 09:21:17 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 1/1] arm: do not copy magic 4 bytes of appended DTB in
 zImage
Message-ID: <20210417072115.GC2573@vergenet.net>
References: <20210412111805.31643-1-egorenar-dev@posteo.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210412111805.31643-1-egorenar-dev@posteo.net>
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
To: Alexander Egorenkov <egorenar-dev@posteo.net>
Cc: rmk@armlinux.org.uk, kexec@lists.infradead.org

On Mon, Apr 12, 2021 at 01:18:05PM +0200, Alexander Egorenkov wrote:
> If the passed zImage happens to have a DTB appended, then the magic 4 bytes
> of the DTB are copied together with the kernel image. This leads to
> failed kexec boots because the decompressor finds the aforementioned
> DTB magic and falsely tries to replace the DTB passed in the register r2
> with the non-existent appended one.
> 
> Signed-off-by: Alexander Egorenkov <egorenar-dev@posteo.net>
> ---
> 
> v1 -> v2:
>   * Add a comment explaining the reason for introducing kernel_buf_size 

Thanks Alexander, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
