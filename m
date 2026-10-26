Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83331606A31D
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 01:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OkYQVur7;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=OxmKE85t
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3JHKNZG3E5vHMpYqgouUpuv8xtxZ/WRsL+FJ8mE54ZM=; b=OkYQVur7wX0UgY
	IxjDk92Ies6ZDKyO3AlZMK++FQxdBr+OzDZhzQqWsZafoVCltJHQLHFoaXsfyR2zpWNdeSdM0ma+e
	D+tnYhQ4Moe4A5LxVdPHn6gGNSvvibRW9++N2HnoaEtDZ90i2GJ2XqxyeyZTq0kqxeqYPTrdyHOIE
	VHylcUcrXXuS59tC7wunSJZKtE635HUuTeek96ppP/SnHJrCDV99kyXe+MTaInyVMMnpkXg57GX9V
	jnWghDwaCZkhXHCq6B7fQAA9LARUfYmV+gAMpyg3UDwQ65Ja3vuyBT5Qcebcz59/ghKuScIaqOmgq
	llcMRZnzLhlBBut4pawQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL9L9-00000001Z8n-2AOJ;
	Mon, 26 Oct 2026 01:17:31 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL9L7-00000001Z8S-0nbV
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 01:17:30 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-6b2232d8ef5so4224025a12.3
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 18:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792977447; cv=none;
        d=google.com; s=arc-20260327;
        b=L7O1SD8BUEr628h6HaQoZ5xiaB0KNx2yyqmi523o4P0mcXfIN2sfKzun2194/u58/G
         5pNf/agqt9YtA6Ggf7KAux9C8Mz2mM03b4N/SD+mE4S3Q3PSTD6yLIeAXIN4UjBTqFFf
         Uxn4f1V7yYduRr2DJrxhKvTsbWFkhLuV0LLQK4SLtaewqDPGl+YXtvE4ClsfWasXHQqb
         AZ4nukt272cyfuS2zQfjNpD8O3DVtNFCAfpYzqIARK4gT3KQ4PyMbJdvrytnN8UhYLb0
         oyIDfAJLhayqPCPmd8ansddVndH51CswJpgjVSWYu2SBLkU9WnBoDlERZmor7p/EDUK4
         BcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3JHKNZG3E5vHMpYqgouUpuv8xtxZ/WRsL+FJ8mE54ZM=;
        fh=jJEB1RumGDLNCz2zUN0YqzfVmj0WecwTUPLMYjRp8UE=;
        b=kHDj5ALKlT5aTJkYRNVBPm9FJlxon60n6axnU/cvVJiSMFTg95H+X1GRgZGPW8aFvv
         VxvJlduxRZp3VoJ+NK6AoCAFfWJm955vlJWxJpHyn8MBmzSXEpF6ZBmsPLOp2IFGrGfH
         p9ppF/wjKAnrVrUsRuiSD4UvzUbbEhvm6uvgqk2BaB3AhnG5DTHz2NZbV0zPqLWJkaWn
         hep/wjO/pbkhRRKR4nNWBsVmI/H73ydCYE9wVTBJ4QohGmcGeZvkl0nP5hzJjxztWjCW
         WKWW5rs1zyp2a9cXKzp5dwKsDLQIWuZHP0p4IJTDFwVFLz+mkDtZFeubDpfGZQ5gquj0
         YmMw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792977447; x=1793582247; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3JHKNZG3E5vHMpYqgouUpuv8xtxZ/WRsL+FJ8mE54ZM=;
        b=OxmKE85tU0V/xyK6JPmvSVpv+z9UeGuduDPXBbGzkfXLGhT97QvkPXZDCtk9Kj/h7i
         6L+3UvS4HyJtmmqF2fv4d5L2Wj2kQ3wWuNz8UdvmM8IVmbvTYCahtZ5XCnOz9UkHwKdv
         4s8N1hJA1tRWqk/I098gmdeO09odREdjrLcfZVjtxNEXM8ge/sR7haWPxT0xp4QS0G0x
         BfPRrr+TJuj6qT/uCDHRCZ7MkXq2DYh4cOKkSYfliLmrdFuW7aUk5DJCB5WoZJXHrnDi
         851iAa9rtJGb0dyNASwzmqfbZQOFsXL3jYv80jxvsH8iLo61Kl3iOPqh+RaWjg7XVarM
         HE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792977447; x=1793582247;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3JHKNZG3E5vHMpYqgouUpuv8xtxZ/WRsL+FJ8mE54ZM=;
        b=fZ963fduq0QWJImh+nB4yuato1or88sRRYPT1OyEz9+NMMVQheOFD9b/WzCHPbCPbw
         1QefhMevM+hLnLO2mCbxCAiUkCMP3Gu1lormhj6uxIAnJxyP6Wk25dn3cQAWdQjRyTLD
         STIxUPBAQVOBrZ3UULvDScnDdsp2E/coB95GdCJAAuM6FwBBHjufw0aTksd4z7jth6vx
         OWouqkO88fGG52OgZRFyjpNk25tcfrICcV2EmA1qvWHMrkAviZptxj16ygwsfRarF27t
         ZGSZ3f3Dg59RCebFOYwJNQLhVRVtsXPvSgA6zk8xlLAXoAvz+9wXk+f5fksg9HBww13b
         6XEg==
X-Forwarded-Encrypted: i=1; AKwUvBy7zfNMcy5Rgn+X+2S3FChi0VZfSLCItpspkWlYfD1CpnMjLJ9BfQUd70b6t4ww8QfLJsWLcQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYJEqB40BxogxhLqn1BxVVE/fh/jdZqZ5LsoQahXJu+k4lbBH5YD
	E5qUR2w9S3Mu56lqE/XwkT+IOnZTzlIVoxhJNXFnCx+URAcBfTZsRXngIN+ZxNakcxa06UKiJ++
	sC3YR0dgdU05Qg2bqt+MGsQDoYbll9ZJcxPo5B7zsjg==
X-Gm-Gg: AYBFou1V6bFOwgIoF++1gyhV9tkDkytDIFctHW3Px+6Zb5JPYnTKZRIzHJdUCqKMb0W
	KwAPZBI0W0kolG3Wc3ezvGaIGPm46qgT47MsZAkpavl12FiNzmZCDsbAqYVkXqI3/kxRhnguXwU
	4aKb/N/m4tKytQggkS68/eaiQBTnC1/lCAh6xmjoN2zebA9/JE/zM9diw0sr2xj97ycCLieP6nZ
	12047GmfAqHQtrWeTFIh8YNHhWA6QkjmVTdE6P3qldgxaIyeBWZmaDQOZXrczupsi71HxfESt8V
	Q2w9r/XIi93kqq471meKDEk+shfptA4bo0/YnyutBErgV7bzOsxJlvq1FupaH0qvXpHR4FYXRcr
	oEh850/qfO5MnwoBMOMVpuA9TwwiKWqs35vy4PvCK5KgwHPC83x0DJOaQuPua4trS4+3W
X-Received: by 2002:a05:6402:234e:b0:6b4:31c5:bb2b with SMTP id
 4fb4d7f45d1cf-6b4430016b5mr6666492a12.41.1792977447040; Sun, 25 Oct 2026
 18:17:27 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020144710.4154339-1-pasha.tatashin@soleen.com>
 <20261020144710.4154339-3-pasha.tatashin@soleen.com> <atsM_WTjuZNl1EGG@kernel.org>
In-Reply-To: <atsM_WTjuZNl1EGG@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 25 Oct 2026 21:16:50 -0400
X-Gm-Features: AclHuK98Gj1W6ZSJdFU1t2f67xVGq0_oZ919Xy4QT-Ox4HmUEuoqqii467TmLm8
Message-ID: <CA+CK2bBXCPBiZ+ek3+PiOHR_8obXkpJmJ=iqcXC4kxO23b8yuA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selftests: liveupdate: Add tests for LIVEUPDATE_SESSION_FREEZE
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, vipinsh@google.com, 
	linux-kernel@vger.kernel.org, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, graf@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_181729_252825_4D1DECEA 
X-CRM114-Status: GOOD (  15.57  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 3:30=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, Oct 20, 2026 at 10:47:04AM -0400, Pasha Tatashin wrote:
> > Provide luo_session_freeze() in the liveupdate test library and add uni=
t
> > tests in liveupdate.c covering the LIVEUPDATE_SESSION_FREEZE ioctl. The
> > tests verify that non-zero reserved bits are rejected with -EINVAL, an
> > outgoing session with preserved files can be frozen early, freezing an
> > already frozen session returns -EBUSY, and attempting to preserve an
> > additional file descriptor into a frozen session fails with -EBUSY.
>
> Please teach your LLM to use shorter paragraphs :)

For selftests, I usually let it express itself :-)))

>
> Do we need the entire list of what the test checks in the changelog?

Will fix.

>
> > Also freeze the test session early in luo_kexec_simple.c to exercise
> > LIVEUPDATE_SESSION_FREEZE across a kexec reboot, and verify that
> > attempting to freeze a retrieved incoming session returns -EINVAL.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  .../liveupdate/lib/include/libliveupdate.h    |  1 +
> >  .../selftests/liveupdate/lib/lu_utils.c       | 10 ++++
> >  .../testing/selftests/liveupdate/liveupdate.c | 49 +++++++++++++++++++
> >  .../selftests/liveupdate/luo_kexec_simple.c   |  8 +++
> >  4 files changed, 68 insertions(+)
>
> --
> Sincerely yours,
> Mike.

