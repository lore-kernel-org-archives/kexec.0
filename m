Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD02C7618B
	for <kexec@archiver.kernel.org>; Tue, 14 Mar 2023 21:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+/ueBxT+pnUhBL3q4pA84+WuGrgqLEwHXqGWdm4kn/c=; b=cU220StslKu3pl
	y56hlJPMesiXWgnNaqhdrKzkLgBRMijHbsTW5W4Rk9SMUEsW1hz71JJ33gfvOne6E2pqYeoc4l1UL
	0DUW+D0DJvs7ysQ57rhuKfSsrA1YAQyGwzCjcRJqzPjO2nDMSto+sHgLMUstVb3s4YqvwqmHn9PCv
	AqIVPVZ/5IK2EgR9rfhhvyz8ofsztHBTnvcX78lH/AyCpPz7bMjegtNVEBEWMnDTI6q1Z7qMikPFv
	bEWCD7rw2sdDru/83LX0TNnhb9/rYWFrA+mbuvJ8Mo+iP6/xCKxF42I8MCR5VE6CrVx7tNMshuJpa
	7GGTLHNfvwpfmvi8iPyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcCHb-00Bavw-0y;
	Tue, 14 Mar 2023 21:34:11 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcCHY-00Bav9-0P
	for kexec@lists.infradead.org;
	Tue, 14 Mar 2023 21:34:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c8YKNDOulGKBFkU6e30QFajptaOddYDXD4U1msaMvSc=; b=jfiT6/wGCSK4hJok38JRVdriQ0
	kztgeKUrgiK4sYFC7JXYut9VLbKNx8k3I/WebyWdMA/0Kq/wx8nY0TXO5UafpUQxE8TjbL44EAuBy
	Nsa4dwr3WcWkP1AY+aKp7VEtUmeX0tI7xZ81iQlsNgVLNEJ6lscUsI5q9BhHQW0HqUDaIeichYGis
	iMnv5pjr0FFsKfiWH7XkFuqviVYKirGYozwcmxR1fMH7jmXbaEH/2yzRDnT7y3a+Mx9gxvchtk50N
	2trLrsH/RcC8PAPGF8bm+rx95Jyi7VegWMU82AgXpTUlncpHoU+b+tqT2mwSLZ2NTQHqnV86PRtcv
	JMvJ/8rg==;
Received: from [152.254.169.34] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1pcCHP-00AVBj-83; Tue, 14 Mar 2023 22:33:59 +0100
Message-ID: <de338659-8346-db8c-f0a8-0d68661ebfd6@igalia.com>
Date: Tue, 14 Mar 2023 18:33:11 -0300
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
 <2d1ad49c-d38e-ef06-8737-766ab0566251@igalia.com>
 <20230314141846.d801ae3dafb6fd2faa7206ac@linux-foundation.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230314141846.d801ae3dafb6fd2faa7206ac@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_143408_164791_5BCFA2C7 
X-CRM114-Status: UNSURE (   8.92  )
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

On 14/03/2023 18:18, Andrew Morton wrote:
> On Tue, 14 Mar 2023 18:08:37 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> [...]
>> Hi Andrew, thanks!
>>
>> Do you want me to re-submit? I see some emails of the patch getting
>> added to "mm-nonmm-unstable" (and also a checkpatch fixes you added on
>> top of that). Lemme know how should I proceed.
> 
> I changed it, thanks.

Tnx a bunch =)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
