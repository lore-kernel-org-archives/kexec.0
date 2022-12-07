Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78283C4708E
	for <kexec@archiver.kernel.org>; Wed,  7 Dec 2022 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=webXpLdO9K1sil9QJrI9XiIcWU8fVZSEnD5O1e0uvXs=; b=DK4RfhaDMgMqvC
	X4OQFg4HlquYV/jsWndny3CVibe1Olt9BVaSXtwTu8fKJrrBK51lNI6rB7VIPxUSkKi06A2p3GSPI
	pTTgq36SRMxMYwJz7gioR06Xh0xYQ4QGQ0AOoJiENTppuOZ+onG3Wz982RtIdIjgKdPmdhNSDi87W
	9bUFGYxvuCoLxsfxdul8TIZ+pOQzTkQEbnbG2FahgMV95Z669nlT20/kwhbXKuSHICZ3dkBL0bRk3
	UAvAk09g92b/rWTMfftT8JPkVCDan+yoGJH02LD4Jn7HDAr+FI+bEItEkQefCZ4GePiDk0lmiktfw
	gf7BS5BN9Qa3GvzztWJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2tmj-002iYe-E7; Wed, 07 Dec 2022 12:44:25 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2tl1-002hhB-Rf
	for kexec@lists.infradead.org; Wed, 07 Dec 2022 12:42:41 +0000
Received: from zn.tnic (p200300ea9733e711329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e711:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 02A7D1EC0513;
	Wed,  7 Dec 2022 13:42:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1670416955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=3MvFYIyTeLFFW1d9iStpsuAgJDEJsf13+oilEAecoj4=;
	b=qdGXzwGhCFmhATB0qA/rtQacIGbPToV2f6g/ANDYFpfJy0fns+dU/7xcn3c9pVXiTS0lfq
	arzPw3oc+ooWALh7wA5C2RO/ZDuUXV28h0NzXaI4HMtgoSUpyagYwVe59nKgY9eK2WGuOd
	le0+RTEY5tJOCR/plq+ipYrV6RC8wZc=
Date: Wed, 7 Dec 2022 13:42:30 +0100
From: Borislav Petkov <bp@alien8.de>
To: Baoquan He <bhe@redhat.com>
Cc: Eric DeVolder <eric.devolder@oracle.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
	dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v14 3/7] crash: add generic infrastructure for crash
 hotplug support
Message-ID: <Y5CKNqtDm5VT+gsz@zn.tnic>
References: <20221116214643.6384-1-eric.devolder@oracle.com>
 <20221116214643.6384-4-eric.devolder@oracle.com>
 <Y4A1/cSekXUTFriC@MiWiFi-R3L-srv>
 <Y5BkL8x01KWoF502@zn.tnic>
 <Y5CIvcZLuokwyGYT@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5CIvcZLuokwyGYT@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_044240_113089_30713B02 
X-CRM114-Status: UNSURE (   7.44  )
X-CRM114-Notice: Please train this message.
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

On Wed, Dec 07, 2022 at 08:36:13PM +0800, Baoquan He wrote:
> Below is my last reply to Eric about my thinking on this.

Yes, I saw that.

So think about it: if a CONFIG_ item is not present, what does that mean
for the code which is enclosed around it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
