Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF3DCF857C
	for <kexec@archiver.kernel.org>; Thu, 20 Nov 2025 09:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dMRteEgX+7XYeptNGrQQ5sd0xlMP9fffdpk+5Hazd+k=; b=1EIrVXz1O0eHH9hiDdqfvFRSci
	HiziQr2EsnU7xfy2AJrna6bynfK+R9o9ooml+zrYQUHtvfae0h4bV7leorecy6CwzPn/vGoH56WU8
	8ybuQx6CzeHpworJDY9C2Gb4S5lMnIFURZb9HviWRMY8BANeQhf6oQuhT9hOswmyWJ5zSaEISwxlB
	B3hOT8nSCZIKdzOBCVyDU/stl0BcHCux02IwyjKeTRnSXWZOJOlpRUlspZ4mhD3BUEyT6FtabkRa6
	hZZhLmmp+8WAe1fKAa8CGh6mId7MYXzC6xjt/JyFKqm2wq0tEXxQpyvIHij0MJt+w/SD3rOGbmiWx
	JupuSyhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM1QW-00000006T1O-1eX1;
	Thu, 20 Nov 2025 09:58:08 +0000
Received: from mout.web.de ([212.227.15.4])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM1QT-00000006T0v-3MeU
	for kexec@lists.infradead.org;
	Thu, 20 Nov 2025 09:58:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763632663; x=1764237463; i=markus.elfring@web.de;
	bh=dMRteEgX+7XYeptNGrQQ5sd0xlMP9fffdpk+5Hazd+k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SKsQG0jrAFvw5ifboeGZ77RV/4lX48+iq3BICXNKfCUtq5p9Toc5RwPaMGG23Hwk
	 d+kqCkuUQh+On4GEF0ll9HFuzPC1RVxQswrmSuBqgjpXlnTwHSGmM5hWHJo9h8Dc4
	 3qWVl1dMylJmmft73226fHywvVwJqtCyifUHYcVLAAcYlD3lyJRVRvrPhvJskLhDt
	 Pq8rFkD5JuflrFmOD6f35OxsyFhjGf9twAaW3SBytJa8TU8gNPUVbfZ55crLh6ZjK
	 kNovxdd4jw1uU196IscaxPKWvA8RGYglLSf7R1v4soXz1IkgFgW0QBid5Dcrc+Pnj
	 MFYgjiA3bx6/9nVy2w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.176]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mc1ZT-1vrVkn3rBf-00ipC7; Thu, 20
 Nov 2025 10:57:42 +0100
Message-ID: <11c0819f-f0e4-42a3-9a0c-fc71de1e59cc@web.de>
Date: Thu, 20 Nov 2025 10:57:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kho: free chunks using free_page() instead of kfree()
To: Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
 linux-mm@kvack.org
Cc: Alexander Graf <graf@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Matlack <dmatlack@google.com>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <20251118182218.63044-1-pratyush@kernel.org>
 <d41ce2d1-e353-4e5b-a17f-52d888a560b4@web.de> <mafs0qztt2h5x.fsf@kernel.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <mafs0qztt2h5x.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tvu3+nV0l4pUnx6OlIjZ+34j2cXMpbhpuiMyDW+MdSVWiFLv84g
 hfZ1EDQZGJfrcOQ9tZv5WiLQcZz3xPtu8mTe815rbwbw4D+UyDsks5udqX8CP62z/JwcBQO
 EE5ZKv3inlLXW2Hpnzy6qX1C3seU2ziaMSj95eqgYKzcFUKCDI/w74fYqIN4dL9MmF/LGva
 bTphGgNeY7gpm2Pmi5EFw==
UI-OutboundReport: notjunk:1;M01:P0:RrDfrEaxlZw=;YGEawOC/oWyu0Dw8tD8qtEv00B/ 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
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251120_015806_204294_D84D41C1 
X-CRM114-Status: UNSURE (   5.86  )
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

> Anyway, if you have something better, happy to take suggestions.

You provided a reasonable change introduction (and justification).
How do you think about to add a wording like =E2=80=9CThus use an appropri=
ate macro call.=E2=80=9D?

Would it be helpful to mention the affected function implementation
also in the summary phrase?

Regards,
Markus

