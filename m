Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D289ECAAD4
	for <kexec@archiver.kernel.org>; Wed, 31 Aug 2022 00:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9SnjdUupK/HHIlI2qFAp05H9YTa92MarzLHqiJukwag=; b=G5huSa/6FhQ5qn
	BHFRiKaZdR5pzCnWwbAWZq1PQwaA4u4fk4QxaMYmbuMRRBRFwwRLXq42WS0OX0BVh3Tp6yfs+yBop
	B30cvTbufDjphl6UUsP4Tmy2HkcZJRWF0DL30LE9arkQz+yzP9XmKJ+Msr9JUcBMjIFXYRhmztoJS
	a1ee5sBuThw+3P5LRPEth74qK8SG828z7DQkDBDNHSbwk9JONwfJUDZ5wlerJAIU21XF/aMiK4api
	zVb9uSYcIRr9hYg1wBkeXTMDrOGJTve0y2oBdJUf4cC1MQk3kEnUMH90BPyGK2LAly9TbTKAKy3S/
	CJMozRtYIbEvEMepBmjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTBkS-002ltA-5J; Wed, 31 Aug 2022 00:38:28 +0000
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTBkH-002lqf-Ct; Wed, 31 Aug 2022 00:38:18 +0000
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-33dce2d4bc8so293835107b3.4;
        Tue, 30 Aug 2022 17:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=N8Oxj5DujnXo7rvapZytc+LXQgd6/nViospKaNQPbC0=;
        b=dprPJsEs0nyRfX2TmM30zqXiIt1fakuHFmqZqLq6mobPb38GIthrMFg0P+1zdnlcWB
         z8RzGHgnfVyyWttJ9IV81fHda39EWxlKO+LZF7EjQKkg8i5VWWzZO15QJoeQIJZbYu4O
         gU0/F0JxaUZCfyMRH9EHWizrP4cf7KRFrWjaKLMECmSWQ433MCAisf71Ng2mcKcDbnOQ
         TTdKVasnrJOHmjqfULXJZwONo7O4Yak84eHQMdq6GvwhL3kFf7fKIhUtiYs4zPtVrk3c
         wy+EocniYedH74c5MRfbU+CfDUp0mrcUlm38y/k5IlYKupG4h3hDsLbFSZ6X12mDqs6U
         MUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=N8Oxj5DujnXo7rvapZytc+LXQgd6/nViospKaNQPbC0=;
        b=Vx/bm/cetMKObwyfAk3IKCCMshVn/olr2IIFtSdCh9ceT58psMO1XHNlKpDNnxKlYe
         18ka4w8JJ7uHuq5hCwXBfGu/KLbxnTE4q+/m80d5FH9b/UtiiwCP766UyY7cb+l3vxx5
         jIamrezXVh5JcfILSc/x2TN/EXdDhvDyQwzvBP+qzzpac0NVf6QFiPWQsHM+BsG9HqgQ
         D55VGv5l7uGmszYKc4xV7q/gVDMm8d70nUJ/Bp/sU8Fy2LP2Ebi4iRT0s5fVBFLEYii7
         sok+SQRiOOOI6Gp1DmnsUCkB+bQeDKIHTi6lS39F1mhnHRoWx6ioWWrCAfrVqJr7Y+NR
         JPTg==
X-Gm-Message-State: ACgBeo0z1lvfUSVexM7vdc8RqOf+o0rCt3fv5OHZ9SrNrmg2nd96dkqo
	2pwM1s8+l1vIZKciM6kVpDa4F9+gttclJb0oT3Y=
X-Google-Smtp-Source: AA6agR58rUt9NhpoySWQE301RGdtiuQIU0akoy1NmgAsJLQHKYYXLilzuSVHfq2bDR4T5R2ZYp/DUqimzetQhGtV5I8=
X-Received: by 2002:a0d:d756:0:b0:33d:cbf9:3faf with SMTP id
 z83-20020a0dd756000000b0033dcbf93fafmr15867325ywd.224.1661906295777; Tue, 30
 Aug 2022 17:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com> <Yw49m7Hpq+NIZYWw@arm.com>
In-Reply-To: <Yw49m7Hpq+NIZYWw@arm.com>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Wed, 31 Aug 2022 09:38:02 +0900
Message-ID: <CAM7-yPQjjwM_fCgojYHbrhE4GFCX22VLoCiTVkorNG6hQDj9EQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/kexec: Fix missing extra range for crashkres_low.
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Baoquan He <bhe@redhat.com>, will@kernel.org, nramas@linux.microsoft.com, 
	thunder.leizhen@huawei.com, linux-arm-kernel@lists.infradead.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_173817_474972_A87CC74A 
X-CRM114-Status: UNSURE (   8.10  )
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

> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
> Does this need a Fixes tag and cc stable?
>
> --
> Catalin

IMHO, it seems good to add two tags like:
   Fixes: 3751e728cef29 ("arm64: kexec_file: add crash dump support")
   Cc: stable@vger.kernel.org

BTW, To add above two tags, should I resend the patch again with
former tags (Acked-by & Reviewed-by)?


Thanks.

-- 
Best regards,
Levi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
