Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658CB606A321
	for <kexec@archiver.kernel.org>; Wed, 25 Nov 2026 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oiEs4n6s;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=qDF/Ej5O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=V3ql+trEST5GBe5icgHLs8egrkIrOnsTHov8GZtBedQ=; b=oiEs4n6sHhTfdu
	zMD/EjQJi0dYae2nxxeHpyVKyL/5wF6Lf19mRNzPpu4RxGZAqHusLOGmSvSRrr9OGSvHehbknwr6e
	0jRtZ3npBmNKTzg6YTBc0IdKxd66Dp+oGl5FFR1/j7y0Yj8QDq+UcxXdRCu5GrZiDe3EaiUr1x7SV
	bFC+WimN/s3QiEZOOXWZZEf3W7g/2IDVFA0nPoxJy+3Q8aZx5/r9CV70j2qoTpyyx0MsiYIRQHbp8
	gtlrDdiRK2zhCWOodfCP+V0Xo3HSbtHpU28RfWvZRKAcgKRbBTxI7lkbNYO+hQLP4IC+52DIcPP7u
	bWILKz9KWG5xqNeGsiXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWHHL-0000000Au97-43OA;
	Wed, 25 Nov 2026 17:59:35 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWHGu-0000000Atx9-1Yk9
	for kexec@lists.infradead.org;
	Wed, 25 Nov 2026 17:59:16 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-3b439e37813so3132729a91.3
        for <kexec@lists.infradead.org>; Wed, 25 Nov 2026 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795629547; x=1796234347; darn=lists.infradead.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V3ql+trEST5GBe5icgHLs8egrkIrOnsTHov8GZtBedQ=;
        b=qDF/Ej5OFZsYXs2J2CvpvRIQx7vRuLSubi36Eb0cu+Kk4tzdyRW/1Jw/3RUEQ6HOGq
         A+jdP4HcxDQ5dsotkqUck7aQtJYP2BYjxExDr0RRcITLfAFFh15kdJbWV+NnFlAhKUw1
         lpdMZ6pqZJRfh4jftpvZ1ejAtpQ+C7DEZwgIiZTyfKWCY8zd9fukqg5e4PGwi056fNs3
         rqReUwyD/oJdV+mYlplAYWj1gOicC8iYZ3VkZSfSdaiIo6BmnfJxigLFcOF4gK69fqis
         m3E4Ej/qz7S1Q4qsIPmOojcF/9zamiw63/trnE6oJvf1/vSS1LgoBV60DoMscr53maFR
         o3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629547; x=1796234347;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3ql+trEST5GBe5icgHLs8egrkIrOnsTHov8GZtBedQ=;
        b=YYgON9VJ8eMj4vgWsLpq4VMMa/l3QuhBn6F/2pmqe+sXAhLM7wfXbTTr5FnQx3a42d
         bSxdYRrpoyAj7UwYXLTeTq2OiT39S+W/0q8DfENtG71DFmzIT/iGYfwd7iqhq3mohXYd
         8Z1QaH+spbLhP+yoP8YgU9o76pDR1VPvEBVrgUlWYTWah6Is8C4vuS+bGHpZM203YR0m
         11su1a/MPhmjvi1ut6G0CvtN97CyRfGHF4sg0suinPJsg76nSOl5soQ3TzRAinqdaquY
         GT+rAEHnNiF2bYNPeLlcnQZZllQ2hbmJS3wCuChWh0vHfS3sOwAPICpEvPjBxZi7DtLq
         7alA==
X-Gm-Message-State: APuU4Z/Qf1Bp/bCtYyjXlpROSoIKLFZZKEJMnKizbm0kyvi0v8XKm433
	RMSvgyJpvG5dDqQTIdZN8AGLTnGD05MUvQtEBsCfDjqdqb6LjyvkZ+NbMIF9nNzewA==
X-Gm-Gg: AZFdTZcXMO4SpCxchi2D6BtKQWj9l6XoDwOm9uTW6kZpRH2GuMtkwLKfeZKB/S57C9F
	prxUBCMKgP8M5fTDo54XGyvpswNCNI/GYtiXmMqHG3/Tph4LnYzfev7eXCYJ9+shuk65gFbb7A3
	N1ADcmRSl76UW6MC9SF95uR5SyfbpOSj4xycXHZkoMTcd82lvW5zTg7sgWNFQdX5QDrW0xQfv5G
	2asbQInQdJ6fdPHA9j+QswPU3COgOx7eBZ+wFwXZYa1u7ZjuWhuli0J8HJMO+Trr6JaGWs8cPfI
	jv4HFphOzHFRLo/OgEaGlELdtYgQ+LouQkEbZOQkxq8dTGqxjpfap9tKUVPmeFzlmfR/+MoYW3h
	YrKEtondOEfYDD0KxzrjigHuy3XZrteodCLrQxKnwFt0iU5iAnMPE4kZMp7tpZGVOe5MmrX1Tvp
	4yclaY4xOsrCsKtjN26qYKAaou3aetEkPEbyIDpG5X/iG9/Vye4ll4a8bVOSJ2nkN7XXxNf0WoS
	HOu7mf2d7m++i1W3Z1L04sYK4nqWrzCbL/v79FX9/foqgr7xciDtOV5dB9v2Fy4VoKXEn0PMmyS
	zc7iZodMfmgNaU9ugeCYCogVGuFqAbqSZbsv0fVfw3/V0rHjON7imLqmP500VrP9
X-Received: by 2002:a17:90a:e7d0:b0:3ab:5832:72af with SMTP id 98e67ed59e1d1-3b41c9cfc12mr15413655a91.32.1795629546987;
        Wed, 25 Nov 2026 09:59:06 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb2076sm29085960a91.2.2026.11.25.09.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 09:59:06 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 09:59:05 -0800
Message-Id: <DN4HJTFG5WHY.1BIGOM7LNESZA@google.com>
Cc: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <graf@amazon.com>, <jacob.pan@linux.microsoft.com>, <jgg@nvidia.com>,
 <jgg@ziepe.ca>, <jrhilke@google.com>, <julianr@linux.ibm.com>,
 <kees@kernel.org>, <kevin.tian@intel.com>, <leon@kernel.org>,
 <leonro@nvidia.com>, <lukas@wunner.de>, <mattev@meta.com>,
 <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 11/27] vfio/pci: Retrieve preserved device files
 after Live Update
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-12-vipinsh@google.com>
 <DMZMRTXS7OSC.M79XF39ZVEWE@google.com>
 <20261125003759.GD3545683.vipinsh@google.com>
In-Reply-To: <20261125003759.GD3545683.vipinsh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_095912_723321_CF168068 
X-CRM114-Status: GOOD (  24.99  )
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
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 24, 2026 at 10:55 PM PST, Vipin Sharma wrote:
> On Thu, Nov 19, 2026 at 05:01:19PM -0800, David Matlack wrote:
>> This is a lot of complexity for one commit, and it's hard to review. I'd
>> like to start with the simplest approach and build from there: implement
>> can_finish() and have it return false until the device is fully
>> retrieved, i.e. retrieved and taken over by VFIO_DEVICE_BIND_IOMMUFD.
>> Then finish() only needs to free the incoming state and call
>> pci_liveupdate_finish().
>
> Closing session FD is not retriable. If it returns an error then
> userspace won't be able to retry. So, only option will remain to reboot
> the host.
>
> VFIO doesn't need to impose this restriction. We discussed in LPC to not
> block finish() as this call can only be tried one time in LU if
> session is leaked.

Right, if userspace closes the session before taking over all of its
devices, the session is leaked and the only way to recover is to reboot.
I'm ok with that in the first series. It only happens if userspace
misbehaves, and the device is left running with its memory still
preserved, so nothing gets corrupted.

I'm not opposed to improving finish() so that it handles devices that
weren't taken over and closing the session always succeeds. But that can
go in a follow-up series. It doesn't have to be in the first series, and
including it makes the first series larger, harder to review, and harder
to merge.

>> It also has a nice side effect: LUO calls can_finish() on every file in
>> a session before finishing any of them, so a memfd in the same session
>> that the device DMAs into can't be finished before the device has been
>> taken over.
>
> If userspace has two session, memfd in one and vfio in another, we will
> still have risk, where memfd is retrieved correctly and may be
> closed/released due to a process crash but VFIO device still acessing mem=
ory
> by continuing its DMA and potentially corrupting memory.

True, but resetting the device in finish() doesn't protect against that
either. The device is only reset when its own session is finished, which
can be after the memfd in the other session has been freed.

With iommufd (i.e. not noiommu), memfds mapped into a VFIO device must
be preserved in the same session, and iommufd enforces that
dependency [1]. noiommu is inherently unsafe in many ways, so I don't
think we need to worry about this one case there.

> I am still inclined to let finish proceed without blocking via
> can_finish(). I can try splitting patches.

Please go with can_finish() in this series, and send the finish()
improvements as a separate series on top. Splitting them into separate
patches within this series still leaves this series larger and harder to
review.

[1] https://lore.kernel.org/all/20261025021930.674647-16-skhawaja@google.co=
m/

