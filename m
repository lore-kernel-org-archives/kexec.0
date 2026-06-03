Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A45CD6E56
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 04:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ney92uXq5bGcYqCxhmX01w64N6s06srEZG2O0KRnUGI=; b=F1z76xbW3aAClXV37E7KswLDAy
	A/EtyNsJo1rDZVGcPp/wEHYAqV9DF+01v6hFaxpkFFqSfdpSlj4vCqmV0/jcq/CVIMJ8DkaobDoXY
	VeNocPPKsXQnR8Gg5tLW6MHeA2IYygtdABmzUKQ44eBCLGv+DKH0dWMiwDFNGbf3hjsSKEbPzhk7m
	jvvXBJkHAaO2+9GhO1OshnfhEdN31MpSL4confHXjoWFLiRgVyfhked0IpX2DWM1CGOzmChT2068C
	+76Mg9ojAAhl1jcxyuqw6FW93MLeARWopcoG7wuq+ZzstRcib4RRMjXb/Ww8ez+4yvaCQ/kPpx2Iw
	1FeKL6fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcoq-0000000EENH-0doD;
	Wed, 03 Jun 2026 04:03:04 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcon-0000000EEMW-0hyc
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 04:03:02 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-8ccdf8d4ac5so55875876d6.1
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 21:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780459380; x=1781064180; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ney92uXq5bGcYqCxhmX01w64N6s06srEZG2O0KRnUGI=;
        b=PEu9OLJv7JAxRnfyru2J0j+HDz0SFPsSuMoT3GtGRlQnGdKSPXmLNpt1dtX/uOvi4N
         ywSrhSZu2z1Ai39ytxvptotSFH0pXcJ6e7rliDRy2AzHucnV+MUu3wbVmaeYX1LORQXw
         ve3CZTHP7vmHy0OUOS/C32exHwjYRh/hsB5x0rYf1s5wic8GaeOge7gCS3eR822s0K0f
         04ir2PCH0LtL/4IkksfkvDfDI24ouaOeS962B/goyWK6gA9VTuZvpzJmg6KevGtUA1G2
         HoIwR7HQS/+6hTa8/aO/eShsoVegtYy352p+PayIG2ttRuBGQZMg4/+9xmPwKkpKd2gf
         AnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780459380; x=1781064180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ney92uXq5bGcYqCxhmX01w64N6s06srEZG2O0KRnUGI=;
        b=rUG7xWjSS+KfSvZWj2rDS38iVMBrr7HzPl3ZiXUsvxyMfGRpM1H/Ea0iQFBMAq7aKX
         3khOp/ZR1rY9s0WpWpppxLWN0oH4eCM6fbZjT8yQ+mZMgtji445jPgsT7maFxiZWufMg
         1y/FtCCJ0As0pxLJM+EHdJw7l12MecqtTDedK9Ugs3dOUQnRrG3/THqKdg0Rh1Y3vav1
         yKK338S1f+reXfEfVTEZr5Ri96AyY2manf2+v22PY5ztZLYF06iBPLtlBSki2QrZJVvy
         A8Z4muVqd09s3igXk/6IRdNQYxvlvVCq54RYaOWruKoix4nuH85zBuNmi2PLR3VgsRZZ
         nr/Q==
X-Forwarded-Encrypted: i=1; AFNElJ93p//pEn136k01UQOzwdF5xuPn1dt4L8xi3OZb1h+m5jK2RIBn4eVUgYv3e6FLjqEa8LLldw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxeeHisv+a/7R+tVdNZ4EkLTL6UaI5gUfBIt0Dq/cShF1x1Tpch
	3i6la00WjiQAw1ONMLW62rFq64mEtdaRuhAHKVSd0rtmx6aQmXUFaMwIdjkopHEFwwg=
X-Gm-Gg: Acq92OEQadie1n+B4FsAEr0w2nm0LLf1H9Q08NalidPoiQ5FM/5CY3RnEiw07vK9WU8
	et1sjwoabKwS0on0omSmqis63GCp2G1QjHbihtDHhoQl1Vn2AFqk1BiJMosBcq7L9MLhdI869wM
	xtMZBCN5B4k9J9c0FRss2xajg9FWMS1YsbUing6KD0rOnWMOcYsmZLkjswhm2QmZ369flqf62Cr
	nTH0/7UOzAleWDpIdfNTMajI0W0zyUBfMNXzpLakWJA/mkFATrha18zT4KN10PBwkGqoB24PzSd
	PVCvYAClBmNBGRJj3gw85omwA0TbngP6UeMDD1K9gimYtaqRGZc3s+1oM301cC9xee0vWNZUTLY
	IfA6V+15lsg+S2KJInqPr9WJ+I78PDkRgQc8YSTercoJHPP/yrd8oIYBn7whdds6z+SNzjjEGop
	I0hqMHMf/qcHLCwtDDrRbt8olttbh5pPRr2iDTzn7cgu8PNeTEzLqGL801L4RyRw==
X-Received: by 2002:a05:6214:dce:b0:8a0:d08c:a720 with SMTP id 6a1803df08f44-8cecde9cf00mr20874956d6.17.1780459379919;
        Tue, 02 Jun 2026 21:02:59 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd2682f8sm9802926d6.43.2026.06.02.21.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 21:02:59 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	kexec@lists.infradead.org,
	Michal Clapinski <mclapinski@google.com>
Subject: Re: [PATCH v2] kexec_file: skip checksum verification when safe
Date: Wed,  3 Jun 2026 04:02:38 +0000
Message-ID: <178045911488.348018.9577276078419028102.b4-ty@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602123311.1841746-1-mclapinski@google.com>
References: <20260602123311.1841746-1-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_210301_213459_476552BA 
X-CRM114-Status: GOOD (  12.69  )
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


On Tue, 02 Jun 2026 14:33:11 +0200, Michal Clapinski wrote:
> Checksum verification is needed
> 1. for crash kernels. In a crash, we can't be sure the kernel is
>    intact.
> 2. if we're worried about relocating the kernel into a region used by
>    some DMA that wasn't properly cancelled.
> 
> If KHO is enabled then relocations will happen to KHO scratch, which
> is free from DMA regions.
> If we used CMA to allocate segments then relocations are not going to
> happen at all.
> Therefore, we can safely disable checksum verification in both of those
> cases.
> 
> [...]

Applied, thanks!

[1/1] kexec_file: skip checksum verification when safe
      commit: 459a08d029bf6f026b25063708a63bdaa8ccc0b1

Best regards,
-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

