Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WkPVn-0007mB-2t
 for kexec@lists.infradead.org; Wed, 14 May 2014 03:05:47 +0000
Date: Wed, 14 May 2014 05:05:14 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v3 0/2] Generic multi-page exclusion
Message-ID: <20140514050514.3046e594@hananiah.suse.cz>
In-Reply-To: <1399482403-3656-1-git-send-email-ptesarik@suse.cz>
References: <1399482403-3656-1-git-send-email-ptesarik@suse.cz>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

On Wed,  7 May 2014 19:06:41 +0200
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
> This is a preparatory series to add hugepage support without having
> to care about the appropriate size of the cyclic buffer.

Kumagai-san,

what is the status of this patch set now? Forgotten, or are you looking
at it?

Regards,
Petr T

> Changelog:
> * v2:
>   - Keep excluded regions per mem_map_data
>   - Process excluded pages in chunks
> 
> * v3:
>   - Keep excluded region extents in struct cycle
> 
> Petr Tesarik (2):
>   Generic handling of multi-page exclusions
>   Get rid of overrun adjustments
> 
>  makedumpfile.c | 108 +++++++++++++++++++--------------------------------------
>  makedumpfile.h |   5 +++
>  2 files changed, 40 insertions(+), 73 deletions(-)
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
