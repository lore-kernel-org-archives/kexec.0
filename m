Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDF1C4332F
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O+VU/KeQdGU5mpnr4fQGl6gGs9GFeJaR+x13PLp+RPE=; b=lQuaNP8MO5GiEV
	bRWM9g2ETKMeXsP40LV38v3MueKr7fUxZDBFopcS1Umm8sVC/E2KokXbgTaYHRp2U/zD5YZPCBFM0
	h8v1ZlqFCzO4cc6m1ingcO4vZNrd0QPZoFRaBIBvD8rGM/G0/vkWo5rW+crbb5UW7t3vqbtDo19Ok
	6GRCy1kG55nYEQOtNfHvZuiZEkXW0UxpRjVCe4eny7vkTiPNZDQcOJnbyEn1MUBsbcNBsX3xJFnyC
	Ha+NlOiH2qiHU+txWQ455mZxJYfAF11a59IF1jSrxXgFk5LyIZKzDPOjQrpRLYzhc6W7kfW3sRIIj
	01oXqMwndGRZ/lfbIEpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDUPN-00FluZ-2k;
	Wed, 13 Dec 2023 18:56:37 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDUPK-00Fltb-1S;
	Wed, 13 Dec 2023 18:56:35 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 74A6A20B74C0;
	Wed, 13 Dec 2023 10:56:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 74A6A20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1702493793;
	bh=txIReIOWTRs39u8OW5af/PT5Nn7b+8jE2eqzUZ8XWC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sKKi+idOLhnITF/wkGrqC9FTWsyho05pam4Ov+NiMJUNOG9wdoVWzvhAzzVVbi0fM
	 iq0Sk46HTEoSPfC26F5n/XR5paRCRmarYFa0kFuxc1gAWLfNan2s1/Q+8P81MaF2gS
	 dZCAJ3GCca9aPvSLzvGvcG/K17vyv+y4Qc5dMZio=
Date: Wed, 13 Dec 2023 10:56:31 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>, arnd@arndb.de,
	pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 04/15] kexec: Add KHO parsing support
Message-ID: <20231213185631.GA14708@skinsburskii.>
References: <20231213000452.88295-1-graf@amazon.com>
 <20231213000452.88295-5-graf@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231213000452.88295-5-graf@amazon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_105634_529864_7690394D 
X-CRM114-Status: UNSURE (   8.97  )
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

On Wed, Dec 13, 2023 at 12:04:41AM +0000, Alexander Graf wrote:
> +void *kho_get_fdt(void)
> +{
> +	return fdt;
> +}
> +EXPORT_SYMBOL_GPL(kho_get_fdt);
> +

Same question here (and in other places of this code): shouldn't this
facility be provided to non-GPL drivers as well?

Also a minor nit: "const void *" looks like a cleaner prototype here.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
