Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KzNif-00015y-Nf
	for kexec@lists.infradead.org; Mon, 10 Nov 2008 03:45:42 +0000
Date: Mon, 10 Nov 2008 14:45:38 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Add include for offsetof macro
Message-ID: <20081110034536.GA5941@verge.net.au>
References: <49116A5D.8040900@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <49116A5D.8040900@suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Stefan Assmann <sassmann@suse.de>
Cc: kexec@lists.infradead.org

On Wed, Nov 05, 2008 at 10:41:49AM +0100, Stefan Assmann wrote:
> kexec/arch/i386/kexec-elf-x86.c and kexec/arch/x86_64/kexec-elf-x86_64.c
> both use the macro offsetof() which according to the man page requires
> #include <stddef.h>.
> The include is not present at the moment and this patch adds it. This is
> necessary for compatibility with i.e. uClibc.
> 
> Signed-off-by: Stefan Assmann <sassmann@suse.de>

Thanks, applied.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
