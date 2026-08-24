Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB659C5DF81
	for <kexec@archiver.kernel.org>; Mon, 24 Aug 2026 20:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dDQCrhRKJv1CgmBzHk5DV2Zi2hk1jJel0LnyJEuda+g=; b=3ChKWyjhHT3SrL0JciPhmJjmSM
	tcozSVac3uQptJ9iLoASbqxYgbKvApT1ceb7AXG1A0TNnhEMT46Af5Gwn5MHthzxy0QrJo2cb9mVp
	K/Iu09sSncNv+h2iVWVvLobEYA5vLWhiClR2cy2g3xD9hm8xvaitwuXnFXS1Ci2VsIHWX3Ce3O8oG
	P5Wt9U9SYydjQNsfv4BTYfF8QWuL98dFyi+ZtRmLzj6qL0RFHG9XfaWv3+GcAYalbGmh+kKlEmhCJ
	d+XI/5v3DjtIKsIEfmEPk6dgIJ8hi5BRk7PVRoaq9zliUr3g5t/L+LWsRfuXSvBVkf9ZMf5p6ojLS
	/uW6ENHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyb93-0000000HM57-2sM4;
	Mon, 24 Aug 2026 20:19:49 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyb8z-0000000HM4X-1fwo
	for kexec@lists.infradead.org;
	Mon, 24 Aug 2026 20:19:46 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-51c2cce930cso40610771cf.0
        for <kexec@lists.infradead.org>; Mon, 24 Aug 2026 13:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787602783; x=1788207583; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dDQCrhRKJv1CgmBzHk5DV2Zi2hk1jJel0LnyJEuda+g=;
        b=YQLzj5Z6wvQVe7gXw0Qr2xy0gK9X1xtE/81N0ffO2NEENpfezHJM279YN2oT6OwfYa
         R5InJofy+BJ2AbCOpRU1es3kRCdEACwbmk7/xruOP/1dy1oYJMD4+7fgaddl10DmJPkG
         CLeuER6kgWLUl5f2Jc3kwbtT/hzj74BnWOyHGI19az+6rouPU3QuTldpu8aM0MwjbYMP
         CAu3ckN0Lki5VGG6UY3VX5xdB8sneMzSZjNVM4zCLhiex3plbJIaT5Tb+9+JGFqeOkTB
         tbq8gSLLEQJdoxx6pgtZKjBD962C79RrTpKc7sEXxBuHvheGtkBKekmiMc9DLot6AQXy
         W82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602783; x=1788207583;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dDQCrhRKJv1CgmBzHk5DV2Zi2hk1jJel0LnyJEuda+g=;
        b=Y3+6SRfEoV24QMfF/SFCZkl9gqQF/0keDXOlweFZQs8G+UrEIlJnG4+mhsUz2FOZqt
         aYJmfLELjZbeHVnZoD1g+jUyPdilEb3qXDPGXerBDD/5J2jkihGi0nlY1FL2YFWRJYzM
         bw6vCBf+KUqODcTOsft29N33TE55m4iwWa2iuQ/fSWanR+FWKSYQjAtvmX+sfWSmQ/Bw
         goKUG9xgw/zeZGDo+ZXYldslXQFzdFQJY3EFzcsho2CSNnqwGEosPcwgSBCAo73sF52w
         31laWCPgW8NC/54GjU8pA6pBaMAfZZ9m5OA3byT1EEEgZLewLJ+8IFaBck3e2h/haUEq
         99lw==
X-Forwarded-Encrypted: i=1; AHgh+RoHtlzP2qIYNvzwUm7zHEk1pclGRMoOJufOokr8SuoLV1dIYSCTk3HvTPBpaZQgPy5zK3iEQw==@lists.infradead.org
X-Gm-Message-State: AFuF++muitkXuAkApKeutLvv1SrOfXjGPBoPRn5qN8b87R+XPKKYRheY
	41p/g7cHaqBYXn0MtJzAw1e8otgtMnMnXQ9XlSe2nDoCXapJp74/819O
X-Gm-Gg: AR+sD11cfG96eSJS8FWhgpeXQjLspsDvkMiDMn5SJLd4RVASNE5Vhzp13MT+P6q9S/M
	i7YI6J61y6Az52rp61H8CrGVJ/5VpO5IOGr6I5TJXSriq0qTJeh7kxfLkGqZ/QQV/kMPRp+J3Ux
	ikh1+dzQIK00hEfQxIBG7UzFhWkGaGcnT0iFg2eZ4wckXtGtCQNVRreP4FosWJDJaiv5XOJjYI3
	7RXfll/tBlYpryYOmo9oVnjCDCQeVAsojtsZdZjCZM0PWZVN3vNTaQyRQV9CjH7+hsoyykmSbMo
	er8Xu349SFnxRlVke8VxSiHpxo2NB73C3+Cy1Duwm3nVgkqVctKm7hCNEdYOPVeZtvHO66GG2vf
	9XPf1xQUXcn2WRQPbUbRVhBxg4tKvV6c4rMKwQC1iCHpkneyf2sImE29arUOX5tvfihTn4Y1/tT
	tXZSy6Wps+OcCr9YW/Jqd8sgwL7We/HjF6VRvTDTusQXUm9rW1oUvjIvKVxnRL/T2arO5e//O/f
	k0BkdbknPdbiwTLO570Q/4=
X-Received: by 2002:a05:622a:1f97:b0:51b:fd82:22dd with SMTP id d75a77b69052e-52e2f092d74mr19871991cf.15.1787602783060;
        Mon, 24 Aug 2026 13:19:43 -0700 (PDT)
Received: from CW-D0XG2Q16P7-L ([2600:4041:5d54:8900:65b6:6c48:5883:571b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c939332c0sm69720456d6.28.2026.08.24.13.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:19:42 -0700 (PDT)
Date: Mon, 24 Aug 2026 16:19:34 -0400
From: Maxi Saparov <maxi.saparov@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Evangelos Petrongonas <epetron@amazon.de>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, sdimitropoulos@coreweave.com, 
	Maxi Saparov <masaparov@coreweave.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] kho: do not reserve scratch memory in the kdump kernel
Message-ID: <aoylgHzZKP8av1pN@CW-D0XG2Q16P7-L>
References: <20260803193938.8778-1-maxi.saparov@gmail.com>
 <20260811161857.3096-1-maxi.saparov@gmail.com>
 <aoF8zPXiKpjt2Nsv@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoF8zPXiKpjt2Nsv@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_131945_442974_2FEF3ED2 
X-CRM114-Status: UNSURE (   7.60  )
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

Hi,

On Sun, Aug 16, 2026 at 12:03:08PM -0500, Mike Rapoport wrote:
> Hi,
> 
> Please don't send vN+1 as a reply to vN next time.
> 

Ack, sorry about that! Thank you for the review.

Maxi

