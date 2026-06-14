Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB976CD98C5
	for <kexec@archiver.kernel.org>; Sun, 14 Jun 2026 12:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7pKzj8DHHkqe+2FveBrKL4u5guUBnntJaiFQS8OA5Fw=; b=mhwkinT+IOAFo58fHNVZ0Louma
	bE5d2Vkxdb7RPY9Y7tTK7MTDz8SOC75Em5X2urQPe57c8xrOnutWRQsUG86xqAFF/GNLkN1NL6sAg
	YgvR3Pl9c8Bm6052VGgFj5Fg0lyTxSgpGO2YvnF1cHlUs7xRvisZWFqf5dmmd1qrRONt7Yct31nxr
	E5wERmBrPrmQeJ4vL18W7wDb/p0tEMQwCP4ZMje61ICptx3xHalg9xQM/kznAVQxe0M+vCtlsstpS
	GoRkkLQ3jLJh3mYhYRxe+y5DNcDvJQY2zQuq+LxDiWnAvuY14sXzaRuuNB3PzNM9NNElN8FSV/DjN
	LbH8uOkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYjY6-0000000CwpP-43pY;
	Sun, 14 Jun 2026 12:02:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYjY6-0000000Cwp5-0v6C
	for kexec@lists.infradead.org;
	Sun, 14 Jun 2026 12:02:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E9A5440320;
	Sun, 14 Jun 2026 12:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DCB1F000E9;
	Sun, 14 Jun 2026 12:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781438565;
	bh=7pKzj8DHHkqe+2FveBrKL4u5guUBnntJaiFQS8OA5Fw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=AdmY0WT7ISPomjl4hbDwMQ/sgW1wbNaubsdDZSqFwINSBYqO5vmrrof25aTgy5Yuh
	 zB0pNGNFO9xtQpuySRJ04Ubohr92sIoFYAEKeit4gEVIZJV1OqDZ3uDDwL6qYergn0
	 S6XOYwgUfSNUDZiWeFIjtUcQeykqW+PhzKzpGtGccr/lO2nEEHe1tw45qxoRSzlZoF
	 0fL4R8GHTf7/xYdcTyv16bQUPhXbSh3hguQ4dvGDwTPNNqwCuWFU5cxYDf3F2eIDKJ
	 kj26kbEVRq7fCXPIQbB8wYOWMxsVM1ZGURv03c8ML156F3KIXfZC1EGY+oPb32HziE
	 XRei40a0tu5qA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 12/18] kho: export kho_scratch_overlap()
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
 Jork Loeser <jloeser@linux.microsoft.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260605183501.3884950-13-pratyush@kernel.org>
References: <20260605183501.3884950-1-pratyush@kernel.org>
 <20260605183501.3884950-13-pratyush@kernel.org>
Date: Sun, 14 Jun 2026 15:02:31 +0300
Message-Id: <178143855113.2123877.811509669260246457.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Fri, 05 Jun 2026 20:34:45 +0200, Pratyush Yadav <pratyush@kernel.org> wrote:

Subject: kho: export kho_scratch_overlap()

rather make it available for !kho users and regardless of KHO_DEBUG.

Nit: we are not really exporting this in the sense of EXPORT_SYMBOL, we

Nit: we are not really exporting this in the sense of EXPORT_SYMBOL, we

-- 
Sincerely yours,
Mike.


