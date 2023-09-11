Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E6DEE7FF4
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 14:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8tlgafEOs2e/k/pQq6f617cQXXI4EjwKZsFB66f15oQ=; b=mB27S9WPScYWx8
	kfzgHoz1rf6a4DBnxZ+fY0Whcv6Ut/efVp6QkXC0Z+h3Ggi2Ck37DuTN6dkvEdu96fo6HVHbrOlIW
	fx3lggrZ9FSwKMcwB32rGOcza2Ztcqlh/Y9WvAsCV5EDrrnna9JbhTPui6vlq8RLNSe4Z8/iTfSXI
	0PUgQRB8Ngikg7bxVjUP4yC7x1SONkCJ/wENGXg7bONtXdTHiqveuSPhIerUUtovlQToHi64JpfX7
	uVkqK/rJD3mlxMeSJP/1ky6PK0VQWWHB1xnZTmrXNbrhpSLI4knZopZXv77xtMj1y6PggHrW6N21h
	acnYd8LCLGswbM9VCimA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfhyB-000iGh-0v;
	Mon, 11 Sep 2023 14:32:55 +0000
Received: from mgamail.intel.com ([192.55.52.115])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfhy8-000iFS-05
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 14:32:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694442772; x=1725978772;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GBvaxapfraK64H6oc4OtRUMWrhE97kyIgzhCWgEuG4k=;
  b=g/RJvAH2n9yGYYDz7nJ9yuSr7dEQ7DK9JQ4RDd7Ji/Q854veHWIETQlq
   0uyMSH6qRAQCK8vZn6ks2wI7oCN13KDo0QDrSe/rP94+CwV5/94SY35FF
   mkEG21yubfAXGwivwW2Uggotcnb4b3LZekPXjEUdgwG1OTwyDbO7RY1b/
   q/4i/xxpbIEWS5pUStjRyOcLeFkTGEoimFBcD/wFZCdQTdO/u69BYH3yk
   MKPksjPRr3ZQxxsIeKdraDQMOe7ZgJOO/XyfeYo7wiDZNN7jaND0owiQ6
   +ptqCyaA3nFo8S7bUAzP82mrfF3L7BYsCdLm8uCoyE8IrlQnmTHHKULPo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378012086"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378012086"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:32:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="720000764"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="720000764"
Received: from cdaubert-mobl13.amr.corp.intel.com (HELO [10.212.203.41]) ([10.212.203.41])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:32:46 -0700
Message-ID: <40a363b1-80be-89ce-6527-ac2a4c04917f@intel.com>
Date: Mon, 11 Sep 2023 07:32:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] /dev/mem: Do not map unaccepted memory
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Borislav Petkov <bp@alien8.de>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@linux.ibm.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
 kexec@lists.infradead.org
References: <20230906073902.4229-1-adrian.hunter@intel.com>
 <20230906073902.4229-4-adrian.hunter@intel.com>
 <9ffb7a3b-cf20-617a-e4f1-8a6a8a2c5972@intel.com>
 <20230907142510.vcj57cvnewqt4m37@box.shutemov.name>
 <7a50d04f-63ee-a901-6f39-7d341e423a77@intel.com>
 <c60df0e4-4214-bbd0-7fc6-8f04e5888f53@redhat.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <c60df0e4-4214-bbd0-7fc6-8f04e5888f53@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_073252_227208_B21747A0 
X-CRM114-Status: UNSURE (   7.51  )
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

On 9/11/23 01:09, David Hildenbrand wrote:
> So, making unaccepted memory similarly depend on "!DEVMEM ||
> STRICT_DEVMEM" does not sound too far off ...

Yeah, considering all of the invasive work folks want to do to "harden"
the kernel for TDX, doing that ^ is just about the best
bang-for-your-buck "hardening" that you can get.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
