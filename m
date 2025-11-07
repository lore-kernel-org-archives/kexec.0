Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E86CCFA18
	for <kexec@archiver.kernel.org>; Fri,  7 Nov 2025 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KmNg0IbiQSMgIBfWpyOISbt53znceGdIygj3J1+GoFo=; b=HrwuGI2gLV6eoHURAf6oD3/H2C
	XQG842+RbKLamxAiTwuW674V5O9DokEEIyXs9FFYmjgyr02uPF9D5XH100ypfwIlWhmgoIU0CivDn
	fV+tBay0M3bLLBDPeoRA/xYG4hftQTZpTy+UDfoZyWp8OHuxpii/g4V2yiZl8iScSZR8Zh1LdNEfK
	GVgmwP+HM0PSX/5XV/X/cnj/JshzQpKXiPaAzx58HRVCfgXceDnvcfQozSguKn+VxNtKroDYa9v6l
	uvSpAGwxjZj5GRTnZSaB0s63/kcyqxxQNh2O733SmAg8oaSGPnz3ifAVtPhLCzgJoLLaf4TNfF7Q9
	csJjh7sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHOzi-000000003jR-3irC;
	Fri, 07 Nov 2025 16:07:22 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHOzh-000000003jK-2FgH
	for kexec@lists.infradead.org;
	Fri, 07 Nov 2025 16:07:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BE54461913;
	Fri,  7 Nov 2025 16:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4214CC116B1;
	Fri,  7 Nov 2025 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762531640;
	bh=KmNg0IbiQSMgIBfWpyOISbt53znceGdIygj3J1+GoFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fRZ7r4cTjf5cb+wQfQZKSi3nxrTbj66GE5KbiX42htXpJ44IXf3nBmo+xC4o+q7TA
	 BRXzD67osZZSe5TEP3UnkDASXEMhdSAiGFcXkjedQ7CCSsHMJlwH57SJmRIb/XCc+V
	 sa8Wvr4hF1Jw3bYrpn3i2K6GJEMueq3rSmlNZQiOu89kvKXq8kl+xoD56DiPOKor8h
	 XPHuYlvf27NrmVcpFt+gtjOFbxd/4hbMJbfWr+jh5UFLH2X2tiLpibtfSo2h7LWloB
	 eGQNAROrX3tSYtgs66K6dFgmfjbzrkO5Jm79bK1xZlxpbl2e+L4DUnV41N81eAfEqB
	 gOE15k6fuoYGQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  akpm@linux-foundation.org,
  rppt@kernel.org,  graf@amazon.com,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH] lib/test_kho: Check if KHO is enabled
In-Reply-To: <CA+CK2bB+EpZg7MTKZhFtaGoYfLN5JNeaH9HDv_Avq9Qm+3e2ig@mail.gmail.com>
	(Pasha Tatashin's message of "Fri, 7 Nov 2025 06:15:37 -0500")
References: <20251106220635.2608494-1-pasha.tatashin@soleen.com>
	<mafs0cy5ub0nc.fsf@kernel.org>
	<CA+CK2bB+EpZg7MTKZhFtaGoYfLN5JNeaH9HDv_Avq9Qm+3e2ig@mail.gmail.com>
Date: Fri, 07 Nov 2025 17:07:18 +0100
Message-ID: <mafs08qghbzd5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Fri, Nov 07 2025, Pasha Tatashin wrote:

> On Fri, Nov 7, 2025 at 5:24=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>>
>> On Thu, Nov 06 2025, Pasha Tatashin wrote:
>>
>> > We must check whether KHO is enabled prior to issuing KHO commands,
>> > otherwise KHO internal data structures are not initialized.
>>
>> Should we have this check in the KHO APIs instead? This check is easy
>> enough to miss.
>
> I considered adding a kho_is_enabled() check to every KHO API, but it
> seems unnecessary.
>
> In-kernel users of KHO, like reserve_mem and the upcoming LUO, are
> already expected to check if KHO is enabled before doing extra
> preservation work. I anticipate any future in-kernel users will follow
> the same pattern.

Hmm, fair enough. I suppose we can always change this later if it causes
more pain.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

--=20
Regards,
Pratyush Yadav

