Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B692B606A31C
	for <kexec@archiver.kernel.org>; Tue, 17 Nov 2026 21:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=0Ww+6F7A;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=R89GajvD;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LCsI095Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=J/fjCpBeMUF8gNXxUY7RYX8CVW+S81rP+s0YQaibwOw=; b=0Ww+6F7AFXuybz
	qSov0JAjJdpVUMI1q5RpIY/B0k6a7Abdl0NS9XxbL37neUSH/fWZ4Nmo0fRPZhuq/e2lJoy5YX9Av
	E+M9z0vkWrtrcLH/MTmKzusBGGhKenQhrFN1QYRWcuu7tfKhbbjWRl3UELv25g7hK/abfCyBpx1Nr
	bOum4BMa9OGzNUKd5DmhmfDuvzmq+GiOQZE9AeUi554m2PyjrRYyW+673E22rVd63Q8QFGMa6E/KK
	bIfEf2YvOCjXViKgklEROgbUyye5wIZERvpTsvl6tfCFSxcpIULpvr9qRJKzPzQunNN4OIMooEysa
	RXJs6cJmMvANHGIeKKjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTQfA-000000077Cv-1eFQ;
	Tue, 17 Nov 2026 21:24:24 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTQf9-000000077Cg-2SRr
	for kexec@bombadil.infradead.org;
	Tue, 17 Nov 2026 21:24:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=J/fjCpBeMUF8gNXxUY7RYX8CVW+S81rP+s0YQaibwOw=; b=R89GajvDL1rG1SV0LNyfakb5C6
	e3Jje9jbkt6C7nEFmbjOwco8B6bga7LO+mChm8Sp7qnsLH1uPGSGHp+Mf4sRAUcC8/813c6CLpnmM
	6hr6LezJlkkUorSkazZZDle2C+XfKLktfIOAxG6dLnPkFY5XoOvStkT3UYoKVyTgNtkv+xpQKQNoL
	z9yvPp4kmqAUPUGAoZMdLch6SMhc8HU6N6L4W6yJ7NmeGcXfXPkPgLoH0PJz3sL+q5SPT9EeslwqG
	/bwDPvFJi/ap6foMPdIeAukgOfFWIcxTA1r/vh1EDZ49Tpzm+8kSIpweHMGLeoJhHJzEnzDG3GLRP
	0Lz7NJIQ==;
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by casper.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTQf6-00000006ACc-2tQu
	for kexec@lists.infradead.org;
	Tue, 17 Nov 2026 21:24:22 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2ed2bfe3252so1115365ad.3
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 13:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794950657; x=1795555457; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J/fjCpBeMUF8gNXxUY7RYX8CVW+S81rP+s0YQaibwOw=;
        b=LCsI095Zt8kfp6M5wUclOe6evbDY2ZGbfEIxpYslFOlfPXSaJOz32ZewXJmMhCriQ9
         F9TD9CcuKsZ8LRjNenhkGkk1NMYJmvjLI/I38GNOlCxmdb3iLqEi8ZXIZRzjNnBMD/3C
         w3uYcCc2MbN5Bzsm4GTeNVPS9bS1/dBrG/TAtXmQbAWKcm3KUpsHkUMLQVHvz9F0Y7a2
         zIfJAYKOmFEzBIdX/fqDV36vZn39dVIGatfv3wiGNDHqCtrTebDGnMvMVpAt9kTeh7F5
         x8ZnsrAgLeOo0h4Vu26ztbuSUp1kfVEpoPUHpbsaEN9TYvpYO3ttzc+YEh+rBqqbaZmp
         1Jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794950657; x=1795555457;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/fjCpBeMUF8gNXxUY7RYX8CVW+S81rP+s0YQaibwOw=;
        b=E8ZMPmbk5GlBB9tT3AdkPHjAQfs+DDWN0T8xMQwVfSgmaGdF87dcaRC04noJFyU/Fn
         49B8XMNS1Y2Fzg+x4khSe5/UDCUSkLDLEWRLKujtTtp5Kzep/1E+wu/tHxR+z6376ycp
         bYC2IfQz0d3gW7FzOMVrD/3S1l8C7nsVw7WYfLq6ZnSfKrMYqvzL+3hMMzr9AKa8bEIt
         4t/3d/E65yYguDLrhFeDvdYlVKxZ6Ln8TPjHPYcY3VQq8skvFm2AWM3YsoBS9nKrnjYd
         NNs6c4sNZ/692RmO3qyRPSK2IRivZYozPOpIq1hjWmBHZhpH1Y7nYuW0fQAlOH4l++gp
         5h1A==
X-Gm-Message-State: APuU4Z/lafp5RTuMBH/OqL1i6ZD1IP9id//J3q37iadBNLn5BEe2SmOP
	yS1pHD7UHRgXpHqNrxdL9IUV9cgRntkDfWJFmVRskZpTniWFiug4UL2CXZsnDOBKRA==
X-Gm-Gg: AZFdTZdi5hcnjWivDfxcqesVuauBdIzaoZ4D4aCCVk0NZzNpJJQtOUsOlUy59+XyYLa
	4pUFQbav9bUaWPBNPCJ1Uf1rKk9oS9SWOrTA9SAH+W7fs2POFHghzx8x27riwXUgE82ZY26aNIW
	HwV+vmKiJ4GYznzJE5/4o7TRChmO/wk5NnhX3nkJc0s7xVPqDv1dh3RaImYNBQpFYM3sHnii9Ij
	Mm0y01iM2OGA8f8HeUc+zDqM2oh9pUOoIFRMDsZ4/zOe2lD1pVbT1KQYd3PqLMclG47o0SqY0BY
	2OeRjJzN77VylKSxgt8Q+2oi/su/N27hHiYQvF/VS44ZPAjmFNOC7az3K7msECYjlqVP2fFliUI
	qIDxge1Z/4LYGOaHaYzmvCKG1Y5PpUtNyEZ+dkCIcH/GRmddC4oDQRRaIS4BYtYRReRCPD18HkA
	EfaYSgy4Q/lVE1hJQqH1GzBL2tILMydrOLn5P1KaKSll6UTFyKYfdciKbUHiYYHuj3dwrtqSCfZ
	D7wAsWKDWD6YdCNWoLnomM7JW1yaWINMpgIylNDEeuHT/jV+lTfZXXQabtb3vBU4YO+kJcPW7gP
	4xo4bXue1qkSQ2G2Xwc+XifJEltdB3a1W5/luk+8nWtHMRnPbAtmlQI/KTr22VVM
X-Received: by 2002:a17:902:d583:b0:2ef:ee74:78e with SMTP id d9443c01a7336-2eff72ea998mr4954175ad.13.1794950656357;
        Tue, 17 Nov 2026 13:24:16 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff617eb61sm2650725ad.28.2026.11.17.13.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 13:24:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 13:24:15 -0800
Message-Id: <DMXSWJDPGJLE.30NVP7WQSZIZ7@google.com>
Cc: <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-pci@vger.kernel.org>, "Adithya Jayachandran"
 <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Chris Li" <chrisl@kernel.org>, "David
 Rientjes" <rientjes@google.com>, "Jacob Pan"
 <jacob.pan@linux.microsoft.com>, "Jason Gunthorpe" <jgg@nvidia.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Josh Hilke" <jrhilke@google.com>,
 "Leon Romanovsky" <leonro@nvidia.com>, "Lukas Wunner" <lukas@wunner.de>,
 "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava"
 <praan@google.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Saeed Mahameed" <saeedm@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Vipin Sharma" <vipinsh@google.com>, "William Tu" <witu@nvidia.com>, "Yi
 Liu" <yi.l.liu@intel.com>
Subject: Re: [PATCH v10 08/13] PCI: Save and restore the ACS Control
 register and Egress Control Vector
From: "David Matlack" <dmatlack@google.com>
To: "Alex Williamson" <alex.williamson@nvidia.com>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-9-dmatlack@google.com>
 <20261116171017.2342bd11@nvidia.com>
In-Reply-To: <20261116171017.2342bd11@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_212420_796124_F509C1D7 
X-CRM114-Status: GOOD (  11.95  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 16, 2026 at 5:10 PM PST, Alex Williamson wrote:
> On Tue, 13 Oct 2026 16:25:24 +0000
> David Matlack <dmatlack@google.com> wrote:
>> +static void pci_allocate_acs_save_buffer(struct pci_dev *dev)
>> +{
>> +	size_t size;
>> +	int pos;
>> +
>
> Nit, moving the device specific enable test here:
>
> 	if (pci_need_dev_specific_enable_acs(dev))
> 		return;
>
> Would avoid:
>
>  - Allocating a buffer that will never be restored
>  - Saving ACS state to a buffer that will never be restored
>  - Testing for the device specific enable at restore
>
> Otherwise,
>
> Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>

Thanks for the review.

I'll make this change as you described. Preserved devices will still
need the buffer even if they match a device-specific quirk (see my reply
on 09), so 09 will also allocate it for devices that were preserved by
the previous kernel. Since restore then just checks whether the buffer
exists, that is all it takes for preserved devices to keep their adopted
controls across a reset.

