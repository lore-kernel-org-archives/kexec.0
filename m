Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF25AC433EF
	for <kexec@archiver.kernel.org>; Mon, 27 Jun 2022 22:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JgzXstpbEkmEA7tcBxcbwXfieU63rPmRYiiEsbq1iJs=; b=ZENtZa9w16Q5cO
	GxSgohB29T/TWDvwesTGYlEMtmeFZUXkOvfHU0yoPSs3LIf9yr4Ajhazn0bzse4iSlpJlkHzMIXU+
	UpE10YWAQOG7fCPJCojofnhCQdyhYk+FZXl4Sovt7wyKJQumaxi2pdPgndA9p7oVQs7Z8V/wA8Upm
	uKrAsc6SdaJm/2edo+Txvcl3uQ+DdRhMlt7n+518CG2WszdsvypAnj67Cv9tRyd2IJvbX++pfhh/a
	kGP8FUZNnbZdw6bUfxkcuV96QoGee5W3Mhz8LDX7hxjeHUypmcnJfPo8AbpvnhCtoyg901JcSkDzs
	XYxr9BAom3Fs5S80X3/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5xIr-0037uI-4G; Mon, 27 Jun 2022 22:33:57 +0000
Received: from mail-io1-f48.google.com ([209.85.166.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5xIp-0037sk-2U
	for kexec@lists.infradead.org; Mon, 27 Jun 2022 22:33:56 +0000
Received: by mail-io1-f48.google.com with SMTP id k15so11135387iok.5
        for <kexec@lists.infradead.org>; Mon, 27 Jun 2022 15:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=32Nxg6F78wS9IwAB+Cxihgn8oha1HxjScddi+4nCHG4=;
        b=fkN7hApP8Ud7hK3HnEmZmYEp+lf0Sch2S2WxTzdJcJyo+8GIjKhcqW49JrpqXmTUgP
         FI+4nAv1Bfjc96VYuKWq19s1YXTJKSY1BfFaQ2Gcu1q9UcEI0H6duZSbBFf1FMt8QlXP
         yBuU57UyhDTrb35FQL26EGgYm6YmiLLZ3cROSQ8n+K6wP33JeOPnWofWbKohha8i9lRg
         6rccGSfKu+j8Nq0xLBb/ppJU82KqrNE7FiAH0Rc5y28rpZngwyZ8PpgPTjyOwjHXEIRS
         qvFBevldrmrrujnp138GqlfOd1MIIScDD+y+6QKPdBVfyCVTwwfb4kLGPiHGbz7XENwy
         hoqw==
X-Gm-Message-State: AJIora9k0ao5uVH2SuSfitLveJrCGi/wvsPCd6q3NscMpN+d1+oh+9Ed
	mZPYPeYIBM9xjcoW7+xOuNCcpZx6eQ==
X-Google-Smtp-Source: AGRyM1uizCsd2c8405104reVZ4+WqtbFQDYdp2onLnzKzFfvElEFQ48+N7iSI1kQlWIgwkVWg4FWcw==
X-Received: by 2002:a05:6638:d4d:b0:333:1aea:4b9f with SMTP id d13-20020a0566380d4d00b003331aea4b9fmr9645855jak.149.1656369234311;
        Mon, 27 Jun 2022 15:33:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q4-20020a5d87c4000000b0066961821575sm5863196ios.34.2022.06.27.15.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:33:53 -0700 (PDT)
Received: (nullmailer pid 3088698 invoked by uid 1000);
	Mon, 27 Jun 2022 22:33:52 -0000
Date: Mon, 27 Jun 2022 16:33:52 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: kexec@lists.infradead.org, devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, nayna@linux.ibm.com, nasastry@in.ibm.com
Subject: Re: [PATCH v2 0/3] tpm: Preserve TPM measurement log across kexec
Message-ID: <20220627223352.GA3082294-robh@kernel.org>
References: <20220616154130.2052541-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220616154130.2052541-1-stefanb@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_153355_163916_9948398E 
X-CRM114-Status: UNSURE (   9.98  )
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

On Thu, Jun 16, 2022 at 11:41:27AM -0400, Stefan Berger wrote:
> The of-tree driver does not currently preserve the IBM vTPM 1.2 and
> vTPM 2.0 measurement logs across a kexec. This series fixes this for the
> kexec_file_load() syscall using the flattened device tree (fdt) to
> carry the measurement log's buffer across kexec.

As mentioned in v1, please Cc other folks that might care about TPMs 
and kexec. I'm sure it's not only IBM.

Rob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
