Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB878CD8C8E
	for <kexec@archiver.kernel.org>; Sat,  6 Jun 2026 10:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rI4D0m/tct5A6mLgdnGzeGFfOZi2MuVNzAsWtboD2FA=; b=qer3f/qYjzy7aAtyjaCVDyF3XX
	fJONlrsubaKwp1cueRSt16XK4gd2E8t49Mo+aZikxALyjw3vSUtMf/oVb1EGHAiR/GV9RSX96yqD+
	oFs/x23qp115zyC1B65e3jlrxYM1ngfUanjNUACJWNNKu/j9DoWNTHWlXOKKPQZvf7Y1KtGXwZNvw
	EsJGJSQQqB/RpwPwnyf6C7XRKmcoCo4xjCeSdtwp1l22GG7BZTwPnbDatGA84m+bjMBDNjImEsN9o
	JhWsbDwIIjIgJ+Ml/CRAidKf6lkaUQhRYZFTSWBby9Ht8M1ZccNCOCxWHaqvhuGKgwOwpJPGun46l
	IHSuNj5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVo8n-00000001YQS-13Ad;
	Sat, 06 Jun 2026 10:20:33 +0000
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVo8k-00000001YQ7-32Zc
	for kexec@lists.infradead.org;
	Sat, 06 Jun 2026 10:20:31 +0000
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-133362c30cfso19554c88.0
        for <kexec@lists.infradead.org>; Sat, 06 Jun 2026 03:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780741230; x=1781346030; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rI4D0m/tct5A6mLgdnGzeGFfOZi2MuVNzAsWtboD2FA=;
        b=oUndpFDbTLQKfolbTmQG6sG5stjlUK+25juoq9XOeoyJ8tPVD7778yklHRfLPgJO+J
         wTPOqAH/B1UnILnsfaXOgAD6/CO+kFWU9CFAItxYghQr6HNGVtmlERyzyaXALXyd8pUt
         96eGGt6LmvnEBE47MUJSolAsv7JcoMXJvZqWaNMAh2Bhnc8Kt6eOi9NXd+EFeaOlXP0B
         Bl7wymEoFlYc4lDsPNf5svr8yU7ZpBmGVdDdKQdxYYhVGUADIb5tcdAd5Z+nXsAl/XSC
         WEdR54/gLlU0sDMpPLV99jU5u6Gz0OAeM94n132Gyginrtw84H7uUV9QUe8WLySnCLBJ
         60kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780741230; x=1781346030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rI4D0m/tct5A6mLgdnGzeGFfOZi2MuVNzAsWtboD2FA=;
        b=RXBJpKwm7VNrwjOmONJ+LJQNGAQ0lohnJFnsHvbB0Ee2oRcAhqoPTric4uG4Dsav6c
         4BxSa7noa+yTMjLpZIBHgPQvJeN8/P9c+3HeXJJQDwKSOYD/ircbzCNAjus7X1Zfn5wY
         cROi0EQ1e11mCEREGg0+gesRBuKyi4QgliZogfotQ53pWJaMvfkXhcwhcZDrqnLFjxcz
         5LRz6ZPeZcmp+2pMmLLeuWt/IoSE8O4iguyxqfLNA4tohkj6Hb4PhL8JBGk0QmcjhMrC
         d9jUj2n30UxcX//2stbGvFawWUzZMLckOY9QO2DUsHu3VXpvuXOaIm/71LzO5PPU+PuJ
         YP4w==
X-Gm-Message-State: AOJu0YwEXxf7aKTKfPCYy6/RwH4oG4Ya4MZVReOjbkb9KVTyAIJbOaxw
	wp6zxYJAIFD0J8j45Pb5ZXUsxH5lT2tIivYQtqTqzQREFL+M8HaKQG+F5V6m9DchzQ==
X-Gm-Gg: Acq92OH5p1npRKOIe9LH8QoOti0lFyJHK+Gg4I/ODihYrJPSDRo5CijL8XhpBnlTM0Q
	KV8axnVytMbINPI2su2X5fF8zRNo/wG54+r7e6WyLya+9rsdtHWBRkK15TSqRD/AgYE73XULhUm
	jl2oQf38DJ3sWQD/ActDYtjW2Wy91rfiiQeAzcVKzf6tJwG2sO4AiFEwz2WGxkMVT1NFyiScD+G
	/1o5PyG/1GEjoxo2YksDWAosHh5d6gtjz0LPG4E862yqmpSRcvMd38TJjFMgSoa8rRNctZ5NlhU
	CpV7hV2rxLm3hANsVG8QiJCyeLSdsagei44FPhAAWkvgliVFlbSHHM7UjtuDtMlBGoYa25Ed9sF
	3LDucCU3OKel6bDtIwaieqpgNjQoxQjxTjh1MmKf74Z5VUYTP6c0m7TpLiIypVjMx+HdDPIh0na
	eAeuMJu3Cfi1W+Q2d8ctXYiCaUgCv5wrZ+S51Ha0+A2FEYWzZzMtSbiyxZERDchu1EL47hrg4=
X-Received: by 2002:a05:7022:671f:b0:137:9ab:2cb0 with SMTP id a92af1059eb24-13807ce58f6mr166369c88.22.1780741229038;
        Sat, 06 Jun 2026 03:20:29 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df349d8sm10350959eec.22.2026.06.06.03.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 03:20:28 -0700 (PDT)
Date: Sat, 6 Jun 2026 10:20:19 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 04/12] PCI: liveupdate: Document driver binding
 responsibilities
Message-ID: <aiP0Y_7dQWPpfS5H@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-5-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-5-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260606_032030_767412_2800C1CC 
X-CRM114-Status: GOOD (  10.26  )
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

On Fri, May 22, 2026 at 08:24:02PM +0000, David Matlack wrote:
> Document how driver binding works during a Live Update and what the PCI
> core expects of drivers and users. Note that this is only a description
> of the current division of responsibilities. These can change in the
> future if we decide.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pranjal Shrivastava praan@google.com

Thanks,
Praan

