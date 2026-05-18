Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1262DCD4F3C
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 16:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BJ4J7H8bL/Iga93LbOA4OuuXi0JQYQdv0zuQKDJ6y7A=; b=BJM8A4msnk7wuhBMj/BIJGuVJu
	FJvKEOY1R5c9/hXgFbAYdffF4PNjtEFnB9cL2CG29PcjOHkJvVVgaO7xkxIGv6x49m8F7zYHfB0ad
	4Rm/sMvalj47jtt/9vdYK0M+plP760XfUk62rKNAz020O/OYV/Tk8n5IQwIdk9ET89Z6QbzXy62Wk
	mMOke6Gu+9pTdS0sCyLV18OM15a+Qx45EXS+dWG3B6Ns7PooNKwM9hu2aZZCfLvZsI20kZ8RxE/Ec
	6/2LQKQq/gGr4nAcptVP+jeU4Tm73JUIq5wEyOofo0r5l1KrEyIs3Eup8j60pvu53sa5I3+S2/nwk
	IfFB5oHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP0lm-0000000GI7r-2ik1;
	Mon, 18 May 2026 16:24:42 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP0lk-0000000GI7P-0h9P
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 16:24:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3E77E40144;
	Mon, 18 May 2026 16:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E29C2BCB7;
	Mon, 18 May 2026 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779121479;
	bh=ySdneF8pTgQ/afNRmGx2ti2OQwsbDxywcrrbCXGzpFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IeW2senRX41ej4+TV+f6kceHrkYL+7Yxwe5OmYzfeLwpw0PDoSm4TZywiWtrnWBP1
	 tDoQHVbRMaxh4+aCwCqAEnFuJlQk6t2E7rINZe8O+iJS+hlGK665ViY248qFnqptqc
	 s2asjxI8DWIix9UAumyE9nMpneaDtUU6PbMArx5GCY+g6CZgB8BYu388UpJMsvv6sl
	 PGu0MQKcPk7rX89XAy/i5dHfrD2ZW7guMQx1T9g96BuvdUgJV5UVEyWWAQa5I3wWSh
	 vD1dy2MWS4TDQRmoHxr9QKeN9msN6bvcFKUszstXDvX9aQ58hzbjtonbYMJHTrRSMa
	 fm/560ZNZAaZw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: rppt@kernel.org,  sourabhjain@linux.ibm.com,  jbouron@amazon.com,
  akpm@linux-foundation.org,  bhe@redhat.com,
  linux-kernel@vger.kernel.org,  dan.carpenter@linaro.org,
  rafael.j.wysocki@intel.com,  piliu@redhat.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com,  mario.limonciello@amd.com
Subject: Re: [PATCH v5 5/5] liveupdate: Remove unused ser field from struct
 luo_session
In-Reply-To: <20260518125459.1092373-6-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Mon, 18 May 2026 12:54:59 +0000")
References: <20260518125459.1092373-1-pasha.tatashin@soleen.com>
	<20260518125459.1092373-6-pasha.tatashin@soleen.com>
Date: Mon, 18 May 2026 18:24:35 +0200
Message-ID: <2vxzse7o8z3w.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_092440_221511_5CC578CD 
X-CRM114-Status: UNSURE (   8.69  )
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

On Mon, May 18 2026, Pasha Tatashin wrote:

> The ser field in struct luo_session was intended to point to the
> serialized data for a session, but it was never actually utilized in the
> implementation. All serialization and deserialization logic consistently
> uses the pointers maintained in struct luo_session_header.
>
> Remove the dead field to clean up the structure.
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav

