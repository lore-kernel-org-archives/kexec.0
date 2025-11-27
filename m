Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DAFD10375
	for <kexec@archiver.kernel.org>; Thu, 27 Nov 2025 03:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qHkW8bc+hQOOPvBbowRqTajBPsCa1JrhaXdbTkX2NKI=; b=T1q19gAxWDJFaZ9Cdrz8gGZzyF
	RcxYF80mNA5dRvLd10E3fRTR8ZaOh6QWEEB2n6bzU6HEy11IWx8u5Va4gbekTxiTXjhZmEAiin+ka
	i+G3wOU0/y0AI6mUK2QNyZUKtK9UNlXT/FbIY37DCbnUOqFmQWNEXKwOGZFETsRw58VtNfdrDvTxO
	hIeFZ9SbXfo/gan2u3Qwjsx9BnoVzuB7TszvN9g/65MX83sY6gVWONjtH8c8qHlft6j1Q1vj/kO2j
	1OM63u1sEyKuNQWPcYFpvh/gZRY6uBkZ8scIxu7MhXHmb8zcBKwslkTIstBvWYScaEX9oR002DVqb
	if5j8SiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOT6v-0000000FwjR-1loj;
	Thu, 27 Nov 2025 03:56:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOT6q-0000000Fwj3-3eHU
	for kexec@lists.infradead.org;
	Thu, 27 Nov 2025 03:55:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764215755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qHkW8bc+hQOOPvBbowRqTajBPsCa1JrhaXdbTkX2NKI=;
	b=GWXi7pz05vigoakyvnQ+p/bCt+bmoqrzYDYWPzH0z6H3clxkJxodDuqBvX9zKpmn1fF/wX
	uRrjxFqfMF1sxUDRLfPscjot8VvNrLk05W8wIA3SlwzgXILlsYTgiD8fgL6vfkvSn5VJHO
	3eJ8XiOzXW5bK4QkQb/T5c8hDiQC7/w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-V0uCc17TMbypJy3zFhpIpA-1; Wed,
 26 Nov 2025 22:55:53 -0500
X-MC-Unique: V0uCc17TMbypJy3zFhpIpA-1
X-Mimecast-MFC-AGG-ID: V0uCc17TMbypJy3zFhpIpA_1764215752
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77C3B180063A;
	Thu, 27 Nov 2025 03:55:49 +0000 (UTC)
Received: from localhost (unknown [10.72.112.107])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19FBA1800876;
	Thu, 27 Nov 2025 03:55:46 +0000 (UTC)
Date: Thu, 27 Nov 2025 11:55:42 +0800
From: Baoquan He <bhe@redhat.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] kexec: print out debugging message if required
 for kexec_load
Message-ID: <aSfLvmG6dap/Fcuf@MiWiFi-R3L-srv>
References: <20251126084427.3222212-1-maqianga@uniontech.com>
 <aSetpjhZi3T1Mjhb@MiWiFi-R3L-srv>
 <63BA9935197ADF34+2a3faf95-36da-46f1-b9b5-4e438e75d1be@uniontech.com>
 <aSe5HXpBtzLnHvNG@MiWiFi-R3L-srv>
 <D40CB4FFD668159A+09161aea-9a97-4e58-8fb4-0a13387da858@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D40CB4FFD668159A+09161aea-9a97-4e58-8fb4-0a13387da858@uniontech.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_195556_983212_9EBAE004 
X-CRM114-Status: GOOD (  27.45  )
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

On 11/27/25 at 11:00am, Qiang Ma wrote:
> 
> 在 2025/11/27 10:36, Baoquan He 写道:
> > On 11/27/25 at 10:04am, Qiang Ma wrote:
> > > 在 2025/11/27 09:47, Baoquan He 写道:
> > > > Hi,
> > > > 
> > > > On 11/26/25 at 04:44pm, Qiang Ma wrote:
> > > > > Overview:
> > > > > =========
> > > > > The commit a85ee18c7900 ("kexec_file: print out debugging message
> > > > > if required") has added general code printing in kexec_file_load(),
> > > > > but not in kexec_load().
> > > > > Since kexec_load and kexec_file_load are not triggered simultaneously,
> > > > > we can unify the debug flag of kexec and kexec_file as kexec_dbg_print.
> > > > As I said in your last post, this is not needed at all, you just add a
> > > > not needed thing to kernel.
> > > > 
> > > > So NACK this patchset, unless you have reason to justify it. Sorry about
> > > > it.
> > > The segment prints discussed in the last post,
> > > 
> > > this patchset has been removed, leaving only type/start/head of kimage and
> > > flags.
> > > 
> > > 
> > > I think the current patchset is still necessary.
> > > For example, renaming kexec_file_dbg_print is still necessary, but not for
> > > kexec_file.
> > How come renaming kexec_file_dbg_print is a justification in this case.
> > 
> > No, kexec_file_dbg_print is named because it's only for kexec_file
> > debugging printing. Because we have had enough debugging printing for
> > kexec_load interface. Do you have difficulty on debugging printing of
> > kexec_load?
> It's sufficient now, but there might be a need in the future.
> Also, there's kexec_dprintk. Judging from its name, it seems like a

Hmm, as I ever said in earlier discussion, kexec sometime means generic
handling including kexec_load and kexec_file_load interfaces. Both possible
future need and kexec_dprintk which seems a little ambiguous to you are
not justified. We do not suggest adding these meaningless code to
kernel. Please do't continue spending effort on this, that is not good.

I welcome cleanup/refactoring/fix for kexec/kdump to improve code, but
adding non-reasonable code is not included.

> universal kexec print.
> Looking at the code, it feels like not only the kexec_file interface path
> uses it for printing.
> 
> So, would it be better to rename kexec_file_dbg_print to kexec_dbg_print.
> 
> 
> > 
> > 
> 


