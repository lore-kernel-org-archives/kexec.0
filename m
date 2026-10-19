Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9923CCF2D5
	for <kexec@archiver.kernel.org>; Mon, 19 Oct 2026 02:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yK2AfROvyluZ6jelv31IeMCyq8ztm+KjQU45e2Dgwa8=; b=kJXQLmDDt3YzjKdcyanPFKiHej
	2W8D63La6d9P+6Qddp3iS5FAiPnyyoviqkWEPsHb4+rRgwu926I+bdmHk3rWIc4mVWDCQd95G7wAp
	rT5ei8V1HHacDhga9O+8MoUxQQ9EtLT1jGqPV0ivHQreyhpjbTCb8uT5qjvQOESmWLK6LI1s3HbU1
	QYTHS9v9zxKGnWb6VxeI6ku0kaxN1NUuzTF94HxEoLsz/+RZVjypzKdvB+22UfbBKqToqQEGC3vIt
	eu6x5azwbUcGWL6u6tgUvVrxISlBZnd9fyC61n0C/ZE0Kn6ttwNlebAe1VY/Jac47FYv9grn9GiLW
	wsyUimgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcxj-00000006SMg-2mw2;
	Mon, 19 Oct 2026 02:18:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xIcxi-00000006SM0-3jXP
	for kexec@lists.infradead.org;
	Mon, 19 Oct 2026 02:18:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 57A1A41221;
	Mon, 19 Oct 2026 02:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527F21F000C4;
	Mon, 19 Oct 2026 02:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792376334;
	bh=yK2AfROvyluZ6jelv31IeMCyq8ztm+KjQU45e2Dgwa8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IB5pv1c916yIj7pMBRn30Jw8Ptr3MFE0xfTgaTpQmTqvSZnJJAZFi4asTn8tnHMds
	 yOY4x/YHVRdH91lSojyaxIQ7F5Jk84nYsDqAutFRWZxnB1yptEbwe3NDkkzhmDO6zo
	 mHxeUWrU974V9O4I0xQThlzn+LCvh0kNtiwjCdhr77oI29OKkTcmrOfSuQfKKH0tYH
	 aAMLFczORf/dGA4cdJGHm2YiRiA1F5edjLUp6DN6ELszkgQtymYa8wC0K5cCQqy1gM
	 7RVjm0q4M/m2qaTJqoqesykwfQ7y1oD9IGV+s8UM4+/Fgrg0txSTnRuY8yberNEzy2
	 TY6Z5Zj3g9sOg==
Message-ID: <sashiko-outbox-176520@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/8] kho: validate preservation metadata in
 kho_restore_vmalloc()
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, kuba@kernel.org, enelsonmoore@gmail.com, bp@alien8.de, shuah@kernel.org, david@kernel.org, akpm@linux-foundation.org, ljs@kernel.org, mhocko@suse.com, skhan@linuxfoundation.org, vbabka@kernel.org, dapeng1.mi@linux.intel.com, corbet@lwn.net, surenb@google.com, kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org, elver@google.com, graf@amazon.com, lirongqing@baidu.com, liam@infradead.org, jlayton@kernel.org
In-Reply-To: <20261019021111.990394-4-pasha.tatashin@soleen.com>
References: <20261019021111.990394-1-pasha.tatashin@soleen.com>
 <20261019021111.990394-4-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 02:18:51 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> kho_restore_vmalloc() currently dereferences preservation before
> checking for NULL, does not reject unknown KHO vmalloc flags in
> kho_flags_to_vmalloc(), and does not validate preservation->first.phys,
> preservation->total_pages, preservation->order, or potential size
> overflow before allocating the pages array and shifting by order.
>=20
> Introduce kho_vmalloc_validate() in kexec_handover_internal.h to
> validate the struct kho_vmalloc header and convert its flags before
> restoring the vmalloc area.
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019021111.9903=
94-1-pasha.tatashin@soleen.com?part=3D3


