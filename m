Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F92CAC5B5
	for <kexec@archiver.kernel.org>; Mon, 29 Sep 2025 09:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hs1heC7z0w2EPg9HJ2svtTSKps9/XKzxRgf8MlJUXlA=; b=MCgiHyEL/5bawNPLgcASIHdp+T
	vEPbTGmbkGctmW3lu1GrYMrspHBRRigmmBagWaUN768qjXLD+6SwU3oIPIwr1Kwg0e5g9UBgJ4Zmh
	fVHRh3+sEz0JkVtyoniiYJxhDwyji63A0ns8q5oMhqve3q1i1hySZU5IryO95xuUZLVwxOWlYqf6T
	TSejfTEv1+C0i2KKim1MdRwyzk29+4FF8HiSyszUlUYu/e6ymxTxAbUpAueFChdU4FJU6lfz3bVtI
	n98lFOF63J78ElYIAd0KUvhBP/7U4iD3kOJodrLALRFRIKN4+HLC4QqW01OsUWICQPmfT9v0Ay3tD
	fTSrrfHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3ARb-000000021gi-0KsP;
	Mon, 29 Sep 2025 09:45:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3AQb-000000021gH-0O5U
	for kexec@lists.infradead.org;
	Mon, 29 Sep 2025 09:44:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2EA4848850
	for <kexec@lists.infradead.org>; Mon, 29 Sep 2025 09:44:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD58C4CEF5
	for <kexec@lists.infradead.org>; Mon, 29 Sep 2025 09:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759139056;
	bh=swuso3Ra/DEVfazApeCOrUctaOmdIY/aha9xdkGOrjQ=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=hnbohWmvMOh6ARrdvHYdHXE6JsT4d0AzDvlUGuqbT8gE1B+khTN6KTyDGOKFtonWx
	 VlpAyX9K3BSzRyX9CfZN+pUQsVfkmsz6qWzVgync8ZvCjajgU31KeZOS9XKg80rtZw
	 yNvU1PhyvuChnYiJuXuJhpADisVECS3UzMDUDxOYzmUhZ68K91GVREqeZWrV2kLFRn
	 5M+RrhTdl5sMpEA46OL7hLzNKWmb46IKPJoNoTC12eyTwL9Uz+p70KTabwqAVr9vPm
	 w/AuSSM0EARPVAcbmHfNBdGjUf6Mjq0GP/bFxwZckR8O7SU2dMtp0GJs8g9Jhj/t09
	 4B9xrTqeZWLPw==
Date: Mon, 29 Sep 2025 10:44:13 +0100
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: Re: [PATCH kexec-tools] workflow: Add loongarch64 build
Message-ID: <aNpU7Uuzr9CfOwsm@horms.kernel.org>
References: <20250923-workflow-loongarch64-v1-1-047ebd559174@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923-workflow-loongarch64-v1-1-047ebd559174@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_024417_147016_6D6693C0 
X-CRM114-Status: UNSURE (   9.41  )
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

On Tue, Sep 23, 2025 at 05:42:54PM +0100, Simon Horman wrote:
> Add loongarch64 to build matrix.
> 
> A gcc-14 package is installed as there is no generic gcc package
> for loongarch in Ubuntu 24.04. Hopefully this will be resolved in
> Ubuntu 26.04.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Applied.

- workflow: Add loongarch64 build
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=0b5aecb85a21

