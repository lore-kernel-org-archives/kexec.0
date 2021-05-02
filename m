Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1ld8wO-002SxF-TG
 for kexec@lists.infradead.org; Sun, 02 May 2021 10:03:10 +0000
Date: Sun, 2 May 2021 12:03:06 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: Remove duplicate definition of ramdisk
Message-ID: <20210502100305.GB18267@vergenet.net>
References: <20210426152815.556fb945@ezekiel.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210426152815.556fb945@ezekiel.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec@lists.infradead.org

On Mon, Apr 26, 2021 at 03:29:51PM +0200, Petr Tesarik wrote:
> The ramdisk variable is defined in kexec/arch/ppc/kexec-ppc.c. This
> other definition is not needed and breaks build with -fno-common.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
