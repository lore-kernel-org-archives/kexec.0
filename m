Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6841EC4332F
	for <kexec@archiver.kernel.org>; Tue, 22 Nov 2022 13:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ogenzZ0OiFoKgwl8hyOaEvhkjTaoBotidjJ7h0WEGCI=; b=xFS+eWXAsdxSsN
	O0F0pAIKDEWlA0E0M0peCoBDlN+Bh3RRsdIzI3wkNKlczUySIuSN5rHN0Ib9PP/nfVuqTgt7mOXUw
	P0lUM98ysE1MaN08n0/N4dkY+KBvAa4UvBLKbrSq6YfOr/pER5CBRZiAk1iY7KfwboNdz0EWiY9ac
	82bZI2NtL+tyLw04nGIuc1OsiUvLTWLDcXWUltbdNZGFBN5Rtgh8xs3HeVj91Y3iav0BHqKCSrM8z
	BckvHqU84gmqLgIfAVlu1bNH+Ck5uYnR6CsfkbSxLlAhaM2zRY26CBnTNXFFxq6f3KRixR8Y9oX0M
	JUGEFInRf6GOseyCNfrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxTMT-009f7W-HB; Tue, 22 Nov 2022 13:30:53 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxTMQ-009f6L-Q4
	for kexec@lists.infradead.org; Tue, 22 Nov 2022 13:30:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9So0O8Pi8i8JHhFiG20jjK2ykR3NF1IMBTGdS9HzvSc=; b=gfoaakATo3McgEoQ5zIJQ3Gsom
	dufqZdgPKM+yw0jFFN/K6+V7g7l5QwaZOV/0S2RmCXXt15cNLAvk2VhphewPoXa2YAcaOECIr2gzj
	pP/kEwIlL2NbJOX4eTQidYlo/snxWt1FO1oIKfU5ewy12GTREQtKId7G2AJGDrYUl/GGDIwUtfuDy
	vNGyHBkQ5D11aIgDyyyXqfReJn5NyJiQtwx9VSsqkqWz3H58/Q0jf0A88u5Ryn7UkSAYIOiFRY3MP
	UITEbCNj1Wp77PuPX5qEZ7voLPw36j5yCi+XjucIaEBqYPOrBRSQhGun0A700bXW3ntCeLuarNZlC
	SXGIR7Rw==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oxTM4-006y2D-7E; Tue, 22 Nov 2022 14:30:28 +0100
Message-ID: <9d9823a9-255b-84c7-53b1-47fe51e1d756@igalia.com>
Date: Tue, 22 Nov 2022 10:30:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 07/11] notifiers: Add tracepoints to the notifiers
 infrastructure
Content-Language: en-US
To: Arjan van de Ven <arjan@linux.intel.com>,
 Xiaoming Ni <nixiaoming@huawei.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Valentin Schneider <valentin.schneider@arm.com>, rostedt@goodmis.org,
 pmladek@suse.com, akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-8-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220819221731.480795-8-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_053050_886099_B0B36032 
X-CRM114-Status: GOOD (  14.21  )
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

On 19/08/2022 19:17, Guilherme G. Piccoli wrote:
> Currently there is no way to show the callback names for registered,
> unregistered or executed notifiers. This is very useful for debug
> purposes, hence add this functionality here in the form of notifiers'
> tracepoints, one per operation.
> 
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Xiaoming Ni <nixiaoming@huawei.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V3:
> - Yet another major change - thanks to Arjan's great suggestion,
> refactored the code to make use of tracepoints instead of guarding
> the output with a Kconfig debug setting.
> 
> V2:
> - Major improvement thanks to the great idea from Xiaoming - changed
> all the ksym wheel reinvention to printk %ps modifier;
> 
> - Instead of ifdefs, using IS_ENABLED() - thanks Steven.
> 
> - Removed an unlikely() hint on debug path.
> 
> 
>  include/trace/events/notifiers.h | 69 ++++++++++++++++++++++++++++++++
>  kernel/notifier.c                |  6 +++
>  2 files changed, 75 insertions(+)
>  create mode 100644 include/trace/events/notifiers.h
> 

Hi Arjan / Xiaoming / all, monthly ping heh

If there's any advice on how to move things here, I would appreciate!
Thanks in advance and apologies for the re-pings.

Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
