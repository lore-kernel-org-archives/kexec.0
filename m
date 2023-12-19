Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61644C35274
	for <kexec@archiver.kernel.org>; Tue, 19 Dec 2023 02:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CummT53OXBwb7zieAtVvseH8IEA+F7eC41A5kZrOm7w=; b=VMxlKdfxhSJmaN
	8RYbPJoVXslokCzfOQHTz3ykCm1k5C/VYVtQkOQSVtcJsHIDIItZBJs/uDFv2pCPomEt7n0Xkojho
	IFICA3J2b91Lr5N0hjUSIkv3rpelF9xz+mWj+t9bAtKWGGAxM4MjTwNoiCR1sFYdVuc6avUuIKf/K
	1tP7ZUQn63A6tr/Hq7AthqEI72E7XE1t5x5nSlwOvK9ilEccg6006ol3s9qyXpvdBg6I/mJOrp9dQ
	taB+nLBmwjzLh5fd76HlPBiqiuwjhAaQnsj5ht02y1zn8c2Va4bSikL54YhAth8BeDG5IoBITg909
	nT71auC40ZL99h5UE+Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFQ8v-00Ccno-3B;
	Tue, 19 Dec 2023 02:47:37 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFQ8s-00CcmW-30
	for kexec@lists.infradead.org;
	Tue, 19 Dec 2023 02:47:36 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6d47bb467a9so1588804b3a.1
        for <kexec@lists.infradead.org>; Mon, 18 Dec 2023 18:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702954053; x=1703558853; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sC/Syu1LO9CGekxHr4hyDiqB1I8nqPv3BQMH/cbp20c=;
        b=lh3Opc6o6kL/yKh3xYRKlcQpmlpskCQ3/sjAxTGh7/3N1fUzZUZ3WHYh5uqDuqNotk
         Ank760jCaUvMM5Wq1fawmqUV4YD1XWXF9VudfMyaRidIlYkbe36wxo2o/Kbz1xstSnNV
         g8yYefnu3i+WfRUSlw/tY/54NzF4gf2o9Gjc/Poe10LddNrRgEZbEt5y8d2i2vTooraF
         JmIt+2ITcqrdzCkysn3R1nyKGTvPgp7ZG2YnCVzx4SoQfu2jKb7Mp/+crJE4W9fZiJMU
         R2OCUXTxE57vKsdVpBmrqP1QHehSCunr0V/uxbGs1H7A1Yxc9DHm64r2U+iQ87IoeWNP
         CXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702954053; x=1703558853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sC/Syu1LO9CGekxHr4hyDiqB1I8nqPv3BQMH/cbp20c=;
        b=c8dlFZOL91Dr7wcpkae9v03PDLRSkzBwXedh6ZrKC9C+BLLRKgzvpdOgemfQTdFnBY
         YKFBWuzVyQnosIHMz1afqVDpZBd3rlZFuVGXDGAsSfOsMJXtr48rHOO1MeLmsm2Y7uY/
         8JioNS+dMkUb3d6+DePjh2bp8G6CSmtzWTf8aKTvcZxqiVPZpElVZQPXqCVpKC7scGBy
         8+oQfHPAAPMZ7NGrbRNEeF8Rf8ZFN6Czomy5o3lTTug0/pENMCWIOFzZ7DYO7i4E4rzA
         m1nEIvaBfOCR9eXg44Rrg1RAWjRVl8jP054RQZp0hYI7lPrX7IFoefxGc+Ka5cKwOoZe
         GJ0w==
X-Gm-Message-State: AOJu0YyuKtXZePQe7wEWzpG1gw4bSWwNAms6WScfnNVj11mIWcQTuBnv
	tRg0ZfZ5Cy/IayCCPImbheNUTAQEmaY=
X-Google-Smtp-Source: AGHT+IHRNqb5kUfBYi12nhyKHU/bcfBy4RNNO0tbkNkX84gE5c5tAlV/+LxFS36wLXSa90oZaRNxvg==
X-Received: by 2002:a05:6a00:330c:b0:6d2:74fc:1f1e with SMTP id cq12-20020a056a00330c00b006d274fc1f1emr542127pfb.14.1702954052994;
        Mon, 18 Dec 2023 18:47:32 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id h25-20020aa786d9000000b006d559d1a674sm3620275pfo.160.2023.12.18.18.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 18:47:32 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: fuqiang.wang@easystack.cn
Cc: bhe@redhat.com,
	dyoung@redhat.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	vgoyal@redhat.com
Subject: Re: [PATCH] kexec: avoid out of bounds in crash_exclude_mem_range()
Date: Tue, 19 Dec 2023 10:47:27 +0800
Message-ID: <20231219024727.35016-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2fc2ad7d-13be-4a9a-b984-67b1bf04c56b@easystack.cn>
References: <2fc2ad7d-13be-4a9a-b984-67b1bf04c56b@easystack.cn>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_184734_965306_24C24C39 
X-CRM114-Status: UNSURE (   7.75  )
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

Hi fuqiang,

Yesterday, I posted two patches that happen to address the bugs you an Baoquan
are currently discussing here, I wasn't aware that you both were also working
on fixing these issues.

Baoquan suggested I talk to you about it.

If you're interested, you can take a look at my patches and review them to see
if there are any issues. If everything is fine, and if you're willing, you can
also add a 'Reviewed-by' tag there.

The following link is for the two patches I posted yesterday:

https://lore.kernel.org/lkml/20231218081915.24120-3-ytcoode@gmail.com/t/#u

Sincerely,
Yuntao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
