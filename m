Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBE1C6FD1F
	for <kexec@archiver.kernel.org>; Tue, 14 Mar 2023 21:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/DfY29n8IoU5R7iegHsY8dB8oeXwG3QRyKTLwlWqjoI=; b=toQONy9wSNP521
	BP3dkgPv1IMEsOdd42nl54KQkgFze1cGyIJVFi+TbZ23q1EYtiePBkWs4sUTYERcg4RjsOhqSvBeW
	Fq7pEAgbDNET1I5s+VlaboNC0T1En/czSAD5+3+2hMq/ytlZSlyZZsEbhEyEpgiZLmVIZQb24szJk
	1CHs/YQLZaFO2FszH7zcsyGRBPVw9sTKUyLNNJ2ib4I7PqgpEVCqhZO50YeG/P/3mARytXQy3DWTy
	Jk3skvw8yfywYvXDMc5XcGkuFPFPdH3RCZIcuDBMEGX81d3M1JGSeIEUj50NEnHA1VZjDVUJ7+jH/
	fcZC1qcvE4kQfLLJ5ZUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcBts-00BYKc-28;
	Tue, 14 Mar 2023 21:09:40 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcBto-00BYIj-2S
	for kexec@lists.infradead.org;
	Tue, 14 Mar 2023 21:09:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=at3EKPja1uG1hmcCODKYPMrJbShMRNNICkl1wIPJzMY=; b=Qy7k5A1PS+h2KnPWMfTWl6/snU
	9RckXkr3ONay6tR1mB5X3zm5L9qM9SWE+pDq7q6a6Ua5VE6Q4TdK3zSrpW714+Vqbt5Q74uqUp/kU
	yt5qtm+8cg3U/n1Ua+yXObM1k4NDdVF8EuGedxMBf+xpv24BtvtE/QUHvEt0e9ufFiAvSLK3rB+Ex
	mOzygRfap1Tw5wVMDoC6zKski4B8UXm2AEIgmErjD0UWfqeAJ2A6JV1WiUUVtD+oQ4piQku/+MIV2
	vGn7fv64qzJduvcdXEnWj8HKgO5rB65xtddOm1T8/p/81XpLBoi6EMIaWsCKPpG6lLjRbWg4kQ0jV
	042UY5GA==;
Received: from [152.254.169.34] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1pcBtD-00ATZw-UZ; Tue, 14 Mar 2023 22:09:01 +0100
Message-ID: <2d1ad49c-d38e-ef06-8737-766ab0566251@igalia.com>
Date: Tue, 14 Mar 2023 18:08:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] notifiers: Add tracepoints to the notifiers
 infrastructure
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, bhe@redhat.com,
 pmladek@suse.com, xiyou.wangcong@gmail.com, dmitry.osipenko@collabora.com,
 rafael.j.wysocki@intel.com, bigeasy@linutronix.de,
 valentin.schneider@arm.com, kernel-dev@igalia.com, kernel@gpiccoli.net,
 Arjan van de Ven <arjan@linux.intel.com>,
 Michael Kelley <mikelley@microsoft.com>, Steven Rostedt
 <rostedt@goodmis.org>, Xiaoming Ni <nixiaoming@huawei.com>
References: <20230314200058.1326909-1-gpiccoli@igalia.com>
 <20230314135015.789369cd9f71b39a5b7eb291@linux-foundation.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230314135015.789369cd9f71b39a5b7eb291@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_140937_099040_CCD3768E 
X-CRM114-Status: UNSURE (   8.58  )
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

On 14/03/2023 17:50, Andrew Morton wrote:
> On Tue, 14 Mar 2023 17:00:58 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> 
>>  include/trace/events/notifiers.h | 69 ++++++++++++++++++++++++++++++++
>>  kernel/notifier.c                |  6 +++
> 
> Perhaps the filenames should match, which means "notifier.h".

Hi Andrew, thanks!

Do you want me to re-submit? I see some emails of the patch getting
added to "mm-nonmm-unstable" (and also a checkpatch fixes you added on
top of that). Lemme know how should I proceed.

Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
