Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5BFC00144
	for <kexec@archiver.kernel.org>; Mon,  1 Aug 2022 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TDN4m5W3lE7/cziGxtOEvr5IdQwihiky8d17K4KPLfA=; b=cp7fFa6gPmQkbT
	nOwD7ndDfq7++GoYkJG6W2Y4oSVv0otfTHNh5QoW9gGkUFwmXyAMLd24DQAOznqQpLm7Qy8SWEYy8
	tyx1LmAPHoqmCY+51o3UPoBUhxtMpINYvvHWBl+3krIcoUz+7CsiTL4GR/j8kbfzuqIXyQCxXgCGH
	TTcn1Fh0W9cQKCZZ4aYi6h3vhzR1xP6Vj+ciLV0rezdFytrpbWpNvF3+vpcykd02Uvv2O4G9HyRt/
	EDE2tgtSuysnQbQAgp/aNHac+mJzpwBjoTYsmQczFi6B1WCXNbWfZKNZy8GXHxVXp/l2DZkBG5S55
	JXMjMPW7FJgji6IYWl+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIXaX-007Y2U-HY; Mon, 01 Aug 2022 15:44:13 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEWje-007RXY-IK
	for kexec@lists.infradead.org; Thu, 21 Jul 2022 14:01:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dlwnS1Fa3TmXXVNwd1KfMLtfg4qW+Hn+l84xHjkNFv4=; b=pM1CVIwQYxiPAKO3GfnMS+lKWM
	v8JWyHbi4HVsskrZQxy4Ji7eppdHhD1UeK7YeES2Rza9Ju3RbEJUXwt5UYgTNVT2z9kdsVJcQZ2L8
	N6sK3PA8ObrNJfk7XzTrJZYWeq5vb9MxU4+a7bb7dfmzv/Ic2EqZMfqBN8NDhXaiSx1krB1zjjBqE
	D6CdkPlu8rryITQUy+7+fBeOogwYiSR19VRwipP0cOL8BciioNlXBMtGct1NVCqFcNqhkzjwMriDU
	fmUlKR/BahxW7dR+bNhJoxAwIaR0xCbzFpxbFgpew/sJHpTkXKvif23GSxed/IZ1m99labnS42keg
	BKnGtb8g==;
Received: from 200-100-212-117.dial-up.telesp.net.br ([200.100.212.117] helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oEWjF-001W4c-TX; Thu, 21 Jul 2022 16:00:38 +0200
Message-ID: <81b1f787-c3d4-1b2d-6b56-38f54947835d@igalia.com>
Date: Thu, 21 Jul 2022 11:00:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 07/13] parisc: Replace regular spinlock with
 spin_trylock on panic path
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Jeroen Roovers <jer@xs4all.nl>
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
 peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
 stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com,
 vkuznets@redhat.com, will@kernel.org, linux-parisc@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-8-gpiccoli@igalia.com>
 <20220720034300.6d2905b8@wim.jer>
 <76b6f764-23a9-ed0b-df3d-b9194c4acc1d@igalia.com>
 <7e5dce87-31c1-401f-324a-2aacb6996625@gmx.de>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <7e5dce87-31c1-401f-324a-2aacb6996625@gmx.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_070104_880603_739F0BD3 
X-CRM114-Status: UNSURE (   5.16  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 01 Aug 2022 08:44:02 -0700
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

On 21/07/2022 10:45, Helge Deller wrote:
> [...]
> Guilherme, I'd really prefer that you push the whole series at once through
> some generic tree.
> 
> Helge

Hmm..OK.

Some maintainers will take patches from here and merge, but given your
preference I can talk to Andrew to see if the can pick via his tree
(along with the generic panic patches).

Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
