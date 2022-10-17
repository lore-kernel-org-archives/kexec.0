Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB114C4332F
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 13:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=R4M2Bubu7OdN/5NDcC9a1GTZ+aiKFEJrWtS27YsDIEA=; b=Po8d/5v/Qh3mwU
	pSR9sjDLNOA90nJ3oMO9bQjQcmVmXyg+Xj0ui3GGNhIfhnC38QqqkS4xbzoIZXmPEhqVMdTghUVcY
	LQNzABLB2jEQq3y6yGT3A0ULUOXZh2SVgNZwTxElLN1PrirogeGyeTrYtXuQ/TUY/I+kAwR+dpZT1
	Q8Wf5w0JcgRSBXTZgmN2ceN/PJ0wQcQm2OfBtr+0wINFMdTGYg5aKtEGabI65v3SVrukm2/8euz7W
	z9OJdVv+CUq1XfPKlTc3q9xuoIZI90TxsaruNenA+v67VTJJNq5BarUHw2s3hv8xCW205oF7oUO4C
	Hx9OWADoEWMoXYF2sZPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olsTg-008K81-Ql; Fri, 21 Oct 2022 13:54:24 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okW2H-00EaY9-BU; Mon, 17 Oct 2022 19:44:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=O7qw3tGrLhskWKqbDCfDfj+wLqZODYlP78Q0++P/SY4=; b=TwFc2lNnhsCPfze3XDnolPfw0x
	Em7u7nbQ/xvyEJY9yBCSew8/yfgmkwT0AsD3QSPQ7fRLYYzDJjj72B4/Iv6Ysg3OHHAQvSeOiG8iF
	taht/B1RHJCtMUs8X8Zk/p3EwGMIQEJuk0zQRaNF/79G/YFTxtzmaMfa+1woSaxoRzvKnSZTkrk/o
	ZczRubAttKxxstE16oxU9S1cIxvz53zw8hLZi53Jla21zuFW+p14OQx2fvbSPk6LVqG0k7IhmwmzN
	Aff99TVmWkm/N0YkxaWGntlzxziZH92hMXRsgdAFeP3ZW0VCKvrbR/WmFB20Pt0k3I0gbNGbk2txi
	wEgIF6ug==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1okW26-000ZvB-0V; Mon, 17 Oct 2022 21:44:17 +0200
Message-ID: <5d2c0413-b19b-eb0b-d1a2-0e0429cccd8e@igalia.com>
Date: Mon, 17 Oct 2022 16:43:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 01/11] ARM: Disable FIQs (but not IRQs) on CPUs
 shutdown paths
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 will@kernel.org, Mark Rutland <mark.rutland@arm.com>, arnd@arndb.de,
 Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org,
 pmladek@suse.com, bhe@redhat.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com,
 alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
 bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com,
 dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com,
 gregkh@linuxfoundation.org, mikelley@microsoft.com,
 hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de,
 keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com,
 xuqiang36@huawei.com
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-2-gpiccoli@igalia.com>
 <a25cb242-7c85-867c-8a61-f3119458dcdb@igalia.com>
 <8e30b99e-70ed-7d5a-ea1f-3b0fadb644bc@igalia.com>
 <Y01j/3qKUvj346AH@shell.armlinux.org.uk>
 <aea7dad7-987d-43ad-3abc-815ede97a127@igalia.com>
 <Y02VGh+eDLMyi/Aj@shell.armlinux.org.uk>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <Y02VGh+eDLMyi/Aj@shell.armlinux.org.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_124429_710599_E238708B 
X-CRM114-Status: GOOD (  11.38  )
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

On 17/10/2022 14:47, Russell King (Oracle) wrote:
> On Mon, Oct 17, 2022 at 11:50:05AM -0300, Guilherme G. Piccoli wrote:
>> On 17/10/2022 11:17, Russell King (Oracle) wrote:
>>> [...]
>>>> Monthly ping - let me know if there's something I should improve in
>>>> order this fix is considered!
>>>
>>> Patches don't get applied unless they end up in the patch system.
>>> Thanks.
>>>
>>
>> Thanks Russell! Can you show me some documentation on how should I send
>> the patches to this patch system? My understanding based in the
>> MAINTAINERS file is that we should send the arm32 patches to you + arm ML.
> 
> Look below in my signature --.
>                              |
> 			     v


Thank you! It seems I was able to submit it properly now:
https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9257/1

Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
