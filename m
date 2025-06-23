Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF642C77B7C
	for <kexec@archiver.kernel.org>; Mon, 23 Jun 2025 18:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bTZ19GRi4KU0H2wNqBnaKkKrv7m6rpdyKuL2QkFh6uQ=; b=l2vfYXPqEPA8/ZZK2gWOF9vVUc
	qKZmiiOINfM9yF2OJf5CSAE0aGWHK8UYckF+YIAo5t0PJt8a0XVvFQJui/QGYd1AY0em4r5LduiFO
	cpgOoz68iXF3TM2cyyOBSmUrzYrRU+K1rC+vBk2xp5lyhamxX3LLtMZBVdznMqzY49oAr0fspN6Dz
	PJpIdE7//CSaUkxxQQIV+V2lqfJ/sXnQEu/4CpgXrIV4mOylDVNuvdUPH5xZc6OXLOtnu0qr/O9Yj
	HGQieIEkNkn89I7lushSj40KLyaMy8FQs+mBYXMVk+b4fIyjMH7e7gxLRzO5TOXWR59J1sUESJs16
	JJXbyMvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTmOL-00000003lTB-0UIU;
	Mon, 23 Jun 2025 18:59:41 +0000
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTj0C-00000003DKS-0wz9
	for kexec@lists.infradead.org;
	Mon, 23 Jun 2025 15:22:33 +0000
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-610cbca60cdso2800744eaf.0
        for <kexec@lists.infradead.org>; Mon, 23 Jun 2025 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750692151; x=1751296951; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bTZ19GRi4KU0H2wNqBnaKkKrv7m6rpdyKuL2QkFh6uQ=;
        b=vPXeFlloAyro7eNN/glV0luon+iO14xpG5V0HeGiuv9U+nk12FTClKXo8QsTc1ysMc
         GhyV4pMC67EQO6QjaE7eL4zoKv1X8B/P60ci3Uaumhq3hFy0//d1i94RooRxXGjzas4V
         xn08sheT+anEi30mfsBO4peu4IHeiSmZJ7xSPnBSfjhWZVHDE9n/pT7xULsmTunJuac8
         kN1/wP2x+1pAVcP1QeMC44aYrZJgUmEaRaeby0MkDKPsivC93xZJwtmTRcr/AlTh/Pez
         6Xs/ySEtNxPH2YjrTBB4gSaAr9lmTMkJbxjwR/1DdRV3lDUoTDryDLq3WnRgi6VRFwtC
         oDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750692151; x=1751296951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTZ19GRi4KU0H2wNqBnaKkKrv7m6rpdyKuL2QkFh6uQ=;
        b=Pu7bF4tg7I3wATJJ5G3GNJoPSvD7SDIgQkwfR8lK8xYp1XGH5w8IrSuGmcbpxf068y
         P8kQJ5Hpq/8NtvNl9dWwaN+GrO8cs5cyMCQli/YE3cyLgY/fFA29QzEXSb9ERkKicCOF
         cegoVI9T19FP9gOfWQsX2alorwKQXwXTMoBKemPa7AuwSGgzE5hU9Q4Ik5ZWB0nfCHac
         SuqekRYyklBwEpAugA2/TKPuUezRoXnFC2R0LEH3SlJmAUMXwJRWKmU5RByGc66LifpY
         jaoTvKl+5svCfjg4ZExPE/4EzYNl+p/XCrMkEG5Fl52fHEnuIZUByBNG151OPPA/O0vP
         lycA==
X-Forwarded-Encrypted: i=1; AJvYcCXG0n3FP5lT1cARWnRI0B9JJWX7wuNF17q3OYCuqAmo3CRzAEbGr8lXwYvKUqyqqs/LyiyVnA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwME8/ATzgksZenRsIXrZqEFMec2kSm0MuAOokchliDmyHu+nhJ
	2m4VY3DID1dffmFNFW9UKoscvRQPn6DsxHm3ofv7w1dK1fJHJAAUTpzDtKge4sHtZrg=
X-Gm-Gg: ASbGncsWnPBI1xbHBd1a8ZN4OvCST8lGql2VHGojtlvbTuoFZw0g5lo+eWiU7KOdjlH
	eDPdnn1yXYchA/CWnLqvgYmf/MhXpQUv6Kqy2fnYuKq6joufNvnxenYMixYrlpCl8Zvf0jvjkdn
	IRolubYCwqUKWA9FsmNI3tk1cnCPapXaLIckXL7Rgn4CvHt4wPCn2+/ZksuN0RBp9iIC3mwTFOD
	TEaqyrDuAN0ALFmxmWEvunsm2WqO4s9LyZMmPIIiDP8xn3OpW5T+YvmuAR7b5RKjZiJp7B8q3ag
	Tdi/TuPb9JzNQX/sZtN/zPuH5zVhDijgInKSM9JNiIPLTaO2EtToNHzE1OJQwIPacChJVg==
X-Google-Smtp-Source: AGHT+IFkGyVDoc+8SQ8rASYfcEKGGB/Oc5hw+KdWNqGCuf0XX49CDwKCA3KtlNIgbDKU0n0iNbw/gw==
X-Received: by 2002:a05:6870:392c:b0:2ea:8091:41f2 with SMTP id 586e51a60fabf-2eeee55c8cemr8102044fac.19.1750692151278;
        Mon, 23 Jun 2025 08:22:31 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:8c3f:8b5f:5c74:76a9])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ee8a8e5eb3sm1697426fac.32.2025.06.23.08.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:22:29 -0700 (PDT)
Date: Mon, 23 Jun 2025 18:22:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Baoquan He <bhe@redhat.com>
Cc: Su Hui <suhui@nfschina.com>, akpm@linux-foundation.org,
	vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/proc/vmcore: a few cleanups for vmcore_add_device_dump
Message-ID: <d60db71a-0b4f-4e7d-8c06-7493934aa507@suswa.mountain>
References: <20250623104704.3489471-1-suhui@nfschina.com>
 <aFlmfdajTOP5Ik9f@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFlmfdajTOP5Ik9f@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_082232_263687_A1F98CBA 
X-CRM114-Status: GOOD (  12.36  )
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

On Mon, Jun 23, 2025 at 10:36:45PM +0800, Baoquan He wrote:
> On 06/23/25 at 06:47pm, Su Hui wrote:
> > There are three cleanups for vmcore_add_device_dump(). Adjust data_size's
> > type from 'size_t' to 'unsigned int' for the consistency of data->size.
> 
> It's unclear to me why size_t is not suggested here. Isn't it assigned
> a 'sizeof() + data->size' in which size_t should be used?

Yeah...  That's a good point.  People should generally default to size_t
for sizes.  It really does prevent a lot of integer overflow bugs.  In
this case data->size is not controlled by the user, but if it were
then that would be an integer overflow on 32bit systems and not on
64bit systems, until we start declaring sizes as unsigned int and
then all the 32bit bugs start affecting everyone.

regards,
dan carpenter


