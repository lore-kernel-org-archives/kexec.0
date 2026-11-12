Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35701606A8A6
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=44lgjRUC;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PGrzvQ9N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GsObTRzQp5AAH8+2vGSXxLU85bsKt/9TG939Q/UcpP4=; b=44lgjRUCDz0yzV6R5nIlTQMV1q
	DeJOSx9MyHlCczGYWNYB2+T9FKRt3P4JZDkaPHo2O5pefeWzEzW1UE3c72ucHInQWmh5Ti6iIED1L
	AkRtpnRyVbs+rbRqISskI1yp8TC5/YbSQCD8gjR+8XRKvS1Poi8Tc2ZQYVbMaRn/Ecykf9pSlcBwt
	gd7KiXsUMNSrTDSanfQKbwmXV/wxmWgW/9vQHghcPsedfYKsFYQUOK0ZSPT+XrSco2KUEdzHH2fh8
	5OAWcf07Sv+4Wakk9lz7+g2kl4AqWU8uVsJUqSxn6YAMTXGnLEU2KTiuf3BMzAcHcHl7rNSkgagKG
	QCnEDfJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVZm-0000000ADZ1-2otS;
	Thu, 12 Nov 2026 14:14:54 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRVZk-0000000ADYf-2pPE
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 14:14:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E366F657C9;
	Thu, 12 Nov 2026 14:14:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A271F00A05;
	Thu, 12 Nov 2026 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492891;
	bh=GsObTRzQp5AAH8+2vGSXxLU85bsKt/9TG939Q/UcpP4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PGrzvQ9NkdzQTCj3XN4IwulUeUObY+SFs3EgRKcf5llSwpryrMtKlPvmMgylvJ9UC
	 yvDj9AHfgUqD/z0o3LkfzugRSQCQpcIJZrcrpHfZGFSo6dg5AOBz5SL8pab6H4Nuqf
	 V/8s58jsPh6fe5nCAVwpSH/NmpYgzRAYriQtV5q6oS6gn6WZoz0jUBwiV9t6XcOnBo
	 qbNk0IWt5pOhLgr9NCZQj7wrvZclXY+O2bASc3YGntIW9IYrt4YjvRoHEdNnKpp82W
	 R3Y8bjg636Z8bYToIwJ0BOUgarxHOYC5JE4USOnUvVR5cgLc0bQXq/ZdGagj7zPTCn
	 ULpEAdnKHJbfg==
Message-ID: <sashiko-outbox-211283@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/11] arm64: kexec_file: Fix CMA segment placement
 retries
To: "Jinjie Ruan" <ruanjinjie@huawei.com>, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, leitao@debian.org, yeoreum.yun@arm.com, mpilaniy@redhat.com, robh@kernel.org, coiby.xu@gmail.com, Yeking@Red54.com, prudo@redhat.com, brads@mainlining.org, sourabhjain@linux.ibm.com, mkchauras@gmail.com, blum@kernel.org, adityag@linux.ibm.com, qirui.001@bytedance.com, hui.wang@canonical.com, sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn, ionut.nechita@windriver.com, vishal.l.verma@intel.com, seanjc@google.com, ardb@kernel.
 org, richard.lyu@suse.com, arnd@arndb.de, tzimmermann@suse.de, rick.p.edgecombe@intel.com, kai.huang@intel.com, kas@kernel.org, piliu@redhat.com, thuth@redhat.com, shradhagupta@linux.microsoft.com, ebiggers@kernel.org, jbouron@amazon.com, me@linux.beauty, mclapinski@google.com, graf@amazon.com, tangyouling@kylinos.cn, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261112133418.4044428-11-ruanjinjie@huawei.com>
References: <20261112133418.4044428-1-ruanjinjie@huawei.com>
 <20261112133418.4044428-11-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:14:49 +0000
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> The file-based kexec system call places segments with kexec_add_buffer(),
> which takes them from CMA when kexec_alloc_contig() succeeds, to avoid
> copying the payload at kexec time.
>=20
> When load_other_segments() cannot place the initrd or the DTB, the
> segments of the attempt are dropped but their CMA pages are leaked.
> Release them with kexec_rollback_segments() in the retry loop and in the
> error path of load_other_segments().
>=20
> The loop makes progress by advancing buf_min past a segment placed by the
> walk.  kexec_alloc_contig() ignores buf_min, so once the pages of a CMA
> segment are released, the next attempt can get the same region again and
> the retry makes no progress.  Disable CMA for the retry.
>=20
> A CMA segment can be anywhere in RAM, so moving buf_min to its end can
> [ ... ]
> Cc: Yeoreum Yun <yeoreum.yun@arm.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112133418.4044=
428-1-ruanjinjie@huawei.com?part=3D10


