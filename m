Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78850EE57C2
	for <kexec@archiver.kernel.org>; Wed, 11 Sep 2024 15:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ySPETofK7tLBGCEIf7l5Iery60uwni9rSdOHab4+UQA=; b=nd5+vpDcteB6Ye
	Nvf5yyYDWyVj2CX3SXcLsbfK2Ab78bZ03AGYsMc45jjYYIFRS5t5GSqeM/NI0Boev7ohlcUrkR5KW
	Z5J00jOkVHvtjZQGWxSZ2eG/0PxDI9+arulF3kfR6PmT9Ig4JXhTqCLS0obbgBZ6qURMxouMXZanT
	1nU/4gTV1TgJ3/2X97RBZXZUO697S71fLVhlmkG1QIg+8hrC0MdSjJJAMy2K7Xck5Q6k7/7UzAh1x
	sZkzr62uatyN/PoHb3PGvFWT1gDXxz1+3vB133/O/rc9DjyCrrfDk8uHxkP3YXhE91fLAlvTheamy
	xDVGxv03Xmk2yri5xq8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soPAe-0000000A7sm-08Qv;
	Wed, 11 Sep 2024 15:22:16 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soOzF-0000000A5Mc-3ewi
	for kexec@lists.infradead.org;
	Wed, 11 Sep 2024 15:10:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iSUmAoKbkFC1zgzAwsv+m6BjssQM8FyL0ByRqeFy6+I=; b=CZKvIOj7HFsJS0sdHhYovrfpue
	oo92pRbxJYzGUfB2zrQwfScKO4eESbCllOLYBd6xMu4DIFZ5hQjmPaN6p+FSw/zaAPn99YsB8o483
	FFW+GGCJHG8uedG1UApHD93E3r55OaLsWXNKe+gfZnhhaKFK7BPxJeuKdJmWKC3xRiaB7BaVjnNLU
	GkHusTCXSwzDr2eLMIwMJTIQmx9E3QoWTiNpXcEMm+w56j7+N7zT8aDU5fwuqOo9TbExjAygmHnIe
	HKcNAymcqlf64ASd/BMN686Z49TG/j8/r2/TlOXW5J4M/3jh1AY1p7NNvos8B8QW6E+0VzKQ4biCk
	0Xo7ZPcA==;
Received: from [195.69.0.8] (helo=[172.21.208.109])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1soOzD-00CUVu-4l; Wed, 11 Sep 2024 17:10:27 +0200
Message-ID: <121b62a7-bd2d-0ded-97a7-ac890831ca63@igalia.com>
Date: Wed, 11 Sep 2024 17:10:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2] Documentation: Improve crash_kexec_post_notifiers
 description
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, bhe@redhat.com,
 corbet@lwn.net, kernel@gpiccoli.net, linux-kernel@vger.kernel.org,
 stephen.s.brennan@oracle.com, kernel-dev@igalia.com, dyoung@redhat.com,
 vgoyal@redhat.com, linux-debuggers@vger.kernel.org
References: <20240830182219.485065-1-gpiccoli@igalia.com>
 <20240902082342.GC23170@kernel.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240902082342.GC23170@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_081030_015877_AAC7DB7E 
X-CRM114-Status: GOOD (  14.16  )
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

On 02/09/2024 10:23, Simon Horman wrote:
> 
> Hi Guilherme,
> 
> Some subjective grammar nits.
> 
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index efc52ddc6864..351730108c58 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -913,12 +913,16 @@
>>  			the parameter has no effect.
>>  
>>  	crash_kexec_post_notifiers
>> -			Run kdump after running panic-notifiers and dumping
>> -			kmsg. This only for the users who doubt kdump always
>> -			succeeds in any situation.
>> -			Note that this also increases risks of kdump failure,
>> -			because some panic notifiers can make the crashed
>> -			kernel more unstable.
>> +			Only jump to kdump kernel after running the panic
>> +			notifiers and dumping kmsg. This option increases the
>> +			risks of a kdump failure, since some panic notifiers
>> +			can make the crashed kernel more unstable. In the
> 
> nit: In the configurations -> In configurations
> 
>> +			configurations where kdump may not be reliable,
>> +			running the panic notifiers can allow collecting more
>> +			data on dmesg, like stack traces from other CPUS or
>> +			extra data dumped by panic_print. Notice that some
> 
> nit: Notice that -> Note that
> 
>> +			code enables this option unconditionally, like
> 
> Maybe: some code enables -> some configurations enable
> 

Hey Simon, tnx for the suggestions, will change in the next version.
Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
