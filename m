Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5E6606A328
	for <kexec@archiver.kernel.org>; Tue,  3 Nov 2026 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KGuly72U;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=XUfibLL8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=q9fnNuB1Wct/8OEoZPHjnr7HEm078IbGQ7GxgW+ue7k=; b=KGuly72UkuVNp2
	YnPkedhT7igcPtnbm/FoLbKsY/qN1znQU/auE7T6OeFq4dvmpbP5/Xf2iD0DsvED7SckWOQr0UjfT
	bkk1UzliJrkiXHM07Kb2HnujhrDLJ6Xv/nJX5veL1Rc9TQ6XxpPkom5l7qPkXILXYGRSso+lEUSJM
	IAzPKevzy/3NN6iga5yYwuH29Y3bbg2WyFI2XdiSVntSNTjkyf5+AYGyqEHDkLmOMf4rvj1WYNemZ
	bbyCxbE8gRAYoXF1+W65g5GjkqkCNRZckoh1NHh9n+MKq12UtpIwb41T9lJ8miKom50aZSqY/np4w
	90ZpiEnY33Tk6AVC7wbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOLDu-00000003dPl-3Pul;
	Tue, 03 Nov 2026 20:35:14 +0000
Received: from mail-vs1-xe35.google.com ([2607:f8b0:4864:20::e35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOLDq-00000003dOH-0QXb
	for kexec@lists.infradead.org;
	Tue, 03 Nov 2026 20:35:13 +0000
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-7cc0e865dd1so1559746137.1
        for <kexec@lists.infradead.org>; Tue, 03 Nov 2026 12:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793738108; x=1794342908; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q9fnNuB1Wct/8OEoZPHjnr7HEm078IbGQ7GxgW+ue7k=;
        b=XUfibLL8jtir+nkwQB7XpK42iD0Ao0ipSvooK4YPwVKvH5NgMaAoAc9qZfg3ECVoAN
         bgec4Lj/sDLWZLJO+jNeXuah261o53Lr4f26VEwZ+st66obbpDb8NVhjgENlh8JMRsjD
         yeOXlQ+kLSxN/wOTsgVXeYmP5MmuiAQuzx2Jj+fNHeVH9pteGpljIitGnSCQVUexRn9O
         Uge6XQXKw2ABnafZktKu6TbRk8pLTQkGPoSImSROissVX4FVR+DbZwQnSTuCgzaDR20U
         GWHzBdMckAJ1ppGzUGLZlhDBck0IN6hIPo1ayx6uDMl33/4JTSMFWAqaAeRLR1GORvWM
         HQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793738108; x=1794342908;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q9fnNuB1Wct/8OEoZPHjnr7HEm078IbGQ7GxgW+ue7k=;
        b=q3wsIMJ55alaYvyTovCta+SSXIDEQPMlGZje5JwPjLuimHRjbKGLWfE/IHRCxMKtYi
         i/OVbUxGiGatyiFvQ4EbkQNbNIaQ8HBATI/1geKaNaCp+Kd41ElMqIYG443bI/jsmw5g
         K7Hyvu6CzOQLaCPgFzXgX0xBlULYMSL5xNHToMu7Pdh0xFEHGqevmnHMwHbL3sITPC2M
         /8pWqe3HyO/eJvmSYRFRhS/17iC2IQmoZ49Fxh5qT22bxnCQirLdDWEm3EUctTqQVf+Y
         +YFX1cAMyT9zKXPLur9qOHDKF/4auAYPJLcL8IbwAiAZXLumHZAPyl9VVdg+DNsiHroy
         OMbQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYDbDe9yLqY/79gwYmMqDoy7SF6kcIhcc1ME8TzE3QSnL2JFaQL6DLvB6opFr4t3sql3iOpQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z+GNtMXNFusYPGqvKvjmh0QGEgTgAek0lS+7XF7Kyu8uiCGorGh
	L4n57dS21vdmBbI5RzQWNpBCXlvVvGUe/QbxoGg/85U+uSqPGusEkH4F0CTbq4LHaE8=
X-Gm-Gg: AYBFou07z3lZ0otqZRuqIcFHPvxCNr/ixN8Pda9wfeZ1iQFPTS81Do4eYbzwc3/9Ryk
	lnIkZWG6dIFLv+dJ/5ScVTqTIWTq6bgevikzACbHwYGG/hvKJSj/Z5JCf/deW2eodzZrND5uzaw
	g3yJu2Eb/hhREexi+kxjFehxRW+Bem7hPkRnQO5vjaUzxQLV9r9QK3nh/CGaQb/Uq58ZXKmi6+/
	+6IPn4J1a+YzNewKVk277r6YQiBn5Kx67WXUDI8AwgIcXkH5hId2EZ5JdD+O5VZacHnLfvj4W/i
	o9RPhZpZBN8nO89DKMu2wYyuQRgKNJ5fcO8jMuz9bjWX/yZtgxMESLILeRtCztKDpXASKtbTR/3
	9yK+SD71HuTCmfJO+ROFhzgHpB66cjcQBMyKknoUGQiwWipK0MmNAmgrkr1lGApACxi/RVJA1b2
	hFVxbFkZQJUN3I+dxuyS3YLKyOo7YuqQpRCkyguyBkc3o8a329UGUNjengX33sO1yjXhL0CoBuQ
	8X3WBAwkD6q9BBAbXa4EBe3R1GPY08qMkRW1JeKsTkXAIyGHgaJw1GTjRSItXkOWIx1ohUI/vFu
	665HalDNH3zH0ngNi04AZLBUfzK+Stq7i2SCeUrLaZu6ZubpJoSxlSN5gkpTgyhzWBoqKRIOES4
	4h7rmoix5lg4x4qqzBNwX78bxJe+Nl4Udfbo6rVyyqePnirYfHa3TxqBJp8RaOwCqQoJi
X-Received: by 2002:a05:6102:689a:b0:7c3:7286:b7ea with SMTP id ada2fe7eead31-7d072c18c5fmr5571067137.17.1793738108579;
        Tue, 03 Nov 2026 12:35:08 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d91d212bsm155984241.6.2026.11.03.12.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:35:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] liveupdate: luo_file: allow keeping private_data
 from retrieve until finish
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20261103181916.2462825-2-pratyush@kernel.org>
References: <20261103181916.2462825-1-pratyush@kernel.org>
 <20261103181916.2462825-2-pratyush@kernel.org>
Date: Tue, 03 Nov 2026 15:35:04 -0500
Message-Id: <179373810485.663454.14095082591432581397.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2169;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=tHMyOi4C3Mnre2HB0bf7Ye3Kluqt8+S+aPWfRyB5xw8=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq6kV7B7E4arxmHQz6//CViXirnIcDK3k6F+IF8
 G2RMjjNCuaJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCaupFewAKCRC7dyhM23N6
 3mpPEADHu6Ct3CLDFw8h+kmZSVru4v6jD1/kPyqBbFgPi31cJh1bTfQMXGCjDlEzSOivapKaQN2
 2v/pdI2q2vwigrPI/DlXzZeWXZPTB4XeUFZNYc9LOkOHGjIgA0kqQcQe5wvgxZv93gnSG7U5MCe
 fNeJBdLPFe4VyDYlD8PPXmI8y32szJDuil5a9xrCoUKTnT0TicuuhdzsohzBIIa82svYrXJ2jhA
 m8xLRbNbsGzvGBH90ZRBeaAmOCpk4VPmTTDROI/y/X+fqMbWkk+niFXnHSjDgH1ulybqaNifL+s
 e0O2oS8tujnsw0bs/Ztt2yo4EvklFYYwbAgzPtbRvmo+pk9DIpqYb5kcERbmU0rB4zZvll2ARp+
 JgRcXoU+h2FD0f6GZACwh7yKwiffUv00MwWqxAtPRjtDhVpbeS9cXRHX3RZ9EpFeJHcXSXDCJsN
 VTrUwITg1oTg6nnzpJPVn+bVu60UYx8kd26BJSKbfiieN3W4xaEIl6vZs+cTm9R3RO8LbBX/8kJ
 aJaXh7hl56jKrQ1mbIEePSvABtuiPTQA2ZvFaPa086+0VDvcpIvuF8Zr5zWTG3Ps0MnuJwj5t9O
 GGbbagRNeTMAhWqjRv4qsStCFg6gcyAMeXHrjuvJUbQTIWRNHwzM+D+zUuhkLYZV8O4gETBtydR
 X57ZvJBdSqeDlhw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_123511_162658_E00548F7 
X-CRM114-Status: GOOD (  18.61  )
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> The private_data field of struct liveupdate_file_op_args lets file
> handlers keep runtime state that is not preserved. It is set by
> .preserve() and passed to the later outgoing callbacks, up to
> .unpreserve(). But in the new kernel, nothing set by .retrieve() is
> kept, and .can_finish() and .finish() always get a NULL private_data.
> 
> Handlers might need to keep runtime state from retrieve until finish.
> For example, memfd will need to remember the folios it holds on to
> until finish so it can release them there.
> 
> Save the private_data set by a successful .retrieve() in the luo_file,
> and pass it to .can_finish() and .finish(). The handler must free it in
> .finish().
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> Link: https://patch.msgid.link/20261103181916.2462825-2-pratyush@kernel.org
>
> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> index 63ea5417de84..21caff8a98a7 100644
> --- a/include/linux/liveupdate.h
> +++ b/include/linux/liveupdate.h
> @@ -36,9 +36,11 @@ struct file;
>   * @serialized_data:  The opaque u64 handle, preserve/prepare/freeze may update
>   *                    this field.
>   * @private_data:     Private data for the file used to hold runtime state that
> - *                    is not preserved. Set by the handler's .preserve()
> - *                    callback, and must be freed in the handler's
> - *                    .unpreserve() callback.
> + *                    is not preserved. For outgoing, set by the handler's
> + *                    .preserve() callback, and must be freed in the handler's
> + *                    .unpreserve() callback. For incoming, set by the handler's
> + *                    .retrieve() callback on success, and must be freed in the
> + *                    handler's .finish() callback.
>   *
>   * This structure bundles all parameters for the file operation callbacks.
>   * The 'data' and 'file' fields are used for both input and output.

Please also update the stale: 'data' argument here.

With that,

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha


