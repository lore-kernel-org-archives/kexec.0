Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF34F606A321
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 03:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZOI0IcC+;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=K3tcHWHA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=f8mmUDpXbdelWthFJmC6h2O4KuH79ZCjDuO+eZML6XE=; b=ZOI0IcC+zmpCHK
	eYU61hu8lWRML6+yromytpYNOad2NQIkqMkL261lDX7heuj0t7N9M/QKzxOG1LAZBUvlJoTpfa/qd
	yW3QRLeroKBMPHGn8+AO2QfBBC7E6gngbWo2MQaUsFJJCCjHvIMmYo0EW7SBNLbioSSDWgQDwd0Cx
	DG0yMpZ8xLltzgujvR/xpRPmllqTUN0KapWq/zrmkz4wc/ENw2zcgs1TyZyVCjtxrYh0RuAnwYh7H
	LIU9vWPrV9jwHcSiZd5z0v/iRQtlWGcc/Y+gUGz4xWBHJBrdphjNThBT6qDo1G5xx5nypenNfpyBU
	jSqftJJbu8JVeVjH2sTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRLFq-00000008b9p-3dVX;
	Thu, 12 Nov 2026 03:13:38 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRLFo-00000008b94-2rqy
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 03:13:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=f8mmUDpXbdelWthFJmC6h2O4KuH79ZCjDuO+eZML6XE=; t=1794453216; x=2109813216; 
	b=K3tcHWHAcLnK2xVwZB4zWGNUNZCui1D0paALdEy51AqXu3FnGQ4jPTXzAV0/wwHMvFbUkYwQwPb
	hmnfbxCP4DYMgZjy8VHDVUEDDWEoZY1Knr9fAgnpMLf/dU0JLnDmbO5ruQuhzE3p2sJMXtQ/Jxz/N
	5KfjND7FwYEMI5k5xNhfjQuzCN6sFIZF++nMaJ6mM1+N50iTIpoiLRBfEytt5ycXGYl78qk3k3aid
	WYoab0Itd+cwegdmWyqufmSZ2ktE8o91/RUSwoMC+VZBOohgVbX9jsUA7l5SV+Dp3gY0Dmi4i2fvR
	qAtctgFvDjW/qiYhEkAvMIqELvWD/WHZjVRg==;
Received: from [189.110.51.50] (helo=[192.168.15.3])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1xRLFW-009Gwm-22; Thu, 12 Nov 2026 04:13:18 +0100
Message-ID: <4a29a98e-92b0-7271-e2e5-10d159ee4a4f@igalia.com>
Date: Thu, 12 Nov 2026 00:13:12 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] efi: efibc: Optionally report panic as a reboot reason
Content-Language: en-US
To: Dave Young <hidave@163.com>
Cc: ardb@kernel.org, linux-efi@vger.kernel.org, ilias.apalodimas@linaro.org,
 jeremy.compostella@intel.com, matthew.k.gumbel@intel.com,
 kernel-dev@igalia.com, kernel@gpiccoli.net, kexec@lists.infradead.org
References: <20261108003549.745697-1-gpiccoli@igalia.com>
 <63d0fb19-b1cb-4729-839a-b9e1f1379473@163.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <63d0fb19-b1cb-4729-839a-b9e1f1379473@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_191336_731342_AD36EBC2 
X-CRM114-Status: UNSURE (   4.54  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -3.8 (---)
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
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/2026 23:57, Dave Young wrote:
> Cc kexec list
> 

Thanks a lot - a very good idea. I forgot doing it, my apologies.
Cheers,


Guilherme

