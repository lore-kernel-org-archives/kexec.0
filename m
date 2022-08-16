Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A45C25B08
	for <kexec@archiver.kernel.org>; Wed, 17 Aug 2022 14:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0aulfhOQPNMMQGJdnsv9ygI+0tgkpUr0/oE/w6c/izM=; b=vibyXCeB6h2R6P
	u8bVhFIuc/bD5c2d2Dw/OmG8Fx1L5jtarXysSQ1K1cffqMQbmewr0STUr2iepJl/n7NxWPh3LCM4s
	jKTfEu0fGguSWjtzOIec1ssIaZzflJhvlCzbdHJ4XBo1fxklfa608QmYAprYRj4lziwbc0WB3qab9
	LcDl0CFqCylscIm/jcC/USrcNW9Yyj0Nxw3vTKHLAO1AYjAqjfJ4ROechB9SwC4rB3JhsEGwAw9hn
	O9BPMC2WqBaOFkNMIL5QWZDeWVCRuhxxYbkpygB1ZlvWYbANcGQ8ZRp3qhRADXo0Dez/s9C7BMeBp
	4WoJLmiGUsUHVLS5SCDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOJrW-002l9g-V7; Wed, 17 Aug 2022 14:17:38 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oO2zv-006iMj-Vl
	for kexec@lists.infradead.org; Tue, 16 Aug 2022 20:17:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pZZrETtmIKdExVtzVzQ8UXA3eX9WZ6xF2u4zNFYqj/s=; b=ptR8j4dyawkqM37lf86AbKOFwy
	vqD50LNT3FK4b3Ha/zFTVqxf8zbh3as0oeroZaX2TnivXLllApZfmMbDzp8qAWTXqFTbpSfaGHF0M
	fGxN+PX2kx8r82YMpSjijG5sV1i4AJ3z7/651SDn3tt7vvF34lL8Cw1zArzLWGGCqiDFTlnFroQ/O
	5az02/1DGkptKGyHRtFk1d5VW8G2DCfsRqvfE6Zwy5OCe/NROVnv7MEnif7q2Ohiv81GpvC/S4Fqf
	dBzhukKSo/tmSLNp0plhiwEcbku8B/ZsP+BOQSlMf5f1yudhZ/U0xeMxA3KNfSl3VsKfa80FtLsYm
	TV6FA3wA==;
Received: from [179.232.144.59] (helo=[192.168.0.5])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oO2zs-00AHrG-K9; Tue, 16 Aug 2022 22:17:08 +0200
Message-ID: <7da27e6f-ff45-9b28-5b67-ab8eabca1ed2@igalia.com>
Date: Tue, 16 Aug 2022 17:16:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 10/13] EDAC/altera: Skip the panic notifier if kdump is
 loaded
Content-Language: en-US
To: Dinh Nguyen <dinguyen@kernel.org>, kexec@lists.infradead.org,
 linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>, bp@alien8.de
Cc: akpm@linux-foundation.org, pmladek@suse.com, bhe@redhat.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com,
 alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
 arnd@arndb.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com,
 dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com,
 gregkh@linuxfoundation.org, mikelley@microsoft.com,
 hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de,
 keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-11-gpiccoli@igalia.com>
 <9f114876-d402-6e74-c1db-4e4983c2d695@kernel.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <9f114876-d402-6e74-c1db-4e4983c2d695@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220816_131712_076331_CA6771F2 
X-CRM114-Status: UNSURE (   7.21  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 17 Aug 2022 07:17:28 -0700
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

On 16/08/2022 15:44, Dinh Nguyen wrote:
> [...] 
>> V2:
>> - new patch, based on the discussion in [0].
>> [0] https://lore.kernel.org/lkml/62a63fc2-346f-f375-043a-fa21385279df@igalia.com/
>>
> 
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>

Thanks a lot Dinh!

There is something I'm asking for maintainers on patches in this series,
so here it goes for you (CC Borislav / Tony): do you think it's possible
to pick this one in your tree directly, from this series, or do you
prefer I re-submit as a standalone patch, on linux-edac maybe?

Thanks,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
