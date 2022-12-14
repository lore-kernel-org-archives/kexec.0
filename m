Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7645CC4332F
	for <kexec@archiver.kernel.org>; Wed, 14 Dec 2022 00:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K8POuUhS/eULonFZd97Yy6GMiLHN87lFPAFREGyKUsY=; b=ejmrwAElxiHoOJ
	3NQDOOkE0nle9klkEJNXp0agXNFRlK9SazHRZ0Y0BeyQZJZJ4Rv8dA/hgkUJtTi0TllneMK0u1l54
	YwHVWYGYrCT6W1RvXwYU1Dgu0QJFtI1Hm2EaijteYKlqRy00lA2nDnQ9SlDlk+Kl2tYhPpaNYxw2P
	uxIl++1xTIaRQ8vb+8dutC3GWlu3A6NAoOQoYrYoHfLD737w1Vls1xjKa1VKiLHp3HIl0LvYOghtH
	EqWnC6OY1RuYWJOT2OoZw70RCgOy7k7peAOFQbdmzX5cGzB/31QpNS5S/ViWe6rcKZb720pTZzUjn
	mTy0cwuv8tNLyHhytKRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5G16-009c3U-Hc; Wed, 14 Dec 2022 00:53:00 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5G12-009c1S-Ek
	for kexec@lists.infradead.org; Wed, 14 Dec 2022 00:52:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zy3O73fmfvkrnYLmlTlp/aoV2gFGdC6nGas691zCLP8=; b=fmjsM/EHeugv7EwGMVJgsXUfds
	2WKC38xXRxFME3vrfBE5Lbp5x5fpiUfSp80hybiDOSDEa0AAtp7oqeXtyemj/YeTQX64hwwXxGFcm
	YbanrvYNrH2QdbBRPfZIjLH5LKVScJVuvhWwIvKQr2rCkU9ptKGB8oNMCr4WC17iQtdxv06cAZv5T
	jx8hOviVnM0Q3cisjPR64jNSldYgG/wsf8Bnwd3zW7CcalMIkQl4d5ig4sI4c0N40qnTWC9dUPS3T
	NcVu4sPOCQjCC9NrTFWSE+Ph9mnNl/rDXo7UJ9aG8glQuyTMU2oAJikPK1YAllTLzQAs8TbpzTF46
	OFQnLSAw==;
Received: from 200-158-226-94.dsl.telesp.net.br ([200.158.226.94] helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1p5G0x-002tOW-O7; Wed, 14 Dec 2022 01:52:52 +0100
Message-ID: <ab0da0ed-044f-9347-a309-5c5ccf402437@igalia.com>
Date: Tue, 13 Dec 2022 21:52:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V3 06/11] tracing: Improve panic/die notifiers
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-7-gpiccoli@igalia.com>
 <20221020172908.25c6e3a5@gandalf.local.home>
 <f29935e3-e3b6-2d4e-7fc1-267e1ef0925b@igalia.com>
 <20221213190656.3c229b73@gandalf.local.home>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221213190656.3c229b73@gandalf.local.home>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_165257_633406_03A3ADAF 
X-CRM114-Status: UNSURE (   8.60  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 13/12/2022 21:06, Steven Rostedt wrote:
> [...]
> Heh, yeah, I forgot about this one too.
> 
>>
>> So, do you think it's possible to pick it for 6.2? No dependency here,
>> it's a standalone patch.
> 
> I can pull it in.

Awesome, thanks a bunch!


> 
>>
>> Thanks again and sorry for the annoyance!
> 
> No, sorry for missing these.
> 
> -- Steve

No biggies =))

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
