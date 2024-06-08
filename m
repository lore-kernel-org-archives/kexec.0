Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D994C25B76
	for <kexec@archiver.kernel.org>; Sat,  8 Jun 2024 09:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=whNv9xJwU9NVXF27kuiY5NACeMcbg9YbbjcUQRFsYms=; b=RsgKM6MOp9xBtc
	h0K+dqxNUvDC/sc491ALitMxPxKB5yBRL5NMJ97KAmQB4UhemF7PWGybEssXaT2VkwUua4PF7+yGJ
	+b3miHKrlqNn/bo6+Q/WcqMcvUWIx5khGt78IrtKrfO2CDzfalUR8FF6Cf4XhGNd2HBCWKoL+h9JN
	58C/YO/Y8dF1/YYzYN5ENVSVERusjNJSH3+YmYbdseYiH0m75u5Kfj6YRoY9j1T2dX1br7bkI+e9v
	EWNoGVSznCgDDxrcoyGRpFrZswdxd/24A+wu1gn2uOpnCUWWON3jYBnDVEtcs2wHXN0ojHvvr3u2q
	sOu52WvdtNxXOM8wbHqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFs5b-0000000H3rh-0uGV;
	Sat, 08 Jun 2024 09:10:19 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFs5Y-0000000H3rF-2iN0
	for kexec@lists.infradead.org;
	Sat, 08 Jun 2024 09:10:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D7C5261B30;
	Sat,  8 Jun 2024 09:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032E4C2BD11;
	Sat,  8 Jun 2024 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717837815;
	bh=utttnpxD3Vn/S5byJWZgpeDZt/SzOHLjqWI3OIi4toM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFDtjtana84RBlxgu/8qJvWZQizKKzQC8bgzRqSwXiqFDxbgiW9fQF4f6tkiuZJU2
	 oHpU4l7t+elhjfrIY/UDPtdB7C5zOcNfceY/42wxrpujLUrdWIUr+d7wx/sNpVjx7L
	 ooI9wFXQXX2xxutbBvNtLjyvDp7NqY16+9ruWn9c=
Date: Sat, 8 Jun 2024 11:10:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v4 0/7] Support kdump with LUKS encryption by reusing
 LUKS volume keys
Message-ID: <2024060833-facsimile-confident-f540@gregkh>
References: <20240607122622.167228-1-coxu@redhat.com>
 <26jkoqavu54xo4ctbpxfibhdlbc5kezu2kkyl5fbb7r6oizvo4@cmq5yaeszfqq>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <26jkoqavu54xo4ctbpxfibhdlbc5kezu2kkyl5fbb7r6oizvo4@cmq5yaeszfqq>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240608_021016_862101_368B213B 
X-CRM114-Status: UNSURE (   7.28  )
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

On Sat, Jun 08, 2024 at 09:26:43AM +0800, Coiby Xu wrote:
> The subject prefix should be "[PATCH v5 0/7]". I'm sorry if it causes
> any confusion.

It will probably break our tools (b4) that want to look this up, so you
might want to fix that for the next version you send out, given that
this one has some 0-day bot issues.

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
