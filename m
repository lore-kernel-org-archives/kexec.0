Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E977C433FE
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 13:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lK/dcmplgibh00TTvEvC3m6WU9xdNZwP5YUOKWKGQis=; b=ZEWBhhqGYF5p+U
	uQWBnMuf/uj3fgkPLWhd5UBaRl4TN17O4XFxP46aEmkB7WiEAqLDYR1YkP7p3t2sQAOJbzj8MvHTm
	/gtZtIqrkPsxIBoKeHzGFLBFvh7BXLV6GGLdD1LBmAYwsMnY9sX4zCfNUQChXC64KdaaT/KxbYFDX
	O0+Cg0kRP8i/s+udrAc+zt/DS7zI+wFOAaTf+9/6YB3JtO2yQmHmD/oo7/DcEhoKze6uIbUIZnRYi
	uAdnTPSOOZMvswpzKVed+B0zdqYK1tiGz6uvNfoxPHs0nJTyI6E3aJuI/bmpq+W+W39Lq6ilb4sVL
	fyaHfl2uJdKYbq4SWcPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olsU0-008KdH-WA; Fri, 21 Oct 2022 13:54:45 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oldUo-0025YK-Gy
	for kexec@lists.infradead.org; Thu, 20 Oct 2022 21:54:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cEtqs1MQcagup4Gfi2oEJoAWnCl0qRYzXZ6/4HturA0=; b=GUCP/T6HJlhOD1kPHYTJmDGe8g
	uhbjtDkiaMbCrXGwggLm3/TWw+xbb4ycvLWpyQGUIQpZOOKOK+ICd/aEssRNRZht3nOLrO0trUzQN
	NbtDUF6gE/eWfobD5uQj5B96MIgB/rOAKtV2VJaZfUdJCN1MaVvQDZwfRpLHoE3i5PMqAAJw8VXVX
	JeZjUgfhOTEb77zoYZZ2jIGV+1JYpVraB8B3SzHNtJfJJIMc+m5xGxUktfotOkSOK+xnpjFLPq5BE
	iamrDYO9Df/UXdouwOrbD3mcJUoegEOUUxuDjoT7pb+acgiZkk0Ubd66HojweepGmnTRCx916xjqa
	0/Qo9XgA==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oldUH-002UDP-4v; Thu, 20 Oct 2022 23:54:01 +0200
Message-ID: <6e2396d1-d0b2-0d1e-d146-f3ad7f2b39f8@igalia.com>
Date: Thu, 20 Oct 2022 18:53:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 06/11] tracing: Improve panic/die notifiers
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com,
 fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
 corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com,
 dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org,
 mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com,
 john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org,
 mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
 peterz@infradead.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org,
 xuqiang36@huawei.com, Sergei Shtylyov <sergei.shtylyov@gmail.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-7-gpiccoli@igalia.com>
 <20221020172908.25c6e3a5@gandalf.local.home>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221020172908.25c6e3a5@gandalf.local.home>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_145434_935608_FF7A80A7 
X-CRM114-Status: UNSURE (   6.07  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Fri, 21 Oct 2022 06:53:58 -0700
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

On 20/10/2022 18:29, Steven Rostedt wrote:
> [...]
> Sorry for the late reply.
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

No need for apologies! Appreciate your review/ack =)

Could you pick it in your tree? Or do you prefer that I re-send as a
solo patch, with your ACK?

Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
