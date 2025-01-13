Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838A6E7719E
	for <kexec@archiver.kernel.org>; Mon, 13 Jan 2025 10:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VoG/OMcJ8d12ZSyD0ZqYeoPA89F0kd/HTyrd5huWlHw=; b=czezn2OboffK6tFgN4SQNdPRv5
	6hKtSNOZyrxSIU1BlPeQrHcAMOS5zjdqgJTtaNBUY3JLpxiKZkHs+G3ft0FwP4wITFaFFUn4n7pD3
	6MDH/++haxYuES4NnNYF94v+PcXzRnVHEnkNi6kF4u77yoRjp6qYMZYcVppN8Jv/L8Njz8EvrBMiq
	l7rFKwTryR6nodWSvLtfys4Pi0JaNhnT+Xo6aNCAY/WcMO9zUC6JO9ApWvoZQVw5HPsB2Uc0EhRZW
	D4yKXzoYWhhW3/PBGp3ttDNbhxsVz4kdNLRUp7R6ZzKu+swKzhpTUtoRYo4aVSFjhWg1GUkXweUcA
	IKt3NacQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXHGU-00000004ibX-0puy;
	Mon, 13 Jan 2025 10:01:46 +0000
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXHGR-00000004ias-0Qun
	for kexec@lists.infradead.org;
	Mon, 13 Jan 2025 10:01:44 +0000
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C6187114013F;
	Mon, 13 Jan 2025 05:01:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jan 2025 05:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1736762499; x=
	1736848899; bh=VoG/OMcJ8d12ZSyD0ZqYeoPA89F0kd/HTyrd5huWlHw=; b=K
	rlnsTkf9lv1i8j7tfYuyo5h2c1OL/22qr80W60Nx/KEnCaET0V/u87X76HmZ3GmC
	6v668UAUbRHupPRtl+Ehhj9+kzsJ/Qpm1XphTBFrF93HpDfOaMnD6IPBwjymfzyF
	3QoE4sqi//8Hjpg0/VzwZwtTrB0eVdYiDr9BdPOJlvAjTrT+zCyponn1oXstyI8e
	04YDae0SMxMMa2/6Nnx9eKBCpKvquzrgVLUVWT3/psDNrkmSJXLryCwUzCd8NWxQ
	P1rOt10s+7oMx36yq9lILiQqumvlz0U6bcDkzVORJrUx/E3JIe+KhIkSnizNvYF6
	jMg4+hlIVRTs8MTgPFqUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736762499; x=1736848899; bh=VoG/OMcJ8d12ZSyD0ZqYeoPA89F0kd/HTyr
	d5huWlHw=; b=MSMEL2d8Fyv8uhUhKMeO95+5BddVh6aCKavbuF2wgEl8Lfz+JFu
	8YF7mOnaEnMu/jVDK47ktOr6LPyE7jMjVWzVgjwGwrU/MMjX4SCbB5pRJBajeqsX
	trpAQ2Uqb7zUrhnh6uqExk0L/mfcG7frTY+GhGIjreYWRxtR8BxkHprVGVfiJTtF
	o0trqHgvYQEsWoboOvysLpFf4RhFuK1ZO4M2Jg9Qa7c0sknj57a/jE93TEFufYoh
	dQDlWiwKmRrhZR6b8dJ35HMuVZQiDunJSMn4PWD6DAgBeLPAXh34ynpEYkFC+7e1
	9DAdj4zzMXclu/FT/8XrPfySLsIejwAAaDQ==
X-ME-Sender: <xms:g-SEZ-3mqwfYA3cplCVhLSqkCAqNXG9XCkw69USpRKknmXbBWNIdVQ>
    <xme:g-SEZxFdHGbUcjnDnZl3f3twIY2gAfXZ9W7rP_bkWnJKXmDpLAC7DDiX9V_Qyau4z
    py3WiyGQV5AvLFuIR0>
X-ME-Received: <xmr:g-SEZ24-vXbYbugB8EO3qVlpYpyIyu-cP2W-tlpeyBruGUm6nY5KF2rd2GvkYV-RY3XGDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepvggsihgvuggvrhhmseigmhhishhsihhonhdrtghomhdprhgtphhtthhopehkvgig
    vggtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohephigrnhdrhi
    driihhrghosehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghotghose
    hlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtoh
    hmpdhrtghpthhtohepkhhirhhilhhlrdhshhhuthgvmhhovheslhhinhhugidrihhnthgv
    lhdrtghomhdprhgtphhtthhopegshhgvsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:g-SEZ_3U9co5D91RLeJssdWWZ6Q_HF544c7wdJGHwHZdknayq3K3Wg>
    <xmx:g-SEZxHChkORcqEehTUhskOyXcK6WHAtn3feTNA1QdfBJ64NQacSVQ>
    <xmx:g-SEZ4-DTvnroz48NDUjHE_dgHIXIcYnmW1lV7s21CFybjt8rw7RWw>
    <xmx:g-SEZ2kPEm05Bd6223mIrfKdWI1SVm8ZKtR_wnnqX5IhDDK-HOWNDA>
    <xmx:g-SEZwAvzvOekzSCzi9N3L1knINsX6eSFKtw8krgShqv4VUZqUYhXNY3>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 05:01:35 -0500 (EST)
Date: Mon, 13 Jan 2025 12:01:32 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: ebiederm@xmission.com, kexec@lists.infradead.org
Cc: Yan Zhao <yan.y.zhao@intel.com>, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, x86@kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, bhe@redhat.com
Subject: Re: [PATCH v2 0/1] Accept unaccepted kexec segments' destination
 addresses
Message-ID: <xgycziy2o56hnom3oau7sbqed3meoni3razc6njj7ujatldnmm@s7odbl4splbn>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213094930.748-1-yan.y.zhao@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_020143_646393_7964FE81 
X-CRM114-Status: UNSURE (   6.67  )
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

On Fri, Dec 13, 2024 at 05:49:30PM +0800, Yan Zhao wrote:
> Hi Eric,
> 
> This is a repost of the patch "kexec_core: Accept unaccepted kexec
> destination addresses" [1], rebased to v6.13-rc2.

Can we get this patch applied?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

