Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29308CA0EEB
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 20:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DxTFBNUIBAQ3FZNSd44Qp10NN2AnsN28C2tejcvZV/w=; b=1FlSw3bYT7oezGnGY3QguMdYY5
	V9pfM5lUQ3MkIrrRNjvuJfexsyO5jh9xmueBh7+65ZsiIobRbrbggFhCRqeNtoXTJfMYmMiZ241zs
	3DR78NoTuh04LKIw23yCeR3nuMMSIrLOTakopb5ecFO7h/UxltNgYOTe1UEV2Fc5XBTuV5VoxPbIM
	OhrZYlf7WfF3PirRR58RC2VK2Vh/yYqRrfcjQGt6amDWz6PXcC5g0yyox73M6vysvpLhprZUOmueM
	j1HajDdhbzwwYxtQ4GmlWokgSN0HPjsrz8TmaOv+sLhMCTPQ6wibwbXWELeC4ckguuwjANnfDAnF/
	hARuV0XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoTAN-0000000BYoE-2Y9u;
	Tue, 19 Aug 2025 20:42:47 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoQzt-0000000BHdB-2194
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 18:23:50 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-afcb7a3ee3cso872551566b.2
        for <kexec@lists.infradead.org>; Tue, 19 Aug 2025 11:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755627827; x=1756232627; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxTFBNUIBAQ3FZNSd44Qp10NN2AnsN28C2tejcvZV/w=;
        b=aB9wgkqx0uTej/9M+HRpWvoUwq1efFlBsR4Qz9Ircx2xHV8nyWTc+AvJffWRN+tGcR
         9VVo1YQIi/np73R//a0JwYKyr9UnIzDBkrHvmygTWfxnWVnHhl3sH9rNO/XlcmKl5xUB
         yzWN0KWMdzQKWHDWgxnOuomUxKAO5cutGP1Nuf/XRarhshitno37RSkC8/Gf4mK8+yxl
         TbZ1M2ngw1/uoos6hVERD9RkfD7PyCDHyjph0sAjOuSY3ZkLM409wqnD3KPQGIb8lteI
         F/9SLWDLX3nTtZnuu1YOExZUbcmXV5gycZC+ArFqhgcbFKAs7qrrVh+R+Rmj+fDv+GFn
         xvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755627827; x=1756232627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxTFBNUIBAQ3FZNSd44Qp10NN2AnsN28C2tejcvZV/w=;
        b=qStsYnTvoIAF2lVR3gxZULgu/qJbDW9hTw8+hA53T0atWxMIQWs/wFPDKedzjTpGMt
         N05fhgfY71Q9IAYtlzrjeK9yEYFBzzAfVDrnivv81lhKSDsluTj05DQtKuAGpbOkvr7G
         1PKk0aH63Q6p2FzNhfbfUt4mhZ75kawKuPnvFZigUFPCTl8OHx3AiTrCu8LKlHPMYHGX
         tu3GQFp7sijJs42fzSonA79EaxUxc+woI6+ueHGVnF1bfbOVIvVVD9G6d7i7RxUTw5Si
         QHYsMuRCjVWRhn2oquMtFLWIyCrB43YmRPRUN5UsCKlzgZnQ1U2tKWziXeu6HHXVarOf
         9MxA==
X-Forwarded-Encrypted: i=1; AJvYcCVKp3kpbIQcHd0urqCFjlG1pUsctjoygNImIitAb0fMdFwADhMPF4MAOzzh7eZ/sxfkwTIwjQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxDM2lZ4dszrLuXn/M3mSFiqCUZoZ4G5kQohWrWABBERBIUrOzP
	r2WVFgJMNbIM3FsO9Aiy4oJPelU5lPcqSXheMgE60UYNxYqRL9PlrOlXW1zO2ZFDMbxX17t5jCF
	9q8N1gRuxztGRQhoZeAm6al9Gmm/A1zQ=
X-Gm-Gg: ASbGncsmwwJIyr52X8XSEp8/6upVbWDTqM3dARZi65L7t37BWmFClYOAZHk721UYmPt
	NUfAMqBDbUwG3Vh2PmlxOoRGsJhc2ZED33nv9LPko5Cl7ocSH1XVTsiKIlttAiNoJlbcqg4hX/o
	5cDQ5MLX0TuJXxMk4OesNTPS8C8JxE0OnZWCCEz3mrw/1orGVDnkt/HnbMpdxTkP6G+6m7vm5f3
	J9oEYw=
X-Google-Smtp-Source: AGHT+IEpYRFsSy28Ub5RwkZQG9OAqpcp3tzJT14fmsx9QTKkRVuQvPxQZqbOleYCt/ozRoA6/WDqrgYXXsLKWxXLwR8=
X-Received: by 2002:a17:907:1c97:b0:af9:81d0:d971 with SMTP id
 a640c23a62f3a-afddd200ce3mr365175966b.50.1755627827345; Tue, 19 Aug 2025
 11:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250819090505.647690-1-safinaskar@zohomail.com> <20250819090505.647690-3-safinaskar@zohomail.com>
In-Reply-To: <20250819090505.647690-3-safinaskar@zohomail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Aug 2025 21:23:11 +0300
X-Gm-Features: Ac12FXwbOF9sQpqacEXKmBt_bM3fXqkamxq8kRUX_dhzM93qjKcx588Nnceo7xg
Message-ID: <CAHp75Vf_6kA7B4ca0_AaM=oAR5JGqTN5oN8vBbojkcXufnqSdg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] kexec/kexec-elf-exec.c: Replace %lux with %lx
To: Askar Safin <safinaskar@zohomail.com>
Cc: Simon Horman <horms@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_112349_516486_F88ECB1A 
X-CRM114-Status: UNSURE (   9.30  )
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

On Tue, Aug 19, 2025 at 12:06=E2=80=AFPM Askar Safin <safinaskar@zohomail.c=
om> wrote:
>
> I think this is what author meant, because current code
> prints decimal number, followed by literal "x".
> I doubt this is useful

The above is the comment and not a commit message. Compare to, e.g.,

"Replace %lux, which prints a decimal number followed by literal 'x',
with %lx, which prints the hexadecimal one. The latter is more useful
for the (address) ranges."
The code LGTM.


--=20
With Best Regards,
Andy Shevchenko

