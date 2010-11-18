Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PJ47r-0004gZ-Sr
	for kexec@lists.infradead.org; Thu, 18 Nov 2010 13:02:08 +0000
Date: Thu, 18 Nov 2010 22:02:00 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Add kernel data section to final vmcore
Message-ID: <20101118130200.GA19859@verge.net.au>
References: <20101113102519.3354.73362.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20101113102519.3354.73362.stgit@localhost.localdomain>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Maxim Uvarov <muvarov@gmail.com>
Cc: kexec@lists.infradead.org

On Sat, Nov 13, 2010 at 01:25:19PM +0300, Maxim Uvarov wrote:
> From: Maxim Uvarov <muvarov@gmail.com>
> 
> Patch adds kernel data section to final vmcore. This forces gdb read kernel
> static data from dump instead of not initialized values from vmlinux.

Thanks, applied

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
