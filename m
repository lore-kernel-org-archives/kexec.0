Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXfw5-009YOu-E8
 for kexec@lists.infradead.org; Tue, 05 Oct 2021 08:36:30 +0000
Date: Tue, 5 Oct 2021 10:36:26 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools:Add some necessary free() calls
Message-ID: <20211005083626.GC23961@vergenet.net>
References: <20210929081157.3999-1-songkai01@inspur.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210929081157.3999-1-songkai01@inspur.com>
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
To: Kai Song <songkai01@inspur.com>
Cc: kexec@lists.infradead.org

On Wed, Sep 29, 2021 at 04:11:57PM +0800, Kai Song wrote:
> free should be called before the function exit abnormally.
> 
> Signed-off-by: Kai Song <songkai01@inspur.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
