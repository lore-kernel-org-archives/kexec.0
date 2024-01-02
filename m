Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A67C46CD2
	for <kexec@archiver.kernel.org>; Tue,  2 Jan 2024 15:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FxX5ZzxuzWR78H5x4W8kApgChBnBL+HF+E+fErmqH7s=; b=mX5umOpROq5pgt
	nacuL1H92tz1cOWrfB8wb+ziwL+FpW7tnNtLB5weVn1egeRZKn5drlitjw6TRsj/4e9dVAcC6gAm6
	RWjEQQqnt4Uy/qwoZdLiyVtaQ276OT/AeKBlj0cV61y3McYH/KxYAfvDMtdPgWOYe7fcQa0GJrWOz
	AyVU6n6t3NyIEdqfjM9ht21iXtqMXU235TVW0gQ+3WhRJ0ov6mGAaP9jTxovmYWLqhfRTD/Wal7L5
	cS3KURvmlOKR6oogrBwWWasCSURwleDqQHNhVKBTiNyVPc1sod8R4+jCpdkjejCcOR0PXjCxVqW3J
	Nx64SkcixTfC/OIHvnGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKgLa-008KEw-2s;
	Tue, 02 Jan 2024 15:06:26 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKgLW-008KBl-0m
	for kexec@lists.infradead.org;
	Tue, 02 Jan 2024 15:06:24 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6d98f6e8de1so2813975b3a.0
        for <kexec@lists.infradead.org>; Tue, 02 Jan 2024 07:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704207979; x=1704812779; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwt7CszV/J46V/JfrZ4yi4aU/mOorO6zMh2f6qpUKyY=;
        b=ZPKhy8qoTfpUjAdk6rXcpZ6/lMPD1MNZ6Tui4Ro3afdkpBEq1QC7iAry9KW2heSYCg
         VK9J+dvLQ05zc+qt/ycltRwXH/KrIWokEelBQbOCgSnQ182YAe24YNjddo98Z9vr9biv
         3fCtYwJas5l+at0vSqBwoFLAADlLdbOdrKV2QRIq9ffm0FEBA42OITaK0w3vBZ0T/J2D
         /4gMZTbmIJsrRCRIV8gK7Nhklt0bjiBxMzuPCvhcyFWur+zRIoi6j7jXnSg5Po8d3MOS
         rl/VNhphgpWrKvrOsRq8rS+9sDdBjLO0dKxBop7VcC9uiC8ls0/Isq8eNb3rM2oGoQaH
         GmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704207979; x=1704812779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwt7CszV/J46V/JfrZ4yi4aU/mOorO6zMh2f6qpUKyY=;
        b=IsrEVgVbgg57mivdq0rsW5B4J7y/7xix79IA4AEIZ207Cboaw/iNVfXIKNXK31WIDR
         5dzwWHN8igAg5Qzl2RrgpglZ37o5viQOOY73I4/VxDzcBNCgtnhMD2lbUIH8J2iR39px
         7CapIcYKGUIE4BSGQrIXXUyiQROTjDTyCQeZ/JHUSJsH8433cz5qQTgxLR+aCNr5eMID
         Xr93YkhMLDC08MNox3/zrDRth42K1ax0MXiK0/fTH75IoiteZaNJZbvdGb9R4SlmJuYf
         xHRFABdFqtHwzi0RlkDQrocuQ0r4Tmcdhks99HBrY5eHgHYQ6nSsr51hWqVH1copMwjD
         R6Ig==
X-Gm-Message-State: AOJu0Yw1L5Hb2LuX1t5sX3qYfldH4CbuhzV6SMhmqL6y/TkOYbLIvead
	19ISEnfPj1ymZpnjU7ME7X4=
X-Google-Smtp-Source: AGHT+IHE48un0LDnENnIvmj49RY3BQYS/qjj1IT4T8V/k7ITKJInhKWS1Armej+LFz9LzsQqfAVA5A==
X-Received: by 2002:a05:6a20:9784:b0:186:bd68:facc with SMTP id hx4-20020a056a20978400b00186bd68faccmr7802964pzc.28.1704207979190;
        Tue, 02 Jan 2024 07:06:19 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id e12-20020a63500c000000b005ce998b9391sm2884851pgb.67.2024.01.02.07.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 07:06:19 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: bhe@redhat.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dyoung@redhat.com,
	eric.devolder@oracle.com,
	hbathini@linux.ibm.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	lijiang@redhat.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	seanjc@google.com,
	sourabhjain@linux.ibm.com,
	tglx@linutronix.de,
	tiwai@suse.de,
	vgoyal@redhat.com,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()
Date: Tue,  2 Jan 2024 23:06:05 +0800
Message-ID: <20240102150605.111256-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZZPMLextp0n3lwbD@MiWiFi-R3L-srv>
References: <ZZPMLextp0n3lwbD@MiWiFi-R3L-srv>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_070622_281594_EACA07F2 
X-CRM114-Status: GOOD (  33.39  )
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

On Tue, 2 Jan 2024 16:41:17 +0800, Baoquan He <bhe@redhat.com> wrote:

> Hi Yuntao,
> 
> On 12/30/23 at 06:16pm, Baoquan He wrote:
> > On 12/29/23 at 12:10pm, Andrew Morton wrote:
> > > On Sat, 16 Dec 2023 11:31:04 +0800 Baoquan He <bhe@redhat.com> wrote:
> > > 
> > > > > > Imagine we have a crashkernel region 256M reserved under 4G, say [2G, 2G+256M].
> > > > > > Then after excluding the 256M from a region, it should stop. But now, this patch
> > > > > > will make it continue scanning. Not sure if it's all in my mind.
> > > > > 
> > > > > Hi Baoquan,
> > > > > 
> > > > > Thank you for such a detailed reply. Now I finally understand why the code is
> > > > > written this way.
> > > > > 
> > > > > However, if we can guarantee its correctness, wouldn't it be better to use the
> > > > > generic region removing logic? At least it is more concise and clear, and other
> > > > > people reading this code for the first time wouldn't get confused like me.
> > > > > 
> > > > > As for your concern about the while loop, I think it wouldn't affect performance
> > > > > much because the total number of loops is small.
> > > > 
> > > > Well, see below kexec-tools commit, you wouldn't say that. And when you
> > > > understand the code, you will feel a little uncomfortable about the
> > > > sustaining useless scanning. At least, we should stop scanning after
> > > > needed exluding is done.
> > > > 
> > > > Or, we may need add a generic region removing function so that it
> > > > can be shared, e.g e820 memory region removing, memblock region removing.
> > > > Otherwise, I can't see why a specific region excluding need a generic 
> > > > region removing function.
> > > 
> > > So where do we now stand on this patchset?
> > 
> > The patch 1 and 2 are good clean up. The patch 3 plus below one, the
> > entire is a good code improvement patch.
> > 
> > [PATCH] crash_core: optimize crash_exclude_mem_range()
> > https://lore.kernel.org/all/20231219163418.108591-1-ytcoode@gmail.com/T/#u
> 
> Can you repost this patchset with some updating, e.g adding ack in patch
> 1 and 2, and squash below patch into patch 3? This will be easier for
> patch merging.
> 
> [PATCH] crash_core: optimize crash_exclude_mem_range()
> https://lore.kernel.org/all/20231219163418.108591-1-ytcoode@gmail.com/T/#u
> 
> And, you may need to drop below patchset since patch 2 conflicts with
> this patchset, and patch 1 is conflicting with fuqiang's patch.
> 
> [PATCH 0/2] crash: fix potential cmem->ranges array overflow
> 
> Thanks
> Baoquan

Hi Baoquan,

I've reposted this patchset, the link to the v2 version of this patchset is:

https://lore.kernel.org/lkml/20240102144905.110047-1-ytcoode@gmail.com/t/#u

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
