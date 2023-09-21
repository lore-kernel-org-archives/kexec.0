Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EE1E706FA
	for <kexec@archiver.kernel.org>; Thu, 21 Sep 2023 09:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-Id:Subject:
	References:In-Reply-To:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l3E7Qo2bNNcAbRx40jcU9IQjLeo0aqoqGvq/pQSI8KA=; b=iUWYRQQtM6QZJW
	2L0c1JZ9OiIA0w42Dm/UmuxxwAfNEMattsb3a0Xs8OHeSKtGIWaVEl8AhD/lNkeA+aPdF7zrn+qK4
	qj+XgXI46wnCnAczUbUQQ5HcyM0QX4mtXb4bBQytBdniymLqi0n9ju3b6vcsgucI1+V5SOJcI2Dwx
	uYSYsEc4k/YbH1s3TjeIhxGCfYwd2QIb5t2aOnAOm9ZZCSqQ63RD3Pojztq+KGCna+x+BQ6n0cI4d
	Ss1kd0gsZRpzGHA7dRrYOw9R79ESFq1cjYhwMTfWtmJ/z884XKgbkaRD6bVJNBOCfxkge157rDQQk
	5NDC1SiZoc31JZsFClNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjG3r-005bQb-20;
	Thu, 21 Sep 2023 09:33:27 +0000
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3] helo=gandalf.ozlabs.org)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjG3m-005bQ0-1w
	for kexec@lists.infradead.org;
	Thu, 21 Sep 2023 09:33:24 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rrqvh3Y4kz4xPX;
	Thu, 21 Sep 2023 19:33:20 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Kexec-ml <kexec@lists.infradead.org>, Hari Bathini <hbathini@linux.ibm.com>
Cc: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20230912082950.856977-1-hbathini@linux.ibm.com>
References: <20230912082950.856977-1-hbathini@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] vmcore: remove dependency with is_kdump_kernel() for exporting vmcore
Message-Id: <169528860033.876432.15480467889695445457.b4-ty@ellerman.id.au>
Date: Thu, 21 Sep 2023 19:30:00 +1000
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_023322_842794_7D476648 
X-CRM114-Status: UNSURE (   8.11  )
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

On Tue, 12 Sep 2023 13:59:49 +0530, Hari Bathini wrote:
> Currently, is_kdump_kernel() returns true when elfcorehdr_addr is set.
> While elfcorehdr_addr is set for kexec based kernel dump mechanism,
> alternate dump capturing methods like fadump [1] also set it to export
> the vmcore. Since, is_kdump_kernel() is used to restrict resources in
> crash dump capture kernel and such restrictions may not be desirable
> for fadump, allow is_kdump_kernel() to be defined differently for such
> scenarios. With this, is_kdump_kernel() could be false while vmcore is
> usable. So, remove unnecessary dependency with is_kdump_kernel(), for
> exporting vmcore.
> 
> [...]

Applied to powerpc/next.

[1/2] vmcore: remove dependency with is_kdump_kernel() for exporting vmcore
      https://git.kernel.org/powerpc/c/86328b338c3996b814417dd68e3f899a1a649059
[2/2] powerpc/fadump: make is_kdump_kernel() return false when fadump is active
      https://git.kernel.org/powerpc/c/b098f1c32365304633077d73e4ae21c72d4241b3

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
