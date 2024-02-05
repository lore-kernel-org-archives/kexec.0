Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE36C4828D
	for <kexec@archiver.kernel.org>; Mon,  5 Feb 2024 12:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=n3DzJy0HrdA6wDd1HKnd1uRr3//3+HVTR2NImIzGNOc=; b=HHlDGf352Bzg+01+PxgJJfFgUX
	em5625EXcWOEhKoweUFEMZxbtV/9CJrkwe2rffoabgxU4UjepsfdoSKAn15iUrNAPE2OpGGU3WTzP
	gEK8CfNKSJtCz4xnmQlGyPv7tM5vdJOiQlj7n9yQT0mRxCvS6tr/0y4VqjkrJGuM2Vqd5ZA6SGvmp
	+ZqfP+nKvReLqxJq8SNdj6mCYZVGajYNaDLJ78hvGi/K/GCe7+ntXl0Laog7ncJ7xTSs0aOkHIf1A
	ujG0Typlx+jdT0grhCZrjpI0l41Jlu1DeQsjWSzeL0Yin2cuuRGOR18Q7+Ixlf395EUL/pVju31cg
	H6AeOTaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWy5D-00000003CPL-0RNY;
	Mon, 05 Feb 2024 12:28:19 +0000
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWy5A-00000003CKx-2HHb
	for kexec@lists.infradead.org;
	Mon, 05 Feb 2024 12:28:17 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:49462)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rWy4q-00A381-UM; Mon, 05 Feb 2024 05:27:56 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54108 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rWy4p-0050ZB-Pj; Mon, 05 Feb 2024 05:27:56 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Baoquan He <bhe@redhat.com>
Cc: "yang.zhang" <gaoshanliukou@163.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  "yang.zhang" <yang.zhang@hexintek.com>
References: <20240130101802.23850-1-gaoshanliukou@163.com>
	<Zb8+8qmn5SV4LKFd@MiWiFi-R3L-srv>
Date: Mon, 05 Feb 2024 06:27:33 -0600
In-Reply-To: <Zb8+8qmn5SV4LKFd@MiWiFi-R3L-srv> (Baoquan He's message of "Sun,
	4 Feb 2024 15:38:26 +0800")
Message-ID: <871q9r3xl6.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1rWy4p-0050ZB-Pj;;;mid=<871q9r3xl6.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/FgnfPR7m0NTTwj+9KpVfyCvCURxVFUjo=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kexec: should use uchunk for user buffer increasing
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_042816_601316_5DF0C725 
X-CRM114-Status: GOOD (  20.58  )
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

Baoquan He <bhe@redhat.com> writes:

> On 01/30/24 at 06:18pm, yang.zhang wrote:
>> From: "yang.zhang" <yang.zhang@hexintek.com>
>> 
>> Because of alignment requirement in kexec-tools, there is
>> no problem for user buffer increasing when loading segments.
>> But when coping, the step is uchunk, so we should use uchunk
>> not mchunk.
>
> In theory, ubytes is <= mbytes. So uchunk is always <= mchunk. If ubytes
> is exhausted, while there's still remaining mbytes, then uchunk is 0,
> there's still mchunk stepping forward. If I understand it correctly,
> this is a good catch. Not sure if Eric has comment on this to confirm.

As far as I can read the code the proposed change is a noop.

I agree it is more correct to not advance the pointers we read from,
but since we never read from them after that point it does not
matter.

>
> static int kimage_load_normal_segment(struct kimage *image,
>                                          struct kexec_segment *segment)
> {
> ......
>
>                 ptr += maddr & ~PAGE_MASK;
>                 mchunk = min_t(size_t, mbytes,
>                                 PAGE_SIZE - (maddr & ~PAGE_MASK));
>                 uchunk = min(ubytes, mchunk);
> ......}

If we are going to improve the code for clarity.  We probably
want to do something like:

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index d08fc7b5db97..1a8b8ce6bf15 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -800,22 +800,24 @@ static int kimage_load_normal_segment(struct kimage *image,
                                PAGE_SIZE - (maddr & ~PAGE_MASK));
                uchunk = min(ubytes, mchunk);
 
-               /* For file based kexec, source pages are in kernel memory */
-               if (image->file_mode)
-                       memcpy(ptr, kbuf, uchunk);
-               else
-                       result = copy_from_user(ptr, buf, uchunk);
+               if (uchunk) {
+                       /* For file based kexec, source pages are in kernel memory */
+                       if (image->file_mode)
+                               memcpy(ptr, kbuf, uchunk);
+                       else
+                               result = copy_from_user(ptr, buf, uchunk);
+                       ubytes -= uchunk;
+                       if (image->file_mode)
+                               kbuf += uchunk;
+                       else
+                               buf += uchunk;
+               }
                kunmap_local(ptr);
                if (result) {
                        result = -EFAULT;
                        goto out;
                }
-               ubytes -= uchunk;
                maddr  += mchunk;
-               if (image->file_mode)
-                       kbuf += mchunk;
-               else
-                       buf += mchunk;
                mbytes -= mchunk;
 
                cond_resched();

And make it exceedingly clear that all of the copying and the rest
only happens before uchunk goes to zero.  Otherwise we are relying
on a lot of operations becoming noops when uchunk goes to zero.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
