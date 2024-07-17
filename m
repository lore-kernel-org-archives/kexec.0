Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C885C3DA62
	for <kexec@archiver.kernel.org>; Wed, 17 Jul 2024 19:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wKQP/Yvn4O80LotqSEDxxh2PNzAAv6gK35bGFkC4pk0=; b=JLwuTspaPvG6Dh
	kaw71aFu7s2LlwuYdXPnqch2uv4ky4w5znktKAnqjmnDPnwjmZix6xFPdENgwD1ez5rzh4HXjcq/b
	XY51imtzFZ+DRgbVBBfZ0z5fssW7UdaQSWZvXzzOyVTkBnuvYVyBJ6aIzbQA8oMgKK5JE0rmL9S3s
	eiKEl4/YLRAif6LryqFXg1WWgZhNIeU1zXlOdBAm7pCebsUtqnZ+DcTYQ9eCKYouNL7mEQMTgmOIC
	5dRu1RJiI8PmGPnW/OsLZvQ5d09YjdNbUUx+NVLUwhxoaetBp1KKNRpZ9RS+0BC5wfsbqMUpHP7Hs
	TfqiG7b5DXH1YxmRJ/jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUAeT-0000000EkD3-24Zq;
	Wed, 17 Jul 2024 19:49:25 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUAeO-0000000EkCD-1Ces
	for kexec@lists.infradead.org;
	Wed, 17 Jul 2024 19:49:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DC57ECE17D8;
	Wed, 17 Jul 2024 19:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DA7C2BD10;
	Wed, 17 Jul 2024 19:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721245757;
	bh=VYVH8+4tHwZfxc0s1qPNWAN9fP+e1O3MLEriEoiya40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sm52eIXxnAzFmAcmYj27/4OzafQtRJdgHcwEboO34IBJRP3y/Hf284VwDHEPIXWNn
	 hFn4/28xPj4bJcjMDKVsXQFLKJrEorVYGdmabqOijbM/DhEtPw9D3FwgR5YxGpJpyA
	 3Mxa4zYEbdMd8hpmfAgNNbDARgKdxszizaFFiPic=
Date: Wed, 17 Jul 2024 12:49:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, vgoyal@redhat.com,
 dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crash: fix x86_32 memory reserve dead loop retry
 bug at "high"
Message-Id: <20240717124916.0535d675cadf2feeee9752fe@linux-foundation.org>
In-Reply-To: <ZpfJYcjZ0QmFUpPf@MiWiFi-R3L-srv>
References: <20240717070904.2671147-1-ruanjinjie@huawei.com>
	<ZpfJYcjZ0QmFUpPf@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_124920_681047_259A37B4 
X-CRM114-Status: UNSURE (   5.96  )
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

On Wed, 17 Jul 2024 21:38:41 +0800 Baoquan He <bhe@redhat.com> wrote:

> 1) revert commit 8f9dade5906a in Andrew's tree;

Thanks, dropped.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
