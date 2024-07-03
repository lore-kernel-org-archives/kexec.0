Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064BBC2BD09
	for <kexec@archiver.kernel.org>; Wed,  3 Jul 2024 07:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xaDKc6F2GoGdVnbD6+eSagi9x1BvDUmVwZz/V/JWxWw=; b=CXiGCD51ikJEJW
	nHixfoG0Lpmh+8xGr1VRrZ+AiILCPqmF7GDZaOpv6hy18TWjgG2njZ2HN3SIsdGEVq0vzND4F61qM
	cXqReesMrS+7P2MCJa9yEa3ap4e9DtTiiUhUgqeWUjLDZ/1HEoUYmHQ5g9+zrGES2KmRjEWwBWanj
	Y28gG7aCEPcGXXPeSXFtSd0qEeSY26P/I7IUosFjqeviKcaNv3sTn4rFaTGnyNDGbZA2SenhJkr3X
	KlIaa3g+2Wf5YFjBND86NtIA3vHw2dbr2vTyc613sOdf6psU+AEhCs3Lzjkq+oyQdBbPWxgKY6gdc
	373+dpVjVOo4kb2kxujA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOuqs-00000009NHS-2ODP;
	Wed, 03 Jul 2024 07:56:30 +0000
Received: from mail.revenueraft.com ([51.210.151.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOuqp-00000009NGd-1m5j
	for kexec@lists.infradead.org;
	Wed, 03 Jul 2024 07:56:29 +0000
Received: by mail.revenueraft.com (Postfix, from userid 1002)
	id DA4C62540C; Wed,  3 Jul 2024 07:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=revenueraft.com;
	s=mail; t=1719993374;
	bh=19VLFL+g9q1Ds0BcHQQucjq8+gJ2KR6LPcT+LA7NWpY=;
	h=Date:From:To:Subject:From;
	b=CdfVz8Vhyn9D0FtlipCCsKgVaSFryuKgYq+sxA2WAZaRVV5H/M06jzzcMILSvuB0G
	 Yck6w2QBIUDtNVYu6DC+IIPuEDlShbTtja7d0MblnYhaMFIKFNuDGdhaq2G2Gt0Uxx
	 r7ifoaqL28TXODp5bnMpAji8RnRR4W0jjF5mN+QDInyS1Q6N4VckaehMYgsLBpkwZ9
	 M5D3139pRJjH29YogNJvZMQjSfNTxIG3zTdmfrBuHumrK4fWG5uK6gGIdNFVUFNyxD
	 LnfS9a0zOZnhOSgUfV+Oc4N58iw799JXE0EwbrEN9I9E/wRihxATctXDmwI/dP/t/z
	 cEXFdkh8KbfLg==
Received: by mail.revenueraft.com for <kexec@lists.infradead.org>; Wed,  3 Jul 2024 07:55:39 GMT
Message-ID: <20240703064500-0.1.13.2l28.0.7drb2s3h2l@revenueraft.com>
Date: Wed,  3 Jul 2024 07:55:39 GMT
From: "Martin Juve" <martin.juve@revenueraft.com>
To: <kexec@lists.infradead.org>
Subject: Cooperate 
X-Mailer: mail.revenueraft.com
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_005628_157852_640D7634 
X-CRM114-Status: UNSURE (   1.61  )
X-CRM114-Notice: Please train this message.
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

Hi, 

Are you looking for IT solutions that will improve the operation of your company?

We have IT specialists who will help you implement projects, even complex ones that require the support of an interdisciplinary team. 

Our UX/UI specialists, product managers, system architects, developers, programmers and software testers have been working in an international environment for years.

If you are interested, our representative will contact you, just reply to this message.


Best regards
Martin Juve

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
