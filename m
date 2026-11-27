Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F9606A32E
	for <kexec@archiver.kernel.org>; Fri, 27 Nov 2026 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KODxjJuB;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BttRjS2O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cNPVJsceKzheptZviJp/LgZiwQdeXt6IT1R58W4nyw8=; b=KODxjJuB14pWSYxjfWTdqtLPpA
	3YHENXqKmEkjRvuKp9952lBwt5omwdvUiU4fKqTt03oi4zN8nIAkrVZECc91Wj8wb3YdEyo7OuSwr
	1Ncvi7a3oNFNc3G8Wo+tHk7lzNLCkcWfWosvE8XL3EiFBE2o6Fcn7gKYHX/w4bmuHjd9UqGUdg03G
	89WMRgq/Lo02d6IocnRt9Vt80frG/s6D40K74c7KMblncVhHy/0p9VRljM1C86hALp+n/L9EIlzJK
	QDG8e/SoXYe9OQiDVGcZvnRg/rKFZR+RMBV1ycpBr9MzL0Y1fYq/8GTcq2VMYKzMy3SoKKjZKluFF
	2rsR7Zew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWtE7-0000000Fc5u-3Edx;
	Fri, 27 Nov 2026 10:30:47 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWtE6-0000000Fc5J-1RBN
	for kexec@lists.infradead.org;
	Fri, 27 Nov 2026 10:30:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 98E18409F4;
	Fri, 27 Nov 2026 10:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767151F00925;
	Fri, 27 Nov 2026 10:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795775445;
	bh=cNPVJsceKzheptZviJp/LgZiwQdeXt6IT1R58W4nyw8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BttRjS2OdIXPrz1E6DxsS2zZNlX+OQEgY1ihKeEROcQWRm+kpn2VSIwUK/JMEsc0J
	 XhDdX5Ki2EcPkk3sJgd8JTo4jkFL0PMeCBfSicP/EeUtsiJEHkslYIu9HpvJYmz09o
	 f7Ktw4o7no3B8DrsxYwcG6iD/pq2gkL9RzcEwoDG8OHMiU5y7C9FYs/dKgyZU5xD3S
	 zcjKhq3xADikh8MNA+WlAzXEP8FG1N6toW9FmSOJww+Sj7uhH3TXplBAFcmwLNzF7J
	 5YcMOMfEYT4xyDeTyRC2jb5WwtrRsrF861Tg9XIJ1QBKRz7dy2SkdCSRGnH/5ZwwFr
	 L4L0E9XDE7C+g==
Message-ID: <sashiko-outbox-237136@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 00/11] kexec: Rework segment loading and fix CMA
 retries
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ben@cressey.dev, leitao@debian.org, mpilaniy@redhat.com, yeoreum.yun@arm.com, coiby.xu@gmail.com, Yeking@Red54.com, prudo@redhat.com, bradley.morgan@linux.dev, sourabhjain@linux.ibm.com, blum@kernel.org, hbathini@linux.ibm.com, qirui.001@bytedance.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, ionut.nechita@windriver.com, vishal.l.verma@intel.com, seanjc@g
 oogle.com, ardb@kernel.org, arnd@arndb.de, tzimmermann@suse.de, kas@kernel.org, rick.p.edgecombe@intel.com, mhklinux@outlook.com, piliu@redhat.com, shradhagupta@linux.microsoft.com, thuth@redhat.com, ebiggers@kernel.org, me@linux.beauty, mclapinski@google.com, graf@amazon.com, tangyouling@kylinos.cn, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261127100925.3019877-1-ruanjinjie@huawei.com>
References: <20261127100925.3019877-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:30:40 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Sashiko has reviewed this 11-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127100925.3019=
877-1-ruanjinjie@huawei.com

