Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CDAC61DFD
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 04:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xa5v7G6swyQRMVl1EcKJ/wOGI31Mh3zTDCzG8j29JfM=; b=SKoCyZ1YxxDr/y2w4BRXzNVp82
	s3Icc6YtDxUm6TUyJpAYMRE1UDV4XAVRc9ItMLHevXAaRoXCG7cxEquJQMDwE4PnTRQz375MznJVx
	PLNie9qnCkcBt7EWWgg634xmbzyIUX3fOsa3OqMxJ+fEAOVGETyiOS/U75xczll1yA5XvckrktCvM
	bWNbou7M79oql6wxrFHTm/aU+KDjKjFam2XfTo9kZoUeMoB1zLb947nzXB8QO0tqETrXPXV+fUVMx
	Lfdq+KQi2KwbGzkITV5nfEKnUOxGTbpwbFpJNqwAc0eYtPgGB57VumHwoUMdDFnCvC4mkGu3sOE1o
	1IWY0vBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1cfp-0000000Dles-1971;
	Wed, 02 Sep 2026 04:34:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1cfo-0000000Dlej-3UzQ
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 04:34:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E78CB4360F;
	Wed,  2 Sep 2026 04:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2791D1F000E9;
	Wed,  2 Sep 2026 04:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788323647;
	bh=Xa5v7G6swyQRMVl1EcKJ/wOGI31Mh3zTDCzG8j29JfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q1vr1UtP3ajVLCnaVsMAGpKCZyvCbr03Y7GXoNXmmmy8ihlQhV13RSTlUtv6Zmobj
	 mA2XVWM50AH7HbLRvdHERIPeRoH/E0c2ScZUuolMGMRudDWUrooUztVCdOezKuVlIt
	 4Az63TewzcXfiU9h/zonwuPyFBiKwtdCFjTJYIpEfRghR3edFCr+7vT6PW76o/JQxH
	 oCInDBeJ2rwq5Yiw/XNdo1uRD7cwhm0Iw30pw5/C2wC4cXlm3B5qHghSnxluIRseOZ
	 N7PR05SncbpakcV0VYn1dqQkSOG6DXYOXwbdN6/GMTXXVHeii/NFHvuE3Mkyw/DAKt
	 3HgOGaVtA/wPg==
Date: Wed, 2 Sep 2026 07:34:01 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Alexander Graf <graf@amazon.com>
Subject: Re: RFC: Enable Sashiko code reviews for kexec@lists.infradead.org
Message-ID: <apenOdHJmH_VeD-X@kernel.org>
References: <CALzav=eL-cARsaH4AO4PzeOPNDmTHpCZbYh9yX_U8pbz96qdTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=eL-cARsaH4AO4PzeOPNDmTHpCZbYh9yX_U8pbz96qdTQ@mail.gmail.com>
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

On Tue, Sep 01, 2026 at 01:27:34PM -0700, David Matlack wrote:
> Hi kexec@ mailing list and maintainers,
> 
> I would like to enable Sashiko code reviews for patches sent to the
> kexec mailing list. I have found it useful for patches I have sent and
> reviewed on the kvm and linux-pci mailing lists, which have Sashiko
> enabled.
> 
> I sent a pull request to Sashiko to add kexec here:
> 
>   https://github.com/sashiko-dev/sashiko/pull/474

diff --git a/sashiko.dev/email_policy.toml b/sashiko.dev/email_policy.toml
index e6e4fb57f..e9ad97708 100644
--- a/sashiko.dev/email_policy.toml
+++ b/sashiko.dev/email_policy.toml
@@ -175,6 +175,12 @@ reply_to_author = false
 cc_individuals = false
 cc = ["Chuck Lever <cel@kernel.org>", "Jeff Layton <jlayton@kernel.org>", "Anna Schumaker <anna@kernel.org>"]
 
+[subsystems.kexec]
+lists = ["kexec@lists.infradead.org"]
+reply_to_author = true
+send_positive_review = true

Do we really want those?

+cc = ["kexec@lists.infradead.org"]

Please add me here.

 [subsystems.kvm]
 lists = ["kvm@vger.kernel.org"]
 reply_to_author = true
 
> I wanted to start this thread to call attention to that pull request
> and see if there are any objections, or opinions about how it should
> be configured.
> 
> Thanks.
> --David

-- 
Sincerely yours,
Mike.

