Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52990606A31C
	for <kexec@archiver.kernel.org>; Sun,  8 Nov 2026 14:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1vRVEPJP;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=k6ZlXEiv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nsEN2ewwq/SO7JFjgqolGnWnhAJtT+s3jJv0A19D4kM=; b=1vRVEPJPT+vARn
	rC4/d79W8246I2D0vMD/whKi5XG/niNsu7rlH7XXB92OQjUgwhDZKVwdld8i/JyyzR7N59OFxgU9U
	A0ztqtzvmHTQo9WOAPwkocKbt6tDNi98y+OOyelfIo2d6f2+F9xFtDWFw2u7BK40QTvy+HhUcCNrH
	UZJFLmxfec2vceSHyiEDIfO+39MthOwmAAzw6m5r2W/7ZlOPs/r+2TJLC9+gYlsNnxxbN9sKAGfdZ
	Oa5H5RTIscSqGJlQ1aekXvCKvKCnJUQQ2m9W5yio3XOOAfCooZb0otVSv4ayWtUfEBk0nYGUu0fq3
	Zjs4Qe4IWgTI3UShqSDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ3tR-0000000GGBq-23ZJ;
	Sun, 08 Nov 2026 14:29:13 +0000
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ3tO-0000000GGBV-3Ci1
	for kexec@lists.infradead.org;
	Sun, 08 Nov 2026 14:29:12 +0000
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so55213e0c.0
        for <kexec@lists.infradead.org>; Sun, 08 Nov 2026 06:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794148149; x=1794752949; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nsEN2ewwq/SO7JFjgqolGnWnhAJtT+s3jJv0A19D4kM=;
        b=k6ZlXEivxSxSOYJ+s4spF5+sNp94sJNxBb8DiMJaPEwrnLsRWos52qc7EUK0y1SxNa
         2yt3MNAe0nx+/K03mOlZYbCMjHlv5Cp6WLrN6wzVK6DMRV47YWkYL9YaclsklErw+wzg
         Tm2t7VyAZOoF6/Oe2GwTDs+3MJahF4EkRSSXBrihK8CI7g7r2f4dWsI4KGdr57j/YCgy
         55/LTnfZADOtYe5Vu5P6VHWGssJcufCvk6WGCVjwA0aUGtVuiU0Tstuqu3YFNH02wRCf
         k1L/3TyRHTPDP+o5FqntFLczeEbjdseglSxVh5Zf5vW3ofOmeE8rXqv+N72DXKYBt4tk
         8ExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794148149; x=1794752949;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nsEN2ewwq/SO7JFjgqolGnWnhAJtT+s3jJv0A19D4kM=;
        b=2vurS0J22rWXNLqV/mZKF3ADKxhGDacZRhpDqz0ZQWX8idnAPW/vT4jIxeDsQxJcaA
         tsvMuhUIGnF/LmHlCExiM1yPMSnnC/PakVetRhYvFZoYcaW2t9up6tPR1TM13spYoB2M
         ymPP/MjyDvNkHitiKOjeOKofti5jh2ILhZcv1XbGaW/1Tm8KN2Tp0/GhTpIZmiyYZlug
         lSqN+yzqP8LzKxsYqr9OM84+Az1I2GsaUGBrNYCB6k07y8dx343XN+efRvFMQ0EEkGSk
         ua5vb+45ANhdRL8WB12c7bHWiXJFIOkQDJuRbiLc2cy61w9Sk39TZPmsVMOF3bnF4bdL
         ITwg==
X-Forwarded-Encrypted: i=1; AL+hErHjik6rXRO1OHvThS8jYP85XC9atML127MhSsVrSAMMdbcosgjNctQN+ERmynuUaWclKogzEg==@lists.infradead.org
X-Gm-Message-State: APuU4Z+Nkx2l9bvqDo4OWs+62Kq9+iVwDUpQwhO5t7/B3S2nHXvhuACP
	W+L5vu/9wfdXRNvoNFnCb+s3SGhGEe5S40ZI/h7NrPEoIYgGH7fUT137Zbghho4HsGRHaFGz0TU
	Y3GzT
X-Gm-Gg: AYBFou3tnFcWTSTdrIwZ306UTkheAzieE6jJfgbIsyPSe0OIdiFav64TIJ5xbsv3LU5
	1dpkOli2Zz1eNPv+o/TEabevGAJThDJBCdG50/KbBsmPjSzGAp7yXTO0eq5nkW7Hq4ua+hBuWv0
	9R4t+o+w9wj02hc3sEY6mvuSxfIy0LUf21xQ7jjvtzWa88H+M0ccVKZOcf2P6pMKkre+hN9j3HA
	f3QeUBTZRB+CZAIySCD1FNBGjcN1Rriht3EoSLGbjznCPa95CMpMSIcXV1RapJjLqjV6YDVx4TV
	BBbn73PNfShaIyDF61YSwmmUwU608saiByPOhGtIMbgZL7aOzHUWkig4RXSbRyqAjPv2bGmlCtw
	H4nWCa8RlZup4pdFVKOB2/zV0LUcIZUtQgrxxA6qsXyk5D/6hyB9cnp9aAl87NaI4FHbN57rSQy
	M233N9j504EuZ6QqM2CnbWenMv8U1ndmd6wN5BEtR/HQZZow9JfdJTWf3uk2svqIZa7ZlgDtJkL
	79Qy3dMntx7vMbPvCi0zdnGtI9PnMGzaxmQ8pgsWNZP/hzYXA1TQg3J+43Mm+dMadkl3dA06aQi
	1Q/BKcm2Jv9huvlIDa/IHnZZ/G54VvTx6UEJlfh0tiwFzZmzyyDaUneru8mzpXFV8f+7tqKcueA
	2oljh40TRAtCgL7WoAVZ/fleBnrZXadXC7SVDHXoV/x4YzL1A
X-Received: by 2002:a05:6122:e00a:10b0:5ea:bf30:851d with SMTP id 71dfb90a1353d-5ecd1fda430mr689131e0c.16.1794148148877;
        Sun, 08 Nov 2026 06:29:08 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece6418de3sm1961786e0c.13.2026.11.08.06.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 06:29:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] kho: Don't release incoming bootmem areas when
 kho_init() fails
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Chris Down <chris@chrisdown.name>
Cc: rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
 graf@amazon.com, kexec@lists.infradead.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com
In-Reply-To: <au_vQhHAcJbkryXN@chrisdown.name>
References: <au_vQhHAcJbkryXN@chrisdown.name>
Date: Sun, 08 Nov 2026 09:29:04 -0500
Message-Id: <179414814499.358073.17024430367999674004.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=531;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=pKVjfmlu0iTkn3Mne7zQTiboAlXNWpArbsEY/CDfG+0=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq8IczShqWPTsPqxG2k3B2z7SD/Zt27GlTcRXCS
 al4yUzZYCmJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavCHMwAKCRC7dyhM23N6
 3rxgD/9MCj+nbRihezlRzunNe1wcq2hnBD3k0gmKVmGDeS3zwRvPDyi5f8qbhin54yxiC6zIGKS
 Yn2jL0+MWh3D673KAwTIKuLgSkLRa31KeqkgDY2NIUeUn8n1dy93a3R6SacrpULUNSSqQBOq/dy
 /MZNEyK82xSwsl+Sx/Hje/21XHQyJPsyH3sCLOoTpyN387Iob3sGAwvPfDCeyFdHkqYceUhuch0
 bVhl0fHheQIkA36lWuVETbYeXTbgULYcBy33lRmBEeXn4u1NFBXg3A4w3PPodi4WkP+kKCD+4k5
 ZhRLfJUfdpzs4vr1D8w6sACIbQtKUKocah2JuyI6+ovgxsIoqDKFrqH8oJVhAuuFSGLvYQ2wPsA
 OEU/OWtcEFLUvTn0Dw997Hdp5qpkq2ai2GgWLBicMwMDvSjNA6uGaOSfBTtyYsxNUn5LFK66m6z
 q6zKYQ4nFeit2N7SB12qa2j0n8ZK8c3LdNBHVNLh34aTCT2hEPO5W0YAYztVYpgdTBMlwTZLcaE
 QGfb5dHSyxjwyB4SKOLGd7zxItpAUtrJ3Jtmo84WFI+WJg1jYppRzuGJye0uO2/HM4o/8lYJkX4
 YiEO/nkmS4FHId5uUw6VSGMYxSw5N9dAPVcFqHmFIw4V3Mj/3VCQp10bH6t1qgUNmxYq1F3Yeny
 y962hGozq0S6EJw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_062910_829363_FC7E8325 
X-CRM114-Status: UNSURE (   5.83  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 07 Nov 2026 19:40:50 -0800, Chris Down <chris@chrisdown.name> wrote:
> kho_populate() adds the incoming bootmem areas without reserving
> them. memblock_free_all() then hands the remainder to the buddy
> allocator.
> 
> Unfortunately however, if kho_init() fails, err_free_bootmem
> currently frees every area with free_reserved_area(). This can free
> pages still backing early allocations or free buddy pages a second
> time.
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha


