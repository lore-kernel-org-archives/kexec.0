Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FE0C433EF
	for <kexec@archiver.kernel.org>; Thu, 23 Jun 2022 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pXYzAf6RT2d9Kndhm1oWlin4UziUxkKS7ySU9PPxIa0=; b=lkc9UUMQgaLrDt
	Lp7NPsjZph+e8pZhr0yhCXBjs62EaMx6q19MMchZZw8j8dv2tn3nwupaNGjmjRMgEIGZWaJaoIAF+
	t+fUiAAJOGbCTJD8QLNWQCvJuYjpfuk+3U38DsP3Vsg/Y6oUsQc4Qb4ZgxMwSnHpPgb+/PYcecHsO
	VxG365qI/vlqD+pw8zPEse1vxKTQvwE4hssKFOl5m4RMiLuQlYdiPzn4fEpK8HnklL4x9O5/9eHvE
	maIzmzgp/bBIM/Psuw6R3WkL89DmP24MWIzlKgGdYR+S8p+BkMZ1lA1jrFDlKq+EASjlVHcrJDOFU
	7uBu/ytt52hiTIfJbSwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4QZF-00G6Ja-KG; Thu, 23 Jun 2022 17:24:33 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4QZB-00G6HS-Ov
	for kexec@lists.infradead.org; Thu, 23 Jun 2022 17:24:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656005069; x=1687541069;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HyD7sZmGzSIHx03CaYUHtjWHrLaftO9PYHM6NFaUHG0=;
  b=iE5BR0PGjFwiQZZXApp1cs06XHtRgxK7atMo+LwMX+B+QVVGG+7S6hGA
   P7EMj/Y5P//jpAFg2sWNV7r8dc5FaggCKvM27DR/BOSrCN5fn1O1qcbmE
   9mTA120K664IsoDRgMFKmI8PdGV926t6c561j3Qxxai9XFjJaDGkKdOrQ
   RmjWh79rym88imY26Tl5z7D9gaQIca0Ab1IRpBcaPzgCt1p0L+9e+wTYK
   GPkkrjLZgW68kn3wqYnj/HohiagLYS1YOVEDwvvZnuNx6OdOuOTM+M+X2
   V47FtefiuU0a99jGUZ+qyNNWpQ5LlpexgBYRlILp/HeokXSdZSTFTMmAp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="278335183"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="278335183"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 10:24:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="563531696"
Received: from ckeane-mobl1.amr.corp.intel.com (HELO [10.209.81.98]) ([10.209.81.98])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 10:24:25 -0700
Message-ID: <6be29d38-5c93-7cc9-0de7-235d3f83773c@intel.com>
Date: Thu, 23 Jun 2022 10:23:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv7 11/14] x86: Disable kexec if system has unaccepted
 memory
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Sean Christopherson <seanjc@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Joerg Roedel <jroedel@suse.de>,
 Ard Biesheuvel <ardb@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
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
 linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 kexec@lists.infradead.org
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <20220614120231.48165-12-kirill.shutemov@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220614120231.48165-12-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_102429_853352_6A2CEEBE 
X-CRM114-Status: GOOD (  16.57  )
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

... adding kexec folks

On 6/14/22 05:02, Kirill A. Shutemov wrote:
> On kexec, the target kernel has to know what memory has been accepted.
> Information in EFI map is out of date and cannot be used.
> 
> boot_params.unaccepted_memory can be used to pass the bitmap between two
> kernels on kexec, but the use-case is not yet implemented.
> 
> Disable kexec on machines with unaccepted memory for now.
...
> +static int __init unaccepted_init(void)
> +{
> +	if (!boot_params.unaccepted_memory)
> +		return 0;
> +
> +#ifdef CONFIG_KEXEC_CORE
> +	/*
> +	 * TODO: Information on memory acceptance status has to be communicated
> +	 * between kernel.
> +	 */
> +	pr_warn("Disable kexec: not yet supported on systems with unaccepted memory\n");
> +	kexec_load_disabled = 1;
> +#endif

This looks to be the *only* in-kernel user tweaking kexec_load_disabled.
 It doesn't feel great to just be disabling kexec like this.  Why not
just fix it properly?

What do the kexec folks think?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
