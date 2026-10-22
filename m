Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82B606A31F
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TfxCPWX2;
	dkim=pass (2048-bit key, unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=WBtw6YoF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:To:From:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1dsQcG/xRxkwASF5f3rK6MWB7/uttInbTcYfUaLqxI0=; b=TfxCPWX2w8YVEuhHw3sLl+k+mz
	0fxgU4C5oupcvNaeLjWagBORPn0nBdyerdJA7Oia5G5p/srs5q2iVzboyi9yRZrjpQiRcpP5OoZwP
	JeSb37Q4eDqVLfy+iZDTHbnjUqYLKKcBu6/v6a80gzzagv5yye6AKMosdJXS9KIkUMg9QFz8ju6mm
	TupHlzPjX8Y8M+vCwp3FnNr0ncDSKoDdrEqXoo87mkiBbk4mh3xvpmizAli5RWc+RfjlXWhNafY+b
	Aim+eAsFCxaF335c6sztxTBzMlqnFNTKnBH3lTBOotSnBj/GPNYvz7AdcAAoLqiC3I9OBvhMXO86S
	+FsJTxPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJv4M-0000000ERhp-17CV;
	Thu, 22 Oct 2026 15:51:06 +0000
Received: from ms.lwn.net ([2600:3c01:e000:3a1::42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJv4J-0000000ERhW-32kU
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 15:51:05 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 83085408DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1792684261; bh=1dsQcG/xRxkwASF5f3rK6MWB7/uttInbTcYfUaLqxI0=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=WBtw6YoFez051Ywtntsg6uu9wNOoQTzrRvfwI+fy0sH3M7wgtbwbKIUVCCloU1/Zf
	 nBjBIzpYwaPKPCoyfUf9CR5R8tAfTCs+vb/Ul1Nbr5so64sC8OnX9poKe/9z7Vz/rn
	 NynpI6SLmNp71KN/bgCFnmBO37aA2YENtX86+zKSlTd5nok7lR4gCR9KZ/hJH4GFhs
	 Or31EAFIlfPNbMw7WG1AabTFZjlpm1+sbpFFhPqW0Cc7LiBM/CVrvuHNOvAieuIuga
	 6/qrNMRU0iiwsYj5tFeiypB7YxsPXo8EW6wy5xH45ABB95Ev9JbIUgEtcbBaMPOBWN
	 A0B3r9nzsmF2A==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 83085408DA;
	Thu, 22 Oct 2026 15:51:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, rppt@kernel.org,
 tudor.ambarus@linaro.org, mchehab+huawei@kernel.org,
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux@weissschuh.net, linux-kernel@vger.kernel.org,
 pasha.tatashin@soleen.com, aleksandr.loktionov@intel.com,
 kexec@lists.infradead.org, pratyush@kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH v1] docs: xforms_lists: Handle DECLARE_KHOSER_PTR()
 struct members
In-Reply-To: <20261015020313.946940-1-pasha.tatashin@soleen.com>
References: <20261015020313.946940-1-pasha.tatashin@soleen.com>
Date: Thu, 22 Oct 2026 09:51:00 -0600
Message-ID: <87y0bp20pn.fsf@trenco.lwn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_085103_786778_BABB8B51 
X-CRM114-Status: UNSURE (   9.35  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pasha Tatashin <pasha.tatashin@soleen.com> writes:

> KHO ABI structures declare their preservation pointers with
> DECLARE_KHOSER_PTR(name, type), which expands to a union of the pointer
> and its physical address. kernel-doc does not know the macro and does
> not see the member: it warns that an unnamed member is not described
> and that the description of the member is excess.
>
> Translate DECLARE_KHOSER_PTR(name, type) into "type name", as is done
> for DECLARE_KFIFO_PTR().
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  tools/lib/python/kdoc/xforms_lists.py | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

One note... these:

> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> prerequisite-patch-id: 557b4f406b7530b8be07d3e3aa6015ad89ceaa6d
> prerequisite-patch-id: c0430a4f0096e4be93a6200aa4e8a1d392238ca5
> prerequisite-patch-id: 524c71eab38a9175f9920f38717c8ed3b157299f
> prerequisite-patch-id: 61cfc274edef2fb23a1b867c9e0d063578387c45
> prerequisite-patch-id: ac022b05628f8e495a224216352aa037a022aae4
> prerequisite-patch-id: 50668baf257da9873190d08f21538ddc453261a8

...make b4 go off on a wild goose chase and caused the application to
fail.  They aren't prerequisites at all, I'm curious about how they came
to be here?

Thanks,

jon

