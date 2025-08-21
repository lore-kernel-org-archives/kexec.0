Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C35CA0EFA
	for <kexec@archiver.kernel.org>; Thu, 21 Aug 2025 23:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DTum6aUzoTd06Yz6vcVkFrgl9Z1aazJsHYJ0yk4IY3s=; b=AmyMpogGA3gejX3ipMWWz6F1f+
	jv2VK7IObu273cj0PucUrrYB4N7UNqppzfgneDB+sPDhrdqGU8BjMBJ4mQo4MNzNMNvQcjtFS9EN7
	nf9DE8FVzhvEocv4sLpvEyChiOj3wjWZ6Si3p1yDN7C+8JgVZvesWF1ALxk1JjG16Nndeco+c2RCb
	IHJ+R8ZP1s8bKQgtqdbiU4QCwV1ARbs47mIommjb9WCfv7l0HmqzFg+T2wYLCIeMViLLqtRY9eyPN
	BG+5fnokyj6uwIWPSA4f6vPrWtbou8Rz+6hJPlTEeGdfl6iZrMUqiuuj/WCMnuchQVMW9u9+LMM3L
	ikuT8Khw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upF6Q-00000000yfb-2DyH;
	Thu, 21 Aug 2025 23:53:54 +0000
Received: from gerbil.ash.relay.mailchannels.net ([23.83.222.67])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upAY4-00000000DYx-2zno
	for kexec@lists.infradead.org;
	Thu, 21 Aug 2025 19:02:10 +0000
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 76A48164DBB;
	Thu, 21 Aug 2025 19:02:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a203.dreamhost.com (trex-blue-8.trex.outbound.svc.cluster.local [100.96.56.164])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A878A164DF0;
	Thu, 21 Aug 2025 19:02:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1755802924; a=rsa-sha256;
	cv=none;
	b=UHJ9p/ve0mOlfSAVmbpIipZIOd5OfU9KF0jnoS0tKPAx89VDGY9eegjAdErUKlTpZjABt7
	Wwxwnjs2KzYeQ6sBWeFUcyE1F0CX+pWlcILdS9n9GzEKcjOt5RPNha97AbZJ8T2b3QWxIy
	MenxIdPWfscCL/Z+Uny2+ODVY1d0vFnKZUZSpjR/wVl6zbq2yYQUmzx2vHJG9gWMCM8uvR
	lwdlfsy3JiI1F+gZUG8G7LoUQ77QwUx+s5otgg5cg82LAY+TTXc3opevcssGu6wNUIRc2J
	65KBoYzqGsBpZo+h2ykCu4VRSrXgYdSWMuMn9WI7CnzyopiQypT+Gk0SliCF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1755802924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=DTum6aUzoTd06Yz6vcVkFrgl9Z1aazJsHYJ0yk4IY3s=;
	b=BKyA+s/BXon0kemDwiuV8iP48IimaC9zbRUSiD6M6gUV/8hAdeyi4m3OEL1JOQKwZTBhoq
	GBHwOXSPAICW4DXOona/MYpRCXAN1KHoS7hwEQ7iXRJx/8O/3eiObuGDgxaDcXDk1WfOz4
	Cqzc0Zc4WvXs0oxYYujLJHsxG1b4ShLyWh7K9c+Wycb2h09DcBSkX2Efx1bb4jvx2molO2
	8ezyKJI1KHXheXnwdE53BKJr1ed2JIKUJYNycXADpj1CibuOK+u9tBIcuZRZTlk/cZ+IGI
	I5OkNPS8Jj3qmh5ZiVA4DkxA9tW3edY6Vyg2qomewSLIWY0kfYgIK0SWWSNEJg==
ARC-Authentication-Results: i=1;
	rspamd-75798d6c54-cc4rx;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Celery: 53726d696e0ad8ed_1755802926174_204621990
X-MC-Loop-Signature: 1755802926174:3800453157
X-MC-Ingress-Time: 1755802926174
Received: from pdx1-sub0-mail-a203.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.56.164 (trex/7.1.3);
	Thu, 21 Aug 2025 19:02:06 +0000
Received: from [IPV6:2607:fb90:faae:51e1:d9d4:2e42:ae75:9827] (unknown [172.58.14.113])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a203.dreamhost.com (Postfix) with ESMTPSA id 4c7CNp0xkPz7J;
	Thu, 21 Aug 2025 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1755802923;
	bh=DTum6aUzoTd06Yz6vcVkFrgl9Z1aazJsHYJ0yk4IY3s=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=r58bI+fxGbZgg/ecLcgnOoYTOsYVltmH7NUpfsqm9MIMlhkgEJ/R/hjN9ruivne1/
	 WctMiTgjRs0ar/91i1xNyh06ocfuIQPaX2H+e/2/4d3Y9+Mt86cVas8aVEaM8iyuro
	 wO2cogZANhQLwsUy2j3bgPV2mKBtkBtYfmiG6p7KAhv99Skigd3uxBZsvs1ny+r4gs
	 hKwPhioSR2YX0+4M5D1nhN9pLn/qdO7Xz75aAJAZna8evySkILVK+ec+W8fAcZQNjS
	 HI5RZzRz/YW6mOdvtVbUEVpJTRRrxggklUipTF77RbatfMCyz2X2x1fO/INWF7NcXv
	 QXTrn8A2N8O6Q==
Message-ID: <da1b1926-ba18-4a81-93e0-56cb2f85e4dd@landley.net>
Date: Thu, 21 Aug 2025 14:02:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: Add 'rootfsflags' to set rootfs mount options
To: Christian Brauner <brauner@kernel.org>, Lichen Liu <lichliu@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 safinaskar@zohomail.com, kexec@lists.infradead.org, weilongchen@huawei.com,
 cyphar@cyphar.com, linux-api@vger.kernel.org, zohar@linux.ibm.com,
 stefanb@linux.ibm.com, initramfs@vger.kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz
References: <20250815121459.3391223-1-lichliu@redhat.com>
 <20250821-zirkel-leitkultur-2653cba2cd5b@brauner>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <20250821-zirkel-leitkultur-2653cba2cd5b@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_120209_024058_6C0FF4F1 
X-CRM114-Status: GOOD (  17.31  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 8/21/25 03:24, Christian Brauner wrote:
> This seems rather useful but I've renamed "rootfsflags" to

I remember when bikeshedding came in the form of a question.

> "initramfs_options" because "rootfsflags" is ambiguous and it's not
> really just about flags.

The existing config option (applying to the fallback root=/dev/blah 
filesystem overmounting rootfs) is called "rootflags", the new name 
differs for the same reason init= and rdinit= differ.

The name "rootfs" has been around for over 20 years, as evidenced in 
https://kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt 
and so on. Over the past decade least three independently authored 
patches have come up with the same name for this option. Nobody ever 
suggested a name where people have to remember whether it has _ or - in it.

Technically initramfs is the name of the cpio extractor and related 
plumbing, the filesystem instance identifies itself as "rootfs" in
/proc/mounts:

$ head -n 1 /proc/mounts
rootfs / rootfs rw,size=29444k,nr_inodes=7361 0 0

I.E. rootfs is an instance of ramfs (or tmpfs) populated by initramfs.

Given that rdinit= is two letters added to init= it made sense for 
rootfsflags= to be two letters added to rootflags= to distinguish them.

(The "rd" was because it's legacy shared infrastructure with the old 
1990s initial ramdisk mechanism ala /dev/ram0. The same reason 
bootloaders like grub have an "initrd" command to load the external 
cpio.gz for initramfs when it's not statically linked into the kernel 
image: the delivery mechanism is the same, the kernel inspects the file 
type to determine how to handle it. This new option _isn't_ legacy, and 
"rootfs" is already common parlance, so it seemed obvious to everyone 
with even moderate domain familiarity what to call it.)

> Other than that I think it would make sense to just raise the limit to
> 90% for the root_fs_type mount. I'm not sure why this super privileged
> code would only be allowed 50% by default.

Because when a ram based filesystem pins all available memory the kernel 
deadlocks (ramfs always doing this was one of the motivations to use 
tmpfs, but tmpfs doesn't mean you have swap), because the existing use 
cases for this come from low memory systems that already micromanage 
this sort of thing so a different default wouldn't help, because it 
isn't a domain-specific decision but was inheriting the tmpfs default 
value so you'd need extra code _to_ specify a different default, because 
you didn't read the answer to the previous guy who asked this question 
earlier in this patch's discussion...

https://lkml.org/lkml/2025/8/8/1050

Rob

P.S. It's a pity lkml.iu.edu and spinics.net are both down right now, 
but after vger.kernel.org deleted all reference to them I can't say I'm 
surprised. Neither lkml.org nor lore.kernel.org have an obvious threaded 
interface allowing you to find stuff without a keyword search, and 
lore.kernel.org somehow manages not to list "linux-kernel" in its top 
level list of "inboxes" at all. The wagons are circled pretty tightly...

