Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K19EI-00073l-G6
	for kexec@lists.infradead.org; Wed, 28 May 2008 00:09:22 +0000
Date: Wed, 28 May 2008 10:09:15 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Use 'long long' for printf() format string and ELF64
	numbers.
Message-ID: <20080528000913.GD6752@verge.net.au>
References: <20080525221154.2fd2e432@kopernikus.site>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080525221154.2fd2e432@kopernikus.site>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

On Sun, May 25, 2008 at 10:11:54PM +0200, Bernhard Walle wrote:
> Since 'long long' is 64 bit wide on almost any platform, especially on
> 32 bit platforms (like i386) while 'long long' is only 64 bit on 64 bit
> platforms but 32 bit on 32 bit platforms, 'long long' is more suited and
> fixes compiler warnings like
> 
>   kexec/crashdump-elf.c:160: warning: format '%lx' expects type \
>         'long unsigned int', but argument 4 has type 'Elf64_Off'
>   kexec/crashdump-elf.c:160: warning: format '%lx' expects type \
>         'long unsigned int', but argument 5 has type 'Elf64_Addr'
>   ...
>   kexec/crashdump-elf.c:248: warning: format '%lx' expects type \
>         'long unsigned int', but argument 8 has type 'Elf64_Xword'
> 
> Tested on i686-pc-linux-gnu.
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>

Thanks Bernhard, I've had much less elegant ideas on how to
solve that problem myself.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
