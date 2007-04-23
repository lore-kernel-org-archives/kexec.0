Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hg2uL-0007zh-HC
	for kexec@lists.infradead.org; Mon, 23 Apr 2007 14:05:03 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Update the list information for kexec and kdump
References: <20070423083936.GI4272@verge.net.au>
Date: Mon, 23 Apr 2007 12:04:01 -0600
In-Reply-To: <20070423083936.GI4272@verge.net.au> (Simon Horman's message of
	"Mon, 23 Apr 2007 17:39:36 +0900")
Message-ID: <m13b2rvuge.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: fastboot@lists.osdl.org, Vivek Goyal <vgoyal@in.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>

Simon Horman <horms@verge.net.au> writes:

> Update the list information for kexec and kdump
>
> Signed-off-by: Simon Horman <horms@verge.net.au>
>
> --- 
> Is it too early for this change?

It looks like the new list is working, and isn't likely to get overwhelmed
with spam.  I don't know if everyone has switched over yet but we can
certainly update MAINTAINERS. 

Eric

> Index: linux-2.6/MAINTAINERS
> ===================================================================
> --- linux-2.6.orig/MAINTAINERS	2007-04-23 17:34:30.000000000 +0900
> +++ linux-2.6/MAINTAINERS	2007-04-23 17:34:47.000000000 +0900
> @@ -1951,7 +1951,7 @@ P:	Vivek Goyal
>  M:	vgoyal@in.ibm.com
>  P:	Haren Myneni
>  M:	hbabu@us.ibm.com
> -L:	fastboot@lists.osdl.org
> +L:	kexec@lists.infradead.org
>  L:	linux-kernel@vger.kernel.org
>  W:	http://lse.sourceforge.net/kdump/
>  S:	Maintained
> @@ -2001,7 +2001,7 @@ P:	Eric Biederman
>  M:	ebiederm@xmission.com
>  W:	http://www.xmission.com/~ebiederm/files/kexec/
>  L:	linux-kernel@vger.kernel.org
> -L:	fastboot@lists.osdl.org
> +L:	kexec@lists.infradead.org
>  S:	Maintained
>  
>  KPROBES

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
