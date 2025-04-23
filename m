Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24412C369CB
	for <kexec@archiver.kernel.org>; Wed, 23 Apr 2025 17:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kgytbttm/vaSZu3MuChMHnVjkv1VT3E9wfPGBOsUTRk=; b=KQAIy73BDf+/2HJP992uSMz+6G
	I2h3zHe+uaPWNehtKh2rIgx9tVWdxn1cp5IwkcU0gKf+VOZj5Z3p1TKLkpXCsSSZDEe8f7Ptu5KBB
	LXlgrMYmb3ZA7VYuuVSIeYNgIs1hVDXvZ7jacvyTMnuW7X7utN82rqi6LDhlsxryGG+c/wCJlzJyT
	a6X6kuuHb2hqcgpkMoudtA2Ev/n2j/nGEfhqRlHID16iGja769NyEtS3l8DCFrLAErw82JO/Ld4Ig
	BP16UrD5GW1NuNx5pLqynyBbtaQetk8MNXDrnM/UC41yrMy9PAwOOfK2aO0heMae4i8syAk1KVpqh
	ko0QWttQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7e8S-0000000BNNt-3AOR;
	Wed, 23 Apr 2025 17:43:48 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7cH9-0000000B0c2-3F9J
	for kexec@lists.infradead.org;
	Wed, 23 Apr 2025 15:44:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D2519A4BC33
	for <kexec@lists.infradead.org>; Wed, 23 Apr 2025 15:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16057C4CEE2
	for <kexec@lists.infradead.org>; Wed, 23 Apr 2025 15:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745423078;
	bh=oXCBGIcq7/IwKPhLWrK9woixHS3sAZ6w66cp5qkHb3U=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=bNTd/o2vKc6U8nl9NByZVLSnk9nVKIMYTi5KKp1495ox+wzRndXDp66sDumbxYs6C
	 5pEMMtuwQGaYdRi/T0AJucBezVTrb64/wUBYH+WhTOsz88W++Yvk8NREB77xkOrBtg
	 zu/452q2+EruA0BtBFssMy0UXkKM54NNVe3SrF+RrxYUpOMy4Nn/3m9jYlqiWVkyJN
	 6U3+lmHeLOnaupunGi5Z1jwoM4BVAUl+/MCni78bgUTIZHa9IyaMsvzDCUT9/VMquH
	 JuX6Jcxc2qVEwH68HJ4i8NaN+WEsqwsRS69FiPnTQRB7EV2cjYaMnIE58F1kvdlXDz
	 ZkvM8YCHDeKvQ==
Date: Wed, 23 Apr 2025 16:44:35 +0100
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: Re: [PATCH] workflow: update to Ubuntu 24.04
Message-ID: <20250423154435.GX2843373@horms.kernel.org>
References: <20250422-ubuntu-24-04-v1-1-5ecea9f52f64@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422-ubuntu-24-04-v1-1-5ecea9f52f64@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_084439_886017_1BECD77E 
X-CRM114-Status: UNSURE (   7.37  )
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

On Tue, Apr 22, 2025 at 11:14:13AM +0100, Simon Horman wrote:
> Bump workflow to use latest LTS release.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

- workflow: update to Ubuntu 24.04
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=1bda78d60504


