Return-path: <kexec-bounces@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IhyVf-0004CM-4Y
	for kexec@lists.infradead.org; Wed, 17 Oct 2007 03:19:50 +0100
Date: Wed, 17 Oct 2007 11:19:04 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] [275/2many] MAINTAINERS - KDUMP
Message-ID: <20071017021902.GB6709@verge.net.au>
References: <46bffa99.nQ27DQOgkKo2uOy+%joe@perches.com>
	<46bffa8e.NHuk7h7puR+3eDXo%joe@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46bffa99.nQ27DQOgkKo2uOy+%joe@perches.com>
	<46bffa8e.NHuk7h7puR+3eDXo%joe@perches.com>
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
Errors-To: kexec-bounces@lists.infradead.org
To: joe@perches.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, vgoyal@in.ibm.com, ebiederm@xmission.com, akpm@linux-foundation.org, torvalds@linux-foundation.org

On Sun, Aug 12, 2007 at 11:30:38PM -0700, joe@perches.com wrote:
> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ea2c63..d61676a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2634,6 +2634,7 @@ L:	kexec@lists.infradead.org
>  L:	linux-kernel@vger.kernel.org
>  W:	http://lse.sourceforge.net/kdump/
>  S:	Maintained
> +F:	Documentation/kdump
>  
>  KERNEL AUTOMOUNTER (AUTOFS)
>  P:	H. Peter Anvin
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

On Sun, Aug 12, 2007 at 11:30:49PM -0700, joe@perches.com wrote:
> Add file pattern to MAINTAINER entry
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d9a53d9..71738bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2694,6 +2694,8 @@ W:	http://www.xmission.com/~ebiederm/files/kexec/
>  L:	linux-kernel@vger.kernel.org
>  L:	kexec@lists.infradead.org
>  S:	Maintained
> +F:	include/linux/kexec.h
> +F:	kernel/kexec.c
>  
>  KPROBES
>  P:	Prasanna S Panchamukhi

I take it that these changes got shelved or canned, as I still don't
seem them in Linus' tree. But just for the record, the file lists seem
to be somewhat sort. I'm not sure exactly what the criteria is, but for
starters, shouldn't all the architecture specific files that only
contain kexec or kdump code be in there too?

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
