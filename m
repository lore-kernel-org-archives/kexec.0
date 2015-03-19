Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YYQ7n-00044z-1n
 for kexec@lists.infradead.org; Thu, 19 Mar 2015 02:23:55 +0000
Date: Thu, 19 Mar 2015 11:23:33 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/4] Minor purgatory updates
Message-ID: <20150319022332.GM14051@verge.net.au>
References: <cover.1426719370.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1426719370.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org

On Wed, Mar 18, 2015 at 11:04:03PM +0000, Geoff Levand wrote:
> Hi Simon,
> 
> Here are a few minor updates for purgatory.  I think the
> no-zero-initialized-in-bss flag and the printf type checking should be
> considered seriously.  The symbol and map files less important, but I found
> them useful in figuring out problems with purgatory.

Thanks Geoff,

these all seem reasonable to me. I have applied the entire series.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
