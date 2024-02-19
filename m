Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27992C48BC3
	for <kexec@archiver.kernel.org>; Mon, 19 Feb 2024 09:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:MIME-Version:References:
	In-Reply-To:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P7C+a+r7tMtAPFmQhV/hvKfTYogh4gPPPQSEgbos56g=; b=tiZQoI16IeAQm8
	8Z8Umxykaz/S/V/HGyPpks73G8dhcT0Vdbxwn5pHOjaqT0Vy5fIyYebmLLhD1zij2rrPrB/NKmsiY
	2helEORnY/VNmp+xWmC7M/tbBT4i9rhUs72IoEX0QHS/OnwgiZxwYyfePV7TyPDTrFBs1JbgSqkv1
	luQd46pZvPKEJecPpLnur88KVhSJUXqk6bLKmIrp7hpCalmGKosBSdnOMv8TjYykteaVYYcqFWWat
	HJgqs7P8tg4hadoa0qSHYhDVGlm9RpXVGZDaA7twsKunU3yxg/1ZEuufsJ7LdpBmZXw0abAmEiCjJ
	PEX7JLuCheN4JNLf/Nig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbzvv-00000009oMt-2kj8;
	Mon, 19 Feb 2024 09:27:31 +0000
Received: from m16.mail.163.com ([220.197.31.3])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbzvs-00000009oLw-1As5
	for kexec@lists.infradead.org;
	Mon, 19 Feb 2024 09:27:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=LdXQA66iqTewnXLGYwkQx7fMCWVbVDbz/y8KNE5FnZ8=; b=J
	SXS+H9s7HHL/vHOzHbkgpxpTndollX4wJaIePQzXjHrOK/O3ld2roYZnMocy8QXS
	LEAoXT8P5gm0llaNzuVV05uVodz6+uEwdiXkp9v/L4oVsW4Z7G8ec+QlxSsBnH6w
	QiRXMHBkdd2BUMO+pwBFRA8LsWPhHJcmKbbX0wTL9M=
Received: from gaoshanliukou$163.com ( [60.24.209.108] ) by
 ajax-webmail-wmsvr-40-114 (Coremail) ; Mon, 19 Feb 2024 17:26:55 +0800
 (CST)
X-Originating-IP: [60.24.209.108]
Date: Mon, 19 Feb 2024 17:26:55 +0800 (CST)
From: "yang.zhang" <gaoshanliukou@163.com>
To: "Baoquan He" <bhe@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, "yang.zhang" <yang.zhang@hexintek.com>, 
	akpm@linux-foundation.org
Subject: Re:Re: [PATCH] kexec: should use uchunk for user buffer increasing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <ZdK/Hsy1TMB8PlJs@MiWiFi-R3L-srv>
References: <20240130101802.23850-1-gaoshanliukou@163.com>
 <Zb8+8qmn5SV4LKFd@MiWiFi-R3L-srv>
 <871q9r3xl6.fsf@email.froward.int.ebiederm.org>
 <2a207ca2.1e87.18dbf17ee10.Coremail.gaoshanliukou@163.com>
 <ZdK/Hsy1TMB8PlJs@MiWiFi-R3L-srv>
X-NTES-SC: AL_Qu2bCv+Yu0Aq4yGRY+kXnEYQh+k3XcK4u/0u2YFVP5E0oyTL8z0ARUdJIVL69+GMNS2NiCCzaBpn5cJBXZNDc7oAhva9lGIG43yCV0QCwDB7
MIME-Version: 1.0
Message-ID: <23cb32ca.9195.18dc0b09810.Coremail.gaoshanliukou@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wD3ny_fHtNl5B7kAA--.18548W
X-CM-SenderInfo: pjdr2x5dqox3xnrxqiywtou0bp/xtbBZQKF8mV4H1oUZwAGs9
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_012728_722744_4E01A723 
X-CRM114-Status: GOOD (  15.86  )
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






Thanks, i would post v2 patch.
Could you please provide the email address for andrew.









At 2024-02-19 10:38:22, "Baoquan He" <bhe@redhat.com> wrote:
>On 02/19/24 at 10:00am, yang.zhang wrote:
>> 
>> 
>> 
>> Thanks for your replies.
>> Do you have plans to merge the improving code for clarity, or just keep them unchanged.
>
>You need post v2 to change those two places as Eric has demonstrated.
>Please CC Andrew when you post.
>
>> 
>> At 2024-02-05 20:27:33, "Eric W. Biederman" <ebiederm@xmission.com> wrote:
>> >Baoquan He <bhe@redhat.com> writes:
>> >
>> >> On 01/30/24 at 06:18pm, yang.zhang wrote:
>> >>> From: "yang.zhang" <yang.zhang@hexintek.com>
>> >>> 
>> >>> Because of alignment requirement in kexec-tools, there is
>> >>> no problem for user buffer increasing when loading segments.
>> >>> But when coping, the step is uchunk, so we should use uchunk
>> >>> not mchunk.
>> >>
>> >> In theory, ubytes is <= mbytes. So uchunk is always <= mchunk. If ubytes
>> >> is exhausted, while there's still remaining mbytes, then uchunk is 0,
>> >> there's still mchunk stepping forward. If I understand it correctly,
>> >> this is a good catch. Not sure if Eric has comment on this to confirm.
>> >
>> >As far as I can read the code the proposed change is a noop.
>> >
>> >I agree it is more correct to not advance the pointers we read from,
>> >but since we never read from them after that point it does not
>> >matter.
>> >
>> >>
>> >> static int kimage_load_normal_segment(struct kimage *image,
>> >>                                          struct kexec_segment *segment)
>> >> {
>> >> ......
>> >>
>> >>                 ptr += maddr & ~PAGE_MASK;
>> >>                 mchunk = min_t(size_t, mbytes,
>> >>                                 PAGE_SIZE - (maddr & ~PAGE_MASK));
>> >>                 uchunk = min(ubytes, mchunk);
>> >> ......}
>> >
>> >If we are going to improve the code for clarity.  We probably
>> >want to do something like:
>> >
>> >diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> >index d08fc7b5db97..1a8b8ce6bf15 100644
>> >--- a/kernel/kexec_core.c
>> >+++ b/kernel/kexec_core.c
>> >@@ -800,22 +800,24 @@ static int kimage_load_normal_segment(struct kimage *image,
>> >                                PAGE_SIZE - (maddr & ~PAGE_MASK));
>> >                uchunk = min(ubytes, mchunk);
>> > 
>> >-               /* For file based kexec, source pages are in kernel memory */
>> >-               if (image->file_mode)
>> >-                       memcpy(ptr, kbuf, uchunk);
>> >-               else
>> >-                       result = copy_from_user(ptr, buf, uchunk);
>> >+               if (uchunk) {
>> >+                       /* For file based kexec, source pages are in kernel memory */
>> >+                       if (image->file_mode)
>> >+                               memcpy(ptr, kbuf, uchunk);
>> >+                       else
>> >+                               result = copy_from_user(ptr, buf, uchunk);
>> >+                       ubytes -= uchunk;
>> >+                       if (image->file_mode)
>> >+                               kbuf += uchunk;
>> >+                       else
>> >+                               buf += uchunk;
>> >+               }
>> >                kunmap_local(ptr);
>> >                if (result) {
>> >                        result = -EFAULT;
>> >                        goto out;
>> >                }
>> >-               ubytes -= uchunk;
>> >                maddr  += mchunk;
>> >-               if (image->file_mode)
>> >-                       kbuf += mchunk;
>> >-               else
>> >-                       buf += mchunk;
>> >                mbytes -= mchunk;
>> > 
>> >                cond_resched();
>> >
>> >And make it exceedingly clear that all of the copying and the rest
>> >only happens before uchunk goes to zero.  Otherwise we are relying
>> >on a lot of operations becoming noops when uchunk goes to zero.
>> >
>> >Eric
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
