Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DF4CD98F2
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rcjq+2Qi4hTz9gKpcoKUN1BL+JOY7raiZGGeg9KpcvI=; b=nF6DjVimb4nlD0vEYpqQc0UOc2
	FtlnieXV+m1Py9DnQ0Tc0dtijU+o0j4w+yp2kHTVgU2QLC6fPKaXWrcTUHJTup6n3SMmUPnGp6NW5
	quS10xm11EJgicD4n5uOhzBP1pdLyJlkqyrIktqbXbhR+smnliTc2KMnNEzbiCoZfVZSzWS5d8ZOQ
	Z4MJ2EqSbQmLlS+/nXejtlKL7VsgYeP2P6hjM0TdLx7R76Iofo7RcETXbgQC8xwLYbCQSP0Kh/iYQ
	S1hsuNpmfWyVw6ilL4qII5YAYi4U/9O8BTQ+oF+knk45l+iuvz72q3iVAE678yE7JQnUzGW5evUsf
	CeA2wA9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc0Cn-00000006GTi-2GGV;
	Tue, 23 Jun 2026 12:26:17 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc0Cl-00000006GTJ-2n33
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 12:26:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 18B89401B5;
	Tue, 23 Jun 2026 12:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8527B1F00A3A;
	Tue, 23 Jun 2026 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782217575;
	bh=rcjq+2Qi4hTz9gKpcoKUN1BL+JOY7raiZGGeg9KpcvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=b3mI0J1Vj5tnmd4HneMBGK3p59ITz1VieMW/bOYNqdxbOLqd8N2r5t+cjcSOrLyya
	 7jzMOUt1wqTPFDP89MqfmDtptnYY8qAei+XgbfUfs2t7s1C2fonAzHq4yxEixK5mGM
	 xSaxJZn7aNqNDusQt5TDinrbc7WnHUeXMWYp6r+9oqTkrjij931bCW7OIhlSWp3z6p
	 dNfzE7OhdfPAhZ2Wb53TNmSQI0nLlpvURc4pJuE7MrWKlMvWMwd6EqyQaf4RPQPera
	 yd4+3OBz/pJwEe9uWowBQcO+lCEjkdyPEie9BNHK6RPPB83+o7DyX26Xsj4t5DSDk7
	 VjP42yWJXnxjg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] kho: add KHOSER_COPY_PTR to allow phys copy of
 serialized ptr
In-Reply-To: <20260623105201.3724592-3-tarunsahu@google.com> (Tarun Sahu's
	message of "Tue, 23 Jun 2026 10:52:00 +0000")
References: <20260623105201.3724592-1-tarunsahu@google.com>
	<20260623105201.3724592-3-tarunsahu@google.com>
Date: Tue, 23 Jun 2026 14:26:12 +0200
Message-ID: <2vxzy0g5moij.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Jun 23 2026, Tarun Sahu wrote:

> Adding KHOSER_COPY_PTR to copy one serializeable pointer to
> another. It basically allows copy of phys val of the
> serializeable pointer.
>
> It ignores the typecheck if any of the argument is of void *
>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

