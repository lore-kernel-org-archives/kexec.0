Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1L5vUM-0003Kd-I3
	for kexec@lists.infradead.org; Fri, 28 Nov 2008 05:01:58 +0000
Date: Fri, 28 Nov 2008 14:01:53 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix compile warnings in get_memory_ranges()
Message-ID: <20081128050151.GF23112@verge.net.au>
References: <1227690052-16219-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
In-Reply-To: <1227690052-16219-1-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0065094907=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

--===============0065094907==
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline

On Wed, Nov 26, 2008 at 10:00:52AM +0100, Bernhard Walle wrote:
> This patch fixes:
> 
>         kexec/arch/i386/kexec-x86-common.c: In function ‘get_memory_ranges’:
>         kexec/arch/i386/kexec-x86-common.c:189: \
>                 warning: passing argument 2 of ‘parse_iomem_single’ from incompatible pointer type
>         kexec/arch/i386/kexec-x86-common.c:189: \
>                 warning: passing argument 3 of ‘parse_iomem_single’ from incompatible pointer type
> 
> Yes, that was my own code. :-(

Thanks, applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en



--===============0065094907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0065094907==--
