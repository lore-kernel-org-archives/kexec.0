Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124DEEEAA71
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 21:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OWPM5eDewe6kAu8TTBfUJijEA6ezNBTfiYoemnRVH3w=; b=GAndY2QOTwriPb
	PhqSMczIamgIy8VIGr2OURZcFEipTLC4ExTxqytPA85PU09slT1NWjpkBTWpj0Fp0uKcb6FH7HZp1
	B4M3f0Fhwxy0DaPWJSHtN+whOdsEjXJEn1ozC9ZU3x8vqoXzJ9QidI+scGdFraVCLN3pOAXEb4+Kf
	d0/L6ZIYrxURA6YlGwHuRfEFJh7H1C7Alwqw2KyfzHoFL9ATdUYiOfzahl9BCF9DVLkd26w1HbFoI
	i9b51pw/5jHhLvJvfoqqpPAGJEByvYfmLdjQ+JeplwyrDJ4tNySgK9Kh/lGGvkbCoxDHn2Hou8F4u
	UC2MTQYvGgG0RoF+DlDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgtfF-009IVe-0J;
	Thu, 14 Sep 2023 21:14:17 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgtfB-009IUQ-1j
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 21:14:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 79DD6CE1693;
	Thu, 14 Sep 2023 21:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEC1C433C7;
	Thu, 14 Sep 2023 21:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694726049;
	bh=L/MzC7ioV9UUQjtz4gA9VmoBaXGgFXYV9zbRrFAiiFw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Ewp1ys3K6A4pyPc53Gx06gClHlc24FZ88ldRltat23EhQEUdBKzj3JnQUJPYDRABc
	 cTHeiDHrwYJtBrQ7O/StXRmkqaagwfZeLYnu9XjfXXlwtu23OhU323F9tCysqO8Dxs
	 DomnnOwA8iM7Tsk60cCPys+QHnZIHw7MbeLwnOKTO3/00W+l55rmSvqfC8webDEL2l
	 KvojDtjH3+kE+fMbv5kWrG7j1nHSlw+1pTCuxcnN0EGjly4oaa/d2ji9U+frrb50LE
	 hSMRcJej1x5vQ86ur2dO0tzPGYhMCtaW/YaxODSl6gmmm1W9PozWX9nvqdbyr8TdVN
	 7hKYJEyHFnsIQ==
Mime-Version: 1.0
Date: Fri, 15 Sep 2023 00:14:04 +0300
Message-Id: <CVIY8SX1DPRH.J1EE2T4RDZZ4@suppilovahvero>
Cc: <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
 <x86@kernel.org>, <tglx@linutronix.de>, <dhowells@redhat.com>,
 <vgoyal@redhat.com>, <keyrings@vger.kernel.org>,
 <akpm@linux-foundation.org>, "Baoquan He" <bhe@redhat.com>,
 <bhelgaas@google.com>, "Luca Boccassi" <bluca@debian.org>,
 <mjg59@google.com>, <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jan Hendrik Farr" <kernel@jfarr.cc>, "Lennart Poettering"
 <mzxreary@0pointer.de>, "Philipp Rudo" <prudo@redhat.com>
X-Mailer: aerc 0.14.0
References: <20230911052535.335770-1-kernel@jfarr.cc>
 <20230913160045.40d377f9@rotkaeppchen> <ZQLTJFb3S/xn5CWo@gardel-login>
 <CVIN0M3IHRKL.3U005Y5QTOJL5@suppilovahvero>
 <CVIR0BGHX3VS.39FY5QL8KXR0F@suppilovahvero>
 <e215acd4-52fd-429c-a569-a20ba5a49d7e@app.fastmail.com>
In-Reply-To: <e215acd4-52fd-429c-a569-a20ba5a49d7e@app.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_141413_742041_24EED652 
X-CRM114-Status: GOOD (  16.45  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu Sep 14, 2023 at 7:11 PM EEST, Jan Hendrik Farr wrote:
> > BTW, would not be a bad idea to extend CC list to at least Matthew and
> > James Bottomley on this patch.
>
> Sure. Added Matthew and James in CC
>
> Also, I already made some minor changes. cmdline is now used from the
> syscall if there is no .cmdline section included in the UKI.
> find_section now returns the section_header as an ERR_PTR. You can
> find them in the uki-v3-wip branch at
> https://github.com/Cydox/linux/commits/uki-v3-wip

Hey, I discussed about IKU at the Linux Linux security module
maintainers monthly meeting and we concluded that it would be nice if
this had a spread to linux-integrity and linux-security-module mailing
lists.

It is x86 feature at this point but obviously that will work as
reference model to other architectures too.  So it would be nice
if those mailing lists would be also included to the loop.

I do not have time to check if this is relevant but this I think
the last version seen of encrypted hibernate:

https://lore.kernel.org/linux-integrity/20221111231636.3748636-1-evgreen@chromium.org/

Just adding it as a reference since I mentioned it earlier.

I'm on holiday for the next week but will look forward to the next
version after I'm back.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
