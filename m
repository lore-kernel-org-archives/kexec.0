Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EA2CD4851
	for <kexec@archiver.kernel.org>; Fri, 15 May 2026 23:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D7nklUCScqv2NitQOcHmOlp1LpHmTXVfX8MzcU0yUSA=; b=1g+Tm87jNt/txw0jEDHUutryu4
	5M8x8laRSvWyMMEj1wShyWDv/31wXG64/+TNVN7DxxvfM2AMkyeMUAD3AQR+i7VPYui8kPtRHbcKl
	A5NyX1v3M4Gc0cSxYc67K8W/47b3uRkdya3RqIp3Lu0+wQkeyvBmNOwamzDPhOGIJ6Qt0M70HYgE9
	1T2mSRg4Ujqqf0O2zI7rGj0luo2/0sYCiLVonUrk+3RGVfEM0w2bplVjz3QLaUGMY0H9jVSfFMaJ3
	QC/2UgOKpdv9cr/cMicw1vkiDDXxvlRXhclxhV+z2XDmFhpy6vHCWZGOYXoq1vcDETK/yJVwSmhu8
	yaFZgTrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO1bR-00000009goi-2VNW;
	Fri, 15 May 2026 23:05:57 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wO1bP-00000009go6-1kLn
	for kexec@lists.infradead.org;
	Fri, 15 May 2026 23:05:56 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-8b7dccd6fe4so4148776d6.1
        for <kexec@lists.infradead.org>; Fri, 15 May 2026 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778886354; x=1779491154; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7nklUCScqv2NitQOcHmOlp1LpHmTXVfX8MzcU0yUSA=;
        b=Wdf0/TdKStAr1LvYteFBZiu73IpztWdBt3T4a1ePU5EUavrgLPX+MjnHX+c9MF87zJ
         yuGsRmrD6qqpbLlnLwdqpeEj1mGsGbwqzXzzhoqqrDJaDpJT6RrD/wpO3WhP5y2GpwNi
         KlVBYcT4zLEM1PT1zNiKTrsmivhc/U0lhufR8xM4+oN6t8PYex2NAc8dsiaowG1gFjs3
         Id6FPDdh7H/bcWW/soZ0gV0Cq84WfC57OxgfQIq6dym2VctnC63LaEFXgAGK9EAqLupe
         8ZP6mwkvPykNu8PVRIf1Tq/RnGnYOZUFmFt5WqERwWMGuxNpQ4hKdU+wDyc03tUWv1U+
         00WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778886354; x=1779491154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7nklUCScqv2NitQOcHmOlp1LpHmTXVfX8MzcU0yUSA=;
        b=hmznN6mBf+CpV/EVY+7WKEs7gmV5/9upIOjUy9/sqGfYMCJvbvTz4qr3DsfmlyCet8
         NWnj3XWgslH9ykg7agjYfDViilOs5Mi4sUXHyrXXgCXgc4cQcdDEaBYhDJuu6TJtI7da
         E1uH3N23OID8ya+vayPUOsSMx/QwGWjL3CRrj8ssh0VRYuLvqcdH4WXJG7tg7US1cfa+
         jtnQBbsZuAKd6vvbIxtqUckNclR6PlWpfpImq3Q1xrrMPgpXMNnZ7IMNPsdGpTyyErlz
         H9glku+RXYtDPXxBjI8n4uUGU8/beP3STbqhuqm7+ZsNNnp6QGCw3xkcCVets00HKSbH
         H0tw==
X-Forwarded-Encrypted: i=1; AFNElJ8ygXMl7kubWC+8KkZld/0UfdweBq2nGNdIbivHC0scn6MKir5LFr3cGN1t2Q+nhLxnvLjX4g==@lists.infradead.org
X-Gm-Message-State: AOJu0YzVYENQIVig9PejqlYM5Ywc65dS5ZdqVHpuudVjuLN5U/2NCUgg
	MjH9p4CRJah8y1pXI6sDE1PnPK2x8D4/ZyX9KpYnz6Lhr4ArjEgr/NOeEkVEH2EhR7A=
X-Gm-Gg: Acq92OHSg94x+o2cEh/47YcWHRujcgAKPRAh88C9uNCTI2d+oCdQCwtB5WBG0+uHUve
	TCUZhTIikde+YWv8TtDJxkiD3LwQo1qC34atoRZWjUAdoJWPjbxALZw/pT47vHmDbbH/gBG0Upn
	MitkpGBeniR2aJsXkKLMV67fi54ZdJH2o4OQ29pJ9GUE8ftde0q2KImLQRuLEg5o6G3195tjkR2
	tX7QHNG2oPl3V3hhPcQ04kvBOWx3h8MPiCP31qGZD1dWfnjYJHFnJItyqP08CGv3PHJ0X6fyMrT
	mAxUysjUWglFkmYt84e28zf0rLz0+t3B2lMycxztJOK2PHKq7CJEiNMK3xWPt7u/ersyXSStc89
	pZwQPMUiHZwWPrsyuCRj6ZZSAlOONWPVdHCh+ff88SfWu4WCP88GBwsdteoVbhL0Wo6MFFegRS4
	YKTtgzQ7H7kJ7tcJVFDtaaPt5s7lwm/Ejh9NNWbRxZLPMvTyPpICqqBPcYISclainCZb9954Gjb
	EjFKA==
X-Received: by 2002:a05:6214:1c82:b0:8c2:b36d:4fc1 with SMTP id 6a1803df08f44-8ca0f66afc4mr87385476d6.14.1778886354080;
        Fri, 15 May 2026 16:05:54 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c374469sm64030376d6.49.2026.05.15.16.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 16:05:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wO1bN-00000008GrB-0jOE;
	Fri, 15 May 2026 20:05:53 -0300
Date: Fri, 15 May 2026 20:05:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Ross Philipson <ross.philipson@gmail.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	iommu@lists.linux.dev, dpsmith@apertussolutions.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	luto@amacapital.net, nivedita@alum.mit.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
	ebiederm@xmission.com, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
	daniel.kiper@oracle.com, andrew.cooper3@citrix.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v16 01/38] tpm: Initial step to reorganize TPM public
 headers
Message-ID: <20260515230553.GO7702@ziepe.ca>
References: <20260515211410.31440-1-ross.philipson@gmail.com>
 <20260515211410.31440-2-ross.philipson@gmail.com>
 <agemXwxVb9jvAbYM@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agemXwxVb9jvAbYM@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260515_160555_459798_B012E693 
X-CRM114-Status: UNSURE (   7.87  )
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

On Sat, May 16, 2026 at 02:03:59AM +0300, Jarkko Sakkinen wrote:

> LGTM
> 
> I'll hold on from actual tags up until there is some consensus with the
> patch set.

This patch set is huge, and I know there is alot of interest now in
DRTM.

Can we please split out and progress the TPM reorg mini-series at the
front?

Jason

