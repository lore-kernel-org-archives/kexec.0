Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from xenotime.net ([66.160.160.81])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IQq1k-0007RH-58
	for kexec@lists.infradead.org; Thu, 30 Aug 2007 15:50:08 -0400
Received: from midway.site ([96.225.192.201]) by xenotime.net for
	<kexec@lists.infradead.org>; Thu, 30 Aug 2007 12:49:52 -0700
Date: Thu, 30 Aug 2007 12:49:51 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [RFC] makedumpfile-1.1.4-rc: ia64 DISCONTIGMEM support
Message-Id: <20070830124951.4585e3ad.rdunlap@xenotime.net>
In-Reply-To: <20070601181114oomichi@mail.jp.nec.com>
References: <20070601181114oomichi@mail.jp.nec.com>
Mime-Version: 1.0
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

On Fri, 1 Jun 2007 18:11:14 +0900 Ken'ichi Ohmichi wrote:

> Hi,
> 
> The attached patch is for the development, and it isn't stable yet.
> This patch can be applied to makedumpfile version 1.1.3.
> If you find some problems in this patch, please let me know.
> If there aren't any problems, I will release a new makedumpfile
> by next weekend.
> 
> diff -puN backup/v1.1.3/README makedumpfile/README
> --- backup/v1.1.3/README	2007-04-13 15:44:55.000000000 +0900
> +++ makedumpfile/README	2007-06-01 13:05:19.000000000 +0900
> @@ -3,6 +3,10 @@
>   makdumpfile's README
>  ======================
>  
> +* REQUIREMENTS
> +  Please download the following library file and install it:
> +  - elfutils-0.125.tar.gz
> +

Is elfutils-0.125 (precisely that version number) required, or
could this be elfutils-0.125.tar.gz or later?
I.e., is there something special/specific about elfutils-0.125 ?

It's a bit difficult to find 0.125 on the internet...


>  * BUILD & INSTALL
>    1.Get the latest makedumpfile from the following site:
>      https://sourceforge.net/projects/makedumpfile/

Thanks,
---
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
