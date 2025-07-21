Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D968BC83F1A
	for <kexec@archiver.kernel.org>; Mon, 21 Jul 2025 22:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ITJXLyxWTvHN5Zjma33z96qKNxETJRMZKbCWbIrMlQA=; b=3A4CE/J2QtLDKPzB9H13BsS/Bw
	4waujjy9ihJ2SCCvFGvJOc3mbO1TsbJJcZuXc3wMjmrG8hTFbFExvm3CgsqwDAPTqZI+9dNOnJAJ/
	yn02WhuiJ+HZofo0TyaAQWCdiBR/U/W40rUaSTzk4DP8fPeE6EPFWGRJq0vb+3JQbHzzcuobOYCLz
	cjiU5Wjfcjx5ZPS3vUxsii7ixcYiq0J4d6ATm/patLfm4/e8A9C2Pm6qAOTDaQdDNt84BGIUnXQ0T
	ESk02DAVz3YXP2TMv51i3oc9ISpeW4k1P7c1F/QgK0ajqiJJPIZQQsh5Bn36C0p/bqZGWEUIaICT9
	a4pc24Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udz4r-00000000op6-2U4r;
	Mon, 21 Jul 2025 22:33:45 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udz4o-00000000ooD-3Wt9
	for kexec@lists.infradead.org;
	Mon, 21 Jul 2025 22:33:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4AD86A54E26;
	Mon, 21 Jul 2025 22:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3DEC4CEF4;
	Mon, 21 Jul 2025 22:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753137221;
	bh=wqvtCvvxBtqckbBNrjXSNAcg18LE4Wi7SGUDbnm1u2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m8NxLEJ5UunsQnsYjSaP7q5QaFoSzldtDWqtoYAjAv26z9uh+UHMq8gh8pikpzYbd
	 N/+6GlSRsE7fEAuz03t0n8TVTN5cCfw0NaBIEfOUrxCT9UcLo2Nwi3SVNdCDSfSGBZ
	 ib9LFBAJYEJnuSEVuqiHw+2hdVUt2SaS12/27buc=
Date: Mon, 21 Jul 2025 15:33:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexander Graf <graf@amazon.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, <kexec@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>, Baoquan He
 <bhe@redhat.com>, Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: Re: [PATCH v5] kexec: Enable CMA based contiguous allocation
Message-Id: <20250721153340.5e033b1df1ac74c1a471c892@linux-foundation.org>
In-Reply-To: <07b21458-832f-4b15-9bc8-43f21f902e34@amazon.com>
References: <20250610085327.51817-1-graf@amazon.com>
	<CA+CK2bBhUdEjD=-gM3=D6mKBYctbXh74_hq-bMf1fa8mfS2Edg@mail.gmail.com>
	<07b21458-832f-4b15-9bc8-43f21f902e34@amazon.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_153342_965303_1CCB43F8 
X-CRM114-Status: UNSURE (   8.45  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, 22 Jul 2025 00:01:25 +0200 Alexander Graf <graf@amazon.com> wrote:

> Andrew, I don't see this patch in linus/master. Is it still in your 
> queue? :)

Seems I dropped v3(?) to make way for v5 but then didn't add v5, sorry.

Added now.

