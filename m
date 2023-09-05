Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBACC83F2C
	for <kexec@archiver.kernel.org>; Tue,  5 Sep 2023 08:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v7yYHJ+rOg/cBvrjGMv6i6IjYC6lH24OwKvv4HRLnpg=; b=TuW0FKB13U/kmc
	BJC3oAzHaKBAuuCbQtvDTNuOzFE8j1H73q4WjHIKvVAHt/vMvnHsQjbb46aA6xAWyKpVXVTQLKAIy
	YRwJ0RD2j8p8EG1WF6FPYdD5h7qX3//M74nJHH9dWdi+LTZGIHCnRGsHpNS0BEDir/oTtSF0CbuHC
	KRNVIgi0I/b+6A65UB5+0kfka6OtwoU/bf4GJflHngyeBWr8tKvA360pNMTycytxizcreMwW/BwWc
	1Vyrs9ZNft7Q1gow5XbTWWLYHnQ+OxEVmimfkO4yptcst9rWfwaQC2OXUxN63qddjIP7diBdjcPUW
	eGS+TByTDodm3Kajcw7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdRRL-005Wtu-0q;
	Tue, 05 Sep 2023 08:29:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdRRH-005WsC-1s
	for kexec@lists.infradead.org;
	Tue, 05 Sep 2023 08:29:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693902574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5qwaCnM8A6hekNnw5uw9hHW7jhIEIVhSWRsoqN1YfI=;
	b=Nd0xc9H/ikJoqPAh0ZUfETrvY5tGW11CQ3LK20YYiWm+phqDZeMQpr32u7q5w0MnfBW5QD
	OzFwfvHYrMpmMyUqfa+PJObOTTj4Zt46GHxbMZRnQoYaIGX2SBRBaU2Fet1NEQderAjH1A
	luYQCSSKEesjPpOQkWKKNNdPze3KXi0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-vn0oRFxSOrmUEzgrn2VTWg-1; Tue, 05 Sep 2023 04:29:30 -0400
X-MC-Unique: vn0oRFxSOrmUEzgrn2VTWg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2126618DA720;
	Tue,  5 Sep 2023 08:29:30 +0000 (UTC)
Received: from localhost (unknown [10.72.113.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2245749310E;
	Tue,  5 Sep 2023 08:29:28 +0000 (UTC)
Date: Tue, 5 Sep 2023 16:29:25 +0800
From: Baoquan He <bhe@redhat.com>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	catalin.marinas@arm.com, thunder.leizhen@huawei.com,
	dyoung@redhat.com, prudo@redhat.com, samuel.holland@sifive.com,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Subject: Re: [PATCH v2 3/8] crash_core: change parse_crashkernel() to support
 crashkernel=,high|low parsing
Message-ID: <ZPbm5SwHOhiAtG7w@MiWiFi-R3L-srv>
References: <20230829121610.138107-1-bhe@redhat.com>
 <20230829121610.138107-4-bhe@redhat.com>
 <c4a1f96e-2c8d-a496-61f3-0299d77c5c84@huaweicloud.com>
 <ZPGzlIkXqVThTwjg@MiWiFi-R3L-srv>
 <2b9af1b7-8d80-46b7-d582-156a97456a36@huaweicloud.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2b9af1b7-8d80-46b7-d582-156a97456a36@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230905_012935_687936_FF912CDC 
X-CRM114-Status: GOOD (  20.63  )
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

On 09/04/23 at 10:47am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2023/9/1 17:49, Baoquan He wrote:
> >>> +
> >>> +		*high = true;
> >>> +	} else if (ret || !*crash_size) {
> >> This check can be moved outside of #ifdef. Because even '!high', it's completely
> >> applicable. The overall adjustment is as follows:
> > Hmm, the current logic is much easier to understand. However, I may not
> > 100% get your suggestion. Can you paste the complete code in your
> > suggested way? Do not need 100% correct code, just the skeleton of code logic
> > so that I can better understand it and add inline comment.
> 
> int __init parse_crashkernel(...)
> {
> 	int ret;
> 
> 	/* crashkernel=X[@offset] */
> 	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
> 				crash_base, NULL);
> 
> #ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
> 	if (high && ret == -ENOENT) {
> 		... ...		//The code for your original branch "else if (ret == -ENOENT) {"
> 		ret = 0;	//Added based on the next discussion
> 	}
> +#endif
> 
>  	if (!*crash_size)
> 		ret = -EINVAL;
> 
> 	return ret;
> }
> 
Thanks, Zhen Lei.

I paste the whole parse_crashkernel() as you suggested at bottom. Please
check if it's what you want. To me, both is fine to me. I have two minor
concerns to your suggested way.

1)
I took the "if (!high) return" way because except of x86/arm64, all
other architectures will call parse_crashkerne() and check
if *crash_size ==0. Please try 'git grep "parse_crashkernel(" arch'
and check those call sites. With that, we will have duplicated checking.

        ret = __parse_crashkernel(cmdline, system_ram, crash_size,
                                crash_base, NULL);
        if (!high)
                return ret;
2)
I actually like below branch and the code comment. It can give people
hint about what's going on in that case. Discarding it is a little pity.

        } else if (ret || !*crash_size) {
                /* The specified value is invalid */
                return -1;
        }

int __init parse_crashkernel(...)
{
	int ret;

	/* crashkernel=X[@offset] */
	ret = __parse_crashkernel(cmdline, system_ram, crash_size,
				crash_base, NULL);
#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
	if (high && ret == -ENOENT) {
		ret = __parse_crashkernel(cmdline, 0, crash_size,
				crash_base, suffix_tbl[SUFFIX_HIGH]);
		if (ret || !*crash_size)
			return -EINVAL;

		/*
		 * crashkernel=Y,low can be specified or not, but invalid value
		 * is not allowed.
		 */
		ret = __parse_crashkernel(cmdline, 0, low_size,
				crash_base, suffix_tbl[SUFFIX_LOW]);
		if (ret == -ENOENT) {
			*low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
			ret = 0;
		} else if (ret) {
			return ret;
		}

		*high = true;
	}
#endif

	if (!*crash_size)
		ret = -EINVAL;

	return ret;
}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
