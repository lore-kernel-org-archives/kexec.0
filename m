Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCFAC3ABC9
	for <kexec@archiver.kernel.org>; Tue, 13 May 2025 03:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tH28IR6cEDMJu6Zp6rniPm7B0/eMWW2T/aX6be9+u0c=; b=F98EyVFc3EGGftInskIy44uWma
	ZyHjYRm+kCcgUqUUgtQ1DAtCN/SABPW2CTVGjZFxJ2FQj58sht6ZEHLWqUddIEBZqKuL3zmT5V6uv
	DIKoErqOPrATvVlvFlult903PY5aMg1XifzStYRLJUQhd18ghJiidTQBfQ9sSXAxOA6tMdYPPZvzk
	Jxk4vrKpoWfS54OiR8fC2FcHBLGwQ3eLZO6N9ADdWXAuHFJGfgFqU2CAE429g1iA8Wg4d6r2beDlc
	upE2dnf9vJxcFMGfkTmRQGkkF2JMPG53uoJ+GQ1Ef+DlQMfXY3Z22bXMH8GMPssBXQkp6OmGx+8b0
	TBJYUCNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEgjz-0000000BHBN-17Wl;
	Tue, 13 May 2025 03:55:39 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEgjv-0000000BH9e-39MP
	for kexec@lists.infradead.org;
	Tue, 13 May 2025 03:55:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747108528; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tH28IR6cEDMJu6Zp6rniPm7B0/eMWW2T/aX6be9+u0c=;
	b=QnSuCW8NmQmaTwybPF6PtvksGCtIhNuGLLenUZoMIuaM80+KeUZy+YNDW6TGwY2KgQmBhEIQDOXmYHRp7WZ5RYXK6mxu91/btxrYOgcgCxiin9DpMwRT8jV/uypeBtOcOJxDz1bJelnSCp0wXu82xMGfF4pAtDTEvL2vj8B0iec=
Received: from 30.221.65.46(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WaRTmuN_1747108522 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 May 2025 11:55:23 +0800
Message-ID: <9c4b14de-692a-415d-876f-c72e42aaba6f@linux.alibaba.com>
Date: Tue, 13 May 2025 11:55:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
To: Coiby Xu <coxu@redhat.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Baoquan He <bhe@redhat.com>,
 chenste@linux.microsoft.com, RuiRui Yang <ruyang@redhat.com>,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 Christian Brauner <brauner@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>
References: <65057b5256a28c3416e6b90a143d741801e68b03.camel@linux.ibm.com>
 <Z/MrpIv9EWftPhbD@MiWiFi-R3L-srv>
 <02563b1e8b0000bedf94ded447a8372f21d4304a.camel@linux.ibm.com>
 <Z/Xero1B0OazLcHL@MiWiFi-R3L-srv>
 <db0f463cbf4ad9b9cf9f9a23c5869a751ad12bba.camel@linux.ibm.com>
 <Z/8ijFhIf1J6vbWM@MiWiFi-R3L-srv>
 <f75tvrcc6xhfwz5rbwh2ps34wt2odz4wq32vez7dsct732x4ik@sv6nyjqr2ykr>
 <80766b04cafd24a1d7171b8da03c822d86272f3c.camel@linux.ibm.com>
 <qvv3tniawgb3rvqeuxzckj25xxkcr2tqbwnji5gmdg4x3ahdha@52hwfd36ttf7>
 <00d282d0cf06c3ac208ab9edfddedda1c9a5a77b.camel@linux.ibm.com>
 <s56ljuvqmrcy5gzjbrfbowq6gel7u4jjqtgyitvcbjgoiaahex@5kezecpurctk>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <s56ljuvqmrcy5gzjbrfbowq6gel7u4jjqtgyitvcbjgoiaahex@5kezecpurctk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250512_205536_431372_CF3AC86D 
X-CRM114-Status: GOOD (  15.10  )
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

Hi Coiby,

On 2025/5/13 08:14, Coiby Xu wrote:
> On Fri, May 09, 2025 at 09:03:11AM -0400, Mimi Zohar wrote:

...

>>>
>>> > I'm aware that some
>>> > store the security xattr information in a file and write it out as xattrs.
>>>
>>> If the built initramfs as a CPIO file doesn't carry xattrs, the loaded
>>> initramfs still doesn't have xattrs. I just found the initramfs could
>>> opt to use squashfs or erofs which supports xattrs but currently it's
>>> hardcoded to disable xattrs. For example, recently the dracut erorfs
>>> module also follows squashfs to disable xattrs [1]. So in the near
>>> future, I don't expect xattrs to be supported in kdump.
>>>
>>> [1] https://github.com/dracut-ng/dracut-ng/pull
> 
> Sorry, I didn't notice the link is incomplete. It should be
> 
> [1] https://github.com/dracut-ng/dracut-ng/pull/1296
> 
>>
>> Right, so the issue isn't the initramfs root filesystem, but CPIO.  Either CPIO
>> would need to be extended, which multiple people have attempted to do, or the xattrs
>> could be stored in a file and written out to the initramfs root filesystem.  In fact
>> Roberto's last attempts at adding CPIO xattr support did something like that.
>>
>> https://lore.kernel.org/linux-integrity/20190523121803.21638-1-roberto.sassu@huawei.com/
> 
> Thanks for introducing Roberto's work to me!

I wrote some words on initramfs vs initrd erofs on related threads:
https://lore.kernel.org/r/934af3e3-3153-40c1-9a25-7a8d08fdb007@linux.alibaba.com
https://lore.kernel.org/r/582bc002-f0c8-4dbb-8fa5-4c10a479b518@linux.alibaba.com/T/#u

The CPIO standard doesn't support xattrs, also initramfs could cause
unnecessary unpacking.

But anyway it needs more work on this stuff too.

Thanks,
Gao Xiang

> 
>>
>> Mimi
>>
> 


