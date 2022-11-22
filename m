Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5791AC433FE
	for <kexec@archiver.kernel.org>; Tue, 22 Nov 2022 13:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=W3vTJaN4oKYLEZcaSx+iwi6Ns9h6PV009pSRVOUww7w=; b=oAu7GAfvaU8v5N
	AoFiypi4yoR4JFQ0Fw0JMkHAhwwfmACm1+cO55bx+XC4Nn8YcU181e1pxI3skXgiA66NZMZoBVdwA
	Vr32F7FdyT1u7X3mWoEkYziWMlJjYmimSd4EPk2iKlfhICGSUGKz8Pc6pxW4XRItJJxENf4LcOcue
	PCjaYgZMr2FdwOdBcwxYL/JDe3flGX+ugqoeviAwaHfN0CQ3tZ209rAOc7GJAT/AWUSWUjvrw13/U
	2K7/t3qJMmmsSSjR3oQSAsYlkpBS9PCDzOk/Xr0HUrsQPjqolvaYQbqfevSakR6HPe2iYoRBO5Tv5
	bVNfKBuNNLhOopZwaBlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxTIx-009eAn-Sj; Tue, 22 Nov 2022 13:27:15 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxTIv-009e9k-Hh
	for kexec@lists.infradead.org; Tue, 22 Nov 2022 13:27:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hhxyfH2q8uH2ClLtYKVFoYmFg/Zqz1IeRGZh33Rp90E=; b=YIpI6ZN4aaZnSV4XS74JLfn2ab
	HwHXM0sCfl5jPn3JGZu9LGyE1gChqmkfjDnXjkwvTmD72Dl10QxGBN1KKWn2QYXfVX8OnX5/LNITc
	KkqrXNnID4YNPlv0JiMC/7W5QuHAhxvfoeNW5irbas9TNK+0rSskh5n54Yz3gxnkfT9nruRfyycHg
	Qh47Y7f844t2pXYbtTaTGiEj07T68UYcWn0buhcf0nL+KYiaGzLM8RZ7v4+nc26jfgKHQeZahBOYF
	9LXgTj3cfLKD9JnL4rkXnqK9zGUzzCaE1XSgkRjArb3Io3f86fBZFKJKqsqLC63T9Om7tF0uNY0NK
	H1qzHS5Q==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oxTIr-006xwh-AS; Tue, 22 Nov 2022 14:27:09 +0100
Message-ID: <960783ed-a8d1-6dd6-d4ac-7d2f28be9d54@igalia.com>
Date: Tue, 22 Nov 2022 10:27:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 06/11] tracing: Improve panic/die notifiers
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>, Petr Mladek <pmladek@suse.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-7-gpiccoli@igalia.com>
 <20221020172908.25c6e3a5@gandalf.local.home>
 <6e2396d1-d0b2-0d1e-d146-f3ad7f2b39f8@igalia.com>
 <20221020182249.691bb82a@gandalf.local.home>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221020182249.691bb82a@gandalf.local.home>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_052713_618079_72D523B1 
X-CRM114-Status: UNSURE (   9.94  )
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

On 20/10/2022 19:22, Steven Rostedt wrote:
> On Thu, 20 Oct 2022 18:53:43 -0300
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> 
>> Could you pick it in your tree? Or do you prefer that I re-send as a
>> solo patch, with your ACK?
> 
> I wasn't sure there were any dependencies on this. If not, I can take it.
> 
> -- Steve

Hi Steve, I'm really sorry for the re-ping. Just wanted to know what's
the status here, not sure if you picked this one (checked
linux-trace/for-next, didn't see it there) or planning to.

Thanks in advance,


Guilherme


P.S. Trimmed huge CC list...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
