Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F71C54EBD
	for <kexec@archiver.kernel.org>; Mon,  9 Jan 2023 07:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eFM5XktmBfM71EfwKGJUl1PMl1h32V0P9FD1IzrVWJ4=; b=4I2hQCAwuzk4+X
	B/Jc2kw48vLc79M7Zsa/TmMQ33PVAmyH60hY6FhXMu/jTRZdYTVLREB7V/xO6ZgxYcwUS+U1DijiI
	6N4K+13OYdgJ0Ad/zUiUK8AF5KcNWXxKdetVO35poQpVcfjclJZdZv9qp073tkHqjJtty++mHQ4YC
	wqloYeHYd+wASBqy4n8oeVs9BUJsPyQ8xMl0nJuxDRLwFm089NHjzThzOvVJmBphfCxIeiWaEeqdm
	wQ7JL2GZDw2BWrAPLAIf7nyJH3/lHOGSnR2prwvXRMjjdNZPSCCntchuPXzVKH9c4d/SmccNguA+v
	FN3noBfGSl3LDuKOKutA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEmhi-000DlE-LO; Mon, 09 Jan 2023 07:36:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEmhf-000DkC-QX
	for kexec@lists.infradead.org; Mon, 09 Jan 2023 07:36:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673249778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3pRRcbAJr9FBmhMCHXLl4cGEBukXZQYCmqCCYZCpshc=;
	b=a4szKYkHnnRyFvQWiHdIksWAaEci92n4iRZEZNXi3CwHPLnzTC7lVw+nW2z3Jjnx3hJc07
	fFCo+3tW2q7o3gjPTXZCnqZ3uCVCaldena0MN7vhjSfZ2u7vA0r+fB/RgULgE7XyNzmRFN
	ezZeqJyf2Vl8ozvthaqzsdIqXb3AZw0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-6SgBgRqnOwOUnSLWDuvUaQ-1; Mon, 09 Jan 2023 02:36:15 -0500
X-MC-Unique: 6SgBgRqnOwOUnSLWDuvUaQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1DF7101A521;
	Mon,  9 Jan 2023 07:36:14 +0000 (UTC)
Received: from localhost (ovpn-12-124.pek2.redhat.com [10.72.12.124])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 96EB3492B00;
	Mon,  9 Jan 2023 07:36:12 +0000 (UTC)
Date: Mon, 9 Jan 2023 15:36:09 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v16 7/7] x86/crash: add x86 crash hotplug support
Message-ID: <Y7vD6bm9xy9uyvRD@fedora>
References: <20230105151709.1845-1-eric.devolder@oracle.com>
 <20230105151709.1845-8-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230105151709.1845-8-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_233619_955466_538174F8 
X-CRM114-Status: GOOD (  14.38  )
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

On 01/05/23 at 10:17am, Eric DeVolder wrote:
......
> @@ -394,10 +409,37 @@ int crash_load_segments(struct kimage *image)
>  	if (ret)
>  		return ret;
>  
> -	image->elf_headers = kbuf.buffer;
> -	image->elf_headers_sz = kbuf.bufsz;
> +	image->elf_headers	= kbuf.buffer;
> +	image->elf_headers_sz	= kbuf.bufsz;
> +	kbuf.memsz		= kbuf.bufsz;
> +
> +	if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
> +		/*
> +		 * Ensure the elfcorehdr segment large enough for hotplug changes.
> +		 * Start with VMCOREINFO and kernel_map.
> +		 */
> +		unsigned long pnum = 2;
> +
> +		if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
> +			pnum += CONFIG_NR_CPUS_DEFAULT;
> +
> +		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +			pnum += CRASH_MAX_MEMORY_RANGES;

Logic of pnum calculating is a little confusing to me. If I only enable
one of CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG, is it OK? Say I
only enable CONFIG_HOTPLUG_CPU and CONFIG_SMP, on x86_64,
CONFIG_NR_CPUS_DEFAULT will be 64. pnum will be 64, is it OK. Am I miss
anything?

> +
> +		if (pnum < (unsigned long)PN_XNUM) {
> +			kbuf.memsz = pnum * sizeof(Elf64_Phdr);
> +			kbuf.memsz += sizeof(Elf64_Ehdr);
> +
> +			image->elfcorehdr_index = image->nr_segments;
> +			image->elfcorehdr_index_valid = true;
> +
> +			/* Mark as usable to crash kernel, else crash kernel fails on boot */
> +			image->elf_headers_sz = kbuf.memsz;
> +		} else {
> +			pr_err("number of Phdrs %lu exceeds max\n", pnum);
> +		}
> +	}
>  
> -	kbuf.memsz = kbuf.bufsz;
>  	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>  	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>  	ret = kexec_add_buffer(&kbuf);
> @@ -412,3 +454,67 @@ int crash_load_segments(struct kimage *image)
>  	return ret;
>  }
>  #endif /* CONFIG_KEXEC_FILE */


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
