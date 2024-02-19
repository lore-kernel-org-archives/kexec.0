Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE17C48BC4
	for <kexec@archiver.kernel.org>; Mon, 19 Feb 2024 02:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:MIME-Version:References:
	In-Reply-To:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yxvr/V/8tYJ28kqZh79MYJV/2uCWnGCKtcvrMiKt6KE=; b=aZPyjScoSQ9r9u
	ApRKUvsoqdf91ZCfjlTMU+59s2zP6FrvBazaRqEWIoquk9F2OkaPvwu7hvU5N/MZcF4xG/hJTdHxx
	J1xiRKcMRmMSxQxntaHYlSTF+7CaD/MuCRhUZtJ7nCRTJzP+4sC6XtUShoHnaw5zt3OFdPN6M1BY0
	4rgwNQhOeVnyzCNR1lV5E6NdRBj2e2/0IvUV3oUh1dzQUQcCU+WgkO6yQmcAm5e415VUItk5sCCP0
	VthVq1KdgfntpPNFhbIqjaroYeIPc7tuIEoZZSqCAcYzq+KhmndDqdwTYusVrQuRhOpI6DuCAVUOv
	nLdK8scg2kuusH5CraDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbsxg-00000008op4-1Xv3;
	Mon, 19 Feb 2024 02:00:52 +0000
Received: from m16.mail.163.com ([220.197.31.4])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbsxb-00000008on7-2SuV
	for kexec@lists.infradead.org;
	Mon, 19 Feb 2024 02:00:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=/LIr/n4Me0c+pWUjj1O4glgEqVVux4ELuAgUnDnG7WY=; b=n
	d+NYiE9MRWavblELTgECINM4SreUUr12x+sT7ZPwPuefCg9hafPq1lVHdl2aRVWL
	26rvKLFMsk6NDk1NYKmKyl2Ag+JZDJo9AR9R9IIWqKSi3lM6epxUMmqzrJTcUOup
	YEFOf4O8oRKRjq5c9WuZXKtyhXPshfnYPF8qO1tHDU=
Received: from gaoshanliukou$163.com ( [60.24.209.108] ) by
 ajax-webmail-wmsvr-40-126 (Coremail) ; Mon, 19 Feb 2024 10:00:33 +0800
 (CST)
X-Originating-IP: [60.24.209.108]
Date: Mon, 19 Feb 2024 10:00:33 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Baoquan He" <bhe@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, "yang.zhang" <yang.zhang@hexintek.com>
Subject: Re:Re: [PATCH] kexec: should use uchunk for user buffer increasing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <871q9r3xl6.fsf@email.froward.int.ebiederm.org>
References: <20240130101802.23850-1-gaoshanliukou@163.com>
 <Zb8+8qmn5SV4LKFd@MiWiFi-R3L-srv>
 <871q9r3xl6.fsf@email.froward.int.ebiederm.org>
X-NTES-SC: AL_Qu2bCv+bt0go5SCbYukXnEYQh+k3XcK4u/0u2YFVP5E0lSTx0wURfH5gB3X34camBz60sRmISxV12Ol9UJl0XYbn5/hBo+Ki1kLwmlHoKHWT
MIME-Version: 1.0
Message-ID: <2a207ca2.1e87.18dbf17ee10.Coremail.gaoshanliukou@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wB39JNBttJl4+HBAA--.24654W
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/xtbBZQKF8mV4H1oUZwADs4
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240218_180047_986103_1FFAEF21 
X-CRM114-Status: GOOD (  14.42  )
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




Thanks for your replies.
Do you have plans to merge the improving code for clarity, or just keep them unchanged.












At 2024-02-05 20:27:33, "Eric W. Biederman" <ebiederm@xmission.com> wrote:
>Baoquan He <bhe@redhat.com> writes:
>
>> On 01/30/24 at 06:18pm, yang.zhang wrote:
>>> From: "yang.zhang" <yang.zhang@hexintek.com>
>>> 
>>> Because of alignment requirement in kexec-tools, there is
>>> no problem for user buffer increasing when loading segments.
>>> But when coping, the step is uchunk, so we should use uchunk
>>> not mchunk.
>>
>> In theory, ubytes is <= mbytes. So uchunk is always <= mchunk. If ubytes
>> is exhausted, while there's still remaining mbytes, then uchunk is 0,
>> there's still mchunk stepping forward. If I understand it correctly,
>> this is a good catch. Not sure if Eric has comment on this to confirm.
>
>As far as I can read the code the proposed change is a noop.
>
>I agree it is more correct to not advance the pointers we read from,
>but since we never read from them after that point it does not
>matter.
>
>>
>> static int kimage_load_normal_segment(struct kimage *image,
>>                                          struct kexec_segment *segment)
>> {
>> ......
>>
>>                 ptr += maddr & ~PAGE_MASK;
>>                 mchunk = min_t(size_t, mbytes,
>>                                 PAGE_SIZE - (maddr & ~PAGE_MASK));
>>                 uchunk = min(ubytes, mchunk);
>> ......}
>
>If we are going to improve the code for clarity.  We probably
>want to do something like:
>
>diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>index d08fc7b5db97..1a8b8ce6bf15 100644
>--- a/kernel/kexec_core.c
>+++ b/kernel/kexec_core.c
>@@ -800,22 +800,24 @@ static int kimage_load_normal_segment(struct kimage *image,
>                                PAGE_SIZE - (maddr & ~PAGE_MASK));
>                uchunk = min(ubytes, mchunk);
> 
>-               /* For file based kexec, source pages are in kernel memory */
>-               if (image->file_mode)
>-                       memcpy(ptr, kbuf, uchunk);
>-               else
>-                       result = copy_from_user(ptr, buf, uchunk);
>+               if (uchunk) {
>+                       /* For file based kexec, source pages are in kernel memory */
>+                       if (image->file_mode)
>+                               memcpy(ptr, kbuf, uchunk);
>+                       else
>+                               result = copy_from_user(ptr, buf, uchunk);
>+                       ubytes -= uchunk;
>+                       if (image->file_mode)
>+                               kbuf += uchunk;
>+                       else
>+                               buf += uchunk;
>+               }
>                kunmap_local(ptr);
>                if (result) {
>                        result = -EFAULT;
>                        goto out;
>                }
>-               ubytes -= uchunk;
>                maddr  += mchunk;
>-               if (image->file_mode)
>-                       kbuf += mchunk;
>-               else
>-                       buf += mchunk;
>                mbytes -= mchunk;
> 
>                cond_resched();
>
>And make it exceedingly clear that all of the copying and the rest
>only happens before uchunk goes to zero.  Otherwise we are relying
>on a lot of operations becoming noops when uchunk goes to zero.
>
>Eric
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
