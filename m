Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0A5C61DD6
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 05:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ATP91jaTIf2GDfHwLhPXeaK68qZZz8YS2WpHG846pBw=; b=vuIUoysOXJaqa4eX+VP6PA03Y7
	Ey/7bMF1ux+O7IjBf77uvWAcSdryemNIFC+LbS83O4BPoMZvbzFEM2Iki1NSF0Dukv9ezTUJZ8F28
	3qdYdLjz6dXn4FmLdRwJ2lcLCq/wUjGHUM3c0xhuXjfSKDvLkO8U63iZm6H5PIxqPiI68OQZDfcSz
	D541WJac0XHKrFi00WJ4eEXiBLf+D86gC8cyBeAv+H9Uio5jvoClNUJqoZ6OhiGz/qfyaX3iWijdZ
	v/xQsdbqKmvUb/+F4Pc50IVKqSSn0vjpUL7k+GlUg2pJjNngJdzfsE0Cepk55bBc0ex5fHtm5Q9+k
	C1+AWcKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1duO-0000000DpFV-1a3P;
	Wed, 02 Sep 2026 05:53:16 +0000
Received: from out-208.mta0.migadu.com ([2001:41d0:1004:224b::d0] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1duL-0000000DpEV-386H
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 05:53:15 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=J4JL5RZAPW5Xm8PwabDqEONDhjGR+8yoHR+OIE7j1ts=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788328388; v=1; x=1788933188;
 b=G3tfvoIQGR+03lzqWM3RXZJLB91V7We3i6X7/8xdwTv93KoN/txQPZ5DVUYnAwXrjC32na2u
 dgI8FFR+gBH4d0se6HV6fJkv8uLxbJeAUpYO1qnCu3EeKc0uaTOmZg+7REz4hbdYpjPCgZooBg2
 RnloOI/uG/12scY4R2RXVsqY=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta11.migadu.com with ESMTPS id 2eab759c58a35d71;
	Wed, 02 Sep 2026 05:52:58 +0000
X-Mizu-Trace-ID: 2eab759c58a35d71
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 13:52:51 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Mike Rapoport <rppt@kernel.org>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Alexander Graf <graf@amazon.com>
Subject: Re: RFC: Enable Sashiko code reviews for kexec@lists.infradead.org
Message-ID: <ape5s5tdwV6WwPih@fedora>
References: <CALzav=eL-cARsaH4AO4PzeOPNDmTHpCZbYh9yX_U8pbz96qdTQ@mail.gmail.com>
 <apenOdHJmH_VeD-X@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apenOdHJmH_VeD-X@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_225313_984260_2ECFBFDE 
X-CRM114-Status: GOOD (  22.87  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 09/02/26 at 07:34am, Mike Rapoport wrote:
> On Tue, Sep 01, 2026 at 01:27:34PM -0700, David Matlack wrote:
> > Hi kexec@ mailing list and maintainers,
> > 
> > I would like to enable Sashiko code reviews for patches sent to the
> > kexec mailing list. I have found it useful for patches I have sent and
> > reviewed on the kvm and linux-pci mailing lists, which have Sashiko
> > enabled.
> > 
> > I sent a pull request to Sashiko to add kexec here:
> > 
> >   https://github.com/sashiko-dev/sashiko/pull/474
> 
> diff --git a/sashiko.dev/email_policy.toml b/sashiko.dev/email_policy.toml
> index e6e4fb57f..e9ad97708 100644
> --- a/sashiko.dev/email_policy.toml
> +++ b/sashiko.dev/email_policy.toml
> @@ -175,6 +175,12 @@ reply_to_author = false
>  cc_individuals = false
>  cc = ["Chuck Lever <cel@kernel.org>", "Jeff Layton <jlayton@kernel.org>", "Anna Schumaker <anna@kernel.org>"]
>  
> +[subsystems.kexec]
> +lists = ["kexec@lists.infradead.org"]
> +reply_to_author = true
> +send_positive_review = true
> 
> Do we really want those?

Some components don't want to CC list, then other people are welcome to
drop any comment during reviewing, while cc to maintainer and author
looks good to me. Just an input, no objection to any move.

> 
> +cc = ["kexec@lists.infradead.org"]
> 
> Please add me here.
> 
>  [subsystems.kvm]
>  lists = ["kvm@vger.kernel.org"]
>  reply_to_author = true
>  
> > I wanted to start this thread to call attention to that pull request
> > and see if there are any objections, or opinions about how it should
> > be configured.
> > 
> > Thanks.
> > --David
> 
> -- 
> Sincerely yours,
> Mike.

