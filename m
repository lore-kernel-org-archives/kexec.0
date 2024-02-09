Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F608C48297
	for <kexec@archiver.kernel.org>; Fri,  9 Feb 2024 19:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=90kI78GNoreoCo3KU5ax/x8xU5ttBppqS+5piiiQsic=; b=J4r1XeARfBWlDtpLlXZxoPRTrY
	wy9IawpSJxtNwjXARYcE346t7WmY+NKVX91W2UjC0y8JcCMxGkkgccN0zZoAPe/peMcLLWZq++vMB
	6lLbmsPhoiLNQSxOQrtd5ykeP4Q3+iTE6upSGWIdm1ZwAq7zM/S71eaMUTybL9YfU8ORleXE0UoZv
	46Q0k3zNnQfqhgDeMv9w/z6iOuarA6CIapHyb0SdYWG2OyzamGZe0iydzJI7ggUdMrgNPxjkar1L5
	9+2Vzqlev6hrA33XYG8zpciEGtpoCzZOiTWqTRPJlTcA3CPxwSiplbft5e//itVdQjJMzhZD2mf75
	s+Txuu8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYWOu-00000000Mac-3zNC;
	Fri, 09 Feb 2024 19:19:05 +0000
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYWOs-00000000MXm-2Und
	for kexec@lists.infradead.org;
	Fri, 09 Feb 2024 19:19:03 +0000
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so3001954276.0
        for <kexec@lists.infradead.org>; Fri, 09 Feb 2024 11:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707506333; x=1708111133; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRnCwxFaBlHNvNYdy1hYfoY/u+PniTnXvczChOkbnWY=;
        b=D+4tv1LjaxD2u6jS6RNOMqwmN6J7mF6aGP24qTB6W+h3Ed4frPrSbgZna95/BRBHWU
         kg8G+siV24ggWQSe+xEEN6zHI9/w94GsSGfnKv64zSAJzPwap+B6MIdKHXquUksRzQhe
         ichk/UsLAOnKxX/jnlnOs8dBQ2q+n7owdORb1AUBQ5o13Q220zeaDGBtE+Vnkh5ranSa
         RzpkGSeTQNHXTYPij4YmW18oo9AxBKvMxSSXS0FEkyAOD+4MuLqbsHSrxRY6H63Fcr0E
         0Ktema4MU97FNOKTf77Ogmdyj4VVRe5/lW3otzzItgOlzOCLNClCjQVkvUYlzjoM1B/g
         rO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707506333; x=1708111133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRnCwxFaBlHNvNYdy1hYfoY/u+PniTnXvczChOkbnWY=;
        b=PhTDtwr+JqXL8ltvlOPh4YEREMDfwzlUceKrP+kRtam5530xavGMcOMFTGdZU95Lia
         u9nXkX26SC0i646yM4B6rxQp9x5et1YycDagI/eF4sZUHUG5xg4FrNMC8SQIv3ViIcPC
         YL2P/xxrc2x6Kv8WeYa8eScCKWGlDDbJWv5hPoNwqC6No7xJB9iD3N7BLIWXCuIeQVP5
         q9FX+VE3ZTML+COHHPxhRKPkHxAPD0dNIzrJ0Vuq8kByHQLkss7sU9+YYI1lXXc0FcAk
         HSplUy/ldGchRSIp8MGCcaFA6T6ssZOHllCkKhodgs+mVEA6TDJgBRYOthIZFopZMiVH
         zDIA==
X-Forwarded-Encrypted: i=1; AJvYcCWXsQRNefsGRjeYHm+0VNEZyRJ6vBnwMrR6BsmtWcp5C+5nPl6BIhiC8bpMuHG+dRri5tddhwguUd8SvMoC+Vz+kYx7z2sQjPHS
X-Gm-Message-State: AOJu0YyjxARzYQvn7kkqsjlqM1Kns1A87bTsgiUl+S438hWpWIk1ovdt
	CwG89pMa5EpvYP0e52Q9LyrAWEAlaV+yPhEtTynIW3bxlt2blxNqPr+NVK+L2+Jqnw==
X-Google-Smtp-Source: AGHT+IE2D/9dq1G+XGY3EnJfEpYpWhoRXnUadsjTmnQ9jUN0w+KcMdMs6s8yG0RaRANU9GOhtzoNUc0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1002:b0:dc6:e884:2342 with SMTP id
 w2-20020a056902100200b00dc6e8842342mr13939ybt.5.1707506333090; Fri, 09 Feb
 2024 11:18:53 -0800 (PST)
Date: Fri, 9 Feb 2024 11:18:51 -0800
In-Reply-To: <20240209123520.778599-1-hbathini@linux.ibm.com>
Mime-Version: 1.0
References: <20240209123520.778599-1-hbathini@linux.ibm.com>
Message-ID: <ZcZ6myvln-v0Y98S@google.com>
Subject: Re: [PATCH linux-next] bpf: fix warning for crash_kexec
From: Stanislav Fomichev <sdf@google.com>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, Kexec-ml <kexec@lists.infradead.org>, 
	Baoquan He <bhe@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240209_111902_654563_8EBFE88A 
X-CRM114-Status: UNSURE (   6.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 02/09, Hari Bathini wrote:
> With [1], CONFIG_KEXEC & !CONFIG_CRASH_DUMP is supported but that led
> to the below warning:
> 
>   "WARN: resolve_btfids: unresolved symbol crash_kexec"
> 
> Fix it by using the appropriate #ifdef.

Same question here: how did you find this particular kconfig option
(CONFIG_CRASH_DUMP) to use? Looking at the code, crash_kexec is defined
in kernel/kexec_core.c and it's gated by CONFIG_KEXEC_CORE. So the
existing ifdef seems correct?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
