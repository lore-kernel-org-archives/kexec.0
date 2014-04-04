Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WW611-0006IR-Eb
 for kexec@lists.infradead.org; Fri, 04 Apr 2014 15:26:48 +0000
Date: Fri, 4 Apr 2014 17:26:22 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH 0/2] Generic multi-page exclusion
Message-ID: <20140404172622.2bda6190@hananiah.suse.cz>
In-Reply-To: <cover.1396604782.git.ptesarik@suse.cz>
References: <cover.1396604782.git.ptesarik@suse.cz>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

On Fri,  4 Apr 2014 11:56:07 +0200
Petr Tesarik <ptesarik@suse.cz> wrote:

> Kumagai-san,
> 
> this patch was inspired by this post of yours:
> 
> http://lists.infradead.org/pipermail/kexec/2013-November/010445.html
> 
> Unfortunately, this rewrite never happened, so I took the liberty of
> overtaking the job. I hope you don't mind.
> 
> This is in fact a preparatory series to add hugepage support without
> having to care about the appropriate size of the cyclic buffer.

Scratch it. The algorithm assumes that work resumes exactly where it
left in a previous run of __exclude_unnecessary_pages. While this is
true for all dumps I have, the function is in fact invoked per-mm, so if
there are two nodes in the cyclic buffer and they are not in ascending
order by physical address, the algorithm may fail. That's simply not
robust enough by my standards, so I'm going to respin this patch set.

Sorry if I've already wasted some of your time.

Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
