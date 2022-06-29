Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B04C43334
	for <kexec@archiver.kernel.org>; Wed, 29 Jun 2022 00:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yEh/UMMCoed0mlZnby1EIHHzSWwog0Rwi86vjuoqu2k=; b=EpBUdPrS4tLgmv
	+tO6govFr93jqPSECwT3xVhqqhgx/vHqPdsWzyf9FCo+wAlyMh9pCoXy0vTHy5zzqeH42RfRP5v/y
	sIwobY5LlE3ViTG4Kw72uSBISu35k6Pm9G190o5tn4hJTMA6GIFhFw6bHeP9j+k7TNjMlDbGmeGF5
	NUfQTIE+Q9xqROuo7YScA/8BYCCVCEN22sPJaQIlTtikeiSLlxV91Wscn9QMtK3+dXf9AVwa2NAkm
	ivtU+mtv6GxvND+khVLfogS6yqBmFraV6SKVOAu8yptPKDHuvbX2ND9r27vJFgn6sR47j8WnKA1kY
	HZMN/CpsaZJIc/lHEcaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6LJW-008jge-0r; Wed, 29 Jun 2022 00:12:14 +0000
Received: from mga18.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6LJT-008jfP-3Y
	for kexec@lists.infradead.org; Wed, 29 Jun 2022 00:12:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656461531; x=1687997531;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1rJZNOGjRv+TC9F6qD+OHSFaxGFTvIixlfRghRPUsaE=;
  b=Ot2Z2YQITZBBMOx2LVKvdfApIaEoqvCSm2DeN4/ri7WbWzqDGRXkClwq
   PXsgbQy6hbZlpNXs4E7W7DkqMOSx3UpWq4Fb63HgBvhfoI3Vfn2D4ebZu
   MHvqFNsbkkIt00PIiakRsIdilQDP0MQDTDMViFlAzmsYGlrtsYwrDFlLn
   OkXol8JHc5UAoA4Ns88E0N/HjUS5gdkv8z60QsnWSeB6DAPBmqWjX61qy
   1f6IBZaJui2KgdcBz49l4ZKsqUZSnJbImIMDXlNTQz1tuyaEuDSSxoLbc
   +Pidduk7qvyu3GXNHMOaHi96p+C6IYXT++JG7NiUKzB5Yev8rhssA7qWq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="264920188"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="264920188"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:12:04 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="617369374"
Received: from staibmic-mobl1.amr.corp.intel.com (HELO [10.209.67.166]) ([10.209.67.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:12:03 -0700
Message-ID: <88fe385c-fe40-d659-5081-7f3cdd9493e4@intel.com>
Date: Tue, 28 Jun 2022 17:10:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv7 11/14] x86: Disable kexec if system has unaccepted
 memory
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Sean Christopherson <seanjc@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Joerg Roedel <jroedel@suse.de>,
 Ard Biesheuvel <ardb@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Tom Lendacky <thomas.lendacky@amd.com>, Thomas Gleixner
 <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Varad Gautam <varad.gautam@suse.com>, Dario Faggioli <dfaggioli@suse.com>,
 Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
 marcelo.cerri@canonical.com, tim.gardner@canonical.com,
 khalid.elmously@canonical.com, philip.cox@canonical.com, x86@kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-12-kirill.shutemov@linux.intel.com>
 <6be29d38-5c93-7cc9-0de7-235d3f83773c@intel.com>
 <87a6a3aw50.fsf@email.froward.int.ebiederm.org>
 <20220624020005.txpxlsbjbebf6oq4@black.fi.intel.com>
 <20220628235105.z6ytdzxofrdkjti4@black.fi.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220628235105.z6ytdzxofrdkjti4@black.fi.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_171211_218664_C450CD0E 
X-CRM114-Status: GOOD (  12.13  )
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

On 6/28/22 16:51, Kirill A. Shutemov wrote:
> On Fri, Jun 24, 2022 at 05:00:05AM +0300, Kirill A. Shutemov wrote:
>>> If there is some deep and fundamental why this can not be supported
>>> then it probably makes sense to put some code in the arch_kexec_load
>>> hook that verifies that deep and fundamental reason is present.
...
> +	/*
> +	 * TODO: Information on memory acceptance status has to be communicated
> +	 * between kernel.
> +	 */

So, the deep and fundamental reason is... drum roll... you haven't
gotten around to implementing bitmap passing yet?!?!?   I have the
feeling that wasn't what Eric was looking for.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
