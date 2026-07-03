Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379BBC43458
	for <kexec@archiver.kernel.org>; Fri,  3 Jul 2026 13:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8v9af2lDSb3ASd8ayFL4ngo6cw2ts8wfFrn9RS1/Vog=; b=wlBVq/+28VzmW9lc52jsKlKf3E
	f05g/5657JT/G0wHjvL+UN9TSYYikkFTSr1Ci/np/sTfCSKJWKQhIfPG0vE1mubuCX1FHyJf9IT/W
	eAS6nXlK/Z4Tb3l7BepAvcaNHuxJGIEJxL5ecSY+tBd7q0GtcBBu7VQsgp7MKRIFmYtz4hAjx9OWD
	raQebjJQAfHIy2txDOm4uJ5wNnZgqbMgZWi2nxIxW4RyfEh+jEFF3FATREycly1oUwBFDjgg0hW9d
	pErezDLSN7CyQRiDZZkqNdz7jpwTO68VdnGskFHrrbjRn0XyZ1xVXA7GuSVIIJJnUHH4hgf464PQA
	ybHO8Kxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfeBe-000000077xI-2GR1;
	Fri, 03 Jul 2026 13:44:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfeBc-000000077wv-47xN
	for kexec@lists.infradead.org;
	Fri, 03 Jul 2026 13:44:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E271B600B0;
	Fri,  3 Jul 2026 13:44:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1F61F000E9;
	Fri,  3 Jul 2026 13:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783086247;
	bh=8v9af2lDSb3ASd8ayFL4ngo6cw2ts8wfFrn9RS1/Vog=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NKIdPs8VWLJaFwVofQ3L9FgfVwwU033hWwf4ACS6efVY4SkGZK8FmDslM9k9BduRe
	 0MzXCbe6Wk6u4Hw7sgMvaWwRbM69mVOxgJT994Jmqu3DCiLoqDDB67Kc5BqHjtJyBH
	 PsJm3m6ADMGg3Qz1IhkUVFfjNKmKyYqxqOJkUP4QvKqcjM7pne5bBiqbpszllP1ySD
	 MzjXc1N3a+7iuTVR3uaOnnXr3Q0sjw3XGXcHWiXd05o+vs+qj13HeuU5CztJVDyQvc
	 l5cb7hFytKNaEAKA3QETH7nD11oIoi0DpHjUEL7kVB3zyO5mGJuUDfd3qVS0vC54Kr
	 ufJ1DFRqcUV1Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Coiby Xu <coiby.xu@gmail.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  mdshahid03@gmail.com,  Andrew
 Morton <akpm@linux-foundation.org>,  Baoquan He <baoquan.he@linux.dev>,
  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Dave Young <ruirui.yang@linux.dev>,
  kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,  Sourabh Jain
 <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH] dm: crash dump: remove redundant NULL check before
 kvfree()
In-Reply-To: <ake3qmuFi62j85r7@Rk> (Coiby Xu's message of "Fri, 3 Jul 2026
	21:28:25 +0800")
References: <20260703112642.65498-1-mdshahid03@gmail.com>
	<2vxzbjcogu0b.fsf@kernel.org> <ake3qmuFi62j85r7@Rk>
Date: Fri, 03 Jul 2026 15:44:04 +0200
Message-ID: <2vxz7bncgpcr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Jul 03 2026, Coiby Xu wrote:

> On Fri, Jul 03, 2026 at 02:03:32PM +0200, Pratyush Yadav wrote:
>>On Fri, Jul 03 2026, mdshahid03@gmail.com wrote:
>>
>>> From: Mohammad Shahid <mdshahid03@gmail.com>
>>>
>>> kvfree() safely handles NULL pointers, so the explicit NULL check
>>> before calling kvfree() is unnecessary.
>>>
>>> This issue was reported by ifnullfree.cocci.
>>>
>>> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
>>
>>Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>
> Hi Pratyush,
>
> Thanks for reviewing this patch!
>
>>
>>BTW, Sashiko [0] pointed out a bunch of problems in the surrounding code,
>>and they seem to look legit. If you're interested, help in fixing them
>>would be much appreciated.
>>
>>[0] https://sashiko.dev/#/patchset/20260703112642.65498-1-mdshahid03@gmail.com
>
> I'll send a new version of
> https://lore.kernel.org/kexec/20260501234342.2518281-1-coiby.xu@gmail.com/
> soon which can address Sashiko's feedback scrutinized by Sourabh.

Oh, great. Thanks!

-- 
Regards,
Pratyush Yadav

