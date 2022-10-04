Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA65BC433FE
	for <kexec@archiver.kernel.org>; Wed,  5 Oct 2022 14:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oMIsXVoVRGQO6c4NmK/x4PaTottfCWah9qkdyCzubBc=; b=DfeWzF7EN3Je3R
	n/q1m0UWvw93Pt5mRhNQ5vJ1GbEneSZAn5IfI7LSKK5IS0vcI4rgULAu+sey9nGTtRAdZIWjHVcJ5
	IZPaUxvW0etJ8Rd4HhJQsGqIYoVqD/w+uJjfSGAsxbKY++t3i+mEczqQWcrbOdGzQ3uiv86FGV8iC
	lfbwxXAGtiF5Dzv7hfCsGKF0yWwUAEaPrIIQBUNjwG4n0G/IFVzCW78uit2Y5YN7g+Bnq3p3M+TzN
	gD2b+Ks+ZYweHsQbVlNcQcfturpF6AFygMuTz7Vasn0YtmGoEvybHIsH9UbQtlJZOvUAAu0pQDfn6
	ZYUxnfE3eSoImuXxe8/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1og5n2-00Egj7-JA; Wed, 05 Oct 2022 14:54:28 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oflbh-00AHUt-IN
	for kexec@lists.infradead.org; Tue, 04 Oct 2022 17:21:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hokMvwUvC6WY6K6ImCsYV+ueNRiNrpYF/k8XAZd7sAk=; b=Ado5fIYMbjxa5xEPPKKiRl2lzA
	OENqeVqw/Qg/6a5d1buSQJyKoWl04CaWPv+03rs09qxh0nE+hNsmSELp49FQIZR45cbrgKo6X9+8X
	uvovB5sICky0oOntRnVG17JZ0Q0kUaDjUwN4c9g8pfkZcmLOKu2ejIJ5kfaMscYCZdw+fE5cHge5G
	NNWI47aGGacEwFp88KVy6GrWnC841uXZeo2iktc/42csiIq60VoXtxL/6zzrKJagPIMqUbhIS0Mb6
	ejK+Z5WSBtW70Tu4xk3rdeeiWN0ooY9D8HKoWWPv1M0bBo5prdKwU8N/wSnM67VBuPLUKeAr2i1bn
	zwn1lebg==;
Received: from [177.36.159.102] (helo=[172.17.2.30])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oflb1-0082Ol-7v; Tue, 04 Oct 2022 19:20:43 +0200
Message-ID: <ae0a1017-7ec6-9615-7154-ea34c7bd2248@igalia.com>
Date: Tue, 4 Oct 2022 14:20:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V3 10/11] drivers/hv/vmbus, video/hyperv_fb: Untangle and
 refactor Hyper-V panic notifiers
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
 "will@kernel.org" <will@kernel.org>,
 "xuqiang36@huawei.com" <xuqiang36@huawei.com>,
 Andrea Parri <parri.andrea@gmail.com>, Dexuan Cui <decui@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, Wei Liu <wei.liu@kernel.org>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-11-gpiccoli@igalia.com>
 <BYAPR21MB16880251FC59B60542D2D996D75A9@BYAPR21MB1688.namprd21.prod.outlook.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <BYAPR21MB16880251FC59B60542D2D996D75A9@BYAPR21MB1688.namprd21.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_102126_738990_578D599F 
X-CRM114-Status: UNSURE (   9.27  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 05 Oct 2022 07:54:21 -0700
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

On 04/10/2022 13:24, Michael Kelley (LINUX) wrote:
> [...]
> 
> Tested this patch in combination with Patch 9 in this series.  Verified
> that both the panic and die paths work correctly with notification to
> Hyper-V via hyperv_report_panic() or via hv_kmsg_dump().  Hyper-V
> framebuffer is updated as expected, though I did not reproduce
> a case where the ring buffer lock is held.  vmbus_initiate_unload() runs
> as expected.
> 
> Tested-by: Michael Kelley <mikelley@microsoft.com>
> 

Thanks a lot for the tests/review Michael!

Do you think Hyper-V folks could add both patches in hv tree? If you
prefer, I can re-send them individually.

Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
