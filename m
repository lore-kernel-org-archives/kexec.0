Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50642C00140
	for <kexec@archiver.kernel.org>; Mon, 15 Aug 2022 06:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IqyR5gK+sY2L1mMCVuVb8xTmQXr7eNpIWWJrOy7JAdY=; b=c4Btf2cm+/Yw8GQMpH8o5DnYle
	v8GWW3cVCY3kfdpnLyZEFOO2HNEkA9AfYQ4qcNRRgD2HwoMpjx1I8aZbsriFtTy0gCAE7L/I7t1yK
	G0GCNVh9ILplRlXiwXiuhb4/m1mtHVdvG/E27vhWPHARrIXvucQze18lbQrG+GhKKXLKqoekeL8Un
	yZRMsXcndIzdwlh4PEKfu78F6wbxYtnAaCeRPIr5NhddZsMBMJzUhwge2y4VbamAueB/yUvIg5Xsl
	dOXaNw2ots/MrLttg+iBs/fLuyJkdygmA1y7jBgUwwR8VC13XjyqvWrQ0arLOx3YVrP6iR3H796Yo
	T7GBkfPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNU0p-00CDQV-4Z; Mon, 15 Aug 2022 06:55:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNU0m-00CDO0-GG
	for kexec@lists.infradead.org; Mon, 15 Aug 2022 06:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1660546542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s27ZkPXAKFlLDtakqNA0q70iNz46u3nf8VUdJxUpsDw=;
	b=VhjS4CpeN6WyYaPRcHJN0mp8iX1yicytUmXfMQSFGqL4jIkMihYafsxh9G6tHdBS8AEdL6
	jLxW2fczbLbMKa0uPbAjZAMrnwQoK33biBRFsxkC8WAZ4lZE4mOg/8nF/V6dcbnRGSQvs3
	YuQHFchaStUntbocT/Su4UA5CLsNk7w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-TB09isOMNNK2BrYqe7-9tQ-1; Mon, 15 Aug 2022 02:55:39 -0400
X-MC-Unique: TB09isOMNNK2BrYqe7-9tQ-1
Received: by mail-pj1-f69.google.com with SMTP id kb4-20020a17090ae7c400b001f783657496so7825669pjb.6
        for <kexec@lists.infradead.org>; Sun, 14 Aug 2022 23:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=s27ZkPXAKFlLDtakqNA0q70iNz46u3nf8VUdJxUpsDw=;
        b=66o5rdrIar3CQ+QgwoMFhEi/CatezT5F18lBaPpdjG9jsnlW9/DJIzqWYbb1qnZ9s4
         Ez4DlNKN6VPi8CUg0G21azuKh7ijlpZq5XqhZmgm8zud7idoHawbT55uucBikZ59jIrg
         ZREw/JiYiCSgOI3EvV/bKliBqqTEVOMRI0IsDCevsKRzdmiCL7+sZ0kvjg3ZPWo5pqOi
         20kZnoNk54ruNf379suOAJF0JUhh7aO8lbxMcxENnAUVRlmDyysYGQGkJLBHyqYg/BFR
         9BYJHZuQvUccBGiPkTxsr5sAVNMuFa3VocIdyhLRh9f+7b04vMgJjclTZULmTReRQJUy
         FibQ==
X-Gm-Message-State: ACgBeo3ft881zBLEXksuKohVRFuw7nKe7jpyHDDh7elPEs3mVlytTM1a
	susZA7W7NcipHQ1/79QSiJZkjhBQNccyGO0Xr8DhvvxwGiaSzflAKyBxs7L2NNe02dPFwRn3m02
	DHX4ZQsY4OBhRB1upkW4K
X-Received: by 2002:a17:90a:5888:b0:1f5:f1d2:54bb with SMTP id j8-20020a17090a588800b001f5f1d254bbmr25854876pji.178.1660546538524;
        Sun, 14 Aug 2022 23:55:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5gSneUL2Qdvf4jY+Km6lnQKEAMNgjtedDGxytTE89P2b0LLUeE3NqKVwS7DQzMiYmV23B6Fg==
X-Received: by 2002:a17:90a:5888:b0:1f5:f1d2:54bb with SMTP id j8-20020a17090a588800b001f5f1d254bbmr25854861pji.178.1660546538288;
        Sun, 14 Aug 2022 23:55:38 -0700 (PDT)
Received: from localhost ([240e:3a1:2ea:acc0:8cff:e01c:2dbf:2ae8])
        by smtp.gmail.com with ESMTPSA id l20-20020a17090b079400b001f89383d587sm4015601pjz.56.2022.08.14.23.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:55:37 -0700 (PDT)
Date: Mon, 15 Aug 2022 14:53:25 +0800
From: Coiby Xu <coxu@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
	nasastry@in.ibm.com, mpe@ellerman.id.au
Subject: Re: [PATCH v7 0/6] tpm: Preserve TPM measurement log across kexec
 (ppc64)
Message-ID: <20220815065325.h3t3igr6nogf7h23@Rk>
References: <20220812164305.2056641-1-stefanb@linux.ibm.com>
 <20220815064813.77g6icbkygrbmapa@Rk>
MIME-Version: 1.0
In-Reply-To: <20220815064813.77g6icbkygrbmapa@Rk>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220814_235544_762695_4BC0036F 
X-CRM114-Status: UNSURE (   8.52  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Aug 15, 2022 at 02:48:13PM +0800, Coiby Xu wrote:
>I can confirm this patch set fixes an issue that guest kdump kernel
>crashes on POWER9 host by applying it to 5.19.1 (there is a conflict
>when applying this patch set to latest kernel i.e. 6.0.0-rc1).

FYI, here's the error of applying it to 6.0.0-rc1,

[root@localhost linux]# git am ../v7_tpm_log.mbox 
Applying: of: check previous kernel's ima-kexec-buffer against memory bounds
error: patch failed: drivers/of/kexec.c:126
error: drivers/of/kexec.c: patch does not apply
Patch failed at 0001 of: check previous kernel's ima-kexec-buffer against memory bounds
hint: Use 'git am --show-current-patch=diff' to see the failed patch

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
