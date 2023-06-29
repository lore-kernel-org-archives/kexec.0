Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36770C001B0
	for <kexec@archiver.kernel.org>; Thu, 29 Jun 2023 23:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p2FP6h7qQds8lJMCDJxihf71BFU+51VKytYL6XTYfJ4=; b=wgiIR1MqhSgnqx
	hZ/JJ06LZZobd1rEqCgCq+UKGqPzlmD9w5PDz5HQfrthYPG5zaH1drukbQNxGMaIGozg6Tvj/R+gC
	Wumuvgc9egkOaPYWRaIhBbEbehOfkV8cyYBYnE6XV5eFy24JINHdIBJIdt+pAdBi9RJPNVEL6JI71
	8aDqP+zrD+wU9E+OVC9f+rdZShIXZSivBbBQwhtYde6dPD5vmj6NRU2WMf1GYIFV6Wp4lYhnRY9Lp
	wIX0AwQy9QndK/m2F2CqWWoGNSk1hn+vpH1njhlTBdadN+zVyEnEDGdCBfLgNs8lRfX5AeUXOmwH9
	YI0Ry1416nXZnOrZ+9fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qF0wK-002SBy-2S;
	Thu, 29 Jun 2023 23:20:40 +0000
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qF0wG-002SBW-16;
	Thu, 29 Jun 2023 23:20:36 +0000
Message-ID: <f907d71b-bd00-5649-d577-bf9f53fc2f83@infradead.org>
Date: Thu, 29 Jun 2023 16:20:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v25 06/10] crash: memory and CPU hotplug sysfs attributes
To: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
 david@redhat.com, osalvador@suse.de, corbet@lwn.net, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 bhe@redhat.com, ebiederm@xmission.com, kexec@lists.infradead.org
Cc: hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
 vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
 akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
 zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz, tiwai@suse.de,
 seanjc@google.com, linux@weissschuh.net, vschneid@redhat.com,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, sourabhjain@linux.ibm.com,
 konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230629192119.6613-1-eric.devolder@oracle.com>
 <20230629192119.6613-7-eric.devolder@oracle.com>
 <c9d4e623-5c8c-885f-4343-980798647a0a@infradead.org>
 <e0f5adf6-4f47-75c7-5697-5e928bee14b7@oracle.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e0f5adf6-4f47-75c7-5697-5e928bee14b7@oracle.com>
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



On 6/29/23 15:31, Eric DeVolder wrote:
>> Did you test build the documentation?
>> It looks to me like the end-of-table '=' signs line needs 3 more === to be long
>> enough for the text above it.
> 
> Hmm, the 'make htmldocs' renders and views ok. Is there perhaps another method I should use?

No, that's it.
Sorry about the noise.

-- 
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
