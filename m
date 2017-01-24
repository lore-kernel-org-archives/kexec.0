Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cW1Ak-0002Ky-OY
 for kexec@lists.infradead.org; Tue, 24 Jan 2017 13:30:12 +0000
Date: Tue, 24 Jan 2017 14:29:38 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ppc64: Reduce number of ELF LOAD segments
Message-ID: <20170124132938.GC28325@verge.net.au>
References: <20170119183709.67327e67@hananiah.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170119183709.67327e67@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.com>
Cc: kexec@lists.infradead.org

On Thu, Jan 19, 2017 at 06:37:09PM +0100, Petr Tesarik wrote:
> The number of program header table entries (e_phnum) is an Elf64_Half,
> which is a 16-bit entity, i.e. the limit is 65534 entries (one entry is
> reserved for NOTE). This is a hard limit, defined by the ELF standard.
> It is possible that more LMBs (Logical Memory Blocks) are needed to
> represent all RAM on some machines, and this field overflows, causing
> an incomplete /proc/vmcore file.
> 
> This has actually happened on a machine with 31TB of RAM and an LMB size
> of 256MB.
> 
> However, since there is usually no memory hole between adjacent LMBs, the
> map can be "compressed", combining multiple adjacent into a single LOAD
> segment.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
