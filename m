Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCB7C00144
	for <kexec@archiver.kernel.org>; Mon,  1 Aug 2022 15:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HMCOfkHmM4hFZDbpga2HBZga2PVR0MKBaS3LcX7bQX0=; b=kLMFJZPDuIAncx
	iTrumMmLIhlHxOlbJHr0QVctr/AuIR5ldnbZv6zZRdfVdSiZMQKh0Gcx6COPZAFyl5kPoeIbqgVGy
	aXQDpCatyuNCcYJLkJLpJ/yX5Ybn3yh2HY0lRVJ1yjFaMK/j1ER3bvsrlNRNXAgIqv6eAZ42ovDU9
	p+X9ZL724nvJYMPz27+30YDAUf2MF9Torudks2cNk8ql8CNR+DA9ox1FMh4DYq7R2sjCC1GGOhR2K
	6t/pRN7wH6rUg88DiqxutCdfGD7kQcjHBkllO5z+SUxs+uaxQXgjKKzqlpC1slr9JBbWgPWXf7uT2
	a1R4njjagvfKpRscNDuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIXai-007YAl-Fv; Mon, 01 Aug 2022 15:44:24 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG6Dj-0031VQ-Ur
	for kexec@lists.infradead.org; Mon, 25 Jul 2022 22:06:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YyhxX2mWLvi9NimhQGcKzGIHUcpD9uFByKnTgfQXT2w=; b=PGkpTuxYoVATcBmmo5QpTR9OdU
	CwxiCUUyg+Y43WZFKPZI8tVhTGlbReOvxwRy9vN5xlFY3Picc9q02QVGon0mk2qr+gc0H6DI1xkdA
	Ocae0c8zKyVjxHiL0K7bl4oQZhe8iJrhJtaQD9dZsgzJVrcCJZAzsov/XHxJWKbmbo5ftSD95pWKz
	UFCnlx6Icb4+P+rIPF6DDujCPBhMW2lOCenPqvqjXpVKjdwjx9mBL17sU/cCfl+FmUrx7l2Dspgvf
	whmOYidPV6T/it/Bz3pnx0XUGVjPveeRJzlInsHK3oB41Rw1lJRpzg9VZc6aVCj990v9DlchEvxp+
	pb2gaO3A==;
Received: from [177.51.67.168] (helo=[192.168.43.24])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oG6D1-006U4U-LN; Tue, 26 Jul 2022 00:05:52 +0200
Message-ID: <da0ed272-1d47-dd1f-9ad3-46b5adba2dec@igalia.com>
Date: Mon, 25 Jul 2022 19:05:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 11/13] video/hyperv_fb: Avoid taking busy spinlock on
 panic path
Content-Language: en-US
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "bhe@redhat.com" <bhe@redhat.com>, "pmladek@suse.com" <pmladek@suse.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "halves@canonical.com" <halves@canonical.com>,
 "fabiomirmar@gmail.com" <fabiomirmar@gmail.com>,
 "alejandro.j.jimenez@oracle.com" <alejandro.j.jimenez@oracle.com>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "dyoung@redhat.com" <dyoung@redhat.com>,
 "feng.tang@intel.com" <feng.tang@intel.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "hidehiro.kawai.ez@hitachi.com" <hidehiro.kawai.ez@hitachi.com>,
 "jgross@suse.com" <jgross@suse.com>,
 "john.ogness@linutronix.de" <john.ogness@linutronix.de>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "luto@kernel.org" <luto@kernel.org>,
 "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
 "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "vgoyal@redhat.com" <vgoyal@redhat.com>, vkuznets <vkuznets@redhat.com>,
 "will@kernel.org" <will@kernel.org>, Andrea Parri <parri.andrea@gmail.com>,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 KY Srinivasan <kys@microsoft.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-12-gpiccoli@igalia.com>
 <PH0PR21MB30252061CD7F2FD15BD77F7ED7959@PH0PR21MB3025.namprd21.prod.outlook.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <PH0PR21MB30252061CD7F2FD15BD77F7ED7959@PH0PR21MB3025.namprd21.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_150636_043697_B42747B2 
X-CRM114-Status: UNSURE (   7.52  )
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

On 25/07/2022 15:09, Michael Kelley (LINUX) wrote:
> [...]
>> +bool hv_ringbuffer_spinlock_busy(struct vmbus_channel *channel)
>> +{
>> +	struct hv_ring_buffer_info *rinfo = &channel->outbound;
>> +
>> +	if (spin_is_locked(&rinfo->ring_lock))
>> +		return true;
>> +
>> +	return false;
> 
> Could simplify the code as just:
> 
> 	return spin_is_locked(&rinfo->ring_lock);
> 

Sure, makes sense! Thanks for the suggestion, I'll do that for V3.
Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
