Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443F6CC6B3A
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hFKDNwcL5zSeZMvtUNUkHPjiEQ7p4vTm0Vb2gSStkZM=; b=ZRjyeZhu37WofbAfjflq9Xse42
	TVqheJFcZboNx8vY70sk/wtdqOqz+2u8Iv1gtvlEoNqsCEtuqmQn2W1tW41uQ5XaTsFLOXjlHadE8
	AoqT2OusNXOCT5TrgsqlZqmqKEO3FKx5+rhDuYknB2YHxaCZy6JMKuHt/lChcLbGM0HfK/bvpYiTv
	7DMPh1oN2TU0EYK8bDVKz16Xx4APh+9ryoBg1eaOtct6EiUhMdGGZA6axXx/rwus+2WVXypZEG4et
	AY+pi+/wNojC1QWv5wZk3OLcVYqLhHOIMiZhRks33rwytGTqWeWNL7P4KvFrUkPGYbsw5KQSuKfMm
	gkUsf28A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNjp-00000000cSl-3RyR;
	Thu, 15 Oct 2026 15:51:25 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHNjm-00000000cRM-2Dni
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 15:51:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EF27D4066D;
	Thu, 15 Oct 2026 15:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7FA1F000C4;
	Thu, 15 Oct 2026 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792079481;
	bh=hFKDNwcL5zSeZMvtUNUkHPjiEQ7p4vTm0Vb2gSStkZM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SDHQrqL2+A0Rw44JdNwg9YmHycRfOlrUFKIuQ5inir22wSPwOkm1IuRLeZS17GGWS
	 ElnjJKHuNO2GA1bdfbXBfUow1g3tD1HCPfc3pQZ3A7Ijokc+rKFc+CnzxPFJwT6BaF
	 FkxZ9ESZem0pvKuza0nH0UkjwR2Pu/tcWYJj6MQiSFTBSfPo40wm3SlyX4oPeUFkQf
	 038JZL1OTrQwJf+9LD85S41YTvYdBevsl8zz3fuPL7stln9hSJl9Jr89+QE9xn8x6O
	 B56BRNKaCC1dJAl8moPhhDlafrHbANIBISNtyeP0z5s/0CccUkfY5a2QZ0r7Hi4Bkv
	 ygL6ouIofnOpQ==
Message-ID: <sashiko-outbox-173106@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/8] x86/mce/intel: Bound cmci_rediscover() to a
 single topology peer
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, kees@kernel.org, rppt@kernel.org, juri.lelli@redhat.com, nik.borisov@suse.com, tglx@kernel.org, vschneid@redhat.com, kprateek.nayak@amd.com, vincent.guittot@linaro.org, bp@alien8.de, thorsten.blum@linux.dev, tony.luck@intel.com, david@kernel.org, mingo@redhat.com, akpm@linux-foundation.org, seanjc@google.com, ljs@kernel.org, zhangguopeng@kylinos.cn, dietmar.eggemann@arm.com, mhocko@suse.com, vinicius.gomes@intel.com, tj@kernel.org, vbabka@kernel.org, peterz@infradead.org, surenb@google.com, hpa@zytor.com, x86@kernel.org, dmatlack@google.com, tim.c.chen@linux.intel.com, kexec@lists.infradead.org, pratyush@kernel.org, dave.hansen@linux.intel.com, rostedt@goodmis.org, gmonaco@redhat.com, jgross@suse.com, mgorman@suse.de, graf@amazon.com, liam@infradead.org, ridong.chen@linux.dev, longman@redhat.com, bsegall@google.com
In-Reply-To: <20261015153331.1872641-4-pasha.tatashin@soleen.com>
References: <20261015153331.1872641-1-pasha.tatashin@soleen.com>
 <20261015153331.1872641-4-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 15:51:19 +0000
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

> When a CPU goes offline, cmci_clear() disables CMCI on any MCA banks
> owned by that CPU, and mce_cpu_dead() calls cmci_rediscover(). Currently
> cmci_rediscover() invokes on_each_cpu(cmci_rediscover_work_func, NULL, 1),
> sending a synchronous broadcast IPI to every online CPU in the system,
> all of which contend on the global cmci_discover_lock while reading up
> to 32 MSR_IA32_MCx_CTL2 MSRs.
>=20
> Any bank disabled by cmci_clear() is either thread-private, core-scoped
> (shared between SMT threads of the same physical core), L2-cluster-scoped,
> die-scoped, or package-scoped:
> 1. Any bank index that is already owned by the target peer in its own
>    mce_banks_owned bitmap is private to a narrower scope than the shared
>    level and will be skipped by cmci_skip_bank() on the target anyway.
> 2. Core- or cluster-shared MCA banks can only be claimed by an online
>    SMT sibling or L2 cluster peer.
> [ ... ]
>   Total:    22.50 s -> 20.74 s (-7.8%)
>   cmci_rediscover() (cpu479 offline):
>     7,720.6 us -> 0.6 us (-99.99%)
>=20
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015153331.1872=
641-1-pasha.tatashin@soleen.com?part=3D3


