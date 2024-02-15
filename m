Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F656C4829E
	for <kexec@archiver.kernel.org>; Thu, 15 Feb 2024 06:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4s7yY1JgP6EHvJXQMcdV+KyO0dO3G9C+htb+WB33Ia4=; b=0xDVKuzqP7hQa/
	v7Ib3GZl+2aOI9JroDMugCC59kt4OQPkSzWptdko/4KxSgu+kF1NF+8y7FzYnJYkoNzdYL5ymr91i
	sdu1gRsurCvMeGCCBc2tO0zJ83seD39CDvYRILSDY3f402QF8o1fcBxH3YLpw9p6gNTSX+ApFsU6L
	BDndDP4GE4/2zHEl+kq2M6MjmoPPXA/ENI3QsiMNCJ6Qtm5b8mIQlC4DUgIvcIZHCDlAkg322U+Y8
	IPHuValFv3w0FYKCOsduGCgOBtpm7VEKKUuNg2LW2H9xIIKnUP5cBiPagN+ongpZHquadymSOCKiP
	doFMKBTFDF0xLqEGEssQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raV02-0000000F4pA-1GTJ;
	Thu, 15 Feb 2024 06:13:34 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raUzz-0000000F4oY-1E65
	for kexec@lists.infradead.org;
	Thu, 15 Feb 2024 06:13:33 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 19540207F228;
	Wed, 14 Feb 2024 22:13:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 19540207F228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707977609;
	bh=/knKuiTuk3RR/f29Du+MCM6o0maziyaOboGneP7mzM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XYkXHuOoVyCjSfhDYJCiKZQw1T937HOdZb6+lcu6gCCuXAKgb/4CxGuy6n6JUwwCi
	 /XhbsdTl/f0fsjcp0lFwlrv+9inGMiQKeoCAyKigt6fl4y91HZkrgSBJBnivLwYS8Y
	 j+Pw4dS6Hb7HAEzYC24xHS60gvUWXWdoXkseM9iI=
Message-ID: <f5c4259d-977c-455e-95ee-1ed2c53f4c50@linux.microsoft.com>
Date: Wed, 14 Feb 2024 22:13:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] kexec: define functions to map and unmap segments
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
 <20240214153827.1087657-3-tusharsu@linux.microsoft.com>
 <e5d6d47a-c9ee-47a1-aec8-aa59a5264884@linux.ibm.com>
Content-Language: en-US
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <e5d6d47a-c9ee-47a1-aec8-aa59a5264884@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_221331_519558_5F29270F 
X-CRM114-Status: UNSURE (   2.67  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 2/14/24 11:43, Stefan Berger wrote:
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks for the tag Stefan.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
