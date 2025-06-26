Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC30C7EE32
	for <kexec@archiver.kernel.org>; Thu, 26 Jun 2025 13:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QZlXkSD04zlKolE5r+OxRCc3dIBq/n6l6fhQYaRGqmU=; b=Xw5aciajqFzkSAXnCYL6+P7sz+
	vl+7pPHnCxhatwirHwHmWN3Icjw6RFM7creB+1cL/A1sAb+xVFRySnZnuCrtZlgwK8vKqrUYl4o7/
	ZJO+nSuMFzuKccB2CZATB0cEgMiBpAJxNXYf8dHLNAUE/7rZckiwAs3Za+SdwgsbisVPYjXUXBOA1
	u5Wcikmhz4PdLoHGEpYneQqbHRfaTYt68/KTmIAX0q/95Szf6n5HRKUzGYpt8e1UpBxMjuvplthcA
	Gb27p8vuEleHR6gjbYNktEZurI1VG1KWMwWMK7eXUoFeL8/FUDz3bNY9uYDywy1Bi44KUXT6Nz2O2
	z3ABWxww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUmeN-0000000Bfjf-46KD;
	Thu, 26 Jun 2025 13:28:23 +0000
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUmas-0000000Bf0N-1FCU
	for kexec@lists.infradead.org;
	Thu, 26 Jun 2025 13:24:47 +0000
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-2e9a38d2a3aso896142fac.3
        for <kexec@lists.infradead.org>; Thu, 26 Jun 2025 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750944285; x=1751549085; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZlXkSD04zlKolE5r+OxRCc3dIBq/n6l6fhQYaRGqmU=;
        b=QbIb5Zm0jDcprEtyHaWvMC0plfN8h51lkhoyLaWPfKpGbO9Nn6HuKpkWClvDSLdiA4
         lhSeZBzyZaBPNLdZN+eSR+88q6aICyljoaQ9x8317mgn/HrohstNbKnBamK/CnWAy2e3
         uUPKKzMk5pqt3sSl5yN7tadO3z2rTtJpNreSfTUWr9haRV5yD2o9aZsnaY/MPyYqAcUm
         E2WeGtCaw2/eL9yky2+6MlEsWwZawnUGwFtF/et25L2ypcbDN/YKDBSq9mEoPu1ppmB/
         5fYxnGwo6S4Zn4n9cI3GI9Vmc/kUDKWF0qfUj/jlRGJmoj3U97HxiPtdZTfHacPfcIMn
         oRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750944285; x=1751549085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZlXkSD04zlKolE5r+OxRCc3dIBq/n6l6fhQYaRGqmU=;
        b=I9mBQ3n32FbqwoXymweeyrI4ux60Is3ZV2aU/l3G0D2ZtDdbIEFFc6xbt8NVMoQILP
         51VMpmi0U9rBJrdyMLiO60n+aYtelfXIQnZuiZYtSAm6esOnjVPvdvimKZMhHg1dvXRs
         mNhJhSL6k8PTcBuGnc7XmEqOJB25QE0yvtsFTCHGZVYaQyWKUItWhOtJvQbqFxA7pJ69
         qfd6iXufC6LFAxz2XVoJkPuoqFqJeWECjrVO41Ck8hUmj/suzId2Q/6KEKX81wJCsmv1
         wjJ7qEF7Neh/H6mXAFeOZmM08tx+4uxS/xSqay51//FcEXKpuW2CefTxK/2lUltkYsEU
         D6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGmV+kpvhSQOV+5gkTy5owPe2nrn/pzZvvjCnSGJZEu/mI1qr8KADobXmY09RmB6g2eSMcPA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzSWFMbE5fu5vUWPKrnb8IichY1z6WF74FuaalP/hjSZ54otoR6
	hs7ezx1HxITXCdD88n3Om8cRiVh345xFXXnuZH7Fie26iROzYESTEpXZ5RI+KPOR2gI=
X-Gm-Gg: ASbGncslfJ5ptaAW7Oq3D+W34itOn3VeWkWFRyPrqN9NbDOqAek5uUZGk9ebuIB6II9
	ETRWGBzx4y94WzYo3Jk/Cqc75c6JtMHzegDM+4RFNTxoRTdN1fP8V/L9UJZj4e5aOxcDd8Vm551
	I6/PcgmPlIMwO11PdDLHg2t+2wnoKP8Qre2EG9gne81OcJobN+po5ZXVzJSNQwBUmLKWCbK4XUT
	i88aIMg/yhE/+8BC8MJvdh436Jh9ILua0DVve6eiA9yplrpOni4eW2OPvi23tYZnZbCmZkV/h9c
	FXHEclN1kBxAawXJMKw2O/YdlJbYmJb+LOaR0Ip75sMMpvkfgZ191UL5U3Ts8/49sVI=
X-Google-Smtp-Source: AGHT+IGHmrXQmGgiM1O4FMJI4ioJnomDeQhk1q4uAMvdGJQNa+bA3kRfvZeSRk6fLbxwCVrLnDbVRA==
X-Received: by 2002:a05:6870:898e:b0:2e9:11c9:1093 with SMTP id 586e51a60fabf-2efb27ce26dmr4871522fac.31.1750944285390;
        Thu, 26 Jun 2025 06:24:45 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3ee4:904:206f:ad8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a90c92150sm2575206a34.39.2025.06.26.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 06:24:44 -0700 (PDT)
Date: Thu, 26 Jun 2025 16:24:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, vgoyal@redhat.com,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] fs/proc/vmcore: a few cleanups for
 vmcore_add_device_dump
Message-ID: <e891bba8-9f67-47c6-8f84-a62abe35f837@suswa.mountain>
References: <20250626105440.1053139-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626105440.1053139-1-suhui@nfschina.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_062446_350685_B45CD034 
X-CRM114-Status: UNSURE (   8.50  )
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

On Thu, Jun 26, 2025 at 06:54:41PM +0800, Su Hui wrote:
> There are two cleanups for vmcore_add_device_dump(). Return -ENOMEM
> directly rather than goto the label to simplify the code. Using
> scoped_guard() to simplify the lock/unlock code.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


