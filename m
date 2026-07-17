Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F3EC4451B
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 21:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zmfnNFiyVA8U0Zovz7XobfQoJyevheG0HUiwPSbCO8g=; b=TfhzMq8J7Gg1UHj2JwhIV6kRYB
	4EcW554wQIMnFq9/tvGae0ThHoCye+Owciy5ekomOr0b7/lJWpENPcQZz+/0OInu6iXD0DWzdxL5n
	IeRGQIx/f8y+OsYnOUGdLs//3sqS2HF+jvCKOkrGw4loaBGb6ecyooFQp/2F3YpafvMB/HY6sE+yA
	azS4QQqy1pMXMH5gg/h9efx2yP/j0i4aJc/lquzyT+slYd7WlhexLamI93lL6jmhUtM607scV1DVt
	OHPjuGl055H5XsnG46Bz/ad8ENR2ESeLbHK+swpUkiXCso5EPIPBH4yOHjuZwnMA6OCuPYw/TK1/l
	4IUAPTiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkqQM-00000003IZx-1TYy;
	Fri, 17 Jul 2026 21:48:50 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkqQJ-00000003IZY-49kI
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 21:48:49 +0000
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-51c1372f84dso47846671cf.2
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 14:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784324926; x=1784929726; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zmfnNFiyVA8U0Zovz7XobfQoJyevheG0HUiwPSbCO8g=;
        b=fAcJwAABBFdVVz182Kfy1l+HSfaNps67tIi/1rTkdHTS6VDbM8pyrHeD+pTVM6YTJS
         GcuZZ4XIEP8EDhzoPmwbD812njRyH+etEZoskjR9buutLP48p3wQG4qgZPrqD1l5cDJ7
         Ig48NyXbhv+CI5rLyhTnEJ8+Aql7JaLu609KrGnMjLae82hhhgJErwwE3vocud4JPA1m
         YIm49tG3No7o0oilv2rN0LwGDN8LyNHIjCk732fLc7ENKiG+Pshv5C/tCMdhjYea/wcv
         hCbZ29RmLsUeMeeSXvFUAMLGxZBwYEDiDblvOKrdMQTlCV/0hOTH6m52+FVX1Ivizy4b
         1++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784324926; x=1784929726;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmfnNFiyVA8U0Zovz7XobfQoJyevheG0HUiwPSbCO8g=;
        b=atniDpOjATSpTutAQ8cYauLnrb1JTQzcgp/uNyq7URhIscAqWy8hInXTGrNejHtpx7
         CiMud30Aa5KJycCsR0DMD+o/Mfr8YTFGJRcQlWQNc/g7aasIu0VMCBgG2rgdP6N07kl6
         iulH5WoWXljHnR+Z3zKgiqVsHjs8LVejfBMoLHL14poxlnbxgjfWQMmSru/W3CAtxzNS
         etz0Km9rMiPcH1+Yt50FiXdu0Qqz3HT9eqa/AKfaPF2sfbWAmzQ6vAsA8okvMSq2vlOA
         JPHrQm8XtD2BhuTBYrlGz5eZ2J1YibWkQAyv8xG+cGNnLg00SX13mub1/SJA4adOny1w
         xlHA==
X-Gm-Message-State: AOJu0YyiRJPVf0d/ZyAxngzN0U9RUKVoJOUeY+IxqYR1b5kpC+atpPIf
	rktfs39DTc23EtDU9aXruv0p93TBZRP1653x/DXw/lJWlB4j14DG1qPXpexaoIU0s0O4fE6MquJ
	JSngP
X-Gm-Gg: AfdE7cmI2vLdC2+vDDK6hRe813Bu2+6u566t23HK9QqutzgbPs3RuBo8mw44Hb27cUN
	xGXo272uSz4AvvDilW3IR9m3zTzxaBmeNpe9Ge3PZiY8yBdrPkHFe09dewPJSXSPe05mHaAtZEt
	5k6cfAvl1AwUUp/HeBx0OATSgZhy5Fc0XCXOTe6C2iaaB91tRWmafF/L8kp5t6syoO7e7IkCsqK
	5/5fzlYS+5ooFVLk43dmlCdGOBexQ8KAOVz72lPwm4Jd9AlkC7sHFXjtpsfmsp1aiaUSxWjv39M
	GW/BYc1qaamuI0QvT4X3vAHJAs/vYeHNNac7urbuFxoBGG+7PLfOo7s8lylwGfYND0smlDt++Q/
	ajdqUjstMTkqAwuUwrgpIEvK2w6ZSPxCakcxrggEnkp2x7IE+C4FHX63YzA5oLRaB51NtA7EWv7
	3Epg9F0uPtgzjObmrEWJW03tchSwialwWX4Zvptnw=
X-Received: by 2002:a05:6214:4284:b0:8e1:694a:73d7 with SMTP id 6a1803df08f44-90778380e0fmr48191416d6.24.1784324926660;
        Fri, 17 Jul 2026 14:48:46 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907786f79e1sm26338696d6.38.2026.07.17.14.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 14:48:46 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 05/12] PCI: liveupdate: Keep bus numbers constant
 during Live Update
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260710212616.1351130-6-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-6-dmatlack@google.com>
Date: Fri, 17 Jul 2026 21:48:42 +0000
Message-Id: <178432492211.189683.10563224295975168718.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=934;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=496HIZ5NHAZVhZ3LL7qzsW0iuwhuVPP7StMDlrFgMMk=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWqM86KaHlniHcC84sbvvlVrTWaav3eU4iNKDj
 SHnfSycZhyJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalqjPAAKCRC7dyhM23N6
 3pAgD/sHtZxz2X4+/Faxm+h83v6Zqb8OrDRH1Mq0Fu/Ty4wrIDO9AUyUsVw70fA/N2MvHxp/1Xp
 KSw01NVB4QDW/o8OkXnordoL06ZSPy/CN8pA4ibrtaW5GTXc0HvVn9XjzLb5TpkRvVQUFoDZlNy
 xqZQfN5QkA5t46L/QfCx5fVPGdFvvCf7gpOQ3aPXbygWPYWSjBL7i6noJgIm8o7tHCxqOCtmJpS
 KLj9FwZbnQrxac6ZagR1+sP2hfHfTsL07j8Xkw3dqdwDw76uuBV3ulOvMvLHk3xJiU8BQmb57po
 lsovpsci8MA+2Nd5qdOYySDGKbbyoTcdUVGqI7ynPmbWL2z6/i/AoYW1JgUN86kg2moCic79wqs
 5LjPhY13xc59vZIJn1Xcd+9qdGgfK5FHgXJ246tswyKVxFHB0Fom6tFgtrU/3QwZeD2Y9dcSZwd
 UJP391ZDKWNhdRK1FDFkE47jOg9y93FaurAyMhna+kJORxVLU814KM6CtBCoIQAwjPE3q+SFwKK
 74v4OBYVRxM7McuhNVOnSHLnObJdMRoYfVJheKPIHNs8V60mCzqr8vQjLPpQVkTZWWxup01Mbxq
 yaOhEnGzX9FrYRbdujMNfroiOD9ejkFN1MRBE6SzdTWb4+cRb6JylvfqUF3OT9qHkmHG5WBvAYM
 euocaROZ3nCR11w==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_144848_047633_B5E60BCC 
X-CRM114-Status: UNSURE (   9.99  )
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

On Fri, 10 Jul 2026 21:26:08 +0000, David Matlack <dmatlack@google.com> wrote:
> During a Live Update, preserved devices must be allowed to continue
> performing memory transactions so the kernel cannot change the fabric
> topology, including bus numbers, since that would require disabling
> and flushing any memory transactions first.
> 
> To keep bus numbers constant, always inherit the secondary and
> subordinate bus numbers assigned to bridges during scanning, instead of
> assigning new ones, if any PCI devices are being preserved. Note that
> the kernel inherits bus numbers even on bridges without any downstream
> endpoints that were preserved. This avoids accidentally assigning a
> bridge a new window that overlaps with a preserved device that is
> downstream of a different bridge.
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

