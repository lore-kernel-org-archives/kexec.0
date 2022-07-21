Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4A5C19F2A
	for <kexec@archiver.kernel.org>; Mon,  1 Aug 2022 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zoy4WfHxkM0yBl08hWOXpkapY16P15oEIDZwmoAUTu8=; b=pyaioAg9bhzVvm
	MO10tTUU9uDzBStIdYByT6h8kDFlfotdGV37fpn2PTZtIHGA55NcLkBBYRQnAX8ngZvQaWENHSCSl
	HXo6Bnip6tmqsKySXURwwsagdLY4mN1qscJoOv+l3vgn4uH3MrCsDwzlzx3rTH4hpAAdQxY+ixFaK
	XsvYANHu1Q6Ly3Q8tpvsZMpSWBxToy00b5qa+4KdWTuInYlzn/WHMbjBjCsj1pZ4bGQqAIEcfb/Wx
	z11bo9ZGBGwrKH8KryrvNla4MR8FGaM1lhc1gyd6imRKwO9GsCg29UW0ryokMndYUOOQrTHpfhTKY
	Ksbbo5aPBrbF+WEL0olw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIXaR-007Xyb-3b; Mon, 01 Aug 2022 15:44:07 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEW6P-006ubl-19
	for kexec@lists.infradead.org; Thu, 21 Jul 2022 13:20:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dvQMYkKmqmqqc4VCUTJzR9+SlJpivrjaeB7DHmCLQrw=; b=Q1+WX7NPoQzh6yiUZFQ0Ek4L5Q
	oXH2OmXCRrxRbE85Oi6Wq2PTmx29N2j3HDT6/Xm2pOWm4imLd4Npy0vQ/CpfJc4OqouQx4jVCY7ut
	CCvUU4wc3ndzWek9kufUeAg70npaFEOeR2jPjDxzAos5yTc3y7Ni4EGLfm3tdfaWDslybxoLxX7hz
	mFJPp4qDIAw4knNXpHYjBube1pYG73dPqWeHBQVIZBJ8Sn52tnE5RQjVR9Illm8eritC4URLV3lcU
	jWaCaNEU8V38HykYQ/BwzKqbKcN9aywfP4PoiFsgknm5Hg4sxvGzw8IfBrP2pQEvMPFDJPBCYWYhC
	cQDURkeA==;
Received: from 200-100-212-117.dial-up.telesp.net.br ([200.100.212.117] helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oEW6F-001UJf-1Z; Thu, 21 Jul 2022 15:20:19 +0200
Message-ID: <76b6f764-23a9-ed0b-df3d-b9194c4acc1d@igalia.com>
Date: Thu, 21 Jul 2022 10:19:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 07/13] parisc: Replace regular spinlock with
 spin_trylock on panic path
Content-Language: en-US
To: Jeroen Roovers <jer@xs4all.nl>, Helge Deller <deller@gmx.de>
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
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220720034300.6d2905b8@wim.jer>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_062029_115569_28A40C6F 
X-CRM114-Status: UNSURE (   7.81  )
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

On 19/07/2022 22:43, Jeroen Roovers wrote:
>      Hi Guilherme,
> [...] 
>> + *
>> + * The _panic version relies in spin_trylock to prevent deadlock
>> + * on panic path.
> 
> in => on
> 

Hi Jer, thanks for the suggestion!

Helge, do you think you could fix it when applying, if there's no other
issue in the patch?
Thanks,


Guilherme


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
