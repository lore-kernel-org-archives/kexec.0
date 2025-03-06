Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53306C282D1
	for <kexec@archiver.kernel.org>; Thu,  6 Mar 2025 06:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=Mx4eXhc4yqpVhI7TdTQuRC9iguxZspH9NuwtaHcC+Lc=; b=Df7t+EVhLGl5DL
	JJB5pw76RsVTqLp26+LkdTWQHU/fZX9ex4HypzRsvPAqnVnGTiPgbxjKZEPHf9Fp85dYvLY73G9d0
	zcBKquiX8oMIAHfbM2/7tHk5AcerUQs+ROTQrBG9AkxN8ed92zWEpE88k36Z2eibkDCjQ/buQMXV6
	wpZuAO8Q/GnHnTWsyIyBsBoMqn3sRp3wCRNTX/Pr/VqP4jXIqn3isMkVKCOeQ/nfgDBqmtnSwzYQQ
	N2/ABeA31PhoajtdfEVxEvsECklBe4XTSqtA9E7wwWTwSsu0p2TNJxCSGyH1hgdUR1gqPqV7OJBPW
	U1Mnqkqsc1dbMKe0pkUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tq4pW-0000000A8Nt-1yPK;
	Thu, 06 Mar 2025 06:35:38 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tq4pQ-0000000A8NR-25Tx
	for kexec@lists.infradead.org;
	Thu, 06 Mar 2025 06:35:33 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso1277805e9.0
        for <kexec@lists.infradead.org>; Wed, 05 Mar 2025 22:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741242931; x=1741847731; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mx4eXhc4yqpVhI7TdTQuRC9iguxZspH9NuwtaHcC+Lc=;
        b=CdO4dN0S1AVUTDhMpvYDDwcv4nAv2rsJXDzVOdpqwB1kfOkb7gWtarRz29y4IDKN79
         5+2Lc114b9RuGZXsj/PEERieBTCuvqJUo5q+nlTWl8geYwn2FBWQBUFqzhECYZc7mSI3
         CwoAILPUEV3QvZdfZ3ZTr3w+Nl4IOPAvr239LfMLSDQoWSbbU8uV6Ol9JLSSiOYIr47W
         /0QId8FNJFmEbYRAkpawVgRfO+IJAlAoIsLzkfNgi9ugV5lBxz9+zSKmyFiBPkI1OS7p
         pSZB2hTbs34h9EEJPuiED38dXJuEGncEi83MbNCES5fNATECZeriS/NF+5gQXNXWcu17
         8lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741242931; x=1741847731;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mx4eXhc4yqpVhI7TdTQuRC9iguxZspH9NuwtaHcC+Lc=;
        b=B9XFhlzM6AVwuJsVDnC9ohTqgZ4LlSUyqOEbpfky2eMz48Huf/uOVMsl83+pU0DZzy
         t4IX1UnYvlmKMWJrHLUJJvG1Op9w9IhEOp4dS/I/1zzBNdCWR+R4Gsuh3UT+TMr3Raxi
         JHTaVhtwQl/+tvit3SQTiyaFR3PRILfPkr2ukGGj/SZhBXBTrlP+yfT8DIR7OAIunLEi
         nXkaFInjDS00WYsiXBnA4HB3wwcKdqppz1UABYzT8wLREa3lTBtGqcQMxcAb4yv9/q1D
         /vrcIANI8FjDbOtG3X9p+j7mTJCgJRh/fi9+cma89EmyM70CXfdS0GUFY15IOJQLDS/T
         7fWg==
X-Forwarded-Encrypted: i=1; AJvYcCUGiSuk2jSmIkJ0D2jlrMDzQWLOXl+o2ckMsFmIOS+wjyXueHVvzkoROEhcqjyu2sJk6K/81A==@lists.infradead.org
X-Gm-Message-State: AOJu0YweAFiXLeIKQiHn56Bw8ObQc0w69jkdruwrNwOesKQR673MDN1x
	TYoFCqEJNs/pvJa49NHqiAuGIpWlgvYW3GzBP/4KoRSLqAXWIOcX6oARkP4/MCNIcsHr2b11Bep
	c
X-Gm-Gg: ASbGncvxQ9ShCPrseI0Nen1FnjzplyGy6eZf9XPEURnI9wPTd7ybW8D40ADSl3ypgiI
	yGWLBf83+0HRLtjCJoA/zX7yrtFPhsWTX0PDkvof0xJCw0UP3QKjTpIDbqUdG5DJ5UFNZ3dFVYg
	+DD0hJOzx9XJB0C2TuLwwcuY4dEjo/LRZmNtFIn7ZoVCWjnC8HKX5WKtaxiaz+svLXCHygYHpbU
	QL8ZMBhJy2/wyi7yvHbzQm3eULu6/4rsu1TraCujUBxh2wJBjIvklTuo6i7wQ3UU8nKbPAa9uQT
	d542oTlNRJRJAXcTBCTh+MfRF6eeFBzhP4/U5Q8+SLMrfIKVfw==
X-Google-Smtp-Source: AGHT+IEldEFBJ6GcJ/9AsmwidDi0MW22pFoTiX1DY3pYgmQW8PLpDd7QMPBO5UsdG2P8Z7W4b9nJlQ==
X-Received: by 2002:a05:600c:1551:b0:43b:cb0c:3556 with SMTP id 5b1f17b1804b1-43bd2af49cemr38379685e9.28.1741242930569;
        Wed, 05 Mar 2025 22:35:30 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bdd8c314asm9415525e9.10.2025.03.05.22.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 22:35:30 -0800 (PST)
Date: Thu, 6 Mar 2025 09:35:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, steven chen <chenste@linux.microsoft.com>,
	zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com
Subject: Re: [PATCH v9 2/7] kexec: define functions to map and unmap segments
Message-ID: <7bde870f-07eb-48a6-8b8d-edac57640775@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304190351.96975-3-chenste@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_223532_546369_3D61CA76 
X-CRM114-Status: UNSURE (   8.57  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi steven,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/steven-chen/ima-copy-only-complete-measurement-records-across-kexec/20250305-031719
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
patch link:    https://lore.kernel.org/r/20250304190351.96975-3-chenste%40linux.microsoft.com
patch subject: [PATCH v9 2/7] kexec: define functions to map and unmap segments
config: x86_64-randconfig-161-20250306 (https://download.01.org/0day-ci/archive/20250306/202503061449.gbVGafZc-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202503061449.gbVGafZc-lkp@intel.com/

smatch warnings:
kernel/kexec_core.c:896 kimage_map_segment() error: uninitialized symbol 'dest_page_addr'.

vim +/dest_page_addr +896 kernel/kexec_core.c

bf06eab7ae0f04 steven chen 2025-03-04  870  void *kimage_map_segment(struct kimage *image,
bf06eab7ae0f04 steven chen 2025-03-04  871  			 unsigned long addr, unsigned long size)
bf06eab7ae0f04 steven chen 2025-03-04  872  {
bf06eab7ae0f04 steven chen 2025-03-04  873  	unsigned long eaddr = addr + size;
bf06eab7ae0f04 steven chen 2025-03-04  874  	unsigned long src_page_addr, dest_page_addr;
bf06eab7ae0f04 steven chen 2025-03-04  875  	unsigned int npages;
bf06eab7ae0f04 steven chen 2025-03-04  876  	struct page **src_pages;
bf06eab7ae0f04 steven chen 2025-03-04  877  	int i;
bf06eab7ae0f04 steven chen 2025-03-04  878  	kimage_entry_t *ptr, entry;
bf06eab7ae0f04 steven chen 2025-03-04  879  	void *vaddr = NULL;
bf06eab7ae0f04 steven chen 2025-03-04  880  
bf06eab7ae0f04 steven chen 2025-03-04  881  	/*
bf06eab7ae0f04 steven chen 2025-03-04  882  	 * Collect the source pages and map them in a contiguous VA range.
bf06eab7ae0f04 steven chen 2025-03-04  883  	 */
bf06eab7ae0f04 steven chen 2025-03-04  884  	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
bf06eab7ae0f04 steven chen 2025-03-04  885  	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
bf06eab7ae0f04 steven chen 2025-03-04  886  	if (!src_pages) {
bf06eab7ae0f04 steven chen 2025-03-04  887  		pr_err("Could not allocate ima pages array.\n");
bf06eab7ae0f04 steven chen 2025-03-04  888  		return NULL;
bf06eab7ae0f04 steven chen 2025-03-04  889  	}
bf06eab7ae0f04 steven chen 2025-03-04  890  
bf06eab7ae0f04 steven chen 2025-03-04  891  	i = 0;
bf06eab7ae0f04 steven chen 2025-03-04  892  	for_each_kimage_entry(image, ptr, entry) {
bf06eab7ae0f04 steven chen 2025-03-04  893  		if (entry & IND_DESTINATION) {
bf06eab7ae0f04 steven chen 2025-03-04  894  			dest_page_addr = entry & PAGE_MASK;

Is the first entry always IND_DESTINATION?

bf06eab7ae0f04 steven chen 2025-03-04  895  		} else if (entry & IND_SOURCE) {
bf06eab7ae0f04 steven chen 2025-03-04 @896  			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
                                                                    ^^^^^^^^^^^^^^
otherwise this is uninitialized

bf06eab7ae0f04 steven chen 2025-03-04  897  				src_page_addr = entry & PAGE_MASK;
bf06eab7ae0f04 steven chen 2025-03-04  898  				src_pages[i++] =
bf06eab7ae0f04 steven chen 2025-03-04  899  					virt_to_page(__va(src_page_addr));
bf06eab7ae0f04 steven chen 2025-03-04  900  				if (i == npages)
bf06eab7ae0f04 steven chen 2025-03-04  901  					break;
bf06eab7ae0f04 steven chen 2025-03-04  902  				dest_page_addr += PAGE_SIZE;
bf06eab7ae0f04 steven chen 2025-03-04  903  			}
bf06eab7ae0f04 steven chen 2025-03-04  904  		}
bf06eab7ae0f04 steven chen 2025-03-04  905  	}
bf06eab7ae0f04 steven chen 2025-03-04  906  
bf06eab7ae0f04 steven chen 2025-03-04  907  	/* Sanity check. */
bf06eab7ae0f04 steven chen 2025-03-04  908  	WARN_ON(i < npages);
bf06eab7ae0f04 steven chen 2025-03-04  909  
bf06eab7ae0f04 steven chen 2025-03-04  910  	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
bf06eab7ae0f04 steven chen 2025-03-04  911  	kfree(src_pages);
bf06eab7ae0f04 steven chen 2025-03-04  912  
bf06eab7ae0f04 steven chen 2025-03-04  913  	if (!vaddr)
bf06eab7ae0f04 steven chen 2025-03-04  914  		pr_err("Could not map ima buffer.\n");
bf06eab7ae0f04 steven chen 2025-03-04  915  
bf06eab7ae0f04 steven chen 2025-03-04  916  	return vaddr;
bf06eab7ae0f04 steven chen 2025-03-04  917  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


