Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB38CCFA00
	for <kexec@archiver.kernel.org>; Tue,  4 Nov 2025 10:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Message-ID:Date:
	In-Reply-To:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=owDawV/cnKyMwzi7YiANe4vB27Qq/ThAIZ5MpALecMg=; b=U5uW0beCavaS1ZCX8u5uHOiaF4
	slhyxLu8nzF2nJCrh6mjZJOUzuT+4dfz3QaNAZnbE0fhZWhws/on5ns81mEIsqrJLtcga/QfJruzM
	gvlxJUx4yn2/rDy2GHunxp783NdfvWaj5wwILgwxaDabGhV5BtpoqOHdDx0YA19euxNz3LH9fT+5j
	31PL0/rJwdE8UT1oQt1fJDZW0FSDxUe4yvl7srxuMmb+AvbDg67oMyMHdAdYmZMeUSwqZUbxhVUY2
	AH7Fq0x0cIT4VsJgErfnH9ZPpLYriXCpXxheubpxtjtVZ4h5EPhr9dGq0ogUnInoTHtreu4/QyFOK
	Gh6ISoHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEDT-0000000BbiF-23Xa;
	Tue, 04 Nov 2025 10:24:43 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEDQ-0000000BbhA-3QLf
	for kexec@lists.infradead.org;
	Tue, 04 Nov 2025 10:24:41 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-294fb21b160so37853185ad.1
        for <kexec@lists.infradead.org>; Tue, 04 Nov 2025 02:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762251879; x=1762856679; darn=lists.infradead.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=owDawV/cnKyMwzi7YiANe4vB27Qq/ThAIZ5MpALecMg=;
        b=hD2V5QxtHE6NbVRoZBTn+et7ueixjr2YwxVcuPA4BoCK1gXgYP1PAqjyiP5dEmejaM
         xkrmtvRc7SL6+zgEK6mFbIwLhAeEJhafQDOwRfY0jJf0L+dR+Txd0nk6ks3zPH96ie07
         /VSG8V+PxTCdpjaOzN7fpcJEP235KnRrHc2yH4y1DPxLBDS63o4H8jSElEsQ5loU2i5J
         i1AMMXPvhyx5h6M3Y0S3P6bJngKoMtIt5n2cMvSq4j1kEJfldB+yN0A5ko6Rj96Qrled
         30xSLht5IShz1GImRDlKK2Rt94BAWGcgVbxOQdsdfoP/HMewW95f7YwOJamHFD8puG0c
         6VHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762251879; x=1762856679;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=owDawV/cnKyMwzi7YiANe4vB27Qq/ThAIZ5MpALecMg=;
        b=HlpeaggUbdt2tXKuD7fPBPXHTPF2ESzt9CZHJkF/R4J7fxX7OdCTehCLhEcwgydFMx
         Mc8rJCZjpKypekRw5+UOYkA3feZcG1GuKGZFH8bElE725tGuQ59zuIW5uR5QWt9M5V0g
         7lI1H9aWsrt50iCf4BEPvuGhZHr9PTmuaHkLJcUOXBBsWwHLrgT8FKjJH2Gf9psLN89m
         RFHfWfSUUD/1x6Fztg0J719oMzVZsaFQla4fYzB/MP+XvE43o7j0qZ301xO4V6ECjFPJ
         vYdY2t5SeKUzhl5cqgqTur8ZEKVjFj5v5cFcNh0BKNH9vEKA88sd0hTCJFznALSbNIl9
         qq8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVv0d4ewdPi11A74LrA/a+BBJkJPHtSQqfLbU4qUg6SJ2hLTlCMuih17XThueXbxcZ8t+/mGA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyNXUBGIxSu1/KY2mgSMVz58Wj5EAXNMSea92j51S3dpvQ1n4GN
	j+yIL5yb/adRB1NqDIBOo1X+T/KGZlDfD6e9mPBYjsrWUpCYO6K7N3xkc0rU4KU/
X-Gm-Gg: ASbGncvSTdWSSVi4+1Yyo7By6c+aam+PGzWKOEHREPe0yy7xjJfAJFpX6w/v6IinsCw
	8wSpDzAJbZs1AjScp6kfzLADrsP9w3NaAw/e8s8kOOGwnHyWSWjR2Qc90ENp46Y4PpZb1t6Amf3
	WafboaF5a29j7NjthDHDppOzm2UEmF+be/aDjrIgmm/+kWjax6zebui94fx/ollVqYs9XgZ0HH1
	HTiOKEBl9tBpqnAz3R72N38ay6kEED6ysAnnVk4zx/F6U5hizjJLf4+ecOeGJST2L5wTNfS5boe
	8PJCV1npkvwgwlXkJTyGlEfKW0+1zpkFyFzmXW2XhLufdkLnNytg3IdHCNTExIQ/1WtufNFZTn2
	kQMurc82DoR6J5pvJSOtCrZhQZptlsGssO36K2t5wEiNELcuyoyoE1evFoy2D4Jk0mvloBA==
X-Google-Smtp-Source: AGHT+IEu4ISs/3Zx+zO0qMNXn+InIequcG2BrEwlpQjYK4nng9gbF8T2Q1dyWzpa23EPsiCBGAeVBw==
X-Received: by 2002:a17:903:41cc:b0:295:7b85:2f5f with SMTP id d9443c01a7336-2957b8530eemr103346575ad.31.1762251879495;
        Tue, 04 Nov 2025 02:24:39 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2960199832asm21393245ad.26.2025.11.04.02.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:24:38 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Baoquan he <bhe@redhat.com>, Jiri Bohac <jbohac@suse.cz>, Hari Bathini <hbathini@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shivang Upadhyay <shivangu@linux.ibm.com>, kexec@lists.infradead.org
Subject: Re: [PATCH v5] powerpc/kdump: Add support for crashkernel CMA reservation
In-Reply-To: <7957bd55-5bda-406f-aab3-64e0620bd452@linux.ibm.com>
Date: Tue, 04 Nov 2025 15:48:48 +0530
Message-ID: <87wm463xtj.ritesh.list@gmail.com>
References: <20251103043747.1298065-1-sourabhjain@linux.ibm.com> <87y0on4ebh.ritesh.list@gmail.com> <7957bd55-5bda-406f-aab3-64e0620bd452@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_022440_860208_4DEF2598 
X-CRM114-Status: GOOD (  10.13  )
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

Sourabh Jain <sourabhjain@linux.ibm.com> writes:


> I would like to keep kdump_cma_reserve() as is it because of two reasons:
>
> - It keeps setup_arch() free from kdump #ifdefs

Not really.

Instead of kdump_cma_reserve(crashk_cma_size), one could call

reserve_crashkernel_cma(crashk_cma_size) directly in setup_arch().

> - In case if we want to add some condition on this reservation it would 
> straight forward.
>

Make sense.

> So lets keep kdump_cma_reserve as is, unless you have strong opinion on 
> not to.
>

No strong opinion, as I said it was a minor nit. Feel free to keep the
function kdump_cma_reserve() as is then.

-ritesh


