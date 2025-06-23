Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C74C7115D
	for <kexec@archiver.kernel.org>; Mon, 23 Jun 2025 04:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0FyxRfB9S1amdCXYnxAVn4IdWJYOv1mIybN5IWmMqHg=; b=WRpxKvPYh5mdv06vcqEdXK536/
	b6uy7nxPfV/8Ml3wciRXuxFcpaY56zkex9qXAKgkIhklssfp9am4NiCtpCJGJ6DGS7eYcFCcshhqe
	3k3m43WlF3SnzO5T3TEEgDaRfm3kk0VNp/7ObxBfNPX3TS7i4gXikYjc7usULBKiqyQHC3+6i/xaa
	9VoJZhK5nda7YR/pzoCByrwIwCrATn8Kw8joFNZ3zdMA7DDUo6JRoVfbsLy12v6NcrdiJqGiu4icV
	0ky90VUh53+2e0bi4c3P3acoNd8F9ylaD0fj1opg2wENb9X/a46HbLu809STgwBlTz3mBVIkMQ3pQ
	f0u9QFgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZGn-00000001aTX-2CXc;
	Mon, 23 Jun 2025 04:59:01 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZGm-00000001aTP-1UPN
	for kexec@bombadil.infradead.org;
	Mon, 23 Jun 2025 04:59:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=0FyxRfB9S1amdCXYnxAVn4IdWJYOv1mIybN5IWmMqHg=; b=GnyshR/MgTz01kJgg34yWaXn5X
	sWFqAO6aEZmGvL3jlTJth5bA9SkckGY+KN6MC1aNKPEbeC+Is1gNEDcEblBgY0ueaUZ0NR2AT9BPI
	yDcxcXCcE4/2EmQYe7THzE+A19GbDi6yoO9tGx6AAt6JbZuW1NRDzpT71R/VM2LRYy67C2lPRjmxO
	HxC4bqFYxTZaea37h9TlUSvFSa/LGX6P2LmKDrxPLjVufk+89DYlSRJiy5x90LENI0EAgMc9ifRc9
	CveRnMBUuX5O/2keGWA1b+yIY6vbL9A9J5MwYBgnC+vJ6eOUr450fpte2khsFc4VDtsV50rFOCxjZ
	AvHhBcGQ==;
Received: from [2a00:23ee:2978:6058:13ae:23c4:6041:a218] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZGg-000000058Ys-3uLV;
	Mon, 23 Jun 2025 04:58:57 +0000
Date: Mon, 23 Jun 2025 05:58:53 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Baoquan He <bhe@redhat.com>, Mario Limonciello <superm1@kernel.org>
CC: mario.limonciello@amd.com, rafael@kernel.org, len.brown@intel.com,
 pavel@kernel.org, gregkh@linuxfoundation.org, dakr@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, christian.koenig@amd.com,
 linux-pm@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH] PM: Restrict swap use to later in the suspend sequence
User-Agent: K-9 Mail for Android
In-Reply-To: <aFjIv5OqUyiSNrRi@MiWiFi-R3L-srv>
References: <20250613214413.4127087-1-superm1@kernel.org> <aFjIv5OqUyiSNrRi@MiWiFi-R3L-srv>
Message-ID: <F68C706A-4B73-442F-B8D7-C0AF35C0294A@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
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

On 23 June 2025 04:23:43 BST, Baoquan He <bhe@redhat=2Ecom> wrote:
>This change is inside KEXEC_JUMP scope, let David know this because he
>ever tested and made change for KEXEC_JUMP=2E
>=2E=2E=2E=2E=2E=2E

Thanks=2E I added a selftest in https://lore=2Ekernel=2Eorg/all/2025032614=
2404=2E256980-5-dwmw2@infradead=2Eorg

