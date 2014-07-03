Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X2gM4-0002yj-GD
 for kexec@lists.infradead.org; Thu, 03 Jul 2014 12:43:13 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 26F87AD61
 for <kexec@lists.infradead.org>; Thu,  3 Jul 2014 12:42:48 +0000 (UTC)
Date: Thu, 3 Jul 2014 14:42:46 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: makedumpfile and elfutils
Message-ID: <20140703144246.6d1cd5ca@hananiah.suse.cz>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9723B871@BPXM01GP.gisp.nec.co.jp>
References: <007BD92917A2324FA403BCF9A464CF845CBC0690@ALA-MBB.corp.ad.wrs.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9723B871@BPXM01GP.gisp.nec.co.jp>
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
To: kexec@lists.infradead.org

On Thu, 3 Jul 2014 00:16:04 +0000
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> Hello Joe,
> 
> > I am updating a bitbake recipe to build makedumpfile 1.5.6.  The current
> > recipe builds 1.4.4 and includes a version of elfutils.  For 1.5.6 you say
> > to use elfutils-0.142 but we already have version 0.158 so I don't see why
> > we should need an older version, too.  makedumpfile builds linking to
> > elfutils-0.158.
> >
> >
> >
> > Do we really need elfutils-0.142?
> 
> No, 0.142 or later are OK, you don't need to downgrade it.
> However, I didn't test the recent versions of elfutils, so please let me
> know if you find any problems.

For the record, makedumpfile linked against 0.158 has now been
extensively tested during the development of SUSE Linux Enterprise 12.
No problems found whatsoever. ;-)

Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
