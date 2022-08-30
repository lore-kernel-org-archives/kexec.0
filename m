Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919BFECAAA1
	for <kexec@archiver.kernel.org>; Tue, 30 Aug 2022 08:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NkLTDlpfQ2rg0U6/Bq0Z7QseK04SDXCQrrSPNW5mTSY=; b=vM0CidvqRg1oUI
	9FOwH1svDERr+a9lFSZbvFNmycNqhEf5dhj3+BLCDTrjp7Q8V0lQ+4fuSmYKPjRnSOCu9Z+6jVCgj
	g3FvDH9KNeIOJ8r6rxefhe8brr7ceH6/WfB49JHRlbtbfAGwdQ7Z86f9XXTbC0CklwBBqTI164gLd
	i4KiCNcJHou8Tty6pMBh4dKoRL9GWNTGQa4LlrVv3iVsDm4whp0ZZNZ8mDquCCrvsjQsnZFU4RSHV
	mEH3ENUnULXV6vNwxGhALgmk2vskiinlyCchehD5FZdXLEebYPctxtayXb+dIVuzr6/zxeG1f/FgP
	3DwNxODm0sL2IrUYvWlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSwec-00FEQn-6L; Tue, 30 Aug 2022 08:31:26 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSwdw-00FE8t-Dp; Tue, 30 Aug 2022 08:30:45 +0000
Received: by mail-io1-xd30.google.com with SMTP id d68so8615892iof.11;
        Tue, 30 Aug 2022 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=XOQ1w4vm4/BAxEC+jX3EtH/zHfW8KGtqf6yAkxCZrGU=;
        b=gcdkuigXVR/vglMBclXyxN6RKU1Cq6mDJqZck+kETu/wpBTgNg/NLwx+KVkgCiSTCa
         QnBaQMICJzda/l5FgnBEN6vk8KZoN0e8/6hW9nr8bmr+HdhOgDcbvfiPhxFUM096SsmS
         aabZxgI2yDhhk8IJbABimf9O4pDaxkZX/0ALC4cYNyQ+zGbklZQGJzyXqZ3R7fL25aCy
         hZvKl/PKJdoaLepvAWzauAspBgUcRPHodvQlaFu7cnJIapB6zTnDwwL4sYT6Mrlmjuj/
         D7i6BlTAiY5oTQsrDib61dL9iFaqWDAsIcuyaBPXxSHYgDEEHctyEMnoH9h3Aih6Oif4
         MIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XOQ1w4vm4/BAxEC+jX3EtH/zHfW8KGtqf6yAkxCZrGU=;
        b=MYJagrdxJSA7SotMumCkpOVOczZEczqidTxv4JHkQwsOVhd3k4jKlHqCWA1qTx+kdE
         YO1V7hH8PbX6ELbgBt0Jwoz6IEl+CrktEFqsBBpgxCh67oS7yXwHe5i04AhV6J+RSeBP
         Xu8l0FuBPq+VXHi9m7G2dw7v0B7KxPmr079P6bPUINoq5IdcVrx2Vc5H2ZNpUxVWNOH0
         ORsDfuiiW9b9/diUtj1DrDKQx9wRb33kqr9GtGtpqjrAqMT77v4z1KqCPIl9pnObmFCN
         5LtW+1kvAsqSLeSxnv6QlkQFvuAuR+PtqjJHDCLx3pgPMS6luJUMDZ9VCOaKSRIaTJ0V
         jmrg==
X-Gm-Message-State: ACgBeo2ZgQHAUN27VIBYagXG1eLecYTEgGmYdiHe7g4Y+a5r5pxkciXw
	CG5yYdAgltz6smilGyvSYHjPfJmj1UQ42aBFE/4=
X-Google-Smtp-Source: AA6agR6MMrtKGn8FUnHIBa7I3kqhhl++k8Y3Jd9D30PcbuoGF4u50BtNrbh/zQRgOvad1+8DaTFKulwW2xYhi2TMrIA=
X-Received: by 2002:a6b:8d8a:0:b0:689:4bb8:d59e with SMTP id
 p132-20020a6b8d8a000000b006894bb8d59emr10535278iod.16.1661848242253; Tue, 30
 Aug 2022 01:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220803151217.75962-1-ppbuk5246@gmail.com> <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <Yw2+H9MNpf3Ve0eJ@MiWiFi-R3L-srv>
In-Reply-To: <Yw2+H9MNpf3Ve0eJ@MiWiFi-R3L-srv>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Tue, 30 Aug 2022 17:30:29 +0900
Message-ID: <CAM7-yPRoBofD9+avRj1SH_GFogAnmJ7U8jJjbViH_hgOFBTX0w@mail.gmail.com>
Subject: Re: [PATCH-RESEND] arm64/kexec: Fix missing extra range for crashkres_low.
To: Baoquan He <bhe@redhat.com>
Cc: will@kernel.org, chenzhou10@huawei.com, nramas@linux.microsoft.com, 
	thunder.leizhen@huawei.com, linux-arm-kernel@lists.infradead.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_013044_509323_F6FEE10F 
X-CRM114-Status: UNSURE (   8.04  )
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

> Right, excluding crashkernel region may cause memory region splitting,
> so we need extra slot for that.
>
> Meanwhile, can you fix above code comment mess? Otherwise, this looks
> good to me.

Thanks! I'll remove the comment.

> Or we can add extra 2 slots like we do in x86, it just add another 16
> bytes temporarily.

Agree. I'll send the patch again by modifying nr_ranges' initialized value as 2.

Thanks!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
