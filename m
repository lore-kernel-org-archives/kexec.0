Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98710C55838
	for <kexec@archiver.kernel.org>; Thu,  6 Aug 2026 05:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:Date:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gkqr2GZb86x9tP0LnxOy+56n+S3UugpLCf+3RJbnTVE=; b=ASHBPTrhQZUNP/Ohr4NzWqO/Xy
	7ah+m6TuOfbtpF0CGe+ZaPa182scX4+sOI9TzKYIfFx2wA7HF0pRV4qfgFHggDqXHXfuxad12NOdY
	iPE4PBY7EUy5c64bqk9YsmiMguTAAiiCWni8twTKEa6cLXyF8XAbuFHMjo5KLOyzLJgOk6yieah6t
	JzpoHVErarRevSKl6YMWStJHQt22lvLp+a+xZJ6/Q8O9BIFg/9TzIjr/yJJta+7c1tKSrEoA9Cnc5
	n/KJG791RK4I66WkIVT8lJCAtpp16C0XpajbTKjnJ7ZtposOKtiP+RpdoVX+wUObBHu0NbOzETru9
	wsTSpAsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrqgD-00000004zDy-2WXb;
	Thu, 06 Aug 2026 05:30:09 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrqgB-00000004zDZ-2gKx
	for kexec@lists.infradead.org;
	Thu, 06 Aug 2026 05:30:08 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2cab973140bso24970265ad.3
        for <kexec@lists.infradead.org>; Wed, 05 Aug 2026 22:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785994207; x=1786599007; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gkqr2GZb86x9tP0LnxOy+56n+S3UugpLCf+3RJbnTVE=;
        b=aGEWvBdrm2GR+Hu1Uwbvj51ECTiOc5uAVBc8ZMa7rQ0b1yw7gg2S1P6FpIaPHVZC1t
         xvmjdtnEeuKvr2euIKNwOnuf5abtkWNGMYQITsj7cvPNHG2FJNdWwbovHuR7/c5o0ZXP
         3xGcd8iikLgoQz7Ihl8dT6KWA0MJePxPFL51yI4jP4jCyFxgkmxThMELue7qSPuewcC8
         cBQcvYqWpPXrBmtFlr6fc5V0RH2L3CiEoOyQeFJiELyOFWhawpi+IAJcJX0xoXxUeox+
         hOvT+CwpdsrIovcnvE0/fLF7R9uhYnGjGPvdnTMPZ4qr7OJ98S2vAKRGvq1g0Y3HV43S
         YunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785994207; x=1786599007;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gkqr2GZb86x9tP0LnxOy+56n+S3UugpLCf+3RJbnTVE=;
        b=Xl53zXsQQH1Rbk5khgYOoe4fepaFYLhxKf6zsxItNK+AvU/VEV9leF+iflxXrgqmLc
         IYT+00PYwD4K8ADVptiRT4O1ZlVZ/jNZAH2kb2GoggKbxNbiiLc1/qOr0mtGO1LAVnwO
         xkotl6JiuYJCSVlA6q6oblAMMo8QbCWxE29X4NHGhGTB7SZ26wsZjC4JD93me+VBEAt2
         6cFFRGnVJ2LAvjQDCefMuPid6YKK79sPXOi7Wr9fmBEM4PuGKdcSvN8h+Gn9IGAcV1L4
         iGQC3U0PkeN3PrJK/Hv4PRi7aRhhuMv6sxZ1IET+0lOeHJl++G8ucEiXLTUiz8nAMlom
         eyNA==
X-Gm-Message-State: AOJu0Yyp4RX/0D+g8JWpoGfPBHYJOplwjjThLAB41p6m2xcBhmAsJYEY
	BL2mcz1wroZpMYKwPnUo+UXu3v5gd7jPkfVKc/g3g4OmNkacGF5gSOXh
X-Gm-Gg: AR+sD11SVk1Os1MCGcWRxDmaM0OASRQuCOd+6XfWgNFxc2BnV3uJxfrrVBikNtMdItD
	KBFvLp80Cjt96obbzPJ9dmavuSr0+7R/UDk3ZwW5Q2LifHVFGJ+irrYTqaJJ9XMzoLOXPBnEpn7
	kn9xkGAI3t5HL2rBpfn4XtvarR7Ac9OA08weu4VK0n2eHdut1fJHsVPtsfoLp3JwP1Qv2gyS9HN
	q/UN/ag596fLg7XlP4hMeX/jp7nlOR2CPneXpqPofUkob7bn/4Z/cyASZRMSMXrDfL7Jsw+mC36
	ZchvOuVjVRX/piijsPErLTJwZX5EUPubvh9QxmFDYbf694foRl1HmVv3s8eTTr5zQ2naxW64o8b
	uTLk0Bp9SymODPkLWG6jKlwsI/Zf1iIRYr7/BbXkegOXe++5F1736gf9Od70gGzld9vJYK642fb
	fugvfJcN/t3AIEASOA4ZPOqfd/Eat2IXlMTjXNsEZBpO+QRI5Xu6gFpw==
X-Received: by 2002:a17:903:1b70:b0:2d0:cc92:f7c2 with SMTP id d9443c01a7336-2d0cc930325mr149023775ad.1.1785994206714;
        Wed, 05 Aug 2026 22:30:06 -0700 (PDT)
Received: from localhost ([2a09:bac5:55f3:25af::3c1:3f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4c911esm25202225ad.66.2026.08.05.22.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 22:30:06 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Thu, 6 Aug 2026 13:27:37 +0800
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Dave Young <ruirui.yang@linux.dev>, 
	Pratyush Yadav <pratyush@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Coiby Xu <coxu@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/10] crash_dump: Only use kexec_dprintk during the
 kexec_file_load syscall
Message-ID: <anQaMPFGyjm7NgMd@Rk>
References: <20260729033654.311541-1-coiby.xu@gmail.com>
 <20260729033654.311541-7-coiby.xu@gmail.com>
 <4eb634a2-375b-45ae-8cc0-7d5ea9f6e264@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4eb634a2-375b-45ae-8cc0-7d5ea9f6e264@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_223007_680254_1A99687A 
X-CRM114-Status: GOOD (  13.64  )
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

On Wed, Aug 05, 2026 at 05:06:39PM +0530, Sourabh Jain wrote:
>
>
>On 29/07/26 09:06, Coiby Xu wrote:
>>kexec_dprintk will only be activated by "kexec -d" during
>>kexec_file_load syscall. So use pr_* outside of this syscall.
>>
>>Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
>>Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
>>Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
>>---
>>  kernel/crash_dump_dm_crypt.c | 15 +++++++--------
>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>index 9a64e2d6841b..3ee01996778f 100644
>>--- a/kernel/crash_dump_dm_crypt.c
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -75,10 +75,10 @@ static int add_key_to_keyring(struct dm_crypt_key *dm_key,
>>  	if (!IS_ERR(key_ref)) {
>>  		r = key_ref_to_ptr(key_ref)->serial;
>>  		key_ref_put(key_ref);
>>-		kexec_dprintk("Success adding key %s", dm_key->key_desc);
>>+		pr_debug("Success adding key %s", dm_key->key_desc);
>
>Missing a newline in the above debug message.
>
>>  	} else {
>>  		r = PTR_ERR(key_ref);
>>-		kexec_dprintk("Error when adding key");
>>+		pr_warn("Error when adding key");
>>  	}
>
>Missing a newline. Also, I think printing the error code (r) would be 
>helpful.

Good catches! And I'll apply your suggestion!

>
>Apart from these two minor nits, the changes look good to me.
>
>Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thanks for reviewing the patch!

[...]

-- 
Best regards,
Coiby

